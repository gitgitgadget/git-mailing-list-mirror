From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/3] test failures on v1.7.8-rc2
Date: Sat, 19 Nov 2011 19:37:31 +0000
Message-ID: <4EC8057B.1060500@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 21:02:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRr7U-0000MP-Ot
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab1KSUCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:02:23 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:61659 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753461Ab1KSUCR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2011 15:02:17 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RRr79-0002fn-ZG; Sat, 19 Nov 2011 20:02:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185700>

Hi Junio,

The test-suite on cygwin has a number of failures. These patches fix
up most of the problems. I know v1.7.8-rc3 is out already, but it takes
2 hours 15 minutes to run the tests on cygwin (and that's without the svn
tests!) so I didn't want to rebase and re-test the patches tonight ... ;-)

    [PATCH 1/3] t5501-*.sh: Fix url passed to clone in setup test
    [PATCH 2/3] config.c: Fix a static buffer overwrite bug by avoiding mkpath()
    [PATCH 3/3] git-submodule.sh: Don't use $path variable in eval_gettext string

Note that patch #3 is an RFC; see patch for more.

[with these patches applied, I have GIT_SKIP_TEST='t0061.3 t0070.3']

ATB,
Ramsay Jones
