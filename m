From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/4] Writing refs in git-ssh-push
Date: Mon, 6 Jun 2005 16:27:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:43:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfOOD-00033n-Bw
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 22:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVFFUdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVFFUcS
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 16:32:18 -0400
Received: from iabervon.org ([66.92.72.58]:47876 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261682AbVFFU3P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 16:29:15 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfOC8-0006YB-00; Mon, 6 Jun 2005 16:27:36 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series adds -w to git-ssh-push (and git-ssh-pull, which is the same).

 - Add code for reading and writing ref files
 - Fix the environment variable for the path in rsh.c
 - Add support for transferring references in pull.c
 - Add support for refs in ssh protocol and options to invoke it

I'll send documentation updates in another patch this evening.

	-Daniel
*This .sig left intentionally blank*


