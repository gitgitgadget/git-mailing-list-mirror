From: Junio C Hamano <gitster@pobox.com>
Subject: Re* Regulator updates for 3.3
Date: Tue, 10 Jan 2012 22:59:04 -0800
Message-ID: <7vzkdu7miv.fsf@alter.siamese.dyndns.org>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com>
 <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com>
 <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <7vmx9v7z1r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com>
 <7vehv77xeq.fsf@alter.siamese.dyndns.org>
 <CA+55aFzuGtJkQFDooSGWQ2_NiJVHN2E7S5dmOnWTYn8_s8Gg3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 11 07:59:24 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Rks9a-0003VG-Lg
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Jan 2012 07:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab2AKG7M (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 11 Jan 2012 01:59:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124Ab2AKG7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2012 01:59:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBB934C2D;
	Wed, 11 Jan 2012 01:59:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=f+6FVC3t7iSPX5r6hMmQr9fkD+k=; b=PqVvFIR/qMamhcPDpWIj
	v+Zck5tCEnkPiRsF4ocD2OENqW37r8gX3MXvp44+wvToKSguqLl/qDV+ldngDH1U
	pWFyENHu/lEvgoSVPL/+eC/pIHKkQBN86NUA/XKCLBT93bdAnB1IFDlfEHgwrDw/
	0dhIWgVzxKjBQEpk19o0xZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=s5uEozBa0vVVLDUetLdy4g9O9XCd74kkAgyvdv101/nvqI
	uJSsAF3GQDfwGgpzWOznJKFdOOoNl0+ROIa2mEH33zTZsmJdsvcYPnMHO//z17ph
	UNTYQrSG+BdD35Wpxn7KAdW2x+R710+M4qmC0pcF0ddYE0nfUcCPxwgpeVqdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF1064C2C;
	Wed, 11 Jan 2012 01:59:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D45524C2B; Wed, 11 Jan 2012
 01:59:05 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C07CC2CE-3C21-11E1-A29E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188337>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The (b) thing I suggested was for "work around for people who have
> legacy cases that they don't want to make explicit". I guess you could
> count that as some rule, but I really think it's more of a "ok, we had
> bad legacy behavior, and now we have scripts that depended on that bad
> legacy".

I would think that would solve the issue for scripts like the one used to
rebuild the linux-next tree.  I also have such a script to rebuild 'pu' I
use three or four times a day, but admittedly the standard input of "git
merge" in that script is connected to a here document that feeds the list
of branches to be merged to the loop that drives the "git merge", so your
heuristic (a) will kick in and I wouldn't need the GIT_MERGE_NO_EDIT
environment myself.

What makes me uneasy about the idea of running the editor by default is
that many people still use Git as a better CVS/SVN. Their workflow is to
build randomly on their 'master', attempt to push and get rejected, pull
only so that they can push out, and then push the merge result out. Such
merges are done without any consideration on the cohesiveness of the
branch (the segment of the history that records their work since they last
pulled from the central repository). Having to justify the backmerge is
nothing but a nuisance for them, as they do not have any justification
better than "I am done for the day, and my commuter shuttle will leave in
15 minutes, so I tried to push what I've done so far, but it was rejected
due to non fast-forward, and I am merging random things others did so that
I can push back". They won't be saying "This merges the great work I
completed and have been testing privately for a few days to the trunk", as
the direction of their merge is backwards.

With that caveat, the patch should look like this.

-- >8 --
Subject: [PATCH] merge: use editor by default in interactive sessions

Traditionally, a cleanly resolved merge was committed by "git merge" using
the auto-generated merge commit log message with invoking the editor.

After 5 years of use in the field, it turns out that many people perform
too many unjustified backmerges of the upstream history into their topic
branches. These merges are not just useless, but they are more often than
not explained and making the end result unreadable when it gets time for
merging their history back to their upstream.

Earlier we added the "--edit" option to the command, so that people can
edit the log message to explain and justify their merge commits. Let's
take it one step further and spawn the editor by default when we are in an
interactive session (i.e. the standard input and the standard output are
pointing at the same tty device).

There may be existing scripts that leave the standard input and the
standard output of the "git merge" connected to whatever environment the
scripts were started, and such invocation might trigger the above
"interactive session" heuristics. Such scripts can export GIT_MERGE_LEGACY
environment variable set to "yes" to force the traditional behaviour.

Suggested-by: Linus Torvalds
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |   34 ++++++++++++++++++++++++++++++----
 t/test-lib.sh   |    3 ++-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 99f1429..6a80e1e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -46,7 +46,7 @@ static const char * const builtin_merge_usage[] = {
 
 static int show_diffstat = 1, shortlog_len, squash;
 static int option_commit = 1, allow_fast_forward = 1;
-static int fast_forward_only, option_edit;
+static int fast_forward_only, option_edit = -1;
 static int allow_trivial = 1, have_message;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
@@ -189,7 +189,7 @@ static struct option builtin_merge_options[] = {
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
 		"perform a commit if the merge succeeds (default)"),
-	OPT_BOOLEAN('e', "edit", &option_edit,
+	OPT_BOOL('e', "edit", &option_edit,
 		"edit message before committing"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast-forward (default)"),
@@ -877,12 +877,12 @@ static void prepare_to_commit(void)
 	write_merge_msg(&msg);
 	run_hook(get_index_file(), "prepare-commit-msg",
 		 git_path("MERGE_MSG"), "merge", NULL, NULL);
-	if (option_edit) {
+	if (0 < option_edit) {
 		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
 			abort_commit(NULL);
 	}
 	read_merge_msg(&msg);
-	stripspace(&msg, option_edit);
+	stripspace(&msg, 0 < option_edit);
 	if (!msg.len)
 		abort_commit(_("Empty commit message."));
 	strbuf_release(&merge_msg);
@@ -1076,6 +1076,29 @@ static void write_merge_state(void)
 	close(fd);
 }
 
+static int default_edit_option(void)
+{
+	static const char name[] = "GIT_MERGE_LEGACY";
+	const char *e = getenv(name);
+	struct stat st_stdin, st_stdout;
+
+	if (e) {
+		int v = git_config_maybe_bool(name, e);
+		if (v < 0)
+			die("Bad value '%s' in environment '%s'", e, name);
+		return !v;
+	}
+
+	/* Use editor if stdin and stdout are the same and is a tty */
+	return (!fstat(0, &st_stdin) &&
+		!fstat(1, &st_stdout) &&
+		isatty(0) &&
+		st_stdin.st_dev == st_stdout.st_dev &&
+		st_stdin.st_ino == st_stdout.st_ino &&
+		st_stdin.st_rdev == st_stdout.st_rdev);
+}
+
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1261,6 +1284,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (option_edit < 0)
+		option_edit = default_edit_option();
+
 	if (!use_strategies) {
 		if (!remoteheads->next)
 			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..439f192 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -63,7 +63,8 @@ GIT_AUTHOR_NAME='A U Thor'
 GIT_COMMITTER_EMAIL=committer@example.com
 GIT_COMMITTER_NAME='C O Mitter'
 GIT_MERGE_VERBOSITY=5
-export GIT_MERGE_VERBOSITY
+GIT_MERGE_LEGACY=yes
+export GIT_MERGE_VERBOSITY GIT_MERGE_LEGACY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
-- 
1.7.9.rc0.39.ged86b
