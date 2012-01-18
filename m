From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Checking out orphans with -f
Date: Wed, 18 Jan 2012 15:50:23 -0700
Organization: CAF
Message-ID: <201201181550.23792.mfick@codeaurora.org>
References: <201201181207.05967.mfick@codeaurora.org> <7vsjjcljmj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 23:50:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RneKu-00065x-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab2ARWuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:50:25 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:6915 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab2ARWuY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 17:50:24 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6593"; a="153819434"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 18 Jan 2012 14:50:24 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 5054510004DC;
	Wed, 18 Jan 2012 14:50:24 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vsjjcljmj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188774>

On Wednesday, January 18, 2012 03:40:36 pm Junio C Hamano 
wrote:
> Martin Fick <mfick@codeaurora.org> writes:
> > I am trying to write some scripts which do various
> > things to a git repo and I have run into a issue where
> > I think that git behavior with respect to orphan
> > branches is potentially
> > 
> > undesirable.  If I type:
> >   git checkout --orphan a
> > 
> > I cannot easily abandon this state
> 
> What do you mean by "abandon"?
> 
> If you want to remove a branch "a" because you do not
> need it, you can check out some other branch and say
> "git branch -D a", no?

Actually, no I can't.  I can check out some other branch 
(assuming I have one), but I cannot then delete a, it 
appears to already be deleted by virtue of checking out 
another branch.  I like that since I never checked it in, 
better to clean up the garbage, but why can't I then 
checkout another orphan to do the same thing?

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
