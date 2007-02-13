From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Mon, 12 Feb 2007 21:15:41 -0800
Message-ID: <7vtzxq3af6.fsf@assigned-by-dhcp.cox.net>
References: <7v1wl15zc2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 06:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGq17-0004hm-60
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 06:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbXBMFPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Feb 2007 00:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbXBMFPp
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 00:15:45 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37025 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161037AbXBMFPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Feb 2007 00:15:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213051543.CAWH21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Feb 2007 00:15:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NtFi1W00N1kojtg0000000; Tue, 13 Feb 2007 00:15:43 -0500
X-maint-at: 6534141151f7fd4334f62827d9234acf3974ca4d
X-master-at: 07fef5fc1599d11f5750ae2440e0da6616c297b8
In-Reply-To: <7v1wl15zc2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 07 Feb 2007 15:21:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39491>

It feels like it took me forever to get here, but this is almost
it.  The short-log looks huge but only because Shawn's git-gui
is now included.

Unless there is some last minute showstopper, the final will be
cut on Wednesday.  Should I give it a catchy codename?  ;-)

* The 'master' branch has these since v1.5.0-rc4

 Alexandre Julliard (3):
  diff.c: Reuse the pprint_rename function for diff --summary output.
  diff.c: Properly quote file names in diff --summary output.
  diff.c: More logical file name quoting for renames in diffstat.

 Aneesh Kumar K.V (1):
  blameview: Move the commit info to a pane below the blame window.

 David K=C3=A5gedal (5):
  Handle uncommitted changes and cache descriptions
  git-blame.el: improve color handling
  git-blame.el: blame unsaved changes
  git-blame.el: Doc fixes and cleanup
  git-blame.el: Autoupdate while editing

 Dotan Barak (1):
  Make it easier to override path to asciidoc command

 Eric Wong (1):
  git-svn: correctly handle boolean options via git-config

 Jakub Narebski (2):
  git-blame: Add Emacs Lisp file headers and GNU GPL boilerplate
  git-blame: Change installation instructions

 James Bowes (1):
  Read cvsimport options from repo-config

 Johannes Schindelin (4):
  for_each_reflog_ent: be forgiving about missing message
  log --reflog: honour --relative-date
  format-patch -n: make sorting easier by padding number
  log --reflog: use dwim_log

 Junio C Hamano (11):
  create_symref(): create leading directories as needed.
  reflog: handle $name =3D> remotes/%s/HEAD mapping consistently for lo=
gs
  Documentation/git-pull: describe default behaviour and config interac=
tions
  git-fetch: document automatic tag following.
  wt_status_prepare(): clean up structure initialization.
  diff_flush_name(): take struct diff_options parameter.
  t4016: test quoting funny pathnames in diff output
  Documentation: git-rebase -C<n>
  Teach git-am to pass -p option down to git-apply
  Add discussion section to git-tag documentation.
  Add RPM target for git-gui

 Linus Torvalds (1):
  git reflog show

 Mark Levedahl (2):
  Make gitk save and restore the user set window position.
  Make gitk save and restore window pane position on Linux and Cygwin.

 Matthias Lederhofer (1):
  git merge documentation: -m is optional

 Michael Loeffler (1):
  import-tars: brown paper bag fix for file mode.

 Michael S. Tsirkin (3):
  Update git-log and git-show documentation
  add -C[NUM] to git-am
  Document that git-am can read standard input.

 Mukund (1):
  Fixed some typos in git-repack docs

 Nicolas Pitre (1):
  remove mailmap.linux

 Ren=C3=A9 Scharfe (1):
  Avoid ugly linewrap in git help

 Shawn O. Pearce (313):
  git-gui: Initial revision.
  git-gui: Additional early feature development.
  git-gui: Fixed UI layout problems on Windows.
  git-gui: Corrected keyboard bindings on Windows, improved state manag=
ement.
  git-gui: Verify we should actually perform a commit when asked to do =
