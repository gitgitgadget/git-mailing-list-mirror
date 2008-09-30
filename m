From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation: remove '\' in front of short options
Date: Tue, 30 Sep 2008 19:27:10 +0200
Message-ID: <20080930172710.GK6941@neumann>
References: <1222781831-6620-1-git-send-email-szeder@ira.uka.de>
	<200809301756.41518.trast@student.ethz.ch>
	<20080930172155.GJ6941@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 19:28:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkj1K-0003O9-B8
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 19:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbYI3R1L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Sep 2008 13:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYI3R1L
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 13:27:11 -0400
Received: from francis.fzi.de ([141.21.7.5]:14051 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752016AbYI3R1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 13:27:10 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 19:27:09 +0200
Content-Disposition: inline
In-Reply-To: <20080930172155.GJ6941@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 30 Sep 2008 17:27:09.0023 (UTC) FILETIME=[C44096F0:01C92321]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97134>

=2E.. because they show up in the man and html outputs.

This escaping is only needed for double dashes to be compatible with
older asciidoc versions;  see commit e1ccf53 ([PATCH] Escape asciidoc's
built-in em-dash replacement, 2005-09-12).

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 Documentation/git-rev-list.txt |    6 +++---
 Documentation/githooks.txt     |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-lis=
t.txt
index fd1de92..1c9cc28 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -32,9 +32,9 @@ SYNOPSIS
 	     [ \--cherry-pick ]
 	     [ \--encoding[=3D<encoding>] ]
 	     [ \--(author|committer|grep)=3D<pattern> ]
-	     [ \--regexp-ignore-case | \-i ]
-	     [ \--extended-regexp | \-E ]
-	     [ \--fixed-strings | \-F ]
+	     [ \--regexp-ignore-case | -i ]
+	     [ \--extended-regexp | -E ]
+	     [ \--fixed-strings | -F ]
 	     [ \--date=3D{local|relative|default|iso|rfc|short} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 046a2a7..7fefdb1 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -87,12 +87,12 @@ default log message, and before the editor is start=
ed.
=20
 It takes one to three parameters.  The first is the name of the file
 that the commit log message.  The second is the source of the commit
-message, and can be: `message` (if a `\-m` or `\-F` option was
-given); `template` (if a `\-t` option was given or the
+message, and can be: `message` (if a `-m` or `-F` option was
+given); `template` (if a `-t` option was given or the
 configuration option `commit.template` is set); `merge` (if the
 commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
 (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
-a commit SHA1 (if a `\-c`, `\-C` or `\--amend` option was given).
+a commit SHA1 (if a `-c`, `-C` or `\--amend` option was given).
=20
 If the exit status is non-zero, 'git-commit' will abort.
=20
--=20
1.6.0.2.448.g0c4e5
