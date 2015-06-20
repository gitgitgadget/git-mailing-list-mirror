From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Sporadic test failures on OSX 10.10.3
Date: Sat, 20 Jun 2015 11:47:58 +0200
Message-ID: <20150620094758.GA22226@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 11:48:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6FO2-0006aQ-6o
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 11:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbbFTJsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 05:48:12 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:36281 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbbFTJsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 05:48:11 -0400
Received: from [92.76.74.139] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Z6FNg-0003sg-7R
	for git@vger.kernel.org; Sat, 20 Jun 2015 11:48:08 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272225>

Hi,

I am currently experiencing sporadic test failures on Mac OS X 10.10.3:

Test Summary Report
-------------------
t7503-pre-commit-hook.sh                         (Wstat: 256 Tests: 11 Failed: 1)
  Failed test:  9
  Non-zero exit status: 1
t7502-commit.sh                                  (Wstat: 256 Tests: 64 Failed: 1)
  Failed test:  59
  Non-zero exit status: 1
t7407-submodule-foreach.sh                       (Wstat: 256 Tests: 17 Failed: 1)
  Failed test:  14
  Non-zero exit status: 1
t7406-submodule-update.sh                        (Wstat: 256 Tests: 43 Failed: 2)
  Failed tests:  36-37
  Non-zero exit status: 1
Files=702, Tests=12559, 618 wallclock secs ( 6.56 usr  2.08 sys + 716.50 cusr 932.03 csys = 1657.17 CPU)
Result: FAIL
make[1]: *** [prove] Error 1
make: *** [test] Error 2

When I execute the tests individually they succeed. Sometimes running the
testsuite succeeds sometimes it does not. For example now running the
testsuite the first and second time showed no failures. Only the third run
revealed the above.

Is anyone else experiencing this as well? I am seeing this on Junios
master (f86f31ab33c3). The list of failed tests varies sometimes.

Cheers Heiko
