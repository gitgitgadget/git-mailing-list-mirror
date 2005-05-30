From: Marcel Holtmann <marcel@holtmann.org>
Subject: cg-update with local uncommitted changes
Date: Mon, 30 May 2005 16:25:14 +0200
Message-ID: <1117463114.7072.185.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 16:23:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DclAI-0004wn-JR
	for gcvg-git@gmane.org; Mon, 30 May 2005 16:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVE3OZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 10:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVE3OZS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 10:25:18 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:60858 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261604AbVE3OZM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 10:25:12 -0400
Received: from pegasus (p5487D5D5.dip.t-dialin.net [84.135.213.213])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4UEQxSs032611
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 30 May 2005 16:27:00 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.85.1/899/Mon May 30 08:57:01 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

when doing a cg-update and I have local uncommitted changes it fails
with the "... needs update" message. From some previous posts on the
mailing list I got the impression that it is possible to pull updates
into the local repository with changed files. At the moment I am using
the following sequence:

	cg-diff > patch
	cg-cancel
	cg-update origin
	cat patch | patch -p1
	rm patch

The problem with this sequence is when I have added or removed files
from my repository. This needs a lot of manual fixing.

With Bitkeeper it was possible to pull changes as long as they don't
affect local uncommitted files.

Any ideas on how to implement or if it exists on how to use it?

Regards

Marcel


