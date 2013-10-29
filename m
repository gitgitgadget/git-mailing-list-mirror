From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 6/7] Documentation: put blame/log -L in sticked form
Date: Tue, 29 Oct 2013 08:20:39 +0100
Message-ID: <c41aef218951f8b0ec6a20e1dbc39712ad13afce.1383031141.git.tr@thomasrast.ch>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 08:21:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3cB-0006Ma-1x
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab3J2HVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:21:09 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:56267 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982Ab3J2HVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:21:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 0DD744D65A8;
	Tue, 29 Oct 2013 08:21:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qSzQEPLw-odO; Tue, 29 Oct 2013 08:21:05 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 564444D6414;
	Tue, 29 Oct 2013 08:21:03 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2.838.ga9a3e20
In-Reply-To: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
In-Reply-To: <cover.1383031141.git.tr@thomasrast.ch>
References: <cover.1383031141.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236898>

The next patch will document gitk -L, but gitk does not understand the
separated form ('gitk -L :foo:bar' results in an error).  Spell
git-blame and git-log -L, which are supposed to be "the same" option,
without the spaces to prevent confusion.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 Documentation/blame-options.txt | 8 ++++----
 Documentation/git-blame.txt     | 8 ++++----
 Documentation/git-log.txt       | 6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 0cebc4f..28ca95e 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -9,13 +9,13 @@
 --show-stats::
 	Include additional statistics at the end of blame output.
 
--L <start>,<end>::
--L :<regex>::
+-L<start>,<end>::
+-L:<regex>::
 	Annotate only the given line range. May be specified multiple times.
 	Overlapping ranges are allowed.
 +
-<start> and <end> are optional. ``-L <start>'' or ``-L <start>,'' spans from
-<start> to end of file. ``-L ,<end>'' spans from start of file to <end>.
+<start> and <end> are optional. ``-L<start>'' or ``-L<start>,'' spans from
+<start> to end of file. ``-L,<end>'' spans from start of file to <end>.
 +
 include::line-range-format.txt[]
 
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index f2c85cc..085dba1 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
-	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	    [-L<range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
 DESCRIPTION
@@ -139,12 +139,12 @@ lines 40-60 for file `foo`, you can use the `-L` option like so
 (they mean the same thing -- both ask for 21 lines starting at
 line 40):
 
-	git blame -L 40,60 foo
-	git blame -L 40,+21 foo
+	git blame -L40,60 foo
+	git blame -L40,+21 foo
 
 Also you can use a regular expression to specify the line range:
 
-	git blame -L '/^sub hello {/,/^}$/' foo
+	git blame -L'/^sub hello {/,/^}$/' foo
 
 which limits the annotation to the body of the `hello` subroutine.
 
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 34097ef..87c10fa 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -62,8 +62,8 @@ produced by --stat etc.
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
--L <start>,<end>:<file>::
--L :<regex>:<file>::
+-L<start>,<end>:<file>::
+-L:<regex>:<file>::
 
 	Trace the evolution of the line range given by "<start>,<end>"
 	(or the funcname regex <regex>) within the <file>.  You may
@@ -152,7 +152,7 @@ EXAMPLES
 	This makes sense only when following a strict policy of merging all
 	topic branches when staying on a single integration branch.
 
-`git log -L '/int main/',/^}/:main.c`::
+`git log -L'/int main/',/^}/:main.c`::
 
 	Shows how the function `main()` in the file 'main.c' evolved
 	over time.
-- 
1.8.4.2.838.ga9a3e20
