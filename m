From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 5/7] reflog: improve and update documentation
Date: Tue,  3 Mar 2015 12:43:15 +0100
Message-ID: <1425382997-24984-6-git-send-email-mhagger@alum.mit.edu>
References: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSlEv-0003ti-23
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbbCCLnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:43:49 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48082 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756414AbbCCLnr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:43:47 -0500
X-AuditID: 12074413-f79f26d0000030e7-c9-54f59e6abdd5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id EC.70.12519.A6E95F45; Tue,  3 Mar 2015 06:43:39 -0500 (EST)
Received: from michael.fritz.box (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BhJqI016748
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:43:36 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqJs972uIQd8rJouuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLX609DBb9PZ9YrXYvLmdxeLMm0ZGB06Pv+8/MHnsnHWX3WPBplKP
	Z717GD0uXlL2WPzAy+PzJrkA9ihum6TEkrLgzPQ8fbsE7oz7XyewFGxzq3i46g5TA+NUqy5G
	Tg4JAROJTcsnM0LYYhIX7q1n62Lk4hASuMwosfDLDSjnGJPE9SfzWUGq2AR0JRb1NDOB2CIC
	ahIT2w6xgNjMAj+YJA6tqAWxhQUcJM5fvQEWZxFQlXh4YBIziM0r4CIx4ftDVohtchLnj/8E
	i3MKuEqsXLsVKM4BtMxF4taHigmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW
	6KWmlG5ihISi8A7GXSflDjEKcDAq8fBOYP8aIsSaWFZcmXuIUZKDSUmUV342UIgvKT+lMiOx
	OCO+qDQntfgQowQHs5IIL/NcoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxW
	hoNDSYJXH6RRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDt/TkH
	ZG9xQWIuUBSi9RSjopQ4ryzIXAGQREZpHtxYWIJ5xSgO9KUwbzxIFQ8wOcF1vwIazAQ0+Jbi
	F5DBJYkIKakGRoGPuUf51afGxx14lXFZ93T2/pSF+48mzRczYDyl9d+AYynnjxmqPDwyX7Oy
	5qi8P/LkVW7F4webZruc4L19RefF+ouH9u6TmSLQ8+ZQzpc7HydZKca+D6p33NM7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264655>

Revamp the "git reflog" usage documentation in the manpage and the
command help to match the current reality and improve its clarity:

* Add documentation for some options that had been left out.

* Group the subcommands and options more logically and move more
  common subcommands/options higher.

* Improve some explanations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-reflog.txt | 143 +++++++++++++++++++++++++------------------
 builtin/reflog.c             |   9 +--
 2 files changed, 88 insertions(+), 64 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 70791b9..730106c 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,85 +17,112 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog expire' [--dry-run] [--stale-fix] [--verbose]
-	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
-'git reflog delete' ref@\{specifier\}...
 'git reflog' ['show'] [log-options] [<ref>]
+'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
+	[--rewrite] [--updateref] [--stale-fix]
+	[--dry-run] [--verbose] [--all | <refs>...]
+'git reflog delete' [--rewrite] [--updateref]
+	[--dry-run] [--verbose] ref@\{specifier\}...
+
+Reference logs, or "reflogs", record when the tips of branches and
+other references were updated in the local repository. Reflogs are
+useful in various Git commands, to specify the old value of a
+reference. For example, `HEAD@{2}` means "where HEAD used to be two
+moves ago", `master@{one.week.ago}` means "where master used to point
+to one week ago in this local repository", and so on. See
+linkgit:gitrevisions[7] for more details.
+
+This command manages the information recorded in the reflogs.
+
+The "show" subcommand (which is also the default, in the absence of
+any subcommands) shows the log of the reference provided in the
+command-line (or `HEAD`, by default). The reflog covers all recent
+actions, and in addition the `HEAD` reflog records branch switching.
+`git reflog show` is an alias for `git log -g --abbrev-commit
+--pretty=oneline`; see linkgit:git-log[1] for more information.
+
+The "expire" subcommand prunes older reflog entries. Entries older
+than `expire` time, or entries older than `expire-unreachable` time
+and not reachable from the current tip, are removed from the reflog.
+This is typically not used directly by end users -- instead, see
+linkgit:git-gc[1].
+
+The "delete" subcommand deletes single entries from the reflog. Its
+argument must be an _exact_ entry (e.g. "`git reflog delete
+master@{2}`"). This subcommand is also typically not used directly by
+end users.
 
-Reflog is a mechanism to record when the tip of branches are
-updated.  This command is to manage the information recorded in it.
 
-The subcommand "expire" is used to prune older reflog entries.
-Entries older than `expire` time, or entries older than
-`expire-unreachable` time and not reachable from the current
-tip, are removed from the reflog.  This is typically not used
-directly by the end users -- instead, see linkgit:git-gc[1].
-
-The subcommand "show" (which is also the default, in the absence of any
-subcommands) will take all the normal log options, and show the log of
-the reference provided in the command-line (or `HEAD`, by default).
-The reflog will cover all recent actions (HEAD reflog records branch switching
-as well).  It is an alias for `git log -g --abbrev-commit --pretty=oneline`;
-see linkgit:git-log[1].
+OPTIONS
+-------
 
-The reflog is useful in various Git commands, to specify the old value
-of a reference. For example, `HEAD@{2}` means "where HEAD used to be
-two moves ago", `master@{one.week.ago}` means "where master used to
-point to one week ago", and so on. See linkgit:gitrevisions[7] for
-more details.
+Options for `show`
+~~~~~~~~~~~~~~~~~~
 
-To delete single entries from the reflog, use the subcommand "delete"
-and specify the _exact_ entry (e.g. "`git reflog delete master@{2}`").
+`git reflog show` accepts any of the options accepted by `git log`.
 
 
-OPTIONS
--------
+Options for `expire`
+~~~~~~~~~~~~~~~~~~~~
 
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
+--all::
+	Process the reflogs of all references.
 
 --expire=<time>::
-	Entries older than this time are pruned.  Without the
-	option it is taken from configuration `gc.reflogExpire`,
-	which in turn defaults to 90 days.  --expire=all prunes
-	entries regardless of their age; --expire=never turns off
-	pruning of reachable entries (but see --expire-unreachable).
+	Prune entries older than the specified time. If this option is
+	not specified, the expiration time is taken from the
+	configuration setting `gc.reflogExpire`, which in turn
+	defaults to 90 days. `--expire=all` prunes entries regardless
+	of their age; `--expire=never` turns off pruning of reachable
+	entries (but see `--expire-unreachable`).
 
 --expire-unreachable=<time>::
-	Entries older than this time and not reachable from
-	the current tip of the branch are pruned.  Without the
-	option it is taken from configuration
-	`gc.reflogExpireUnreachable`, which in turn defaults to
-	30 days.  --expire-unreachable=all prunes unreachable
-	entries regardless of their age; --expire-unreachable=never
+	Prune entries older than `<time>` that are not reachable from
+	the current tip of the branch. If this option is not
+	specified, the expiration time is taken from the configuration
+	setting `gc.reflogExpireUnreachable`, which in turn defaults
+	to 30 days. `--expire-unreachable=all` prunes unreachable
+	entries regardless of their age; `--expire-unreachable=never`
 	turns off early pruning of unreachable entries (but see
-	--expire).
-
---all::
-	Instead of listing <refs> explicitly, prune all refs.
+	`--expire`).
 
 --updateref::
-	Update the ref with the sha1 of the top reflog entry (i.e.
-	<ref>@\{0\}) after expiring or deleting.
+	Update the reference to the value of the top reflog entry (i.e.
+	<ref>@\{0\}) if the previous top entry was pruned.
 
 --rewrite::
-	While expiring or deleting, adjust each reflog entry to ensure
-	that the `old` sha1 field points to the `new` sha1 field of the
-	previous entry.
+	If a reflog entry's predecessor is pruned, adjust its "old"
+	SHA-1 to be equal to the "new" SHA-1 field of the entry that
+	now precedes it.
+
+--stale-fix::
+	Prune any reflog entries that point to "broken commits". A
+	broken commit is a commit that is not reachable from any of
+	the reference tips and that refers, directly or indirectly, to
+	a missing commit, tree, or blob object.
++
+This computation involves traversing all the reachable objects, i.e. it
+has the same cost as 'git prune'.  It is primarily intended to fix
+corruption caused by garbage collecting using older versions of Git,
+which didn't protect objects referred to by reflogs.
+
+-n::
+--dry-run::
+	Do not actually prune any entries; just show what would have
+	been pruned.
 
 --verbose::
 	Print extra information on screen.
 
+
+Options for `delete`
+~~~~~~~~~~~~~~~~~~~~
+
+`git reflog delete` accepts options `--updateref`, `--rewrite`, `-n`,
+`--dry-run`, and `--verbose`, with the same meanings as when they are
+used with `expire`.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 49c64f9..8182b64 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -8,14 +8,11 @@
 #include "revision.h"
 #include "reachable.h"
 
-/*
- * reflog expire
- */
-
+/* NEEDSWORK: switch to using parse_options */
 static const char reflog_expire_usage[] =
-"git reflog expire [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
+"git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
 static const char reflog_delete_usage[] =
-"git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
+"git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
-- 
2.1.4
