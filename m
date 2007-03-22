From: Steven Grimm <koreth@midwinter.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 22 Mar 2007 10:08:32 -0700
Message-ID: <4602B810.40504@midwinter.com>
References: <7vbqjp1dyx.fsf@assigned-by-dhcp.cox.net>	<7v3b4x9sst.fsf@assigned-by-dhcp.cox.net>	<7v8xed5mex.fsf@assigned-by-dhcp.cox.net> <7vr6rtle8o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:08:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUQmS-00079s-Rm
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 18:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934132AbXCVRIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Mar 2007 13:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934131AbXCVRIj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 13:08:39 -0400
Received: from tater.midwinter.com ([216.32.86.90]:46037 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934135AbXCVRId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 13:08:33 -0400
Received: (qmail 20029 invoked from network); 22 Mar 2007 17:08:32 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.131?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 22 Mar 2007 17:08:32 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vr6rtle8o.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42868>

Will you be applying your patch for the "checkout fails if something is=
=20
a file in one branch and a directory in another" problem? I realize it'=
s=20
not a complete solution, but it's at least a significant improvement=20
over the current behavior, and I don't imagine it breaks anything else.

I can resend my test case if you like.

-Steve


Junio C Hamano wrote:
> Perhaps it is time for 1.5.0.4 this Wednesday (my time) from
> 'maint'.
>
> On the 'master' front, Johannes and Matthias cleaned up the
> git-bundle and made it (hopefully) usable shape.  Also git-diff
> got even nicer when used outside the context of git, again
> thanks to Johannes.  I think we are nearing 1.5.1-rc1, which
> I'll talk about in "What's cooking".
>
> ----------------------------------------------------------------
>
> * The 'maint' branch has these fixes since the last announcement.
>
>  Alexandre Julliard (2):
>   git.el: Avoid appending a signoff line that is already present.
>   git.el: Retrieve commit log information from .dotest directory.
>
>  Avi Kivity (1):
>   git-send-email: Document configuration options
>
>  Brian Gernhardt (1):
>   Fix diff-options references in git-diff and git-format-patch
>
>  J. Bruce Fields (13):
>   Documentation: mention module option to git-cvsimport
>   user-manual: reset to ORIG_HEAD not HEAD to undo merge
>   user-manual: ensure generated manual references stylesheet
>   user-manual: insert earlier of mention content-addressable architec=
ture
>   user-manual: how to replace commits older than most recent
>   user-manual: more detailed merge discussion
>   glossary: fix overoptimistic automatic linking of defined terms
>   user-manual: fix inconsistent example
>   user-manual: fix inconsistent use of pull and merge
>   user-manual: fix missing colon in git-show example
>   user-manual: fix rendering of history diagrams
>   user-manual: install user manual stylesheet with other web document=
s
>   git-merge: warn when -m provided on a fast forward
>
>  Jeff King (2):
>   Documentation: s/seperator/separator/
>   fast-import: grow tree storage more aggressively
>
>  Johannes Schindelin (2):
>   Begin SubmittingPatches with a check list
>   make t8001 work on Mac OS X again
>
>  Junio C Hamano (2):
>   GIT 1.5.0.3
>   git-commit: cd to top before showing the final stat
>
>  Matthias Kestenholz (1):
>   Adjust reflog filemode in shared repository
>
>  Matthias Lederhofer (1):
>   setup_git_directory_gently: fix off-by-one error
>
>  Shawn O. Pearce (13):
>   git-gui: Relocate the menu/transport menu code.
>   git-gui: Add Reset to the Branch menu.
>   git-gui: Don't create empty (same tree as parent) commits.
>   git-gui: Remove unnecessary /dev/null redirection.
>   fast-import: Avoid infinite loop after reset
>   fast-import: Fail if a non-existant commit is used for merge
>   git-gui: Make 'make' quieter by default
>   Catch write_ref_sha1 failure in receive-pack
>   git-gui: Allow committing empty merges
>   git-gui: Revert "Don't modify CREDITS-FILE if it hasn't changed."
>   git-gui: Revert "git-gui: Display all authors of git-gui."
>   git-gui: Allow 'git gui version' outside of a repository
>   Don't package the git-gui credits file anymore
>
>  Theodore Ts'o (1):
>   Add definition of <commit-ish> to the main git man page.
>
>  Yasushi SHOJI (1):
>   glossary: Add definitions for dangling and unreachable objects
>
>
> * The 'master' branch has these since the last announcement
>   in addition to the above.
>
>  Alex Riesen (4):
>   git-gui: Support of "make -s" in: do not output anything of the bui=
ld itself
>   More build output cleaning up
>   Support of "make -s": do not output anything of the build itself
>   Allow "make -w" generate its usual output
>
>  Avi Kivity (1):
>   git-send-email: configurable bcc and chain-reply-to
>
>  Frank Lichtenheld (1):
>   cvsserver: Use Merged response instead of Update-existing for merge=
d files
>
>  Jakub Narebski (1):
>   gitweb: Don't escape attributes in CGI.pm HTML methods
>
>  Jeff King (1):
>   New fast-import test case for valid tree sorting
>
>  Jim Meyering (1):
>   I like the idea of the new ':/<oneline prefix>' notation, and gave =
it
>
>  Johannes Schindelin (15):
>   fetch & clone: do not output progress when not on a tty
>   Fixup no-progress for fetch & clone
>   Make git-revert & git-cherry-pick a builtin
>   diff: support reading a file from stdin via "-"
>   diff --no-index: support /dev/null as filename
>   Get rid of the dependency to GNU diff in the tests
>   cherry-pick: Suggest a better method to retain authorship
>   format-patch: add --inline option and make --attach a true attachme=
nt
>   bundle: fix wrong check of read_header()'s return value & add tests
>   git-bundle: avoid packing objects which are in the prerequisites
>   git-bundle: Make thin packs
>   git-bundle: handle thin packs in subcommand "unbundle"
>   git-bundle: die if a given ref is not included in bundle
>   git-bundle: prevent overwriting existing bundles
>   git-bundle: only die if pack would be empty, warn if ref is skipped
>
>  Johannes Sixt (3):
>   Add core.symlinks to mark filesystems that do not support symbolic =
links.
>   Handle core.symlinks=3Dfalse case in merge-recursive.
>   Tell multi-parent diff about core.symlinks.
>
>  Junio C Hamano (14):
>   diff-ni: fix the diff with standard input
>   format-patch --attach: not folding some long headers.
>   Post 1.5.0.3 cleanup
>   fsck: fix broken loose object check.
>   unpack_sha1_file(): detect corrupt loose object files.
>   fsck: exit with non-zero status upon errors
>   git-bundle: fix pack generation.
>   revision walker: Fix --boundary when limited
>   revision traversal: retire BOUNDARY_SHOW
>   git-bundle: various fixups
>   revision traversal: SHOWN means shown
>   git-bundle: make verify a bit more chatty.
>   revision --boundary: fix stupid typo
>   revision --boundary: fix uncounted case.
>
>  Li Yang (1):
>   gitweb: Change to use explicitly function call cgi->escapHTML()
>
>  Linus Torvalds (1):
>   Re-fix get_sha1_oneline()
>
>  Paolo Bonzini (3):
>   git-config: document --rename-section, provide --remove-section
>   git-archimport: allow remapping branch names
>   git-commit: add a --interactive option
>
>  Santi B=C3=A9jar (2):
>   t/t5515-fetch-merge-logic.sh: Added tests for the merge login in gi=
t-fetch
>   t/t5515-fetch-merge-logic.sh: Add two more tests
>
>  Shawn O. Pearce (31):
>   cherry-pick: Bug fix 'cherry picked from' message.
>   Make 'make' quieter while building git
>   Make 'make' quiet by default
>   Display the null SHA-1 as the base for an OBJ_OFS_DELTA.
>   Fix mmap leak caused by reading bad indexes.
>   Don't build external_grep if its not used
>   General const correctness fixes
>   Use uint32_t for all packed object counts.
>   Use uint32_t for pack-objects counters.
>   Use off_t when we really mean a file offset.
>   Use off_t in pack-objects/fast-import when we mean an offset
>   Cast 64 bit off_t to 32 bit size_t
>   Preallocate memory earlier in fast-import
>   Move post-update hook to after all other activity
>   Don't run post-update hook unless a ref changed
>   Refactor run_update_hook to be more useful
>   Refactor handling of error_string in receive-pack
>   Teach receive-pack to run pre-receive/post-receive hooks
>   Use atomic updates to the fast-import mark file
>   Allow fast-import frontends to reload the marks table
>   Switch to run_command_v_opt in revert
>   Remove unused run_command variants
>   Start defining a more sophisticated run_command
>   Split run_command into two halves (start/finish)
>   Teach run_command how to setup a stdin pipe
>   Refactor run_command error handling in receive-pack
>   Split back out update_hook handling in receive-pack
>   Change {pre,post}-receive hooks to use stdin
>   Remove unnecessary casts from fast-import
>   Simplify closing two fds at once in run-command.c
>   Fix t5510-fetch's use of sed
>
>  Xavier Maillard (1):
>   contrib/emacs: Use non-interactive function to byte-compile files
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  =20
