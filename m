From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: How to merge FETCH_HEAD?
Date: Tue, 16 Jan 2007 19:37:18 +0200
Message-ID: <20070116173706.GB20898@mellanox.co.il>
References: <20070116162645.GA18894@informatik.uni-freiburg.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 16 18:38:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6sF2-00043l-NZ
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 18:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbXAPRg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 12:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXAPRg5
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 12:36:57 -0500
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:60926 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbXAPRg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 12:36:56 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.2-1)
	with ESMTP id 83d0da54.2637970352.2382.00-016.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Tue, 16 Jan 2007 10:36:56 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 Jan 2007 19:38:38 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue, 16 Jan 2007 19:35:40 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070116162645.GA18894@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 16 Jan 2007 17:38:39.0048 (UTC) FILETIME=[282FCC80:01C73995]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14938.003
X-TM-AS-Result: No--0.141200-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36950>

OK, I did a fetch and now I can see remote history by

$git log FETCH_HEAD

But, how to merge it?

$ git pull . FETCH_HEAD
error: no such remote ref refs/heads/FETCH_HEAD
Fetch failure: .

$git merge FETCH_HEAD
FETCH_HEAD - not something we can merge

So, how can I merge this without an extra fetch?

-- 
MST
