From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/14] misc test-suite patches
Date: Tue, 14 Dec 2010 18:17:37 +0000
Message-ID: <4D07B4C1.2050007@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:45:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZsM-0004cc-Af
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121Ab0LNSpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:45:21 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52451 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753550Ab0LNSpT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:45:19 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZsD-0006gw-Yl; Tue, 14 Dec 2010 18:45:18 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163662>

Hi Junio,

I've had many of these test-suite related patches lying around for
a while, so I'm passing these along now in the hope I can remove
some old branches...

[PATCH 01/14] t3600-rm.sh: Don't pass a non-existent prereq to test #15
[PATCH 02/14] t9142: Move call to start_httpd into the setup test
[PATCH 03/14] lib-git-svn.sh: Avoid setting web server variables unnecessarily
[PATCH 04/14] lib-git-svn.sh: Add check for missing mod_dav_svn module
[PATCH 05/14] lib-git-svn.sh: Add check for mis-configured web server variables
[PATCH 06/14] t9501-*.sh: Fix a test failure on Cygwin
[PATCH 07/14] t7800-difftool.sh: Fix a test failure on Cygwin
[PATCH 08/14] help.c: Fix detection of custom merge strategy on cygwin
[PATCH 09/14] t1301-*.sh: Fix the 'forced modes' test on cygwin
[PATCH 10/14] t6038-*.sh: Pass the -b (--binary) option to sed on cygwin
[PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed on cygwin
[PATCH 12/14] t3032-*.sh: Do not strip CR from line-endings while grepping on MinGW
[PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
[PATCH 14/14] t{3032,6038}-*.sh: Allow SED_BIN_OPT to override the -b sed option

These patches don't really have too much in common, well 2-5 and 10-12 are
somewhat related, other than fixing tests! (These were mostly done on Linux
and Cygwin but, since I also test on MinGW, one or two are just for MinGW)

ATB,
Ramsay Jones
