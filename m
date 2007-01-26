From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git merge FETCH_HEAD produced bad commit message
Date: Fri, 26 Jan 2007 16:42:46 +0200
Message-ID: <20070126144246.GQ10812@mellanox.co.il>
References: <81b0412b0701260632l2181ef10i8d49ee9a795228b7@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 15:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HASHa-0002HL-0F
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 15:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030635AbXAZOmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 09:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbXAZOmW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 09:42:22 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:57961 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030635AbXAZOmV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 09:42:21 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-4.0.2-1)
	with ESMTP id d431ab54.1784146864.4646.00-017.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 26 Jan 2007 07:42:21 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 26 Jan 2007 16:44:13 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri, 26 Jan 2007 16:41:30 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0701260632l2181ef10i8d49ee9a795228b7@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 26 Jan 2007 14:44:14.0034 (UTC) FILETIME=[72AEE320:01C74158]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14958.003
X-TM-AS-Result: No--3.797300-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37862>

> What is the point then?

That
	git fetch <url>
	git merge FETCH_HEAD
should be equivalent to
	git pull <url>
and it isn't

-- 
MST