so.
  git-gui: Finished commit implementation.
  git-gui: Implemented amended commits.
  git-gui: Misc. nit type of bug fixes.
  git-gui: Started construction of fetch and push operations.
  git-gui: Worked around environment variable problems on Windows.
  git-gui: Reorganized startup procedure to ensure gitdir is right.
  git-gui: Fix menu item accelerator display on Mac OS X.
  git-gui: Correctly handle CR vs. LF within the console of fetch.
  git-gui: Check for fetch or push command failure and denote it.
  git-gui: Don't complain if no .git/remotes exist.
  git-gui: Added current TODO list.
  git-gui: Last minute idea about fetch shortcuts.
  git-gui: Automatically reopen any console closed by the user.
  git-gui: Cache all repo-config data in an array.
  git-gui: Added support for pulling from default branch of a remote.
  git-gui: Updated TODO list now that pull is starting to work.
  git-gui: Corrected diff-index/diff-files protocol parsing errors.
  git-gui: Performance improvements for large file sets.
  git-gui: More performance improvements to rescan logic.
  git-gui: Flip commit message buffer and diff area.
  git-gui: Added repack database menu option, to invoke git repack.
  git-gui: Allow the user to disable update-index --refresh during resc=
an.
  git-gui: Grab the index lock while running pull.
  git-gui: Pluralize timestamps within the options menu.
  git-gui: Disable pull menu items when the index is locked.
  git-gui: Don't let the user pull into an uncommitted working director=
y.
  git-gui: Update TODO list.
  git-gui: Bug fix for bad variable reference in display_file.
  git-gui: Changed term 'check-in' to 'include'.
  git-gui: Show only the abbreviated SHA1 after committing.
  git-gui: Cache the GIT_COMMITTER_IDENT value on first sign-off.
  git-gui: Save window geometry to .git/config during exit.
  git-gui: Change accelerator for "Include All" to M1-I.
  git-gui: Created edit menu and basic editing bindings.
  git-gui: Clear undo/redo stack when loading a message file from disk.
  git-gui: Updated TODO list now that geometry is stored.
  git-gui: Always indicate the file in the diff viewer.
  git-gui: Correctly handle files containing LF in their name.
  git-gui: Efficiently update the UI after committing.
  git-gui: Use catch rather than array names to check file.
  git-gui: Rename difffont/mainfont variables.
  git-gui: Use native tk_messageBox for errors.
  git-gui: Cleaned up error message formatting.
  git-gui: Simplified format of geometry configuration.
  git-gui: Misc. formatting cleanups.
  git-gui: Misc. bug fixes for mouse click crashes.
  git-gui: Added context menus for consoles and commit message buffer.
  git-gui: Fix mouse cursor behavior when in widgets.
  git-gui: Teach sign off to be more intelligent.
  git-gui: Corrected font used for options menu items.
  git-gui: Honor system font and let user configure fonts.
  git-gui: Allow the user to change the diff viewer font size.
  git-gui: Refresh a file if it has an empty diff.
  git-gui: Make use of the Tk font system rather than faking it.
  git-gui: Improve right click context menu binding on all platforms.
  git-gui: Rename quitting global to is_quitting.
  git-gui: Use arrow cursor rather than left_ptr.
  git-gui: Refactor options menu into an options dialog.
  git-gui: Allow the user to manipulate the fonts from the options pane=
l.
  git-gui: Supply progress feedback when running update-index.
  git-gui: Minor options dialog UI cleanups.
  git-gui: Added Options... menu item to end of diff context menu.
  git-gui: Use 'after 1' to post UI rather than tkwait.
  git-gui: Correct bugs in font config handling.
  git-gui: Hide non-commit related commands when invoked as git-citool.
  git-gui: Don't load the global options unless necessary.
  git-gui: Allow the user to disable diff stat summary during pull.
  git-gui: Run the pre-commit hook in the background.
  git-gui: Remove the commit_active global variable.
  git-gui: Added post-commit invocation after the commit is done.
  git-gui: Always use eq/ne for string comparsions.
  git-gui: Reshow diff if we sent the file to update-index.
  git-gui: Cleanup diff construction code to prepare for more options.
  git-gui: Allow the user to control the number of context lines in a d=
