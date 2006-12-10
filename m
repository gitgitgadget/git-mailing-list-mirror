X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: globs in partial checkout?
Date: Sun, 10 Dec 2006 23:07:13 +0200
Message-ID: <20061210210713.GC9205@mellanox.co.il>
References: <Pine.LNX.4.64.0612101209370.12500@woody.osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 21:07:59 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612101209370.12500@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 10 Dec 2006 21:08:46.0828 (UTC) FILETIME=[61B99AC0:01C71C9F]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14862.000
X-TM-AS-Result: No--11.509800-4.000000-31
X-Spam: [F=0.0822901203; S=0.082(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33928>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtVtp-0002fm-PO for gcvg-git@gmane.org; Sun, 10 Dec
 2006 22:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933059AbWLJVHL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 16:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933073AbWLJVHL
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 16:07:11 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:52911 "EHLO
 p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S933059AbWLJVHJ (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 16:07:09 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o143.mxlogic.net) by
 p02c11o143.mxlogic.net (mxl_mta-4.0.1-4) with ESMTP id
 df67c754.2112060336.11478.00-500.p02c11o143.mxlogic.net (envelope-from
 <mst@mellanox.co.il>); Sun, 10 Dec 2006 14:07:09 -0700 (MST)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com) by
 p02c11o143.mxlogic.net (mxl_mta-4.0.1-4) with ESMTP id
 bf67c754.2531654576.11476.00-005.p02c11o143.mxlogic.net (envelope-from
 <mst@mellanox.co.il>); Sun, 10 Dec 2006 14:07:07 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with
 Microsoft SMTPSVC(6.0.3790.1830); Sun, 10 Dec 2006 23:08:46 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 10 Dec 2006
 23:11:33 +0200
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

> However, since about 1.4.4.1 or so, it now does the same filename 
> expansion as "git add" etc does, which means that you can give it a 
> directory name and it will check out everything under that directory, or 
> you can give it a pattern, and it should glob it. But it sounds like you 
> may have a slightly older version of git (the pathname matching really is 
> fairly recent).

Seems like this was post-1.4.4.1. Just updated to 1.4.4.2 and this works for me now,
thanks.

-- 
