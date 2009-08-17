From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 11:51:38 +0200
Message-ID: <4A89282A.3020907@viscovery.net>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>  <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com> <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com> <alpine.DEB.1.00.0908171113420.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 11:52:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcyt2-0006Kf-0p
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 11:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316AbZHQJvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 05:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756895AbZHQJvk
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 05:51:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2680 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890AbZHQJvj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 05:51:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1McysN-0002Wg-6x; Mon, 17 Aug 2009 11:51:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E3C5BC6C2; Mon, 17 Aug 2009 11:51:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.1.00.0908171113420.4991@intel-tinevez-2-302>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126150>

Johannes Schindelin schrieb:
> On Mon, 17 Aug 2009, skillzero@gmail.com wrote:
>> On Mon, Aug 17, 2009 at 1:17 AM, Nguyen Thai Ngoc Duy<pclouds@gmail.com> wrote:
>>> On Mon, Aug 17, 2009 at 1:09 PM, <skillzero@gmail.com> wrote:
>>>> 1. Have people decided whether it should be on by default if you have 
>>>>    a .git/info/sparse file? I'd definitely like it to be on by 
>>>>    default.  When I first tried it, I didn't realize I had to use 
>>>>    --sparse to git checkout to get it to use the sparse rules. The 
>>>>    same goes for a merge I did that happened to have a file in the 
>>>>    excluded area (it included it because I didn't use --sparse to git 
>>>>    merge).
>>> I tend to make it enabled by default too. I have made it stricter to 
>>> trigger reading sparse in unpack_trees() -- only do it when 
>>> unpack_opts.update is TRUE. This should make it safer to be enabled by 
>>> default.
>> Other than it being new and not-widely-tested code, is there any 
>> additional risk to having it enabled by default if there are no sparse 
>> patterns defined?
> 
> I think that in and of itself is reason enough to turn off the feature 
> when .git/info/sparse is not present.

I might have missed something: Would there be any observable difference
between whether .git/info/sparse is absent and whether it is empty? If
not, what do you mean by "turn the feature off"?

>> It would be nice if .git/info/sparse is there by default (like
>> .git/info/exclude) with some commented out instructions (also like
>> .git/info/exclude).
> 
> I'm not a fan of this idea.

For any particular reason?

-- Hannes
