From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Thu, 11 Oct 2012 19:43:26 +0700
Message-ID: <20121011124326.GA30589@do>
References: <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7vvcer4chm.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com>
 <7va9w23i45.fsf@alter.siamese.dyndns.org>
 <CACsJy8BeWuKT_jUyRYf3cKrp7Jx07J2jPEZd96KbWEY+aiX24w@mail.gmail.com>
 <7vmx00u1nz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 14:43:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMI7E-000811-CS
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 14:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669Ab2JKMnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 08:43:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48665 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab2JKMnk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 08:43:40 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1706804pad.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OdxAlhLMy0jt8vqOKO3JUnIEyJFbedvbjUuXyelqRK0=;
        b=o2pp85Rlqr6hzMwVMV1OJomOU+RxMu2btmqsYYVjCWo2HB/D4Ea5x2NqewK4psc0Ch
         /1x8xJiUgTOxclxEYV9tJ6PO8AkyajLbNZlTMsBhGeJ8AwewCpUw0VxyK9wzryhN8nhb
         f27g6U12d1+iF925KfPTA7gy8xwg+AEqpPKAWwY8N4ZDeORUpAX9BTgw+ga+uyKwbYWJ
         ty+Y32G6+Pzf6G184wHq4sm57il/mYTjFSa53GaMUi+wsxDqQN0isDWNFtVL3F3KSA3c
         kBo/l/kdZqdIRhDBOHplPQENngaqH+pcmISYWceNXrxvGJ6jwipIcgHyXtybvEWL39FJ
         JFOA==
Received: by 10.66.78.4 with SMTP id x4mr1801666paw.60.1349959419883;
        Thu, 11 Oct 2012 05:43:39 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id s10sm2567223paz.11.2012.10.11.05.43.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Oct 2012 05:43:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Oct 2012 19:43:26 +0700
Content-Disposition: inline
In-Reply-To: <7vmx00u1nz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207475>

On Fri, Oct 05, 2012 at 01:03:28PM -0700, Junio C Hamano wrote:
> >>> OK. I think I was surprised that some messages were controlled by
> >>> advice.* but gave no hints about that and I found that out by other
> >>> means. I'll check all the advice messages.
> >
> > It's about the commands, not the documents. For example I had no idea
> > I could set advice.statusHints to turn off some advice. "git status"
> > does not say that those messages can be turned off.
> 
> OK, the messages are supposed to advise how to turn them off, so we
> would want some code updates in that case.

Something like this? It turns out none of the advice messages says
anything about advice.*.

This patch makes many output more verbose/annoying, (which is good,
more motivation to turn advice off). On the other hand, if a user sees
a message telling her/him to turn advice.statusHints off, (s)he may
miss other helpful advice as it turns the whole set off. I don't know
if that is good or bad for newbies.

Tests are broken due to output changes. Will fix it if it may have a
chance of entering git.git.

There are two advise() calls in sequencer.c that we may want to
trigger with a new advice config, by the way.

-- 8< --
diff --git a/advice.c b/advice.c
index edfbd4a..5b78c01 100644
--- a/advice.c
+++ b/advice.c
@@ -70,7 +70,8 @@ int error_resolve_conflict(const char *me)
 		advise(_("Fix them up in the work tree,\n"
 			 "and then use 'git add/rm <file>' as\n"
 			 "appropriate to mark resolution and make a commit,\n"
-			 "or use 'git commit -a'."));
+			 "or use 'git commit -a'.\n"
+			 "Set advice.resolveConflict to false to turn off this message."));
 	return -1;
 }
 
@@ -89,7 +90,9 @@ void detach_advice(const char *new_name)
 	"state without impacting any branches by performing another checkout.\n\n"
 	"If you want to create a new branch to retain commits you create, you may\n"
 	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
-	"  git checkout -b new_branch_name\n\n";
+	"  git checkout -b new_branch_name\n"
+	"Set either advice.detachedHead to false to turn off this message\n\n"
+;
 
 	fprintf(stderr, fmt, new_name);
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 781295b..a805961 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -699,7 +699,9 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 			_(
 			"If you want to keep them by creating a new branch, "
 			"this may be a good time\nto do so with:\n\n"
-			" git branch new_branch_name %s\n\n"),
+			" git branch new_branch_name %s\n"
+			"Set either advice.detachedHead to false"
+			" to turn off this message\n\n"),
 			sha1_to_hex(commit->object.sha1));
 }
 
diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..5a4d85f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -50,7 +50,8 @@ N_("Your name and email address were configured automatically based\n"
 "\n"
 "After doing this, you may fix the identity used for this commit with:\n"
 "\n"
-"    git commit --amend --reset-author\n");
+"    git commit --amend --reset-author\n"
+"Set either advice.implicitIdentity to false to turn off this message\n");
 
 static const char empty_amend_advice[] =
 N_("You asked to amend the most recent commit, but doing so would make\n"
diff --git a/builtin/merge.c b/builtin/merge.c
index 0ec8f0d..754f51e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1227,14 +1227,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your merge (MERGE_HEAD exists).\n"
-				  "Please, commit your changes before you can merge."));
+			      "Please, commit your changes before you can merge.\n"
+			      "Set advice.resolveConflict to false"
+			      " to turn off this message\n"));
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
 	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
