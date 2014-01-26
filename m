From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] doc: remote author/documentation sections from more pages
Date: Mon, 27 Jan 2014 00:43:49 +0100
Message-ID: <1390779829-24168-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 00:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7ZNI-0006lU-3o
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 00:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbaAZXoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 18:44:20 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45092 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753401AbaAZXoS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 18:44:18 -0500
X-AuditID: 1207440f-b7f306d000006d99-f7-52e59dd15104
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.0C.28057.1DD95E25; Sun, 26 Jan 2014 18:44:17 -0500 (EST)
Received: from michael.fritz.box (p4FDD4D73.dip0.t-ipconnect.de [79.221.77.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0QNhqBv019652
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 26 Jan 2014 18:44:13 -0500
X-Mailer: git-send-email 1.8.5.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqHtx7tMgg6bjOhZdV7qZLBp6rzBb
	rFyzh9li3t1dTBb9y7vYLN7eXMJocXvFfGaL7ilvGS3mH5rI6sDp8ff9ByaPlWdrPXbOusvu
	8eFjnMell9/ZPC5eUvb4c34Pq8fnTXIBHFHcNkmJJWXBmel5+nYJ3BlnDi5jKTguW/F56XWm
	BsbPEl2MnBwSAiYSZ97vZYOwxSQu3FsPZHNxCAlcZpQ4dPk5K4Rzgkni86c+ZpAqNgFdiUU9
	zUwgtoiAmsTEtkMsIEXMAp+ZJPp/H2EBSQgLeEmsn7uFFcRmEVCVWHv2NzuIzSvgIrHs1V2g
	FRxA6xQkVl8XmsDIvYCRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZGSJjx
	72DsWi9ziFGAg1GJh/eF1ZMgIdbEsuLK3EOMkhxMSqK8V+Y8DRLiS8pPqcxILM6ILyrNSS0+
	xCjBwawkwpu3HqicNyWxsiq1KB8mJc3BoiTOq75E3U9IID2xJDU7NbUgtQgmK8PBoSTBuxBk
	qGBRanpqRVpmTglCmomDE0RwgWzgAdpwCKSQt7ggMbc4Mx2i6BSjopQ4rzhIQgAkkVGaBzcA
	lhBeMYoD/SPMmwdSxQNMJnDdr4AGMwENXrkP5PTikkSElFQD43rF6ep2Bcz7JTO3T0vYt7HQ
	L/f9/gNfpGY9Frj+NGPfC7Xb2xZ9X3Z27rNLhel7N0YXr31WZdb46YmxmYtRbE7s3b+fj9/5
	97p0noLDMePVq5RTv4g9OhzzaL7e13n/Qtj0ZH79/XUiTi+y20J1RdMU1l6m76o1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241118>

We decided at 48bb914e (doc: drop author/documentation sections from
most pages, 2011-03-11) to remove "author" and "documentation"
sections from our documentation.  Remove a few stragglers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
These deletions were assented to on the Git mailing list by the
persons whose names are thereby removed.  (I mention this fact without
implying that people mentioned in documentation hold a veto over their
names' removal.)

 Documentation/git-column.txt       | 4 ----
 Documentation/git-for-each-ref.txt | 8 --------
 Documentation/git-http-backend.txt | 7 -------
 Documentation/git-notes.txt        | 9 ---------
 Documentation/git-remote-ext.txt   | 4 ----
 Documentation/git-remote-fd.txt    | 3 ---
 6 files changed, 35 deletions(-)

diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 5d6f1cc..850449e 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -44,10 +44,6 @@ OPTIONS
 	The number of spaces between columns. One space by default.
 
 
-Author
-------
-Written by Nguyen Thai Ngoc Duy <pclouds@gmail.com>
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d639abe..4240875 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -219,14 +219,6 @@ eval=`git for-each-ref --shell --format="$fmt" \
 eval "$eval"
 ------------
 
-Author
-------
-Written by Junio C Hamano <gitster@pobox.com>.
-
-Documentation
--------------
-Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
-
 SEE ALSO
 --------
 linkgit:git-show-ref[1]
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index e3bcdb5..16706cf 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -263,13 +263,6 @@ identifying information of the remote user who performed the push.
 All CGI environment variables are available to each of the hooks
 invoked by the 'git-receive-pack'.
 
-Author
-------
-Written by Shawn O. Pearce <spearce@spearce.org>.
-
-Documentation
---------------
-Documentation by Shawn O. Pearce <spearce@spearce.org>.
 
 GIT
 ---
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 46ef046..ecf3fcf 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -376,15 +376,6 @@ If not set in the environment, the list of notes to copy depends
 on the `notes.rewrite.<command>` and `notes.rewriteRef` settings.
 
 
-Author
-------
-Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
-Johan Herland <johan@herland.net>
-
-Documentation
--------------
-Documentation by Johannes Schindelin and Johan Herland
-
 GIT
 ---
 Part of the linkgit:git[7] suite
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 8cfc748..e4d89a7 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -116,10 +116,6 @@ begins with `ext::`.  Examples:
 	determined by the helper using environment variables (see
 	above).
 
-Documentation
---------------
-Documentation by Ilari Liusvaara, Jonathan Nieder and the Git list
-<git@vger.kernel.org>
 
 GIT
 ---
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 933c2ad..768b512 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -50,9 +50,6 @@ EXAMPLES
 `git push fd::7,8/bar master`::
 	Same as above.
 
-Documentation
---------------
-Documentation by Ilari Liusvaara and the Git list <git@vger.kernel.org>
 
 GIT
 ---
-- 
1.8.5.2
