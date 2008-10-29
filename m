From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Pull request for sub-tree merge into /contrib/gitstats
Date: Thu, 30 Oct 2008 00:06:44 +0100
Message-ID: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:08:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK98-0005xN-R5
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbYJ2XGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbYJ2XGt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:06:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:44409 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbYJ2XGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:06:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so230143fgg.17
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=VgcgJWzNmJbI8pIi613eLuu2HhdzYaltEmrUg5BckSk=;
        b=qWlQRtWTPfYpxdpgKU/3tXcH/GIsPEBL+rHuBEeH/1KgwFr3pACcIbSYQGDebTEf1n
         FCBovN/j0sUa1zdbV5fB7YJOFd5Mk3MeQn6d3M/VoM9+8i92rVv7ygfzUItsI7+K3tej
         MKzgZtEnQvUi1iBb0i00uVKPkJrSZgMHSFrB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=CS8+V375aRJNREH5Z5mtCr359o4EaN9Rrkwb1x4KgWv4d1AN+A0vPQcl+zAQauzJr6
         Sni04dxrnPmRBdWEfdnle57WuQwsNlfobpwroI2QwLjncvk/ZRA1tvNb0BNhKzGSapaN
         L4PpOpt9ExqCXOVbSNa6ZlNr+rAJL5b2GWptY=
Received: by 10.187.227.5 with SMTP id e5mr918066far.86.1225321604342;
        Wed, 29 Oct 2008 16:06:44 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Wed, 29 Oct 2008 16:06:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99432>

My work is available in the git repository at:

  git://repo.or.cz/git-stats.git master

Please use a subtree merge to put this in contrib/gitstats.

David Symonds (2):
      Insert the git_stats path to the start of os.sys.path, not 1 element in.
      Fix some spelling mistakes.

Sverre Rabbelier (237):
      Created a script to setup a repo to test metrics on.
      Converted the setupRepo script to python to allow creating the same repo.
      Added the use cases in text form.
      Added a README.
      Initial commit for notes branch
      Changelog for 28-05-2008
      Changelog for 29-05-2008
      Changelog for 30-05-2008
      Changelog for 31-05-2008
      Created a script that aggregates author activity in one part of
the content.
      Updated the script to handle merges and to treat '-' as 0.
      Modified author.activityInArea to take a list of strings instead
of a file.
      Added a module containing the wrappers for the commands.
      Replaced funny characters in use-cases.txt with whitespace.
      Created a script that handles index related activities.
      Added a script to handle data mining related to commit history.
      Created a 'touched' command in the wrapper module.
      Added pathsTouched to the history module.
      Created a commitTouched function and a prettyPrint helper function
      Wrapped the use-cases.txt document at ~72 characters.
      Created a list of metrics that can be used to indentify fixes.
      Added three more data mining functions to the history module
      Gave the setupRepo script some major TLC.
      Added commitdiffEqual functionality to the history module.
      Creating the repository in a temp directory, use tempfile.gettempdir().
      Improved the metrics documentation.
      Use 'os.path.join(a, b)' rather than 'a + os.sep + b'.
      Removed try/except from setupRepo but added a manual raise
      Use the same configurations as test-lib.sh in setupRepo
      Copied the test-lib.sh script from git.git/t
      Modified test-lib.sh to use ~/code/git as git dir.
      Added a basic test that sets up our test repository.
      Added a test that verifies the HEAD revision hash
      There is now a testcase to check HEAD, don't do it in setupRepo
      Added a basic dispatcher to stats.py.
      Moved things around a lot, and made commitTouches fixup nonrelative paths
      Added basic dispatching functionality for diff
      Added a __init__.py file since every module needs one
      Made stats.py add the directory containing git_stats to the path
      Moved stats.py up one directory
      We no longer require running from the root of the repository
      Prefixed private methods with _ and and made parseFileDiff
