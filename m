From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.8
Date: Fri, 23 Dec 2005 15:19:41 +0000
Message-ID: <1135351181.8101.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 23 16:19:52 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Epohx-0003IZ-DE
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 16:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbVLWPTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 10:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbVLWPTp
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 10:19:45 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:65301 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030548AbVLWPTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 10:19:45 -0500
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20051223151944.LJAD17804.mta08-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>;
          Fri, 23 Dec 2005 15:19:44 +0000
Received: from cpc1-cmbg5-3-0-cust39.cmbg.cable.ntl.com ([81.104.192.39])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20051223151943.XYMH1068.aamta10-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust39.cmbg.cable.ntl.com>;
          Fri, 23 Dec 2005 15:19:43 +0000
To: GIT <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13993>

Stacked GIT 0.8 release is available from http://www.procode.org/stgit/

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

What's new in this release:

      * 'branch' command for the GIT branches manipulation: creation,
        deletion, switching, renaming, cloning (including the StGIT
        patches)
      * 'patches' command to show the StGIT patches modifying a file
      * Better visualisation of the StGIT patches and branches (a short
        description can be displayed)
      * '--fold' option for the 'pick' command to allow folding a given
        commit onto an existing patch
      * Automatic invocation of the editor for the cover message when
        sending a series by e-mail
      * StGIT informs when a patch was modified during a push or pick
        operation (i.e. a three-way merge was needed)
      * StGIT now complies with the recommended format for the author
        information in the patch description (both for sending and
        receiving)
      * Further optimisations
      * Bug fixes

Acknowledgements (generated with 'git shortlog'):

Catalin Marinas:
      Optimise 'push' to use git-apply instead of git-read-tree
      Escape the unusual characters in the name <email> strings
      Cache the HEAD value
      Make __commits global in git.py
      Add an uninstallable script for profiling
      Add the --reset option to status
      'status --reset' should remove the conflicts as well
      TODO updated with the need for a 'prune' command
      Add a --fold option to pick
      Allow git.apply_patch() to take a base revision
      Add a --reset option to resolved
      Fix the caching of the HEAD value
      Use git_id in import and fold instead of git.rev_parse
      Allow the short version of --base (i.e. -b) in import
      Flush the HEAD cache in set_head_file()
      Fix the branch protect/unprotect message
      Allow the editing of the cover message before sending it by e-mail
      Notify when a patch was modified during a push operation
      Notify when a cherry-picked commit was modified by 'pick'
      Capture the KeyboardInterrupt exception
      Fix the 'files' initialisation in git.checkout()
      Add a patches command
      Optimise the export command
      Add a space after ',' when building the e-mail recipients headers
      Different fixes for the branch command
      Optimise pick --fold to use git-apply first
      Fix the --name option for the pick command
      Fix the unapplied variable missing in export.py
      Allow 'stg status --reset' to work on individual files
      Make StGIT comply with the author information retrieving
      Update the tutorial
      Update the TODO information
      Fix the import command when the body is empty
      "status --reset" does not restore the deleted files
      Release 0.8

Chuck Lever:
      Use a more clear message when pop or push can't apply a patch
      Use "git-rev-parse" to get the HEAD commit
      Add a stack method to delete a patch series
      Create a new utility function in git.py for setting the HEAD link
      Add git method for creating a fresh branch
      Add git method for switching to a different branch
      Add the ability to delete a branch to git.py
      Add the ability to rename a git branch
      Allow print_crt_patch to work on other branches
      Rudimentary support for multiple development branches
      Allow user to protect some branches against "stg pull"
      Add support for branch description files
      Fix a couple of bugs in "stg branch --create"
      Fix a bug in "stg branch --rename"
      Give the global "crt_series" variable a default value
      Remove unused import in stgit/git.py
      Make sure switch_branch uses the right __head
      Get rid of an unused variable
      Fix exception error message in git.merge()
      Make switching to the current branch a no-op
      Make listing branches more efficient
      "stg mail" doesn't distinguish between unapplied and non-existent patches
      Print the git version when running the "stg version" command
      Need to do "git-update-index --refresh" in more places
      Prevent stderr from appearing on stdout when running commands
      Use __run instead of os.system() in git.merge()
      Using a mutable default function argument is bad
      remove extra refresh_index() call in apply_patches()
      "stg export" error message could be more specific
      Fix up help string for "stg clone"
      Replace a variable that uses the same name as a built-in
      Add a stack method for determining whether a branch is initialised
      Generalize branch renaming
      Better error message when renaming patches to same name
      use "crt_series.get_branch()" instead of "git.get_head_file()"
      Fix a typo in "stg pick"
      Fix a typo in the "add" command's documentation
      Cleanup: remove unused variable
      Clean up StGIT's "branch --delete" command
      Seamlessly allow diffs "from" the current working directory
      Using delete_patch while deleting a branch is broken
      Align branch descriptions in output of "stg branch -l"
      Use git-rev-parse to find the local GIT repository
      "stg series" option to show patch summary descriptions
      Add facility to print short list of patches around 'top'
      Make "stg export" save the base commit in the output directory
      Fast-forwarding does a git.switch() even when it forwarded no patches
      Add a "--clone" option to "stg branch"
      Add a brief sentence to the documentation of the "stg branch" command.
      Remove "-r" option on invocations of git-diff-index

Paolo 'Blaisorblade' Giarrusso:
      Parse /top.old with id and when requesting diffs
      Ask vim to avoid backup copies of .stgit.msg
      Add an option to delete a patch from a certain branch

Trond Myklebust:
      remove formatting of git log entry on an imported patch

-- 
Catalin
