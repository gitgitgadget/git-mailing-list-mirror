From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: Annoated tag not found on git describe
Date: Wed, 27 Oct 2010 20:19:46 +0200
Message-ID: <4CC86D42.20008@debugon.org>
References: <alpine.LNX.2.01.1010271957520.28381@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Wed Oct 27 20:20:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBAbP-0004dA-L3
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 20:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab0J0STw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 14:19:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51029 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab0J0STv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 14:19:51 -0400
Received: from [192.168.2.2] (p54B945B7.dip.t-dialin.net [84.185.69.183])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Mg0zl-1OzHxA0Uej-00O3dg; Wed, 27 Oct 2010 20:19:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.14) Gecko/20101006 Thunderbird/3.0.9
In-Reply-To: <alpine.LNX.2.01.1010271957520.28381@obet.zrqbmnf.qr>
X-Provags-ID: V02:K0:PffDahf5RAsvi+R9ht0dUVwFX1BEc+r+M5lopkxjfg+
 avK/Bir4vLcvtAsL3fVpShM1K6GY/+SpWmi7EPJSk6hiLfc/t0
 z4uIjck97OuuaLOThatIHOuw5vq336jZ+ZI2dPrBain/4tBDZB
 MBa20K+xSRAggq7HGKa7N+HXxyulM7WWgG9k8Mqgun0aewCB/N
 Iowt+MRjgwFN8sHdIaoskFIQE6Rs8pvSb4u+e5w5LA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160111>

On 10/27/2010 08:00 PM, Jan Engelhardt wrote:
> Hi,
> 
> 
> in the linux-manpages repository at 
> git://git.kernel.org/pub/scm/docs/man-pages/man-pages , running git 
> describe on the current HEAD (8482c7b836) produces
> 
> fatal: No annotated tags can describe 
> '8482c7b836a66f874e7dfea9c35fee4a82ad817b'.
> However, there were unannotated tags: try --tags.
> 
> Which seems strange, given there is an annotated tag:
> 
> (.git/refs/packed-refs)
> 45aba08f23aea4baf9ff5603cb5ec4ce148be2cc refs/tags/man-pages-3.29
> ^80786722b116f5002c28e9e0200044f825b236f6
> 
> ==>
> object 80786722b116f5002c28e9e0200044f825b236f6
> type commit
> tag man-pages-3.29
> tagger Michael Kerrisk <mtk.manpages@gmail.com> 1287508632 +0200
> 
> This is man-pages-3.29
> 
> commit 80786722b116f5002c28e9e0200044f825b236f6
> tree 65ca9b696771fba53902a1342dc982066c9467e0
> parent 435070082d2694737825491cc47973626f352645
> author Michael Kerrisk <mtk.manpages@gmail.com> 1287508632 +0200
> committer Michael Kerrisk <mtk.manpages@gmail.com> 1287508632 +0200
> 
>     Ready for 3.29
> 
> 
> 
> So what caused git 1.7.1 to get confused here?
> 
> 
> thanks,
> Jan

Hi,

must have been fixed in a later version, as it works for me:

$ git describe 
man-pages-3.29-49-g8409222

$ git --version 
git version 1.7.3.2

-Mathias
