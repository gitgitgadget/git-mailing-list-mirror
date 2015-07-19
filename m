From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/6] worktree: remove references to "git checkout --to" from the manpage
Date: Sat, 18 Jul 2015 19:10:54 -0700
Message-ID: <58c91f8907d5f3ef91607e85a96adcf0b1278e14.1437271363.git.mhagger@alum.mit.edu>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:11:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGe50-0008Qc-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbbGSCLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:11:37 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51645 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238AbbGSCLg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2015 22:11:36 -0400
X-AuditID: 1207440f-f79df6d000007c0f-21-55ab0758c407
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C7.2B.31759.8570BA55; Sat, 18 Jul 2015 22:11:36 -0400 (EDT)
Received: from localhost.localdomain ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6J2BUOc011238
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jul 2015 22:11:35 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1437271363.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBvBvjrU4Pp8HouuK91MFg29V5gt
	bq+Yz2zRPeUto8WZN42MDqwef99/YPLYOesuu8fFS8oeix94eXzeJBfAGsVtk5RYUhacmZ6n
	b5fAnfFsxkH2gvk8FecebWBqYJzN1cXIySEhYCKxtO8/O4QtJnHh3no2EFtI4DKjxNxJCV2M
	XED2eiaJNU+esYIk2AR0JRb1NDOB2CICmxglWl/ng9jMAg4Smz83MoLYwgIREj1nprOA2CwC
	qhKL/n8Cq+cViJK4sbiVEWKZnMT54z+ZQWxOAQuJSa9aoBabS9ye9495AiPvAkaGVYxyiTml
	ubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxghAcW/g7FrvcwhRgEORiUeXosvq0KFWBPL
	iitzDzFKcjApifKWvgIK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHNZ1wdKsSbklhZlVqUD5OS
	5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuBdwQrUKFiUmp5akZaZU4KQZuLgBBnOJSVS
	nJqXklqUWFqSEQ+KjPhiYGyApHiA9r4CaectLkjMBYpCtJ5iVJQS5w0ASQiAJDJK8+DGwtLE
	K0ZxoC+FeXnZgKp4gCkGrvsV0GAmoMGdq1eADC5JREhJNTDGvEw/fHwrk9ayQ7ynL6VY8H0O
	8txVkXXc0j6vVGrWFJd5yx6ZfF/s1P6r5XWvffrLIr6J+Ts/qpw0VZ1hVP/Q8e7nWwmfZjrN
	fsFVsttd2+ZLYUAu+5z0AP23Mvds6vcpv5Hdw3nnL9caE9ujO59w5ZrrZZw6/K/o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274185>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index c8dd0e5..707dfd0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -18,7 +18,7 @@ DESCRIPTION
 Manage multiple worktrees attached to the same repository.
 
 A git repository can support multiple working trees, allowing you to check
-out more than one branch at a time.  With `git checkout --to` a new working
+out more than one branch at a time.  With `git worktree add`, a new working
 tree is associated with the repository.  This new working tree is called a
 "linked working tree" as opposed to the "main working tree" prepared by "git
 init" or "git clone".  A repository has one main working tree (if it's not a
@@ -99,7 +99,7 @@ Each linked working tree has a private sub-directory in the repository's
 $GIT_DIR/worktrees directory.  The private sub-directory's name is usually
 the base name of the linked working tree's path, possibly appended with a
 number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
-command `git checkout --to /path/other/test-next next` creates the linked
+command `git worktree add /path/other/test-next next` creates the linked
 working tree in `/path/other/test-next` and also creates a
 `$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
 if `test-next` is already taken).
-- 
2.1.4
