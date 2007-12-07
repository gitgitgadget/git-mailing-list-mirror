From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Fri, 07 Dec 2007 01:51:03 -0800
Message-ID: <7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 10:51:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Zs2-0006P2-4v
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 10:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbXLGJvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 04:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbXLGJvT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 04:51:19 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:42681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXLGJvS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 04:51:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 60B383775;
	Fri,  7 Dec 2007 04:51:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 37BB83774;
	Fri,  7 Dec 2007 04:51:09 -0500 (EST)
In-Reply-To: <7vzlwps8zf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Dec 2007 02:59:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67405>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  Others commits may be stashed in 'offcuts'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[Graduated to 'master']

* jc/clean-fix (Wed Dec 5 22:28:06 2007 -0500) 2 commits

This does fix limited test cases I tried, but the original breakage
around the directory related options are probably still there.

* jc/docmake-perl (Fri Nov 30 18:36:34 2007 -0800) 1 commit

Let's see if I can get a straight answer from Merlyn if this fixes the
issue for him.

* jc/addi-color (Wed Dec 5 22:12:07 2007 -0800) 3 commits

This is Dan Zwell's colorized interactive add.

* jc/git-log-doc (Thu Nov 1 15:57:40 2007 +0100) 1 commit

Rewrote Miklos's patch rather extensively.  Need to be in v1.5.4.

* kh/fetch-optparse (Tue Dec 4 02:25:47 2007 -0500) 1 commit

Makes fetch parameter parser to use optparse.

* mw/cvsserver (Wed Dec 5 01:15:01 2007 -0800) 2 commits

Make cvsserver to call post-update and receive hooks to act more like
receive-pack.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

* pr/mergetool (Wed Dec 5 09:19:13 2007 +0200) 1 commit
 + Open external merge tool with original file extensions for all
   three files

Waiting for Ted's Ack but I think this is safe.  Hoping to merge before
v1.5.4-rc0.

* jc/spht (Thu Dec 6 00:14:14 2007 -0800) 7 commits
 + Use gitattributes to define per-path whitespace rule
 + core.whitespace: documentation updates.
 + builtin-apply: teach whitespace_rules
 + builtin-apply: rename "whitespace" variables and fix styles
 + core.whitespace: add test for diff whitespace error highlighting
 + git-diff: complain about >=8 consecutive spaces in initial indent
 + War on whitespace: first, a bit of retreat.

This teaches apply and diff about the customizable definition of what
whitespace breakages are, and the customization can be refined per-path
using the attributes mechanism.  It would be to nice to have this in
v1.5.4.

----------------------------------------------------------------
[Actively cooking]

* cc/help (Sun Dec 2 06:08:00 2007 +0100) 4 commits
 - Use {web,instaweb,help}.browser config options.
 - git-help: add -w|--web option to display html man page in a
   browser.
 + Documentation: describe -i/--info option to "git-help"
 + git-help: add -i|--info option to display info page.

Not a must, but would be very nice to have in v1.5.4.

* jc/api-doc (Sat Nov 24 23:48:04 2007 -0800) 1 commit
 - Start preparing the API documents.

The primary reason of this series is because I think we made the system
a lot less approachable by losing hackability.  Although we still have
sample scripts in contrib/example for use of plumbing in scripts, they
will not help aspiring git-hacker-wannabees when our primary attention
has already shifted to moving things to C.

This currently consists of mostly stubs, although I wrote about a few
topics as examples.  Nice to have in v1.5.4.

* jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
 + Support builtin aliases

Cute hack.

----------------------------------------------------------------
[On hold]

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

I think this is a sane thing to do in the longer term.  Will be in
'next' after v1.5.4.  I think "leave porcelain on PATH" might be also a
good thing as a transition measure.

Incidentally, if we do not install dashed form of built-ins anywhere
(which is not this series is about --- this is just moving them out of
user's PATH), "git help -a" will stop showing them.  I am not enthused
about removing the hardlinks to built-ins to begin with, but people who
want such a change need to first modify help.c:list_commands() to pick
up builtins without having git-foo hardlinks in gitexecdir.  This may
need to happen anyway as mingw fallouts.

----------------------------------------------------------------
[Stalled]

* ns/checkout-push-pop (Wed Dec 5 07:04:06 2007 +0900) 1 commit
 - git-checkout --push/--pop

A reasonably cleanly written cute hack, and I do not see this breaking
the normal codepath, so I do not mind merging this as long as people
find it useful.

* js/remote (Wed Dec 5 19:02:15 2007 +0000) 4 commits
 - Make git-remote a builtin
 - Test "git remote show" and "git remote prune"
 - parseopt: add flag to stop on first non option
 - path-list: add functions to work with unsorted lists

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 . Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 . git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, so these are not strictly necessary.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 . pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 . ls-tree.c: refactor show_recursive() and rename it.
 . tree-diff.c: split out a function to match a single pattern.

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 . merge-nu: a new merge backend without using unpack_trees()
 . read_tree: take an explicit index structure
 . gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix

* jc/cherry-pick (Tue Nov 13 12:38:51 2007 -0800) 1 commit
 . revert/cherry-pick: start refactoring call to merge_recursive

* jc/diff-pathspec (Sun Nov 25 10:03:48 2007 -0800) 1 commit
 - Making ce_path_match() more useful by accepting globs

This was to allow "git diff-files -- '*.h'" (currently diff family
knows only the leading directory match and not fileglobs), but was shot
down by Alex.  I tend to agree with him.

* jc/diff-relative (Thu Dec 6 09:48:32 2007 -0800) 1 commit
 . Make "diff" Porcelain output paths as relative to subdirectory.
