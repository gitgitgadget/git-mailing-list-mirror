From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/4] Pulling refs files
Date: Fri, 13 May 2005 02:49:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 08:42:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWTsY-00082M-Al
	for gcvg-git@gmane.org; Fri, 13 May 2005 08:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVEMGuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 02:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVEMGuF
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 02:50:05 -0400
Received: from iabervon.org ([66.92.72.58]:40197 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262263AbVEMGtx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 02:49:53 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWTzB-0007nS-00; Fri, 13 May 2005 02:49:25 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series makes the following changes:

 1: Adds support for having the C code know about the general existance of
    .git/refs, and functions for writing these files.
 2: Adds support in the generic pull code for fetching refs (and dummy
    implementations).
 3: Adds support in the HTTP pull code for fetching refs
 4: Adds support in the rsh pull code for fetching refs; this requires
    changes to the protocol. These changes should be sufficient to support
    any future extension, however.

	-Daniel
*This .sig left intentionally blank*

