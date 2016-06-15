From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 13 Jul 2008 22:11:20 -0700
Message-ID: <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 07:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIGMd-00026z-6w
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 07:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbYGNFL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 01:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYGNFL2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 01:11:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYGNFL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 01:11:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 00FCE15908;
	Mon, 14 Jul 2008 01:11:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 70D0615907; Mon, 14 Jul 2008 01:11:22 -0400 (EDT)
In-Reply-To: <7vabgqsc37.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 Jul 2008 19:32:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4E662682-5163-11DD-AF95-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88375>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

I think most of the important stuff is already in 'next'.  Let's start
talking about closing the merge window for 1.6.0.

----------------------------------------------------------------
[New Topics]

* sb/dashless (Sun Jul 13 15:36:15 2008 +0200) 3 commits
 - Make usage strings dash-less
 - t/: Use "test_must_fail git" instead of "! git"
 - t/test-lib.sh: exit with small negagive int is ok with
   test_must_fail

* mv/dashless (Fri Jul 11 02:12:06 2008 +0200) 4 commits
 - make remove-dashes: apply to scripts and programs as well, not
   just to builtins
 - git-bisect: use dash-less form on git bisect log
 - t1007-hash-object.sh: use quotes for the test description
 - t0001-init.sh: change confusing directory name

* sp/maint-bash-completion-optim (Mon Jul 14 00:22:03 2008 +0000) 1 commit
 + bash completion: Append space after file names have been completed

Early parts are already merged to 'master' and need to be merged down to
maint as well, as this is about a "performance bug" that has been with us
almost forever.

* ag/rewrite_one (Sat Jul 12 22:00:57 2008 +0400) 1 commit
 + Fix quadratic performance in rewrite_one.

* sp/win (Fri Jul 11 18:52:42 2008 +0200) 3 commits
 + We need to check for msys as well as Windows in add--interactive.
 + Convert CR/LF to LF in tag signatures
 + Fixed text file auto-detection: treat EOF character 032 at the end
   of file as printable

* js/merge-rr (Sat Jul 12 15:56:19 2008 +0100) 2 commits
 + Move MERGE_RR from .git/rr-cache/ into .git/
 + builtin-rerere: more carefully find conflict markers

* sb/rerere-lib (Wed Jul 9 14:58:57 2008 +0200) 2 commits
 + rerere: Separate libgit and builtin functions
 + builtin-rerere: more carefully find conflict markers

* ls/mailinfo (Sun Jul 13 20:30:12 2008 +0200) 3 commits
 - git-mailinfo: use strbuf's instead of fixed buffers
 - Add some useful functions for strbuf manipulation.
 - Make some strbuf_*() struct strbuf arguments const.

* gi/cherry-cache (Sat Jul 12 20:14:51 2008 -0700) 1 commit
 - cherry: cache patch-ids to avoid repeating work

This does not seem to pass tests even on its own.

* js/maint-pretty-mailmap (Sat Jul 12 00:28:18 2008 +0100) 1 commit
 + Add pretty format %aN which gives the author name, respecting
   .mailmap

* js/more-win (Sun Jul 13 22:31:23 2008 +0200) 6 commits
 - Allow add_path() to add non-existent directories to the path
 - Allow the built-in exec path to be relative to the command
   invocation path
 - Fix relative built-in paths to be relative to the command
   invocation
 + help (Windows): Display HTML in default browser using Windows'
   shell API
 + help.c: Add support for htmldir relative to git_exec_path()
 + Move code interpreting path relative to exec-dir to new function
   system_path()

The earlier parts are obvious; Dscho seemed to have some comments on the
later ones that are in 'pu'.

* lw/gitweb (Fri Jul 11 03:11:48 2008 +0200) 3 commits
 - gitweb: use new Git::Repo API, and add optional caching
 - Add new Git::Repo API
 - gitweb: add test suite with Test::WWW::Mechanize::CGI

This does not pass t9710, at least for me X-<.

----------------------------------------------------------------
[Will merge to master soon]

