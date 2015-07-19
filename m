From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/6] worktree: the "locked" mechanism is already implemented
Date: Sat, 18 Jul 2015 19:10:56 -0700
Message-ID: <afdc2580349017ae26aade63c9e5ea2b4a986beb.1437271363.git.mhagger@alum.mit.edu>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:11:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGe55-0008Qc-JJ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbbGSCLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:11:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50139 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752494AbbGSCLj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2015 22:11:39 -0400
X-AuditID: 1207440c-f79e16d000002a6e-94-55ab075adc31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A9.11.10862.A570BA55; Sat, 18 Jul 2015 22:11:38 -0400 (EDT)
Received: from localhost.localdomain ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6J2BUOe011238
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jul 2015 22:11:37 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1437271363.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqBvFvjrUYMIBCYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WZN42MDqwef99/YPLYOesuu8fFS8oeix94eXzeJBfAGsVtk5RYUhacmZ6n
	b5fAnTHp2XaWghOsFffPzmNvYDzB0sXIySEhYCJxaNFXRghbTOLCvfVsXYxcHEIClxklZt4/
	wwjhrGeSuL/tHzNIFZuArsSinmYmEFtEYBOjROvrfBCbWcBBYvPnRrBJwgI+El3vV7OD2CwC
	qhKdky6wgti8AlESz7v7obbJSZw//hNsJqeAhcSkVy1sILaQgLnE7Xn/mCcw8i5gZFjFKJeY
	U5qrm5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJERJSPDsYv62TOcQowMGoxMNr8WVVqBBr
	YllxZe4hRkkOJiVR3tJXQCG+pPyUyozE4oz4otKc1OJDjBIczEoivPmMq0OFeFMSK6tSi/Jh
	UtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvCpsQI2CRanpqRVpmTklCGkmDk6Q4VxS
	IsWpeSmpRYmlJRnxoNiILwZGB0iKB2jvK1aQvcUFiblAUYjWU4y6HAt+3F7LJMSSl5+XKiXO
	6wCyQwCkKKM0D24FLIG8YhQH+liYtxmkigeYfOAmvQJawgS0pHP1CpAlJYkIKakGxub5x2Wc
	Pxe++rMoNWZ+4HrpK8wS3+JET1f/W3okleOXwvvWy9pLeEOzvO9bPjs6M8OWYfmiPO+Qg2ui
	k4TZ1u+9u3jRvxx/7382ShNEltV0pr/foq5dWyj07ZZM6uRrxtfZ8moWJPh2fJz8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274191>

So remove it from the "BUGS" section.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-worktree.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 6cb3877..d5aeda0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -167,8 +167,6 @@ performed manually, such as:
   warn if the worktree is dirty)
 - `mv` to move or rename a worktree and update its administrative files
 - `list` to list linked working trees
-- `locked` to prevent automatic pruning of administrative files (for instance,
-  for a worktree on a portable device)
 
 GIT
 ---
-- 
2.1.4
