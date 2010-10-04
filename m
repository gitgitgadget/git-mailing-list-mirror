From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PULL] Pull request from msysGit
Date: Tue, 05 Oct 2010 00:52:20 +0100
Message-ID: <87ocb9zfbf.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 01:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2upf-0007rK-4j
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 01:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab0JDXwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 19:52:30 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:56271 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756643Ab0JDXw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 19:52:29 -0400
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P2upV-0002jo-SS; Tue, 05 Oct 2010 00:52:25 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P2upR-0002Lz-Nv; Tue, 05 Oct 2010 00:52:21 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id F23D325205; Tue,  5 Oct 2010 00:52:20 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158144>

This follows up on the comments made for the previous pull request for
patches from msysGit. This batch is restricted to those that passed
review or have been modified as a result of the earlier review.
I've added some Acked-by's resulting from comments made.

The following changes since commit 1e633418479926bc85ed21a4f91c845a3dd3ad66:

  Merge branch 'maint' (2010-09-30 14:59:53 -0700)

are available in the git repository at:

  git://repo.or.cz/git/mingw/4msysgit.git work/pt/for-junio
or alternatively
  http://repo.or.cz/w/git/mingw/4msysgit.git/shortlog/refs/heads/work/pt/for-junio

5debf9a Add MinGW-specific execv() override.
77df1f1 Fix Windows-specific macro redefinition warning.
b248e95 Fix 'clone' failure at DOS root directory.
1a40420 mingw: do not crash on open(NULL, ...)
5e9677c git-am: fix detection of absolute paths for windows
36e035f Side-step MSYS-specific path "corruption" leading to t5560 failure.
ca02ad3 Side-step sed line-ending "corruption" leading to t6038 failure.
97f2c33 Skip 'git archive --remote' test on msysGit
a94114a Do not strip CR when grepping HTTP headers.
3ba9ba8 Skip t1300.70 and 71 on msysGit.
4e57baf merge-octopus: Work around environment issue on Windows
442dada MinGW: Report errors when failing to launch the html browser.
9b9784c MinGW: fix stat() and lstat() implementations for handling symlinks
4091bfc MinGW: Add missing file mode bit defines
e7cf4e9 MinGW: Use pid_t more consequently, introduce uid_t for greater compatibility

 abspath.c                        |    6 +++-
 compat/mingw.c                   |   56 ++++++++++++++++++++++++++++++++-----
 compat/mingw.h                   |   36 +++++++++++++++++++-----
 git-am.sh                        |   12 ++++----
 git-merge-octopus.sh             |    5 +++
 git-sh-setup.sh                  |   15 ++++++++++
 t/t1300-repo-config.sh           |    6 ++--
 t/t5000-tar-tree.sh              |    2 +-
 t/t5503-tagfollow.sh             |    9 +-----
 t/t5560-http-backend-noserver.sh |    5 ++-
 t/t6038-merge-text-auto.sh       |    4 ++-
 t/test-lib.sh                    |    2 +
 12 files changed, 122 insertions(+), 36 deletions(-)
