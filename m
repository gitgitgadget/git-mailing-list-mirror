From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: failed to read delta-pack.
Date: Mon, 1 Jan 2007 11:49:23 +0200
Message-ID: <20070101094923.GC14793@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 01 10:49:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1JnB-00050i-F4
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 10:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbXAAJtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 04:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbXAAJtM
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 04:49:12 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:59419 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbXAAJtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 04:49:11 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.1-5)
	with ESMTP id 619d8954.1703513008.38069.00-011.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 01 Jan 2007 02:49:10 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Jan 2007 11:51:20 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  1 Jan 2007 11:54:28 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Jan 2007 09:51:21.0109 (UTC) FILETIME=[64139450:01C72D8A]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14908.002
X-TM-AS-Result: No--3.915400-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35735>

I'm getting this with git 1.4.4.3:

remote: Generating pack...
remote: Done counting 1294 objects.
remote: Result has 916 objects.
remote: Deltifying 916 objects.
remote:  100% (916/916) done
Unpacking 916 objects
remote: Total 916, written 916 (delta 758), reused 0 (delta 0)
error: failed to read delta-pack base object
b47ceb21cfed93f410e6329040784d43864dab33
fatal: unpack-objects died with error code 1
Fetch failure: /mswg2/git/linux-2.6/.git

-- 
MST
