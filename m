From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] add test case for rebase of empty commit
Date: Thu, 28 Jun 2012 07:30:57 -0400
Message-ID: <20120628113057.GA29277@hmsreliant.think-freely.org>
References: <1340814121-23813-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vr4t079jp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 13:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkCwN-0008NV-RU
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 13:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab2F1LbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 07:31:08 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:39934 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2F1LbH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 07:31:07 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SkCw6-0005GA-0A; Thu, 28 Jun 2012 07:30:59 -0400
Content-Disposition: inline
In-Reply-To: <7vr4t079jp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200785>

On Wed, Jun 27, 2012 at 02:02:34PM -0700, Junio C Hamano wrote:
> Thanks.
> 
> We recently had a topic to add an option to allow rebase to carry
> empty commits forward, but I notice that it only had tests for the
> component cherry-pick to keep empty or redundant commits, so it may
> not be a bad idea to add tests for that series to the same t3401
> after this commit (Neil Horman CC'ed).
> 
> 
So if I understand correctly, the desire is to augment t3401 such that it adds a
test in which both of the commits in the local branch are empty, and still
correctly identifies the one that was cherry-picked and only adds the remaining
one during the rebase?

Yes, I think that sounds like a good idea.  I'm in the middle of an sctp project
at the moment, but I expect to complete it in the next few days.  I can look
into writing this next week if you like.

Thanks & Regards
Neil
 
