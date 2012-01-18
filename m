From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Checking out orphans with -f
Date: Wed, 18 Jan 2012 15:45:29 -0700
Organization: CAF
Message-ID: <201201181545.30043.mfick@codeaurora.org>
References: <201201181207.05967.mfick@codeaurora.org> <7vsjjcljmj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 23:45:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RneG8-0003IC-6f
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab2ARWpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:45:31 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:15337 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab2ARWpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 17:45:31 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6593"; a="153818089"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 18 Jan 2012 14:45:30 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 9359210004DC;
	Wed, 18 Jan 2012 14:45:30 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vsjjcljmj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188772>

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

By abandon, I simply mean to check out another branch, which 
as you point, I can almost do.  I just can't do it by 
checking out another orphaned branch!  Why not, this seems 
inconsistent?  In both cases I loose what the original 
orphaned branch (a) is, so why prevent me from doing it in 
the one case and not the other?

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
