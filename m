From: Jan Engelhardt <jengelh@medozas.de>
Subject: Annoated tag not found on git describe
Date: Wed, 27 Oct 2010 20:00:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1010271957520.28381@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 20:01:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBAJ0-0003IO-JX
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 20:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab0J0SAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 14:00:54 -0400
Received: from borg.medozas.de ([188.40.89.202]:54628 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762Ab0J0SAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 14:00:52 -0400
Received: by borg.medozas.de (Postfix, from userid 25121)
	id 58019F0C32A90; Wed, 27 Oct 2010 20:00:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id 4A1D964E3
	for <git@vger.kernel.org>; Wed, 27 Oct 2010 20:00:51 +0200 (CEST)
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160109>

Hi,


in the linux-manpages repository at 
git://git.kernel.org/pub/scm/docs/man-pages/man-pages , running git 
describe on the current HEAD (8482c7b836) produces

fatal: No annotated tags can describe 
'8482c7b836a66f874e7dfea9c35fee4a82ad817b'.
However, there were unannotated tags: try --tags.

Which seems strange, given there is an annotated tag:

(.git/refs/packed-refs)
45aba08f23aea4baf9ff5603cb5ec4ce148be2cc refs/tags/man-pages-3.29
^80786722b116f5002c28e9e0200044f825b236f6

==>
object 80786722b116f5002c28e9e0200044f825b236f6
type commit
tag man-pages-3.29
tagger Michael Kerrisk <mtk.manpages@gmail.com> 1287508632 +0200

This is man-pages-3.29

commit 80786722b116f5002c28e9e0200044f825b236f6
tree 65ca9b696771fba53902a1342dc982066c9467e0
parent 435070082d2694737825491cc47973626f352645
author Michael Kerrisk <mtk.manpages@gmail.com> 1287508632 +0200
committer Michael Kerrisk <mtk.manpages@gmail.com> 1287508632 +0200

    Ready for 3.29



So what caused git 1.7.1 to get confused here?


thanks,
Jan