-			    "Please, commit your changes before you can merge."));
+			    "Please, commit your changes before you can merge.\n"
+			      "Set advice.resolveConflict to false"
+			      " to turn off this message\n"));
 		else
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists)."));
 	}
diff --git a/builtin/push.c b/builtin/push.c
index db9ba30..420a17a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -206,19 +206,25 @@ static const char message_advice_pull_before_push[] =
 	N_("Updates were rejected because the tip of your current branch is behind\n"
 	   "its remote counterpart. Merge the remote changes (e.g. 'git pull')\n"
 	   "before pushing again.\n"
-	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.\n"
+	   "Set either advice.pushNonFFCurrent or advice.pushNonFostForward to false\n"
+	   " to turn off this message");
 
 static const char message_advice_use_upstream[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. If you did not intend to push that branch, you may want to\n"
 	   "specify branches to push or set the 'push.default' configuration variable\n"
-	   "to 'simple', 'current' or 'upstream' to push only the current branch.");
+	   "to 'simple', 'current' or 'upstream' to push only the current branch.\n"
+	   "Set either advice.pushNonFFDefault or advice.pushNonFostForward to false\n"
+	   " to turn off this message");
 
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. Check out this branch and merge the remote changes\n"
 	   "(e.g. 'git pull') before pushing again.\n"
-	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.\n"
+	   "Set either advice.pushNonFFMatching or advice.pushNonFostForward to false\n"
+	   " to turn off this message");
 
 static void advise_pull_before_push(void)
 {
diff --git a/notes-merge.c b/notes-merge.c
index 0f67bd3..601bf26 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -273,7 +273,10 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 				    "'git notes merge --commit' or 'git notes "
 				    "merge --abort' to commit/abort the "
 				    "previous merge before you start a new "
-				    "notes merge.", git_path("NOTES_MERGE_*"));
+				    "notes merge.\n"
+				    "Set advice.resolveConflict to false"
+				    " to turn off this message",
+				    git_path("NOTES_MERGE_*"));
 			else
 				die("You have not concluded your notes merge "
 				    "(%s exists).", git_path("NOTES_MERGE_*"));
diff --git a/sequencer.c b/sequencer.c
index e3723d2..489c97c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -182,7 +182,8 @@ static int error_dirty_index(struct replay_opts *opts)
 		error(_("Your local changes would be overwritten by revert."));
 
 	if (advice_commit_before_merge)
-		advise(_("Commit your changes or stash them to proceed."));
+		advise(_("Commit your changes or stash them to proceed.\n"
+			 "Set advice.commitBeforeMerge to false to turn off this message."));
 	return -1;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 6d96366..6c274bc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -60,7 +60,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
 	if (advice_commit_before_merge)
 		msg = "Your local changes to the following files would be overwritten by %s:\n%%s"
-			"Please, commit your changes or stash them before you can %s.";
+			"Please, commit your changes or stash them before you can %s.\n"
+			"Set advice.commitBeforeMerge to false to turn off this message.";
 	else
 		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
 	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 2);
@@ -73,7 +74,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 
 	if (advice_commit_before_merge)
 		msg = "The following untracked working tree files would be %s by %s:\n%%s"
-			"Please move or remove them before you can %s.";
+			"Please move or remove them before you can %s.\n"
+			"Set advice.commitBeforeMerge to false to turn off this message.";
 	else
 		msg = "The following untracked working tree files would be %s by %s:\n%%s";
 	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strlen(cmd2) - 4);
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..344f5f6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -178,6 +178,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	}
+	status_printf_ln(s, c, _("  Set advice.statusHints to false to turn off this message"));
 	status_printf_ln(s, c, "");
 }
 
@@ -194,6 +195,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
+	status_printf_ln(s, c, _("  Set advice.statusHints to false to turn off this message"));
 	status_printf_ln(s, c, "");
 }
 
@@ -213,6 +215,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
+	status_printf_ln(s, c, _("  Set advice.statusHints to false to turn off this message"));
 	status_printf_ln(s, c, "");
 }
 
@@ -225,6 +228,7 @@ static void wt_status_print_other_header(struct wt_status *s,
 	if (!advice_status_hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
+	status_printf_ln(s, c, _("  Set advice.statusHints to false to turn off this message"));
 	status_printf_ln(s, c, "");
 }
 
@@ -783,15 +787,23 @@ static void show_merge_in_progress(struct wt_status *s,
 {
 	if (has_unmerged(s)) {
 		status_printf_ln(s, color, _("You have unmerged paths."));
-		if (advice_status_hints)
+		if (advice_status_hints) {
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git commit\")"));
+			status_printf_ln(s, color,
+					 _("  Set advice.statusHints to"
+					   " false to turn off this message"));
+		}
 	} else {
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
-		if (advice_status_hints)
+		if (advice_status_hints) {
 			status_printf_ln(s, color,
 				_("  (use \"git commit\" to conclude merge)"));
+			status_printf_ln(s, color,
+					 _("  Set advice.statusHints to "
+					   "false to turn off this message"));
+		}
 	}
 	wt_status_print_trailer(s);
 }
