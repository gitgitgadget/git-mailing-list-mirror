From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Pull request for msysGit patches
Date: Tue, 28 Sep 2010 10:46:40 +0100
Message-ID: <87ocbitd33.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 11:48:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Wns-00023V-Kt
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 11:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab0I1Jss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 05:48:48 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:54060 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751964Ab0I1Jsr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 05:48:47 -0400
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P0Wnj-0007jv-Fz; Tue, 28 Sep 2010 10:48:43 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P0Wll-0001ch-QA; Tue, 28 Sep 2010 10:46:41 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 1875624CDB; Tue, 28 Sep 2010 10:46:41 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: msysgit@googlegroups.com
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157400>

Junio,

The msysGit tree currently tracks some 50+ patches on top of 'next'. I
have gathered 42 of these that look good to move upstream. 
Please pull from
  git://repo.or.cz/git/mingw/4msysgit.git work/pt/for-junio
also visible for inspection at
  http://repo.or.cz/w/git/mingw/4msysgit.git/shortlog/refs/heads/work/pt/for-junio

Output of git-request-pull....

The following changes since commit 2a10b71f738b8b77ba8d243574f537a54dbf9a62:

  Merge branch 'mg/reset-doc' into next (2010-09-22 09:38:57 -0700)

are available in the git repository at:

  git://repo.or.cz/git/mingw/4msysgit.git work/pt/for-junio

Eric Sunshine (6):
      Fix 'clone' failure at DOS root directory.
      Fix Windows-specific macro redefinition warning.
      Add MinGW-specific execv() override.
      Side-step MSYS-specific path "corruption" leading to t5560 failure.
      Side-step sed line-ending "corruption" leading to t6038 failure.
      Side-step line-ending corruption leading to t3032 failures.

Erik Faye-Lund (6):
      core.hidedotfiles: hide '.git' dir by default
      mingw: do not hide bare repositories
      mingw: fix st_mode for symlink dirs
      send-email: accept absolute path even on Windows
      config.c: trivial fix for compile-time warning
      mingw: do not crash on open(NULL, ...)

Heiko Voigt (4):
      mingw: move unlink wrapper to mingw.c
      mingw: work around irregular failures of unlink on windows
      mingw: make failures to unlink or move raise a question
      mingw: add fallback for rmdir in case directory is in use

Johannes Schindelin (11):
      Avoid TAGS/tags warning from GNU Make
      When initializing .git/, record the current setting of core.hideDotFiles
      git-am: fix absolute path logic on Windows
      mingw_rmdir: set errno=ENOTEMPTY when appropriate
      Add a Windows-specific fallback to getenv("HOME");
      Tests: make sure that $DIFF is non-empty
      merge-octopus: Work around environment issue on Windows
      Make sure that git_getpass() never returns NULL
      Give commit message reencoding for output on MinGW a chance
      Fix typo in pack-objects' usage
      Fix compile error on MinGW

Johannes Sixt (1):
      criss cross rename failure workaround

Karsten Blees (4):
      Enable color output in Windows cmd.exe
      Support Unicode console output on Windows
      Detect console streams more reliably on Windows
      Warn if the Windows console font doesn't support Unicode

Pat Thoyts (6):
      Skip t1300.70 and 71 on msysGit.
      fix mingw stat() and lstat() implementations for handling symlinks
      Report errors when failing to launch the html browser in mingw.
      mingw: add tests for the hidden attribute on the git directory
      Do not strip CR when grepping HTTP headers.
      Skip 'git archive --remote' test on msysGit

Sebastian Schuberth (2):
      MinGW: Use pid_t more consequently, introduce uid_t for greater compatibility
      MinGW: Add missing file mode bit defines

bert Dvornik (2):
      mingw: Don't ask the user yes/no questions if they can't see the question.
      send-email: handle Windows paths for display just like we do for processing

 Documentation/config.txt            |    6 +
 Makefile                            |    2 +
 abspath.c                           |    7 +-
 builtin/config.c                    |    4 +-
 builtin/init-db.c                   |    1 +
 builtin/pack-objects.c              |    2 +-
 cache.h                             |    7 +
 compat/mingw.c                      |  296 +++++++++++++++++++++++++++++++++--
 compat/mingw.h                      |   63 +++++---
 compat/regex/regexec.c              |   20 ++-
 compat/winansi.c                    |  132 ++++++++++++----
 config.c                            |   11 ++-
 connect.c                           |    8 +-
 environment.c                       |    1 +
 git-am.sh                           |    2 +-
 git-compat-util.h                   |    8 +
 git-merge-octopus.sh                |    5 +
 git-send-email.perl                 |    4 +-
 log-tree.c                          |    3 +-
 path.c                              |    2 +-
 t/t0001-init.sh                     |   28 ++++
 t/t1300-repo-config.sh              |    6 +-
 t/t3032-merge-recursive-options.sh  |   11 +-
 t/t4130-apply-criss-cross-rename.sh |    4 +-
 t/t5000-tar-tree.sh                 |    2 +-
 t/t5503-tagfollow.sh                |    9 +-
 t/t5560-http-backend-noserver.sh    |    5 +-
 t/t6038-merge-text-auto.sh          |    4 +-
 t/test-lib.sh                       |    4 +
 29 files changed, 556 insertions(+), 101 deletions(-)