accept larger diffs
      Change 'PATHS' to 'COMMIT COMMIT' in the usage text
      Finished the dispatching function for commit.
      Moved stats.py back to the git_stats directory
      Removed the $GIT_STATS_PATH related code
      Removed extra newlines and replaced import with 'from .. import ..'
      Moved stats.py back up again.
      Moved diff.diffContains to commit.logContains
      Removed the executable bit on author.py and index.py
      Added dispatching to branch and finished branchList
      Added dispatching to the author module
      Added dispatching to the index module
      Started on testing author.py and found the first bug so far
      Bugfix for the author filter in author.py
      Created a test case to point out an unimplemented function
      Added a testcase to point out wrong output for 'stats.py branch -c'
      Bugfix for the branchList output in branch.py
      Finished the branch testcases, but no test for -r switch yet
      The testcases require two patches to git-python to run successfully
      Changelog for 01-06-2008
      Changelog for 02-06-2008
      Changelog for 02-06-2008 (2)
      Changelog for 03-06-2008
      Changelog for 04-06-2008
      Changelog for 05-06-2008
      Changelog for 06-06-2008
      Changelog for 07-06-2008
      Changelog for 08-06-2008
      Changelog for 09-06-2008
      Changelog for 10-06-2008
      Made GitStats compatible with the latest version of git-python
      Patches to git-python, since its latest changes, are no longer required
      Added testcases for 'commit'
      Changelog for 10-06-2008 (2)
      Changelog for 11-06-2008
      Bugfix for commitdiffMatches
      Usability enhancement: print help msg on 'stats.py subcmd'
      Merge branch 'notes'
      Moved the changelog into the doc subdirectory
      Changelog for 12-06-2008
      Added testcases for diff and pointed out a bug and some output problems
      Bugfix for diff -i, also removed debug output
      Improved the dispatching in index.py
      Added tests for index.py
      Improved the test descriptions
      Expanded the setupRepo script to generate a more elaborate tree
      Made use of with_keep_cwd now that git-python runs from the top dir
      Added tests for "commit -r" and pointed out a bug
      Added a todo to check the file passed to "stats.py commit"
      Stripped down test-lib.sh to the bits we need
      Changelog for 13-06-2008
      Changelog for 14-06-2008
      Refactored the custom parser into it's own file
      Bugfix for commit -t, now checks if the specified file is sane
      Changelog for 15-06-2008
      Bugfix, created a missing test for "diff -n"
      Slight usability improvement
      Expanded setupRepo and refactored 'addFile' into it's own function
      Bugfix for the testsuite, added tests for 'index -a'
      Changelog for 16-06-2008
      Created a remote branch in the setupRepo script
      Bugfix, added a testcase for "branch -r -c"
      Changelog for 17-06-2008
      Extended the description of the 'branch contains' metric
      Refactored setupRepo a bit to make room for a metrics repo
      Added a little more documentation on the branch metric
      Extended setupRepo to create the repo as specified in metrics.txt
      Updated the metrics repo to have two commits on the topic branch
      Initial draft of the 'belongs to' metric
      Typo, 'dilate' should be 'dilute'
      Changelog for 19-06-2008
      Described a more complex tree in metrics.txt
      Added a bumpTime to make the commit history look a bit more sane
      Changelog for 20-06-2008
      Added with_exceptions=False to 'git rev-parse --verify'
      Added a GIT_STATS_PRETTY_PRINT environmental variable
      Added a '-v' option to stats.py
      Added more tags to the generated test repo
      Bail out when the testrepo couldn't be set up
      Use the new GIT_STATS_PRETTY_PRINT and added tags features
      When specifying kwargs they should be in quotes when not part of
