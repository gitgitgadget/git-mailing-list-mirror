From: "Sean" <seanlkml@sympatico.ca>
Subject: cg-log patches
Date: Sun, 8 May 2005 13:35:50 -0400 (EDT)
Message-ID: <1742.10.10.10.24.1115573750.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 19:32:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpdA-00084I-Gm
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVEHRhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVEHRhw
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:37:52 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:3288 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262907AbVEHRfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 13:35:51 -0400
Received: from linux1 ([69.156.111.46]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508173550.IRZR1834.simmts6-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 13:35:50 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48HZnUk026666;
	Sun, 8 May 2005 13:35:49 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 13:35:50 -0400 (EDT)
To: "Petr Baudis" <pasky@ucw.cz>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

A few minor cg-log patches outlined below available for you at:
http://git.homelinux.com/cogito


commit ce5e8e645754f3051ce3b3cf87c085544339acef

    Permit cg-log command line options to be given in any order

commit a1c2b474ad39750a07a43ddee2682f5613624652

    Make sure that CC: and From: lines are picked up as a valid
    part of the sign off process and given the proper color

commit 33762f33ee87377c0cfcea51382bad04d7c9ba8d

    Fix cg-log -f option so that a complete list of files is
    displayed when a commit has more than one parent.

    Move the list of files so they're displayed after the
    commit message

    List the files in columns, instead of one big line of comma-
    separated files.

---
cg-log | 135
++++++++++++++++++++++++++---------------------------------------
 1 files changed, 56 insertions(+), 79 deletions(-)

Cheers,
Sean


