From: Stephen Bash <bash@genarts.com>
Subject: Re: A workflow for local patch maintenance
Date: Fri, 11 Oct 2013 09:22:28 -0400 (EDT)
Message-ID: <247350414.2015225.1381497748024.JavaMail.root@genarts.com>
References: <20131010173628.GB24782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tony Finch <dot@dotat.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 11 15:31:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUco8-0007MU-6i
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 15:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935Ab3JKNbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 09:31:03 -0400
Received: from hq.genarts.com ([173.9.65.1]:39720 "EHLO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467Ab3JKNbB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 09:31:01 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Oct 2013 09:31:01 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B77B2BE4541;
	Fri, 11 Oct 2013 09:22:33 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QQKTKy2LxTkL; Fri, 11 Oct 2013 09:22:28 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 18FF8BE4093;
	Fri, 11 Oct 2013 09:22:28 -0400 (EDT)
In-Reply-To: <20131010173628.GB24782@sigill.intra.peff.net>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC30 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235905>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> Sent: Thursday, October 10, 2013 1:36:28 PM
> Subject: Re: A workflow for local patch maintenance
> 
> ... snip ...
>
> That being said, there are some new downsides, as you noted:
> 
>   1. Resolving conflicts between your version and the reworked
>   upstream version can be a pain.
> 
> ... snip ...
> 
> To mitigate problem 1, I will sometimes revert a local topic before
> doing the upstream merge, if I know it has been reworked.

Peff (slightly off topic) - A coworker of mine actually ran into this
problem earlier this week.  Is there recommended way to revert a merged
topic branch?  I assume it's essentially reverted each commit introduced
by the branch, but is there a convenient invocation of revert? (easy to 
remember and hard to screw up)

Thanks,
Stephen
