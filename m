From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-relink.txt: describe more clearly how hard linking occurs
Date: Fri, 11 Jan 2008 12:14:19 -0600
Message-ID: <4787B1FB.3020500@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDOPp-0004Ii-M2
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760108AbYAKSPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759783AbYAKSPJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:15:09 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45236 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759302AbYAKSPI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:15:08 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0BIEJuT019873;
	Fri, 11 Jan 2008 12:14:20 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Jan 2008 12:14:19 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 11 Jan 2008 18:14:19.0695 (UTC) FILETIME=[C8D29BF0:01C8547D]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15652001
X-TM-AS-Result: : Yes--5.645800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDE0MC03MDAx?=
	=?us-ascii?B?NjAtNzA0NDEwLTE4ODAxOS03MDQ5MjctNzAxMTYzLTcwNDU2OC03?=
	=?us-ascii?B?MDIxNzEtMTA1MjUwLTcwMzgwNy03MTE5NTMtNzEwODQyLTE0ODAz?=
	=?us-ascii?B?OS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70182>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Documentation/git-relink.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index ccbda9f..06a3e32 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -7,12 +7,13 @@ git-relink - Hardlink common objects in local repositories
 
 SYNOPSIS
 --------
-'git-relink' [--safe] <dir> <dir> [<dir>]\*
+'git-relink' [--safe] <dir> [<dir>]\* <master_dir>
 
 DESCRIPTION
 -----------
-This will scan 2 or more object repositories and look for common objects, check
-if they are hardlinked, and replace one with a hardlink to the other if not.
+This will scan 1 or more object repositories and look for objects in common
+with a master repository. Objects not already hardlinked to the master
+repository will be replaced with a hardlink to the master repository.
 
 OPTIONS
 -------
-- 
1.5.4.rc2.84.gf85fd-dirty
