From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-711084@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:06:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNog8-0005V9-Tz
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVDSJJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDSJJr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:09:47 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:49550 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261254AbVDSJJm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 05:09:42 -0400
Received: (qmail 23321 invoked by uid 5006); 19 Apr 2005 02:09:39 -0700
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm working on an OO perl alternative to Petr's git scripts, which I'm
currently calling "yogi" (your other git interface).  While I'm not
ready to release that just yet, I wanted to start floating some patches to
the core plumbing to support the respective packages' potentially
divergent demands.  For those die-hard perl hackers, I can float you a copy
of the package off-list if you're interested; I'm hoping to finish a public
0.0.1 release by the end of the week.

The first two patches in the series are already in the pasky.git repository,
but Linus hasn't merged them yet.  The are included only because the next 
few patches expect them to be in place.

The third patch in the series prepares for the forth patch by factoring 
the object directory detection and creation functionality.  The fifth patch
makes one final pass at cleaning up init-db.  The 3rd and 5th patches aren't 
particularly valuable unless the remaining patches are also applied, but 
they do make the code a bit prettier.  To me, at least.

The remaining patches (4,6,7,8) add the ability for the '.git' index directory 
to be overridden in the same manner as the object directory.  This allows
me to create my own independent '.yogi' trees, the very notion of which
may cause this whole series to be henceforth flamed into oblivion.

Here's to hoping otherwise....

Cheers,

Zach Welch
Superlucidity Services

These patches are based off commit 5b53d3a08d64198d26d4f2323f235790c04aeaab.

There are 8 patches in this series:
        [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
        [PATCH 2/8] init-db.c: [RESEND] make init-db work with common objects
        [PATCH 3/8] init-db.c: refactor directory creation
        [PATCH 4/8] init-db.c: add INDEX_FILE_DIRECTORY support
        [PATCH 5/8] init-db.c: refactor mkdir logic
        [PATCH 6/8] read-cache.c: add INDEX_FILE_DIRECTORY support
        [PATCH 7/8] read-tree.c: add INDEX_FILE_DIRECTORY support
        [PATCH 8/8] update-cache.c: add INDEX_FILE_DIRECTORY support
