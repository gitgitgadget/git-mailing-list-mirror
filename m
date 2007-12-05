From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 05 Dec 2007 02:59:16 -0800
Message-ID: <7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 11:59:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izryr-0008RK-Qc
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXLEK7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 05:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbXLEK7W
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:59:22 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35229 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbXLEK7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 05:59:21 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2F0E82F9;
	Wed,  5 Dec 2007 05:59:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 51F729A189;
	Wed,  5 Dec 2007 05:59:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67141>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

----------------------------------------------------------------
[Graduated to 'master']

* sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
* kh/commit (Mon Dec 3 00:03:10 2007 -0800) 33 commits
* wc/add-i (Mon Dec 3 09:09:43 2007 +0100) 34 commits

----------------------------------------------------------------
[New Topics]

* jc/addi-color (Wed Dec 5 00:50:23 2007 -0800) 1 commit
 - Color support for "git-add -i"

This is Dan Zwell's colorized interactive add.  I'll wait for an ack
from Dan and will merge this to 'next', will merge by v1.5.4-rc0.

* ns/checkout-push-pop (Wed Dec 5 07:04:06 2007 +0900) 1 commit
 - git-checkout --push/--pop

A reasonably cleanly written cute hack, and I do not see this breaking
the normal codepath, so I do not mind merging this as long as people
find it useful.

* jc/clean-fix (Tue Dec 4 23:55:41 2007 -0800) 1 commit
 - git-clean: Honor pathspec.

This does fix limited test cases I tried, but I didn't check the
directory related options at all.  Sanity checking appreciated.  We need
a regression fix before v1.5.4

* jc/git-log-doc (Thu Nov 1 15:57:40 2007 +0100) 1 commit
 - Include diff options in the git-log manpage

Rewrote Miklos's patch rather extensively.  Need to be in v1.5.4.

* jc/am-fix (Tue Dec 4 23:01:30 2007 -0800) 1 commit
 - git-am -i: report rewritten title

Microfix for a UI glitch noticed by Jeff Garzik.
Will merge before v1.5.4-rc0.

* pr/mergetool (Wed Dec 5 09:19:13 2007 +0200) 1 commit
 - Open external merge tool with original file extensions for all
   three files

Waiting for Ted's Ack but I think this is safe.  Will merge before v1.5.4-rc0.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

* jc/docmake-perl (Fri Nov 30 18:36:34 2007 -0800) 1 commit
 + Run the specified perl in Documentation/

Still waiting for Ack from Merlyn, but will merge before v1.5.4-rc0 anyway.

* kh/fetch-optparse (Tue Dec 4 02:25:47 2007 -0500) 1 commit
 + Rewrite builtin-fetch option parsing to use parse_options().

I need to re-read the patch just to make sure, but will merge before
v1.5.4-rc0.

----------------------------------------------------------------
[Actively cooking]

* cc/help (Sun Dec 2 06:08:00 2007 +0100) 4 commits
 - Use {web,instaweb,help}.browser config options.
 - git-help: add -w|--web option to display html man page in a
   browser.
 + Documentation: describe -i/--info option to "git-help"
 + git-help: add -i|--info option to display info page.

I haven't really read the two commits near the tip.  Comments and
nitpics are appreciated.  Nice to have in v1.5.4.

* mw/cvsserver (Wed Dec 5 01:15:01 2007 -0800) 2 commits
 - git-cvsserver runs hooks/post-update
 - git-cvsserver runs hooks/post-receive

I added the missing support for hooks/post-update; will wait for an Ack
from Michael and merge to 'next'.  Nice to have in v1.5.4.

* jc/spht (Sat Nov 24 11:57:41 2007 -0800) 6 commits
 + core.whitespace: documentation updates.
 + builtin-apply: teach whitespace_rules
 + builtin-apply: rename "whitespace" variables and fix styles
 + core.whitespace: add test for diff whitespace error highlighting
 + git-diff: complain about >=8 consecutive spaces in initial indent
 + War on whitespace: first, a bit of retreat.

Now apply also knows about the customizable definition of what
whitespace breakages are, and I was reasonably happy. But Bruce kicked
it back from "scheduled to merge" to "still cooking" status, reminding
that we would want to have this not a tree-wide configuration but
per-path attribute.  And I agree with him.

Bruce volunteered to tackle the gitattributes side.  Nice to have in
v1.5.4.

* jc/api-doc (Sat Nov 24 23:48:04 2007 -0800) 1 commit
 - Start preparing the API documents.

The primary reason of this series is because I think we made the system
a lot less approachable by losing hackability.  Although we still have
sample scripts in contrib/example for use of plumbing in scripts, they
will not help aspiring git-hacker-wannabees when our primary attention
has already shifted to moving things to C.

This currently consists of mostly stubs, although I wrote about a few
topics as examples.  Nice to have in v1.5.4.

* nd/maint-work-tree-fix (Thu Nov 29 19:21:39 2007 +0700) 2 commits
 + Do check_repository_format() early
 + Add missing inside_work_tree setting in setup_git_directory_gently

The tip one needs test script.

* jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
 + Support builtin aliases

Cute hack.  I'd like to have "git less" here.

----------------------------------------------------------------
[Stalled]

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
need to happen anyway as mingw fallouts, though ;-).

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, so these are not strictly necessary.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 - merge-nu: a new merge backend without using unpack_trees()
 - read_tree: take an explicit index structure
 - gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix

* jc/cherry-pick (Tue Nov 13 12:38:51 2007 -0800) 1 commit
 - revert/cherry-pick: start refactoring call to merge_recursive

* jc/diff-pathspec (Sun Nov 25 10:03:48 2007 -0800) 1 commit
 - Making ce_path_match() more useful by accepting globs

This was to allow "git diff-files -- '*.h'" (currently diff family
knows only the leading directory match and not fileglobs), but was shot
down by Alex.  I tend to agree with him.

* dz/color-addi (Sat Nov 10 18:03:44 2007 -0600) 3 commits
 . Added diff hunk coloring to git-add--interactive
 . Let git-add--interactive read colors from .gitconfig
 . Added basic color support to git add --interactive

I'd drop this series (still parked in 'offcuts' that is 'even outside
than pu') once I hear back from Dan.
