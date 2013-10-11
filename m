From: Stephen Bash <bash@genarts.com>
Subject: Re: A workflow for local patch maintenance
Date: Fri, 11 Oct 2013 11:30:53 -0400 (EDT)
Message-ID: <636938755.2020935.1381505453539.JavaMail.root@genarts.com>
References: <20131011151614.GA29226@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tony Finch <dot@dotat.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 11 17:31:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUegF-00056q-An
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 17:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256Ab3JKPbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 11:31:01 -0400
Received: from hq.genarts.com ([173.9.65.1]:10081 "EHLO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510Ab3JKPbA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 11:31:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 59621BE4C62;
	Fri, 11 Oct 2013 11:30:59 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NeS0vo-nPwoc; Fri, 11 Oct 2013 11:30:53 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 94F83BE496D;
	Fri, 11 Oct 2013 11:30:53 -0400 (EDT)
In-Reply-To: <20131011151614.GA29226@sigill.intra.peff.net>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC30 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235909>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: git@vger.kernel.org, "Tony Finch" <dot@dotat.at>
> Sent: Friday, October 11, 2013 11:16:14 AM
> Subject: Re: A workflow for local patch maintenance
> 
> On Fri, Oct 11, 2013 at 09:22:28AM -0400, Stephen Bash wrote:
> 
> > > To mitigate problem 1, I will sometimes revert a local topic
> > > before doing the upstream merge, if I know it has been reworked.
> > 
> > Peff (slightly off topic) - A coworker of mine actually ran into
> > this problem earlier this week.  Is there recommended way to revert
> > a merged topic branch?  I assume it's essentially reverted each
> > commit introduced by the branch, but is there a convenient
> > invocation of revert?  (easy to remember and hard to screw up)
> 
> If you merged the whole topic in at once, then you can use "git revert
> -m 1 $merge_commit" to undo the merge. If it came in individual
> pieces, then you have to revert each one individually (though if it
> was a series of merges, you can in theory revert each merge in reverse
> order).

Thanks for the pointer.  That got me to the right place on the revert
manpage, and there I found the link to howto/revert-a-faulty-merge.txt
which was extremely helpful.

Thanks!
Stephen
