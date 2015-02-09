From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/8] reflog: rearrange the manpage
Date: Mon,  9 Feb 2015 10:12:41 +0100
Message-ID: <1423473164-6011-6-git-send-email-mhagger@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:13:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkP3-0007jN-Gz
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbbBIJND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:13:03 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56368 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932512AbbBIJNA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:13:00 -0500
X-AuditID: 1207440d-f79976d000005643-53-54d87a1b1cfb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 41.7D.22083.B1A78D45; Mon,  9 Feb 2015 04:12:59 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQb026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:12:58 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqCtddSPE4MdeGYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZ16c9Ziq4o1pxf+E0xgbGV3JdjJwcEgImEp/fXmCHsMUkLtxbz9bF
	yMUhJHCZUeLBpl9Qzgkmie3Xv7OAVLEJ6Eos6mlmArFFBNQkJrYdAoszC6xmkth6lw3EFhYw
	klizaifYVBYBVYkn/UvBangFnCUOfFzNCLFNTuL88Z/MIDangIvEu3NzwHqFgGpmT97HPIGR
	dwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkDDj3cH4f53MIUYBDkYl
	Ht4Ln6+HCLEmlhVX5h5ilORgUhLlXZB4I0SILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO/3DKAc
	b0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCl6sSqFGwKDU9tSItM6cE
	Ic3EwQkynEtKpDg1LyW1KLG0JCMeFBvxxcDoAEnxAO39WgGyt7ggMRcoCtF6ilFRSpz3G0hC
	ACSRUZoHNxaWPF4xigN9KczLCbKdB5h44LpfAQ1mAhpcUAA2uCQRISXVwKh/bN3lP6kVH/4f
	zjV3ffcvfZPe+6nf31TH8r5azenEmmG9JmzmoQC5qDfxK45Zv3xoIbAtQsSx8pbb48eT5/Q1
	lxw26qjZcjni7E7zqA0Lyh+e/h+odPL+z97V1/YKXn/41vLk69p9tyV4Ffyqj7r6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263549>

Rearrange the "git reflog" manpage to list more common operations
earlier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-reflog.txt | 56 ++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index b410ee6..f15a48e 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,21 +17,21 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
+'git reflog' ['show'] [log-options] [<ref>]
 'git reflog expire' [--dry-run] [--verbose]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
 'git reflog delete' [--dry-run] [--verbose]
 	[--rewrite] [--updateref] ref@\{specifier\}...
-'git reflog' ['show'] [log-options] [<ref>]
 
-Reflog is a mechanism to record when the tip of branches are
-updated.  This command is to manage the information recorded in it.
+Reflog is a mechanism to record when the tips of branches are updated.
+The reflog is useful in various Git commands, to specify the old value
+of a reference. For example, `HEAD@{2}` means "where HEAD used to be
+two moves ago", `master@{one.week.ago}` means "where master used to
+point to one week ago", and so on. See linkgit:gitrevisions[7] for
+more details.
 
-The subcommand "expire" is used to prune older reflog entries.
-Entries older than `expire` time, or entries older than
-`expire-unreachable` time and not reachable from the current
-tip, are removed from the reflog.  This is typically not used
-directly by the end users -- instead, see linkgit:git-gc[1].
+This command manages the information recorded in the reflog.
 
 The subcommand "show" (which is also the default, in the absence of any
 subcommands) will take all the normal log options, and show the log of
@@ -40,11 +40,11 @@ The reflog will cover all recent actions (HEAD reflog records branch switching
 as well).  It is an alias for `git log -g --abbrev-commit --pretty=oneline`;
 see linkgit:git-log[1].
 
-The reflog is useful in various Git commands, to specify the old value
-of a reference. For example, `HEAD@{2}` means "where HEAD used to be
-two moves ago", `master@{one.week.ago}` means "where master used to
-point to one week ago", and so on. See linkgit:gitrevisions[7] for
-more details.
+The subcommand "expire" is used to prune older reflog entries.
+Entries older than `expire` time, or entries older than
+`expire-unreachable` time and not reachable from the current
+tip, are removed from the reflog.  This is typically not used
+directly by the end users -- instead, see linkgit:git-gc[1].
 
 To delete single entries from the reflog, use the subcommand "delete"
 and specify the _exact_ entry (e.g. "`git reflog delete master@{2}`").
@@ -53,19 +53,6 @@ and specify the _exact_ entry (e.g. "`git reflog delete master@{2}`").
 OPTIONS
 -------
 
---stale-fix::
-	This revamps the logic -- the definition of "broken commit"
-	becomes: a commit that is not reachable from any of the refs and
-	there is a missing object among the commit, tree, or blob
-	objects reachable from it that is not reachable from any of the
-	refs.
-+
-This computation involves traversing all the reachable objects, i.e. it
-has the same cost as 'git prune'.  Fortunately, once this is run, we
-should not have to ever worry about missing objects, because the current
-prune and pack-objects know about reflogs and protect objects referred by
-them.
-
 --expire=<time>::
 	Entries older than this time are pruned.  Without the
 	option it is taken from configuration `gc.reflogExpire`,
@@ -83,8 +70,18 @@ them.
 	turns off early pruning of unreachable entries (but see
 	--expire).
 
---all::
-	Instead of listing <refs> explicitly, prune all refs.
+--stale-fix::
+	This revamps the logic -- the definition of "broken commit"
+	becomes: a commit that is not reachable from any of the refs and
+	there is a missing object among the commit, tree, or blob
+	objects reachable from it that is not reachable from any of the
+	refs.
++
+This computation involves traversing all the reachable objects, i.e. it
+has the same cost as 'git prune'.  Fortunately, once this is run, we
+should not have to ever worry about missing objects, because the current
+prune and pack-objects know about reflogs and protect objects referred by
+them.
 
 --updateref::
 	Update the ref with the sha1 of the top reflog entry (i.e.
@@ -98,6 +95,9 @@ them.
 --verbose::
 	Print extra information on screen.
 
+--all::
+	Instead of listing <refs> explicitly, prune all refs.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.1.4
