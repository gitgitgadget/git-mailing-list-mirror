From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Fri, 13 Jun 2008 03:16:42 -0700
Message-ID: <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 12:18:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K76MJ-0004Y1-6m
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 12:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbYFMKQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 06:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbYFMKQ5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 06:16:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbYFMKQz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 06:16:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 65FBD2BAE;
	Fri, 13 Jun 2008 06:16:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1363F2BAD; Fri, 13 Jun 2008 06:16:50 -0400 (EDT)
In-Reply-To: <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 02 Jun 2008 00:58:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D82E00C8-3931-11DD-8640-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84863>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

It's been a while since the last issue of this series.  I've been
swamped, and haven't had a chance to spend enough time on reviewing and
accepting patches.

A rough timeline from now on.

 * 1.5.6-rc3 this weekend.

 * 1.5.6 Final (2008-06-20).

----------------------------------------------------------------
[New Topics]

* jn/web (Tue Jun 10 19:21:44 2008 +0200) 2 commits
 - gitweb: Separate generating 'sort by' table header
 - gitweb: Separate filling list of projects info

* rs/archive-ignore (Sun Jun 8 18:42:33 2008 +0200) 1 commit
 + Teach new attribute 'export-ignore' to git-archive

* rg/gitweb (Fri Jun 6 09:53:32 2008 +0200) 1 commit
 + gitweb: remove git_blame and rename git_blame2 to git_blame

* kh/update-ref (Tue Jun 3 01:34:53 2008 +0200) 2 commits
 + Make old sha1 optional with git update-ref -d
 + Clean up builtin-update-ref's option parsing

* mo/status-untracked (Thu Jun 5 14:47:50 2008 +0200) 3 commits
 - Add configuration option for default untracked files mode
 - Add argument 'no' commit/status option -u|--untracked-files
 - Add an optional <mode> argument to commit/status -u|--untracked-
   files option

* rs/attr (Sun Jun 8 17:16:11 2008 +0200) 1 commit
 + Ignore .gitattributes in bare repositories

* sr/tests (Sun Jun 8 16:04:35 2008 +0200) 3 commits
 + Hook up the result aggregation in the test makefile.
 + A simple script to parse the results from the testcases
 + Modify test-lib.sh to output stats to t/test-results/*

None of the above are 1.5.6 material, except for the "ignore
=2Egitattributes file in bare repositories" from Ren=C3=A9, which I thi=
nk we
should have.

----------------------------------------------------------------
[Graduated to "master"]

Nothing this week.

----------------------------------------------------------------
[Stalled]

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 + "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with sha=
red
repository workflow in certain minority situations.  The lack of protoc=
ol
support has been bugging me for quite some time, and that was the reaso=
n I
did this.

This needs debugging.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 7 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

The blame that finds where each line in the original lines moved to.  T=
his
may help a GSoC project that wants to gather statistical overview of th=
e
history.  The final presentation may need tweaking (see the log message=
 of
the commit ""git-blame --reverse" on the series).

* js/rebase-i-sequencer (Sun Apr 27 02:55:50 2008 -0400) 17 commits
 + Use perl instead of tac
 + Fix t3404 assumption that `wc -l` does not use whitespace.
 + rebase -i: Use : in expr command instead of match.
 + rebase -i: update the implementation of 'mark' command
 + Add option --preserve-tags
 + Teach rebase interactive the tag command
 + Add option --first-parent
 + Do rebase with preserve merges with advanced TODO list
 + Select all lines with fake-editor
 + Unify the length of $SHORT* and the commits in the TODO list
 + Teach rebase interactive the merge command
 + Move redo merge code in a function
 + Teach rebase interactive the reset command
 + Teach rebase interactive the mark command
 + Move cleanup code into it's own function
 + Don't append default merge message to -m message
 + fake-editor: output TODO list if unchanged

This may complement the proposed "sequencer" GSoC project.  Dscho seems=
 to
have quite a strong objection to the 'mark' syntax and mechanism being
unnecessarily complex.  Let's wait and see if a less complex but equall=
y
expressive alternative materializes...

It is very likely that this whole thing will be reverted from 'next' an=
d
be replaced with the new sequenser series during 1.6.0 cycle.

* sj/merge (Sat May 3 16:55:47 2008 -0700) 6 commits
 - Introduce fast forward option only
 - Head reduction before selecting merge strategy
 - Restructure git-merge.sh
 - Introduce -ff=3D<fast forward option>
 - New merge tests
 - Documentation for joining more than two histories

This will interfere with Miklos's rewrite of merge to C but it appears
neither will happen by 1.5.6 anyway.

* dr/ceiling (Mon May 19 23:49:34 2008 -0700) 4 commits
 - Eliminate an unnecessary chdir("..")
 - Add support for GIT_CEILING_DIRECTORIES
 - Fold test-absolute-path into test-path-utils
 - Implement normalize_absolute_path

----------------------------------------------------------------
[On Hold]

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will=
 be
hit due to tcl/tk's limitation, so I am holding this back for now.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 - merge: remove deprecated summary and diffstat options and config
   variables

This needs to be held back, as it actually removes the support for
features that the main part of the series deprecates, until 1.6.0 or
later.

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 3 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive

This is meant to improve cherry-pick's behaviour when renames are
involved, by not using merge-recursive (whose d/f conflict resolution i=
s
quite broken), but unfortunately has stalled for some time now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.
