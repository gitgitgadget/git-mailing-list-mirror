From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git rebase: unexpected conflict
Date: Fri, 9 Feb 2007 12:23:23 +0200
Message-ID: <20070209102323.GV6560@mellanox.co.il>
References: <7vabzp7lgs.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 11:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFSuP-0004EF-Ak
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 11:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946319AbXBIKW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 05:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946311AbXBIKW5
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 05:22:57 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:33245 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946323AbXBIKW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 05:22:56 -0500
Received: from unknown [63.251.237.3] (EHLO mtiexch01.mti.com)
	by p02c11o144.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 08b4cc54.2216508336.3912.00-001.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 09 Feb 2007 03:22:56 -0700 (MST)
Received: from mtlexch01.mtl.com ([10.0.8.11]) by mtiexch01.mti.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Feb 2007 02:25:55 -0800
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Feb 2007 12:25:03 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri,  9 Feb 2007 12:20:46 +0200
Content-Disposition: inline
In-Reply-To: <7vabzp7lgs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 09 Feb 2007 10:25:03.0408 (UTC) FILETIME=[8F922B00:01C74C34]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14986.003
X-TM-AS-Result: No--10.269200-4.000000-31
X-Spam: [F=0.0883213769; S=0.088(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39173>

> > 2. It's unfortunate that I need a temp file here.
> > Can git-am get stdin somehow?
> 
> See "git-rebase.sh" around ll.325.

git-am can read standard input. Document this.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

--

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index f7d551e..77ef103 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -21,6 +21,10 @@ current branch.
 
 OPTIONS
 -------
+<mbox>...::
+	The list of mailbox files to read patches from. If you do not
+	supply this argument, reads from the standard input.
+
 --signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.

-- 
MST
