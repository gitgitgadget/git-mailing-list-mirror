From: <konstunn@ngs.ru>
Subject: "Sparse checkout leaves no entry on working directory" all the
 time on Windows 7 on Git 1.8.5.2.msysgit.0
Date: Thu, 06 Feb 2014 18:54:04 +0700
Message-ID: <web-57771132@mx45.intranet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 13:04:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBNh6-00062q-Mh
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 13:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbaBFMEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 07:04:32 -0500
Received: from fallback3.ngs.ru ([195.19.71.23]:58456 "EHLO smtpout.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755949AbaBFMEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 07:04:31 -0500
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2014 07:04:31 EST
Received: from smtpout.ngs.ru (mc-spool2 [172.16.103.67])
	by mc-spool1.in.ngs.ru (fallback) with ESMTP id 86B0218455A
	for <git@vger.kernel.org>; Thu,  6 Feb 2014 18:54:15 +0700 (NOVT)
Received: from mx40.intranet.ru (mx40.intranet.ru [172.16.103.130])
	by mail.ngs.ru (smtp) with ESMTP id BCAD5200DBE
	for <git@vger.kernel.org>; Thu,  6 Feb 2014 18:54:04 +0700 (NOVT)
Received: from mx45.intranet.ru (mx45.intranet.ru [172.16.103.135])
	by mx40.intranet.ru (mx14.intranet.ru) with ESMTP id BA0A036EE3
	for <git@vger.kernel.org>; Thu,  6 Feb 2014 18:54:04 +0700 (NOVT)
Received: from [37.193.43.33] (account konstunn@ngs.ru)
  by mx45.intranet.ru (CommuniGate Pro WebUser 4.3.11)
  with HTTP id 57771132 for git@vger.kernel.org; Thu, 06 Feb 2014 18:54:04 +0700
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 56388 [Feb 06 2014]
X-KLMS-AntiSpam-Version: 5.3.6
X-KLMS-AntiSpam-Envelope-From: konstunn@ngs.ru
X-KLMS-AntiSpam-Rate: 15
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Moebius-Timestamps: 2768420, 2768454, 2768379
X-KLMS-AntiSpam-Info: {RECEIVED: dynamic ip detected}, {Subject: IP found}
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server 8.0.0.455, bases: 2014/02/06 05:41:00 #7450425
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241687>

Greetings.

I've tried to perform a single simple task to fetch data
from the linux-next integration testing tree repo and
sparse checkout the "drivers/staging/usbip/" directory.

I managed to perform it successfully under Linux with Git
1.7.1.

But I always failed to perform checkout under Windows 7
with Git 1.8.5.2.msysgit.0 facing the following error:
"Sparse checkout leaves no entry on working directory".

Unfortunately, I haven't tried that under Linux with Git
1.8.5.2. So, don't know if there is the same problem.

However I typed the checkout directory in file
.git/info/sparse-checkout by using different formats with
and without the leading and the trailing slashes, with and
without asterisk after trailing slash, having tried all
the possible combinations, but, all the same,
nevertheless, the error occured.

On Linux I stored the checkout directory in
sparse-checkout file in the following way:
"drivers/staging/usbip/". And everything was fine under
Linux, but not under Windows.

However, I don't, of course, if the format of this
directory really matters.
May be the Git install on Windows 7 specific configuration
is the reason?

Could you, please, tell me, what might be wrong?
Am I doing something wrong or it's a bug?

Best Regards,
Constantine Gorbunov
