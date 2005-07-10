From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Support for packs in HTTP
Date: Sun, 10 Jul 2005 15:53:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101539220.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jul 10 22:02:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dri02-0008RU-9w
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 22:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVGJT7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 15:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVGJT4c
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 15:56:32 -0400
Received: from iabervon.org ([66.92.72.58]:38660 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262090AbVGJTzP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 15:55:15 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Drhra-00078S-00; Sun, 10 Jul 2005 15:53:18 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series has one patch which is ready to go in and one that's not
(although it's a reasonable phony for the current state of the git world).

 1: Several additional functions are needed in the library to support
    progressively getting pack data from some remote location and using it
    to determine what else to get.

 2: git-http-pull can get packs as appropriate by getting all the index
    files first, and then using them to figure out whether the object it's
    looking for is in some pack it could get.

Currently, there's no sane way to figure out what pack/index files are
available from an HTTP server. But there only seems to be one pack file
available on an HTTP server at the moment, so this tries to get that
one.

	-Daniel
*This .sig left intentionally blank*
