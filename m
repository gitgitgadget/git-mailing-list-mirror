From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 5/5] Documentation: add caveats about I/O buffering
 for check-{attr,ignore}
Date: Fri, 12 Apr 2013 12:00:45 +0100
Message-ID: <20130412110045.GC26949@pacific.linksys.moosehall>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-5-git-send-email-git@adamspiers.org>
 <7vsj2xhrc7.fsf@alter.siamese.dyndns.org>
 <20130411201219.GA21091@pacific.linksys.moosehall>
 <7vzjx4fqex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 12 13:00:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQbiw-0003g0-TX
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 13:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab3DLLAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 07:00:47 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:60968 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3DLLAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 07:00:47 -0400
Received: from localhost (0.4.0.0.6.9.f.2.8.9.8.0.5.f.0.9.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:90f5:898:2f96:40])
	by coral.adamspiers.org (Postfix) with ESMTPSA id DC6172E330
	for <git@vger.kernel.org>; Fri, 12 Apr 2013 12:00:45 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vzjx4fqex.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220975>

On Thu, Apr 11, 2013 at 07:12:22PM -0700, Junio C Hamano wrote:
> It is usually OK to re-flow the text in the paragraph you are
> touching. After all, for the purpose of reviewing, people can just
> blindly apply and then ask "diff --color-words".  In this case,
> however, there was some changes that conflict in the vicinity, and
> reflowing made the resolution unnecessarily more cumbersome.

I see.  Thanks for the tip; I was only dimly aware of --color-words.

> I have briefly looked at this series, but it severely conflicts with
> a few topics in flight that touch the infrastructure you are using,
> so I haven't merged it to 'pu'. Perhaps after things calm down, we
> may want to ask you to reroll on top of updated codebase.

Sure, no problem.  I'll try a quick rebase now to see how ugly it is.

By the way, I've replaced my test for streaming --stdin which was
based on stdbuf(1) and sleep(1) with Peff's clever hack based on
mkfifo.  I'll hold off from sending a reroll until pathspec activity
cools down, but in the meantime it's available here:

    https://github.com/aspiers/git/compare/master...git-annex-streaming

It requires my "t: make PIPE a standard test prerequisite" patch, but
I notice that's already in master which will make things easier later
on.

Thanks!
Adam
