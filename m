From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [0/5] Parsers for git objects, porting some programs
Date: Sun, 17 Apr 2005 22:33:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504172206460.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:29:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNM18-0001UV-FS
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVDRCdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVDRCdf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:33:35 -0400
Received: from iabervon.org ([66.92.72.58]:20742 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261317AbVDRCde (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:33:34 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNM58-0004zY-00; Sun, 17 Apr 2005 22:33:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504172206460.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series introduces common parsers for objects, and ports the programs
that currently use revision.h to them.

 1: the header files
 2: the implementations
 3: port rev-tree
 4: port fsck-cache
 5: port merge-base

	-Daniel
*This .sig left intentionally blank*