@@ -813,6 +825,8 @@ static void show_am_in_progress(struct wt_status *s,
 			_("  (use \"git am --skip\" to skip this patch)"));
 		status_printf_ln(s, color,
 			_("  (use \"git am --abort\" to restore the original branch)"));
+		status_printf_ln(s, color,
+			 _("  Set advice.statusHints to false to turn off this message"));
 	}
 	wt_status_print_trailer(s);
 }
@@ -878,17 +892,25 @@ static void show_rebase_in_progress(struct wt_status *s,
 				_("  (use \"git rebase --skip\" to skip this patch)"));
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
+			status_printf_ln(s, color,
+				_("  Set advice.statusHints to false to turn off this message"));
 		}
 	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), &st)) {
 		status_printf_ln(s, color, _("You are currently rebasing."));
-		if (advice_status_hints)
+		if (advice_status_hints) {
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
+			status_printf_ln(s, color,
+				_("  Set advice.statusHints to false to turn off this message"));
+		}
 	} else if (split_commit_in_progress(s)) {
 		status_printf_ln(s, color, _("You are currently splitting a commit during a rebase."));
-		if (advice_status_hints)
+		if (advice_status_hints) {
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
+			status_printf_ln(s, color,
+				_("  Set advice.statusHints to false to turn off this message"));
+		}
 	} else {
 		status_printf_ln(s, color, _("You are currently editing a commit during a rebase."));
 		if (advice_status_hints && !s->amend) {
@@ -896,6 +918,8 @@ static void show_rebase_in_progress(struct wt_status *s,
 				_("  (use \"git commit --amend\" to amend the current commit)"));
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --continue\" once you are satisfied with your changes)"));
+			status_printf_ln(s, color,
+				_("  Set advice.statusHints to false to turn off this message"));
 		}
 	}
 	wt_status_print_trailer(s);
@@ -913,6 +937,8 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 		else
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git commit\")"));
+		status_printf_ln(s, color,
+			_("  Set advice.statusHints to false to turn off this message"));
 	}
 	wt_status_print_trailer(s);
 }
@@ -922,9 +948,12 @@ static void show_bisect_in_progress(struct wt_status *s,
 				const char *color)
 {
 	status_printf_ln(s, color, _("You are currently bisecting."));
-	if (advice_status_hints)
+	if (advice_status_hints) {
 		status_printf_ln(s, color,
 			_("  (use \"git bisect reset\" to get back to the original branch)"));
+		status_printf_ln(s, color,
+			_("  Set advice.statusHints to false to turn off this message"));
+	}
 	wt_status_print_trailer(s);
 }
 
@@ -1011,10 +1040,16 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-	} else if (s->commitable)
-		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
-			advice_status_hints
-			? _(" (use -u option to show untracked files)") : "");
+	} else if (s->commitable) {
+		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed"));
+		if (advice_status_hints) {
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+					 _(" (use -u option to show untracked files)"));
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+					 _("  Set advice.statusHints to"
+					   " false to turn off this message"));
+		}
+	}
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
@@ -1026,24 +1061,32 @@ void wt_status_print(struct wt_status *s)
 		else if (s->workdir_dirty) {
 			if (advice_status_hints)
 				printf(_("no changes added to commit "
-					 "(use \"git add\" and/or \"git commit -a\")\n"));
+					 "(use \"git add\" and/or \"git commit -a\")\n"
+					 "Set advice.statusHints to false"
+					 " to turn off this message\n"));
 			else
 				printf(_("no changes added to commit\n"));
 		} else if (s->untracked.nr) {
 			if (advice_status_hints)
 				printf(_("nothing added to commit but untracked files "
-					 "present (use \"git add\" to track)\n"));
+					 "present (use \"git add\" to track)\n"
+					 "Set advice.statusHints to false"
+					 " to turn off this message\n"));
 			else
 				printf(_("nothing added to commit but untracked files present\n"));
 		} else if (s->is_initial) {
 			if (advice_status_hints)
 				printf(_("nothing to commit (create/copy files "
-					 "and use \"git add\" to track)\n"));
+					 "and use \"git add\" to track)\n"
+					 "Set advice.statusHints to false"
+					 " to turn off this message\n"));
 			else
 				printf(_("nothing to commit\n"));
 		} else if (!s->show_untracked_files) {
 			if (advice_status_hints)
-				printf(_("nothing to commit (use -u to show untracked files)\n"));
+				printf(_("nothing to commit (use -u to show untracked files)\n"
+					 "Set advice.statusHints to false"
+					 " to turn off this message\n"));
 			else
 				printf(_("nothing to commit\n"));
 		} else
-- 8< --
-- 
Duy
