From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: [PATCH 0/5] Fix msvc build
Date: Tue, 26 Feb 2013 20:48:09 +0100
Message-ID: <512D1179.7030009@kdbg.org>
References: <510AB766.4030806@ramsay1.demon.co.uk> <7vehg4288w.fsf@alter.siamese.dyndns.org> <512B2003.804@viscovery.net> <alpine.DEB.1.00.1302252000440.32206@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQWj-0006Pv-9F
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759948Ab3BZTsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:48:16 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:35764 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759922Ab3BZTsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 14:48:14 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9CBD013004E;
	Tue, 26 Feb 2013 20:48:10 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id F31B719F486;
	Tue, 26 Feb 2013 20:48:09 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <alpine.DEB.1.00.1302252000440.32206@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217169>

Am 25.02.2013 20:01, schrieb Johannes Schindelin:
> Can you please send a pull request on GitHub?

It's not github, but hopefully useful for you:

The following changes since commit bcd45b4085f9269a536c8fb1963ac8380bfac0e8:

  Update draft release notes to 1.8.2 (2013-02-01 12:52:08 -0800)

are available in the git repository at:

  git://repo.or.cz/git/mingw/j6t.git rj/msvc

for you to fetch changes up to 4c3f0410bfc3f42f9c62c7a23a0ef78420967f84:

  msvc: avoid collisions between "tags" and "TAGS" (2013-02-26 20:40:16
+0100)

----------------------------------------------------------------
Ramsay Allan Jones (5):
      msvc: Fix compilation errors caused by poll.h emulation
      msvc: git-daemon: Fix linker "unresolved external" errors
      msvc: Fix build by adding missing symbol defines
      msvc: test-svn-fe: Fix linker "unresolved external" error
      msvc: avoid collisions between "tags" and "TAGS"

 compat/msvc.h                     | 2 ++
 compat/vcbuild/include/sys/poll.h | 1 -
 compat/vcbuild/include/unistd.h   | 3 +++
 config.mak.uname                  | 4 +++-
 git-compat-util.h                 | 3 +++
 test-svn-fe.c                     | 2 +-
 6 files changed, 12 insertions(+), 3 deletions(-)
 delete mode 100644 compat/vcbuild/include/sys/poll.h