iff.
  git-gui: Sort the list of paths being updated in the index.
  git-gui: Use a smaller pipe buffer for update-index.
  git-gui: Allow the user to copy name of the file in the diff viewer.
  git-gui: Correct language for M_/A_ status codes.
  git-gui: Display status on left in diff header.
  git-gui: Minor UI layout improvements for console windows.
  git-gui: Reverted file name text field to a label.
  git-gui: By default don't allow partially included files.
  git-gui: Refactor mouse clicking on file names/icons.
  git-gui: Narrow the no differences information message.
  git-gui: Implemented multiple selection in file lists.
  git-gui: Refactor update_status -> rescan.
  git-gui: Provide an after-rescan script to rescan.
  git-gui: Allow update_index to also run a script when it completes.
  git-gui: Automatically update-index all included files before commit.
  git-gui: Disable diff actions when no diff is active.
  git-gui: Created makefile to install the program.
  git-gui: Correctly handle GIT_DIR environment variable.
  git-gui: Create Windows shortcut icons for git-gui.
  git-gui: Protect ourselves from funny GIT_DIR/working directory setup=
s.
  git-gui: Handle ' within paths when creating Windows shortcuts.
  git-gui: Only populate a fetch or push if we have an action.
  git-gui: Create a .app file on MacOS X if requested.
  git-gui: Display error dialog on Mac OS X when no .git found.
  git-gui: Make initial commits work properly.
  git-gui: Only reshow diff when really necessary.
  git-gui: Refactor file state representations.
  git-gui: Add menu option to include only selected files.
  git-gui: Misc. comment formatting cleanups.
  git-gui: Start UI with the index locked.
  git-gui: Remove completed items from TODO list.
  git-gui: Toggle between new commit and amend commit modes.
  git-gui: Verify the user has GIT_COMMITTER_IDENT before comitting.
  git-gui: Rephrase rescan before commit informational message.
  git-gui: Allow adding untracked files in selection.
  git-gui: Don't create PkgInfo on Mac OS X "desktop icons".
  git-gui: Teach the gui how to uninclude a file.
  git-gui: Make consecutive icon clicks toggle included status of a fil=
e.
  git-gui: Correct toggling of deleted file status.
  git-gui: Fix list loading corruption introduced by 1461c5f3.
  git-gui: Describe deleted symlinks in a more friendly way.
  git-gui: Correct toggling of added/untracked status for new files.
  git-gui: Updated TODO list now that a task is complete.
  git-gui: Refactored diff line display formatting logic.
  git-gui: Restore the all important shebang line.
  git-gui: Update in memory states after commit.
  git-gui: Correct some state matchings for include/remove.
  git-gui: Improve handling of merge commits.
  git-gui: Allow users to run fsck-objects from the gui.
  git-gui: Don't save amended commit message buffer.
  git-gui: Reworded verify console title.
  git-gui: Seperate out the database operations in project menu.
  git-gui: Rename Project menu to Repository.
  git-gui: Added about dialog box.
  git-gui: Be more Macintosh like.
  git-gui: Make the copyright notice serve double duty.
  git-gui: Include the Tcl/Tk version in the about dialog.
  git-gui: Abstract out windows platform test to is_Windows proc.
  git-gui: Correct is_MacOSX platform test.
  git-gui: Warn Cygwin users about possible environment issues.
  git-gui: Added configuration editor TODO list.
  git-gui: Refactor M1 binding selection.
  git-gui: Added menu command to visualize all branches.
  git-gui: Don't start 'gitk --all' on Mac OS X.
  git-gui: Improve pull error dialogs.
  git-gui: Added revert changes command.
  git-gui: Display the current branch.
  git-gui: Support file state MD (modified/deleted).
  git-gui: Created Branch menu.
  git-gui: Parse off refs/remotes when showing current branch.
  git-gui: Abort on not implemented branch switching.
  git-gui: Automatically skip tracking branches in branch menu.
  git-gui: Rename all_branches -> all_heads.
  git-gui: Misc. comment and formatting cleanups.
  git-gui: Started implementation of switch_branch.
  git-gui: Set a proper title on our revert confirm dialog box.
  git-gui: Updated todo list.
  git-gui: Enable resolution of merge conflicts.
  git-gui: Auto-update any A? or M? files during rescan.
  git-gui: Reworded 'Include' to 'Add' to match core Git.
  git-gui: Created very crude Tools menu, to support miga.
  git-gui: Show all fetched branches for remote pulls.
  git-gui: Run git-gc rather than git-repack.
  git-gui: Corrected behavior of deleted (but existing in HEAD) files.
  git-gui: Correct wording of the revert confirmation dialog.
  git-gui: Work around odd cygpath bug on Windows.
  git-gui: Change more 'include' language to 'add'.
  git-gui: Hide the ugly bash command line from the windows desktop ico=