* jc/rebase-orig-head (Tue Jul 8 00:12:22 2008 -0400) 2 commits
 + Documentation: mention ORIG_HEAD in am, merge, and rebase
 + Teach "am" and "rebase" to mark the original position with
   ORIG_HEAD

* jc/branch-merged (Tue Jul 8 17:55:47 2008 -0700) 3 commits
 + branch --merged/--no-merged: allow specifying arbitrary commit
 + branch --contains: default to HEAD
 + parse-options: add PARSE_OPT_LASTARG_DEFAULT flag

This builds on top of the parse-options enhancement series that
has been cooking in 'next' for some time.

* om/rerere-careful (Mon Jul 7 14:42:48 2008 +0200) 1 commit
 + builtin-rerere: more carefully find conflict markers

* ls/maint-mailinfo-patch-label (Thu Jul 10 23:41:33 2008 +0200) 1 commit
 + git-mailinfo: Fix getting the subject from the in-body [PATCH]
   line

----------------------------------------------------------------
[Actively Cooking]

* xx/merge-in-c-into-next (Wed Jul 9 13:51:46 2008 -0700) 4 commits
 + Teach git-merge -X<option> again.
 + Merge branch 'jc/merge-theirs' into xx/merge-in-c-into-next
 + builtin-merge.c: use parse_options_step() "incremental parsing"
   machinery
 + Merge branch 'ph/parseopt-step-blame' into xx/merge-in-c-into-next

I've described what this is in a separate message.

* rs/imap (Wed Jul 9 22:29:02 2008 +0100) 5 commits
 - Documentation: Improve documentation for git-imap-send(1)
 - imap-send.c: more style fixes
 - imap-send.c: style fixes
 - git-imap-send: Support SSL
 - git-imap-send: Allow the program to be run from subdirectories of
   a git tree

Some people seem to prefer having this feature available also with gnutls.
If such a patch materializes soon, that would be good, but otherwise I'll
merge this as-is to 'next'.  Such an enhancement can be done in-tree on
top of this series.

* jc/merge-theirs (Mon Jun 30 22:18:57 2008 -0700) 5 commits
 + Make "subtree" part more orthogonal to the rest of merge-
   recursive.
 + Teach git-pull to pass -X<option> to git-merge
 + Teach git-merge to pass -X<option> to the backend strategy module
 + git-merge-recursive-{ours,theirs}
 + git-merge-file --ours, --theirs

Punting a merge by discarding your own work in conflicting parts but still
salvaging the parts that are cleanly automerged.  It is likely that this
will result in nonsense mishmash, but somehow often people want this, so
here they are.  The interface to the backends is updated so that you can
say "git merge -Xours -Xsubtree=foo/bar/baz -s recursive other" now.

* mv/merge-in-c (Sun Jul 13 08:13:55 2008 +0000) 19 commits
 + reduce_heads(): thinkofix
 + Add a new test for git-merge-resolve
 + t6021: add a new test for git-merge-resolve
 + Teach merge.log to "git-merge" again
 + Build in merge
 + Fix t7601-merge-pull-config.sh on AIX
 + git-commit-tree: make it usable from other builtins
 + Add new test case to ensure git-merge prepends the custom merge
   message
 + Add new test case to ensure git-merge reduces octopus parents when
   possible
 + Introduce reduce_heads()
 + Introduce get_merge_bases_many()
 + Add new test to ensure git-merge handles more than 25 refs.
 + Introduce get_octopus_merge_bases() in commit.c
 + git-fmt-merge-msg: make it usable from other builtins
 + Move read_cache_unmerged() to read-cache.c
 + Add new test to ensure git-merge handles pull.twohead and
   pull.octopus
 + Move parse-options's skip_prefix() to git-compat-util.h
 + Move commit_list_count() to commit.c
 + Move split_cmdline() to alias.c

Sverre seems to have a yet another fixup on top of this that came late and
I haven't looked at.

----------------------------------------------------------------
[Graduated to "master"]

* js/pick-root (Fri Jul 4 16:19:52 2008 +0100) 1 commit
 + Allow cherry-picking root commits

