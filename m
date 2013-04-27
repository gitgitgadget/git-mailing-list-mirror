From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/2] Remove the CYGWIN_V15_WIN32API build variable
Date: Sat, 27 Apr 2013 20:39:20 +0100
Message-ID: <517C2968.4010605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, mlevedahl@gmail.com,
	tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB5o-0000tv-7O
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509Ab3D0TrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:24 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33169 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756460Ab3D0TrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:23 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id DE3BC384081;
	Sat, 27 Apr 2013 20:47:22 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 4AA7738407C;
	Sat, 27 Apr 2013 20:47:22 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:47:21 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222677>


Hi Junio,

I have tested these patches on cygwin 1.5; the test suite threw up
one additional test failure (t4205-*.sh test 18-20, 27), but it was
not caused by these patches. (I will be sending a patch to fix this
issue).

Unfortunately, I can't test them on cygwin 1.7, but I suspect they
will work just fine (famous last words!). Hopefully someone will be
able to try them on cygwin 1.7 and report on a successful test.

ATB,
Ramsay Jones

Jonathan Nieder (1):
  mingw: rename WIN32 cpp macro to GIT_NATIVE_WINDOWS

Ramsay Allan Jones (1):
  cygwin: Remove the CYGWIN_V15_WIN32API build variable

 Makefile          |  7 -------
 abspath.c         |  2 +-
 compat/cygwin.c   |  5 -----
 compat/terminal.c |  4 ++--
 compat/win32.h    |  2 +-
 config.mak.uname  |  1 -
 diff-no-index.c   |  2 +-
 git-compat-util.h |  3 ++-
 help.c            |  2 +-
 run-command.c     | 10 +++++-----
 test-chmtime.c    |  2 +-
 thread-utils.c    |  2 +-
 12 files changed, 15 insertions(+), 27 deletions(-)

-- 
1.8.2
