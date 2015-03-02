From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/7] reflog: improve and update documentation
Date: Mon,  2 Mar 2015 10:29:55 +0100
Message-ID: <1425288597-20547-6-git-send-email-mhagger@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:30:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMgf-0007St-N6
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbbCBJar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:30:47 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64808 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753810AbbCBJaX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 04:30:23 -0500
X-AuditID: 12074413-f79f26d0000030e7-65-54f42dadea6f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BE.F9.12519.DAD24F45; Mon,  2 Mar 2015 04:30:21 -0500 (EST)
Received: from michael.fritz.box (p5DDB2321.dip0.t-ipconnect.de [93.219.35.33])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t229U5HY008921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Mar 2015 04:30:19 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqLtW90uIwcSjOhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3BmzT+1jK1jlUnHx3iHmBsajFl2M
	HBwSAiYSe2e5dTFyApliEhfurWfrYuTiEBK4zCix89gpFgjnGJPEom2rmUGq2AR0JRb1NDOB
	2CICahIT2w6xgNjMAj+YJA6tqAWxhQUcJCYvnQxWzyKgKnHr5G6wGl4BF4nJO06xQWyTkzh/
	/CdYDaeAq8TPX43sILYQUM2s66uZJzDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66X
	m1mil5pSuokREorCOxh3nZQ7xCjAwajEw7tg3ucQIdbEsuLK3EOMkhxMSqK8x3W+hAjxJeWn
	VGYkFmfEF5XmpBYfYpTgYFYS4X0tD5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1I
	LYLJynBwKEnw7gAZKliUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjPhiYGyApHiA
	9t4FaectLkjMBYpCtJ5iVJQS5+0GSQiAJDJK8+DGwhLMK0ZxoC+Fef+CVPEAkxNc9yugwUxA
	g28pgg0uSURISTUwZlT9+Xg5dO4O2ylKD5RWzF3aZT2P+0DvtLbk0AP+5oJfz2xae3BD1Ppf
	u5rXe+a4Poqo3f5xfbDe5e9v9u3nEDhSwy229FTisux77jsDIjMiVj8/bhX9b4WU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264585>

Revamp the "git reflog" usage documentation in the manpage and the
command help to match the current reality and improve its clarity:

* Add documentation for some options that had been left out.

* Group the subcommands and options more logically and move more
  common subcommands/options higher.

* Improve some explanations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-reflog.txt | 138 +++++++++++++++++++++++++------------------
 builtin/reflog.c             |   4 +-
 2 files changed, 81 insertions(+), 61 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 70791b9..3af9422 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,81 +17,101 @@ The command takes various subcommands, and different options
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
+to one week ago", and so on. See linkgit:gitrevisions[7] for more
+details.
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
+master@{2}`").
 
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
+Options for `expire` and/or `delete`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
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
+	(For the `expire` command only.) Process the reflogs of all
+	references.
 
 --expire=<time>::
-	Entries older than this time are pruned.  Without the
-	option it is taken from configuration `gc.reflogExpire`,
-	which in turn defaults to 90 days.  --expire=all prunes
-	entries regardless of their age; --expire=never turns off
-	pruning of reachable entries (but see --expire-unreachable).
+	(For the `expire` command only.) Prune entries older than the
+	specified time. If this option is not specified, the
+	expiration time is taken from the configuration setting
+	`gc.reflogExpire`, which in turn defaults to 90 days.
+	`--expire=all` prunes entries regardless of their age;
+	`--expire=never` turns off pruning of reachable entries (but
+	see `--expire-unreachable`).
 
 --expire-unreachable=<time>::
-	Entries older than this time and not reachable from
-	the current tip of the branch are pruned.  Without the
-	option it is taken from configuration
-	`gc.reflogExpireUnreachable`, which in turn defaults to
-	30 days.  --expire-unreachable=all prunes unreachable
-	entries regardless of their age; --expire-unreachable=never
-	turns off early pruning of unreachable entries (but see
-	--expire).
-
---all::
-	Instead of listing <refs> explicitly, prune all refs.
+	(For the `expire` command only.) Prune entries older than
+	`<time>` that are not reachable from the current tip of the
+	branch. If this option is not specified, the expiration time
+	is taken from the configuration setting
+	`gc.reflogExpireUnreachable`, which in turn defaults to 30
+	days. `--expire-unreachable=all` prunes unreachable entries
+	regardless of their age; `--expire-unreachable=never` turns
+	off early pruning of unreachable entries (but see `--expire`).
 
 --updateref::
-	Update the ref with the sha1 of the top reflog entry (i.e.
-	<ref>@\{0\}) after expiring or deleting.
+	Update the reference to the value of the top reflog entry (i.e.
+	<ref>@\{0\}) if the previous top entry was pruned.
 
 --rewrite::
-	While expiring or deleting, adjust each reflog entry to ensure
-	that the `old` sha1 field points to the `new` sha1 field of the
-	previous entry.
+	While expiring or deleting, adjust each reflog entry's "old"
+	SHA-1 to be equal to the "new" SHA-1 field of the entry
+	preceding it.
+
+--stale-fix::
+	(For the `expire` command only.) Prune any reflog entries that
+	point to "broken commits". A broken commit is a commit that is
+	not reachable from any of the reference tips and that refers,
+	directly or indirectly, to a missing commit, tree, or blob
+	object.
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
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 49c64f9..dd68a72 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,9 +13,9 @@
  */
 
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
