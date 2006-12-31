From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: How to commit removed file?
Date: Sun, 31 Dec 2006 12:24:44 +0200
Message-ID: <20061231102444.GD26552@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 31 11:24:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0xrx-00023N-Mm
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 11:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbWLaKY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 05:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933119AbWLaKY2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 05:24:28 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:43657 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933116AbWLaKY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 05:24:27 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.1-5)
	with ESMTP id adf87954.1738890160.65615.00-005.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 31 Dec 2006 03:24:26 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 31 Dec 2006 12:26:40 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 31 Dec 2006 12:29:46 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 31 Dec 2006 10:26:40.0875 (UTC) FILETIME=[292473B0:01C72CC6]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14904.000
X-TM-AS-Result: No--1.084100-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35690>

I'd like to remove a file and commit the removal while
leaving out other changes in repository/index.

$git rm kernel_patches/fixes/ib_verbs_warning_fix.patch
rm 'kernel_patches/fixes/ib_verbs_warning_fix.patch'

$ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
error: pathspec 'kernel_patches/fixes/ib_verbs_warning_fix.patch' did not match
any file(s) known to git.
Did you forget to 'git add'?

A similiar thing works with "git add".


-- 
MST