n.
  git-gui: Modified makefile to embed version into git-gui script.
  git-gui: Display the git-gui version in the Help->About dialog.
  git-gui: Display the full GPL copyright notice in about dialog.
  git-gui: Ensure version number is always current.
  git-gui: Allow the user to copy the version data to the clipboard.
  git-gui: Don't offer my miga hack if its configuration file isn't pre=
sent.
  git-gui: Suggest when running 'git gc' may be worthwhile.
  git-gui: Refactor reponame computation.
  git-gui: Cleanup usage of gitdir global variable.
  git-gui: Allow [gitdir ...] to act as [file join [gitdir] ...].
  git-gui: Make the gitk starting message match our usual format.
  git-gui: Display the directory we are entering during startup.
  git-gui: Start file status display refactoring.
  git-gui: Convert UI to use 'staged for commit' interface.
  git-gui: Correct DD file state to be only D_.
  git-gui: Remove invalid DM state.
  git-gui: Cleanup state descriptions.
  git-gui: Refactor add/remove proc names to align with reality.
  git-gui: Add or unstage based on the specific icon used.
  git-gui: Refactor the revert (aka checkout-index) implementation.
  git-gui: Refactor the add to commit state filters.
  git-gui: Simplify printing of index info to update-index.
  git-gui: Only permit selection in one list at a time.
  git-gui: Pad the cancel/save buttons in the options window.
  git-gui: Implemented create branch GUI.
  git-gui: Bind M1-N to create branch.
  git-gui: Implemented local branch deletion.
  git-gui: Allow users to delete branches merged upstream.
  git-gui: Allow creating branches from tracking heads.
  git-gui: Use borders on text fields in branch dialog.
  git-gui: Remove 'Allow Partially Added Files' option.
  git-gui: Move commit_prehook into commit_tree.
  git-gui: Improve the branch delete confirmation dialogs.
  git-gui: Don't delete the test target branch.
  git-gui: Attempt to checkout the new branch after creation.
  git-gui: Refactor current_diff -> current_diff_path.
  git-gui: Remove combined diff showing behavior.
  git-gui: Improve the display of merge conflicts.
  git-gui: Improve diff --cc viewing for unmerged files.
  git-gui: Fix bug in unmerged file display.
  git-gui: Clear diff from viewer if the side changed.
  git-gui: Correct disappearing unstaged files.
  git-gui: Add Refresh to diff viewer context menu.
  git-gui: Correct unmerged file detection at commit time.
  git-gui: Pad new branch name input box.
  git-gui: Use a grid layout for branch dialog.
  git-gui: Improve the merge check interface for branch deletion.
  git-gui: Change rude error popup to info popup.
  git-gui: Correctly ignore '* Unmerged path' during diff.
  git-gui: Make diff viewer colors match gitk's defaults.
  git-gui: Never line wrap in file lists.
  git-gui: Don't offer tracking branches if none exist.
  git-gui: Give a better error message on an empty branch name.
  git-gui: Allow user to specify a branch name pattern.
  git-gui: Improve keyboard traversal in dialogs.
  git-gui: Fully select a field when entering into it.
  git-gui: Automatically toggle the relevant radio buttons.
  git-gui: Correctly categorize tracking branches and heads.
  git-gui: Update todo list with finished and new items.
  git-gui: Slightly tweak new window geometry.
  git-gui: Create missing branch head on initial commit.
  git-gui: Don't format the mode line of a diff.
  git-gui: Force an update-index --refresh on unchanged files.
  git-gui: Don't attempt to tag new file/deleted file headers in diffs.
  git-gui: Fix 'Select All' action on Windows.
  git-gui: Ignore 'No newline at end of file' marker line.
  git-gui: Always start a rescan on an empty diff.
  git-gui: Don't show content of untracked binary files.
  git-gui: Limit display of large untracked files.
  git-gui: When possible show the type of an untracked file.
  git-gui: Don't try to tag the 'Binary files * and * differ' line.
  git-gui: Remove spurious newline in untracked file display.
  git-gui: Honor system encoding for filenames.
  git-gui: Handle commit encoding better.
  git-gui: Display database stats (count-objects -v) on demand.
  git-gui: Implement basic branch switching through read-tree.
  git-gui: Use system default labelframe bordering.
  git-gui: Display the size of the pack directory.
  git-gui: Only allow Refresh in diff context menu when we have a diff.
  git-gui: Allow staging/unstaging individual diff hunks.
  git-gui: Elide CRs appearing in diff output from display.
  git-gui: Cleanup end-of-line whitespace in commit messages.
  git-gui: Unset unnecessary UI setup variable.
  git-gui: Force focus to the diff viewer on mouse click.
  git-gui: Support 'Visualize All Branches' on Mac OS X.
  git-gui: Pad the database statistics dialog window.
  git-gui: Prefer Tk's entry widget over a 1 line text field.
  git-gui: Remove Pull menu and cleanup Branch/Fetch/Push menus.
  git-gui: Don't switch branches if changing to the current branch.
  git-gui: Maintain the same file list for diff during refresh.
  git-gui: Always use lsearch -exact, to prevent globbing.
  git-gui: Added arbitrary branch pushing support.
  git-gui: Remove no longer used pull from remote code.
  git-gui: Always use -v option to push.
  git-gui: Refactor console success/failure handling.
  git-gui: Use builtin version of 'git gc'.
  git-gui: Implement local merge operations.
  git-gui: Let users abort with `reset --hard` type logic.
  git-gui: Update status bar during a merge.
  git-gui: Don't allow users to commit a bad octopus merge.
  git-gui: Don't allow merges in the middle of other things.
  git-gui: Always offer scrollbars for branch lists.
  git-gui: Support merge.summary, merge.verbosity.
  git-gui: Reword meaning of merge.summary.
  git-gui: Offer quick access to the HTML formatted documentation.
  git-gui: Test for Cygwin differently than from Windows.
  git-gui: Implemented file browser and incremental blame.
  git-gui: Improve the icons used in the browser display.
  git-gui: Display the current branch name in browsers.
  git-gui: Allow users to edit user.name, user.email from options.
  git-gui: Use -M and -C when running blame.
  git-gui: Correctly handle spaces in filepaths.
  git-gui: Display original filename and line number in blame.
  git-gui: Install column headers in blame viewer.
  git-gui: Use a grid layout for the blame viewer.
  git-gui: Assign background colors to each blame hunk.
  Correct ^0 asciidoc syntax in fast-import docs.
  Correct some language in fast-import documentation.
  Correct spelling of fast-import in docs.
  tar archive frontend for fast-import.
  git-gui: Update known branches during rescan.
  git-gui: Support keyboard traversal in browser.
  git-gui: Replace \ with \\ when showing paths.
  git-gui: Refactor single_commit to a proc.
  git-gui: Separate transport/branch menus from multicommit.
  git-gui: Optionally save commit buffer on exit.
  git-gui: View blame from the command line.
  git-gui: Select subcommands like git does.
  git-gui: Relabel the Add All action.
  git-gui: Use git-config now over git-repo-config.
  git-gui: Redesign the display of annotated files.
  git-gui: Jump to the first annotation block as soon as its available.
  git-gui: Improve annotated file display.
  git-gui: Focus into blame panels on Mac OS.
  git-gui: Stop deleting gitk preferences.
  fast-import: Hide the pack boundary commits by default.
  fast-import: Add tip about importing renames.
  bash: Hide git-fast-import.
  fast-import: Support reusing 'from' and brown paper bag fix reset.
  git-gui: Allow gitexecdir, INSTALL to be set by the caller.
  git-gui: Rename GIT_VERSION to GITGUI_VERSION.
  git-gui: Generate a version file on demand.
  git-gui: Handle gitgui tags in version gen.
  git-gui: Guess our version accurately as a subproject.
  git-gui: Change base version to 0.6.
  Link git-gui into the master Makefile.

 Theodore Ts'o (2):
  Print a sane error message if an alias expands to an invalid git comm=
and
  Allow aliases to expand to shell commands
