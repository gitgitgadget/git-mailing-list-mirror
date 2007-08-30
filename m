From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: parallel make problem with git
Date: Thu, 30 Aug 2007 09:38:10 +0300
Message-ID: <20070830063810.GD16312@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 08:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQdgR-0005NK-11
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 08:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbXH3GjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 02:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbXH3GjM
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 02:39:12 -0400
Received: from p02c11o142.mxlogic.net ([208.65.144.75]:51931 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbXH3GjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 02:39:10 -0400
Received: from unknown [194.90.237.34] (EHLO p02c11o142.mxlogic.net)
	by p02c11o142.mxlogic.net (mxl_mta-5.1.0-1)
	with ESMTP id e0666d64.1775381424.282209.00-509.p02c11o142.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Thu, 30 Aug 2007 00:39:10 -0600 (MDT)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-5.1.0-1)
	with ESMTP id 7f566d64.2520161200.282073.00-004.p02c11o142.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Thu, 30 Aug 2007 00:38:47 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Aug 2007 09:41:03 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 30 Aug 2007 09:37:26 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Aug 2007 06:41:03.0017 (UTC) FILETIME=[BBEAC190:01C7EAD0]
X-Spam: [F=0.0100000000; S=0.010(2007082901); SS=0.500]
X-MAIL-FROM: <mst@dev.mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57004>

Try this
$ git describe
v1.5.3-rc7
$make clean
$make -j 4
#... builds ok
$touch revision.c
$make -j 4
    CC revision.o
    AR libgit.a
    LINK git-fetch-pack
    LINK git-convert-objects
    LINK git-hash-object
    LINK git-index-pack
    LINK git-local-fetch
    LINK git-fast-import
    LINK git-daemon
    LINK git-mktag
    LINK git-merge-index
    LINK git-mktree
    LINK git-patch-id
    LINK git-peek-remote
    LINK git-receive-pack
    LINK git-send-pack
    LINK git-shell
    LINK git-show-index
    LINK git-ssh-fetch
    LINK git-ssh-upload
    LINK git-unpack-file
    LINK git-update-server-info
    LINK git-upload-pack
    LINK git-pack-redundant
    LINK git-var
    LINK git-merge-tree
    LINK git-imap-send
    LINK git-merge-recursive
    LINK git-ssh-pull
    LINK git-ssh-push
    LINK git-http-fetch
    LINK git-http-push
    LINK git
    LINK test-chmtime
gcc: test-chmtime.o: No such file or directory
make: *** [test-chmtime] Error 1
make: *** Waiting for unfinished jobs....

Any ideas?

-- 
MST
