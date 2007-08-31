From: David Watson <dwatson@mimvista.com>
Subject: Re: git svn dcommit not checking if up-to-date?
Date: Fri, 31 Aug 2007 17:46:15 -0400
Message-ID: <20070831214615.GA3443@mimvista.com>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:45:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IREIl-0008IH-Sn
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbXHaVpM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXHaVpL
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:45:11 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:40644
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750721AbXHaVpJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 17:45:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id D4A92355EA2;
	Fri, 31 Aug 2007 17:43:19 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: 1.393
X-Spam-Level: *
X-Spam-Status: No, score=1.393 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RCVD_IN_NJABL_DUL=1.946,
	RCVD_IN_SORBS_DUL=2.046]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szj+qIplFEtT; Fri, 31 Aug 2007 17:43:17 -0400 (EDT)
Received: from localhost (cpe-66-61-71-72.neo.res.rr.com [66.61.71.72])
	by zimbra.mimvista.com (Postfix) with ESMTP id 7122E355E9A;
	Fri, 31 Aug 2007 17:43:17 -0400 (EDT)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708312200480.28586@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57223>

I believe I've had this same issue as well. Like you, I assumed it was
user error on my part - I had been doing a lot of 'rebase -i' with that
particular set of changes, and figured I had just messed up somehow.

In my case, my coworker's commit happened 15 minutes before my dcommit, so
it wasn't *that* close in time. I tried to reproduce at that point, but
was unable to. I may try to reproduce this weekend if I get a chance.

On Fri, Aug 31, 2007 at 10:04:24PM +0100, Johannes Schindelin wrote:
> Hi Eric,
> 
> harningt just asked about known issues of git-svn on IRC, and I remembered 
> that I had an issue: Accidentally, I forgot to "git svn fetch" before "git 
> svn dcommit"ing, and unfortunately, a colleague had just checked in a 
> change, which got undone by my dcommit.
> 
> Is this a known issue, has it been fixed, am I a bad pilot?
> 
> Ciao,
> Dscho
> 
> P.S.: harningt promised to get his hands dirty, but I just realised that 
> the issue could be fixed since long ago...
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dave Watson
Software Engineer
MIMvista Corp