* ab/bundle (Sat Jul 5 17:26:40 2008 -0400) 1 commit
 + Teach git-bundle to read revision arguments from stdin like git-
   rev-list.

* sg/stash-k-i (Tue Jul 8 00:40:56 2008 -0700) 2 commits
 + Documentation: tweak use case in "git stash save --keep-index"
 + stash: introduce 'stash save --keep-index' option

One weakness of our "partial commit" workflow support used to be that the
user can incrementally build what is to be committed in the index but that
state cannot be tested as a whole in the working tree.  This allows you to
temporarily stash the remaining changes in the working tree so that the
index state before running "stash save --keep-index" can be seen in the
working tree to be tested and then committed.

* am/stash-branch (Mon Jul 7 02:50:10 2008 +0530) 2 commits
 + Add a test for "git stash branch"
 + Implement "git stash branch <newbranch> <stash>"

Creates a new branch out of the stashed state, after returning from the
interrupt that forced you to create the stash in the first place.

* tr/add-i-e (Thu Jul 3 00:00:00 2008 +0200) 3 commits
 + git-add--interactive: manual hunk editing mode
 + git-add--interactive: remove hunk coalescing
 + git-add--interactive: replace hunk recounting with apply --recount

Adds 'e/dit' action to interactive add command.

* jc/report-tracking (Sun Jul 6 02:54:56 2008 -0700) 5 commits
 + branch -r -v: do not spit out garbage
 + stat_tracking_info(): clear object flags used during counting
 + git-branch -v: show the remote tracking statistics
 + git-status: show the remote tracking statistics
 + Refactor "tracking statistics" code used by "git checkout"

Makes the "your branch is ahead of the tracked one by N commits" logic and
messages available to other commands; status and branch are updated.

* ph/parseopt-step-blame (Wed Jul 9 23:38:34 2008 +0200) 18 commits
 + revisions: refactor handle_revision_opt into parse_revision_opt.
 + git-shortlog: migrate to parse-options partially.
 + git-blame: fix lapsus
 + git-blame: migrate to incremental parse-option [2/2]
 + git-blame: migrate to incremental parse-option [1/2]
 + revisions: split handle_revision_opt() from setup_revisions()
 + Merge branch 'jc/blame' (early part) into HEAD
 + parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
 + parse-opt: fake short strings for callers to believe in.
 + parse-opt: do not print errors on unknown options, return -2
   intead.
 + parse-opt: create parse_options_step.
 + parse-opt: Export a non NORETURN usage dumper.
 + parse-opt: have parse_options_{start,end}.
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

Became active again ;-) This probably is ready for 'master' already,
except for the last two which I only looked at the patch and have not
used heavily in production yet.

----------------------------------------------------------------
[On Hold]

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perhaps
in 1.7.0.

* jc/dashless (Thu Jun 26 16:43:34 2008 -0700) 2 commits
 + Revert "Make clients ask for "git program" over ssh and local
   transport"
 + Make clients ask for "git program" over ssh and local transport

This is the "botched" one.  Will be resurrected during 1.7.0 or 1.8.0
timeframe.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.

----------------------------------------------------------------
[Stalled/Needs more work]

* sb/sequencer (Tue Jul 1 04:38:34 2008 +0200) 4 commits
 . Migrate git-am to use git-sequencer
 . Add git-sequencer test suite (t3350)
 . Add git-sequencer prototype documentation
 . Add git-sequencer shell prototype

* jc/grafts (Wed Jul 2 17:14:12 2008 -0700) 1 commit
 - [BROKEN wrt shallow clones] Ignore graft during object transfer

Cloning or fetching from a repository from grafts did not send objects
that are hidden by grafts, but the commits in the resulting repository do
need these to pass fsck.  This fixes object transfer to ignore grafts.

Another fix is needed to git-prune so that it ignores grafts but treats
commits that are mentioned in grafts as reachable.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

This is for peeling to see what's behind the blamed commit, which may or
may not help applications like gitweb.