a function call.
      Use Repo(".").git instead of Git(".")
      Updated the metrics repo to match the documented tree
      Changelog for 24-06-2008
      Changelog for 27-06-2008
      Made the 'belongs to' metric recursive
      Added tests for the 'belongs to' metric
      First gather all parentage information, then run metrics
      Changelog for 28-06-2008
      Moved isUnique into parse.py so that other modules may use it
      Added a "author -f" aggregation, and a test case.
      Changelog for 29-06-2008
      Minor cleanups, added documentation
      Added a switch that lists only reverts of a specified commit
      Changelog for 02-07-2008
      Changelog for 02-07-2008
      When parsing the parent listing take into account parentless commits
      Print the usage help sorted and added some documentation
      Use a stack-based approach instead of a recursive algorithm
      Added a simple 'stats.py bug' command
      Disable debug output, print minimum dilution
      Optimizations to the 'belongs to' metric
      Bugfix to only ignore if dilution was 'worse'
      Optimion to the 'belongs to' metric
      Don't filter out subsets in the belongs to metric
      Optimization in the 'belongs to' metric
      Changelog for 06-07-2008
      Improved the output of 'branch -b' with '-d'
      Added aggregation and showing all activity
      Add a config parser and an example configuration
      Bugfix to _parseFileDiff so that it handles diffs with mode changes only
      Made use of the new config parser in bug.py
      Changelog for 10-07-2008
      When the specified path was not found, return an empty dict
      Don't die when an option is not specified at all
      Moved the commit information into a seperate class
      Restructured the commit and diff module so that diff depends on commit
      Refactored bug.py to allow for a trivial aggregation function
      Refactored stats.py to use a main function
      Allow for checking deleted files in commitsThatTouched
      Check for empty diffs
      Add a diff memory to diff.py and use it in bug.py
      Don't look before we leap in getting the commit diff
      Add a 'commits that touch' memory to commit.py
      Two more memories were added and some refactoring
      Print authors sorted in 'author -e'
      Added an option to disable line numbering in diff parsing
      Added a proof of concept matcher
      Changelog for 12-07-2008
      Add an option to ignore parent in the 'belongs to' metric
      Added an option to limit the amount of commits checked
      Allow specifying True, False, or None in the config file
      Allow specifying True, False, or None on the command line
      General cleanups in bug.py
      Bugfix for branchContains Fix the branch
      Make use of the ignore_parents option to belongsTo
      Changelog for 14-07-2008
      Provide a default empty dict to pretty names
      Refactored bug.py to use a Memory and Options class
      Make config.py more versatile
      Teach config.py to read multiple verses
      Introduce a bugfixRating to bug.py
      Changelog for 15-07-2008
      Refactoring, cleanups and documentation
      Changelog for 16-07-2008
      Updated the README to include specific installation instructions
      Added a 'net loc' to 'author -a'
      Updated the tests to match the new output of 'author -a'
      Official 0.1.4 release of git-python
      Removed the redundant setupRepo.sh script
      Added an option to print the path for setupRepo.py
      Added a way to specify the path to use instead of the default
      Don't assume the temp path is /tmp
      Make use of the 'sorted' built-in
      Changelog for 17-07-2008
      Added a unit-test framework for GitStats
      Use 'key in dict' instead of 'dict.has_key(key)'
      Renamed fileDiff to FileDiff
      Bugfix for diff.py, don't die on empty diffs
      Make use of getattr instead of just trying
      Use format specifiers instead of appending to a string
      Replace backslashes with parens to do line continuation
      Don't asume setupRepo.py is executable
      Remove unneeded executionable bit on setupRepo.py
      Replace check_file with checkFile
      Use dashed_form for variable names instead of camelCase
      Changelog for 23-07-2008
      Made config.read take a bunch of strings instead of a path
      Improved testing.py output and removed manual parsing of arguments
      Added a module to dispatch unit-testing commands
      Hooked up the test suite in stats.py
      Do not require lines to end with a '\n' in the config parser
      Refactor config.py to make it more testable
      Wrote unittests for the config module and hooked them up
      Changelog for 24-07-2008
      Don't require stats.py to be in $PATH when running the regression tests
      Renamed README to INSTALL
      Expanded the INSTALL file to include usage information
      Added a README describing GitStats purpose
      Convert matcher.py to use optparse
      Add a description about the branch module
      Add a description about the author module
      Add a description about the commit module
      Add a general note about the 'stats.py'
      Add a description about the diff module
      Add a description about the index module
      Add a description about the matcher module
      Add a description about the tests module
      Renamed the GitStats to include a gitstats- prefix
      Add a description about the bug module
      Renamed Memory->GitCache and Options->OptionList
      Expanded the documentation of the bug module
      Ran ispell on all non gitstats-* files in doc/
      Ran ispell on all gitstats-* files in doc/
      Added some example values to gitstats-bug.txt
      Bugfix for the config parsing mechanism

 INSTALL                       |   33 ++
 README                        |   59 ++++
 doc/changelog.txt             |  335 +++++++++++++++++++++
 doc/gitstats-author.txt       |   30 ++
 doc/gitstats-branch.txt       |   35 +++
 doc/gitstats-bug.txt          |  109 +++++++
 doc/gitstats-commit.txt       |   44 +++
 doc/gitstats-diff.txt         |   24 ++
 doc/gitstats-index.txt        |   19 ++
 doc/gitstats-matcher.txt      |   19 ++
 doc/gitstats-stats.txt        |   36 +++
 doc/gitstats-tests.txt        |    8 +
 doc/metrics.txt               |   83 ++++++
 doc/use-cases.txt             |  160 ++++++++++
 src/git_stats/author.py       |  315 ++++++++++++++++++++
 src/git_stats/branch.py       |  420 ++++++++++++++++++++++++++
 src/git_stats/bug.py          |  306 +++++++++++++++++++
 src/git_stats/commit.py       |  343 ++++++++++++++++++++++
 src/git_stats/config          |    5 +
 src/git_stats/config.py       |  219 ++++++++++++++
 src/git_stats/config_tests.py |  245 +++++++++++++++
 src/git_stats/diff.py         |  515 ++++++++++++++++++++++++++++++++
 src/git_stats/index.py        |  102 +++++++
 src/git_stats/matcher.py      |  130 ++++++++
 src/git_stats/parse.py        |  109 +++++++
 src/git_stats/testing.py      |  212 +++++++++++++
 src/git_stats/tests.py        |   96 ++++++
 src/scripts/setupRepo.py      |  652 +++++++++++++++++++++++++++++++++++++++++
 src/scripts/setupRepo.sh      |   31 --
 src/stats.py                  |  112 +++++++
 src/t/t8100-stats.sh          |  333 +++++++++++++++++++++
 src/t/t8101-metrics.sh        |  163 ++++++++++
 src/t/test-lib.sh             |  372 +++++++++++++++++++++++
 33 files changed, 5643 insertions(+), 31 deletions(-)
 create mode 100644 INSTALL
 create mode 100644 README
 create mode 100644 doc/changelog.txt
 create mode 100644 doc/gitstats-author.txt
 create mode 100644 doc/gitstats-branch.txt
 create mode 100644 doc/gitstats-bug.txt
 create mode 100644 doc/gitstats-commit.txt
 create mode 100644 doc/gitstats-diff.txt
 create mode 100644 doc/gitstats-index.txt
 create mode 100644 doc/gitstats-matcher.txt
 create mode 100644 doc/gitstats-stats.txt
 create mode 100644 doc/gitstats-tests.txt
 create mode 100644 doc/metrics.txt
 create mode 100644 doc/use-cases.txt
 create mode 100644 src/git_stats/__init__.py
 create mode 100644 src/git_stats/author.py
 create mode 100644 src/git_stats/branch.py
 create mode 100644 src/git_stats/bug.py
 create mode 100644 src/git_stats/commit.py
 create mode 100644 src/git_stats/config
 create mode 100644 src/git_stats/config.py
 create mode 100644 src/git_stats/config_tests.py
 create mode 100644 src/git_stats/diff.py
 create mode 100644 src/git_stats/index.py
 create mode 100644 src/git_stats/matcher.py
 create mode 100644 src/git_stats/parse.py
 create mode 100644 src/git_stats/testing.py
 create mode 100755 src/git_stats/tests.py
 create mode 100644 src/scripts/setupRepo.py
 delete mode 100755 src/scripts/setupRepo.sh
 create mode 100755 src/stats.py
 create mode 100755 src/t/t8100-stats.sh
 create mode 100755 src/t/t8101-metrics.sh
 create mode 100644 src/t/test-lib.sh
