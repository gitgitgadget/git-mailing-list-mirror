From: David Watson <dwatson@mimvista.com>
Subject: Re: [EGIT] Sort order from hell fixes, take 2
Date: Mon, 3 Mar 2008 09:17:04 -0500
Message-ID: <20080303141704.GA48263@mimvista.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 15:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWBUC-0001DE-ST
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 15:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYCCORK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 09:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbYCCORK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 09:17:10 -0500
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:38235
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752962AbYCCORI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2008 09:17:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 9BB0338BE8A;
	Mon,  3 Mar 2008 09:11:50 -0500 (EST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -3.694
X-Spam-Level: 
X-Spam-Status: No, score=-3.694 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.705, BAYES_00=-2.599]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rka+9G1d0pkz; Mon,  3 Mar 2008 09:11:50 -0500 (EST)
Received: from localhost (unknown [10.0.10.104])
	by zimbra.mimvista.com (Postfix) with ESMTP id 5F5CA38BE75;
	Mon,  3 Mar 2008 09:11:50 -0500 (EST)
Mail-Followup-To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75928>

I've looked over this a bit, and it looks like a good set of changes. 


On Sun, Feb 24, 2008 at 12:50:33AM +0100, Robin Rosenberg wrote:
> Hi fans,
> 
> My previous attempt to fix this failed, so here is another round, including
> some new infrastructure like a TreeIterator to support this fix and whatever
> will need it.
> 
> Feed free to scrutize and invent whatever evil test case might be missing.
> 
> The reason I noticed the problem was introduced in c20142, where the unit
> tests for org.spearce.jgit was moved to the new project org.spearce.jgit.test .
> 
> -- robin
> 
> 

-- 
Dave Watson
Software Engineer
MIMvista Corp
