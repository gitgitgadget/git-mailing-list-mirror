From: Mike Galbraith <efault@gmx.de>
Subject: git semd-email - Unknown callback: 'authname'.
 (user|auth|language|pass)
Date: Sat, 04 Sep 2010 09:41:28 +0200
Message-ID: <1283586088.7322.35.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 09:41:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrnNN-00045F-Bp
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 09:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab0IDHlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 03:41:18 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:59430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753814Ab0IDHlN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 03:41:13 -0400
Received: (qmail invoked by alias); 04 Sep 2010 07:41:10 -0000
Received: from p4FE1AC4C.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [79.225.172.76]
  by mail.gmx.net (mp009) with SMTP; 04 Sep 2010 09:41:10 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1/WUxk/bbfWU4G0TsyJvN9zNNEJZlq4+la9QtcMSd
	U3uxpvSwqD0MAj
X-Mailer: Evolution 2.24.1.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155309>

Greetings,

Trying to convince send-email to send a series isn't working out for me
at all, and I'm wondering what I'm doing wrong.

(using git 1.7.2.3 now , was 1.7.2.2 yesterday)

git send-email --compose --from='Mike Galbraith <efault@gmx.de>' --to='Mike Galbraith <efault@gmx.de>' --subject='el-testo' --suppress-cc=all --thread v2.6.32.21...

From: Mike Galbraith <efault@gmx.de>
To: Mike Galbraith <efault@gmx.de>
Subject: [PATCH 01/50] sched: kill migration thread in CPU_POST_DEAD instead of CPU_DEAD
Date: Sat,  4 Sep 2010 09:03:26 +0200
Message-Id: <1283583855-23333-1-git-send-email-efault@gmx.de>
X-Mailer: git-send-email 1.7.2.3

Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
Unknown callback: 'authname'. (user|auth|language|pass)

Also, with sendemail.smtpencryption = ssl

Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
Can't locate Net/SMTP/SSL.pm in @INC (@INC contains: /usr/lib/perl5/site_perl/5.10.0/x86_64-linux-thread-multi /usr/lib/perl5/site_perl/5.10.0 /usr/lib/perl5/5.10.0/x86_64-linux-thread-multi /usr/lib/perl5/5.10.0 /usr/lib/perl5/vendor_perl/5.10.0/x86_64-linux-thread-multi /usr/lib/perl5/vendor_perl/5.10.0 /usr/lib/perl5/vendor_perl .) at /usr/lib/git/git-send-email line 1037.

Linking /usr/lib/perl5/vendor_perl/5.10.0/x86_64-linux-thread-multi/Net/SSL.pm so it can find/include it didn't help much..

From: Mike Galbraith <efault@gmx.de>
To: Mike Galbraith <efault@gmx.de>
Subject: [PATCH 01/50] sched: kill migration thread in CPU_POST_DEAD instead of CPU_DEAD
Date: Sat,  4 Sep 2010 09:19:09 +0200
Message-Id: <1283584798-23449-1-git-send-email-efault@gmx.de>
X-Mailer: git-send-email 1.7.2.3

Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
Can't locate object method "new" via package "Net::SMTP::SSL" at /usr/lib/git/git-send-email line 1039.

..so I _suppose_ I need newer perl toys.

I had to git format-patch, and import 50 mbox files into evolution one
by one to get the job done.

TIA for any hints, tips, tricks.. kicks in the britches,

	-Mike
