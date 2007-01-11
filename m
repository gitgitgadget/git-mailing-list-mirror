From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: tree corrupted on disk quota full
Date: Fri, 12 Jan 2007 00:39:05 +0200
Message-ID: <20070111223905.GP17999@mellanox.co.il>
References: <Pine.LNX.4.64.0701111410420.3594@woody.osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 23:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H58Zu-0001p5-NT
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbXAKWjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932807AbXAKWjU
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:39:20 -0500
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:59598 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbXAKWjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 17:39:19 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o145.mxlogic.net)
	by p02c11o145.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id 79cb6a54.1756785584.8727.00-503.p02c11o145.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 11 Jan 2007 15:39:19 -0700 (MST)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o145.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id 97cb6a54.2243996592.8640.00-014.p02c11o145.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 11 Jan 2007 15:38:49 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 12 Jan 2007 00:40:23 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri, 12 Jan 2007 00:37:19 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701111410420.3594@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 11 Jan 2007 22:40:23.0642 (UTC) FILETIME=[7B4CDBA0:01C735D1]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14930.000
X-TM-AS-Result: No--3.276100-4.000000-31
X-Spam: [F=0.0230661655; S=0.023(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36629>

> So this bug was _literally_ introduced three days ago, and it was 
> introduced by a set of patches that tried to _avoid_ the problem.
> 
> Sad. The old code was perfectly good. The new code was unsafe, but thought 
> it was better. See commit 93822c2239a336e5cb583549071c59202ef6c5b2 for 
> details.

Weird. I think the system where the tree got corrupted had git 1.4.4.4.

-- 
MST
