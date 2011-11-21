From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH] spec: add missing build dependency
Date: Mon, 21 Nov 2011 17:35:26 +0200
Message-ID: <1321889726-29620-1-git-send-email-felipe.contreras@nokia.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 16:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSVyp-0001vZ-Gk
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 16:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab1KUPkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 10:40:15 -0500
Received: from smtp.nokia.com ([147.243.1.47]:30513 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab1KUPkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 10:40:14 -0500
Received: from localhost (esdhcp034117.research.nokia.com [172.21.34.117])
	by mgw-sa01.nokia.com (Switch-3.4.4/Switch-3.4.4) with ESMTP id pALFe5TV014611;
	Mon, 21 Nov 2011 17:40:06 +0200
X-Mailer: git-send-email 1.7.7.3
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185747>

From: Felipe Contreras <felipe.contreras@gmail.com>

Otherwise:

/usr/bin/perl Makefile.PL PREFIX='/opt/git' INSTALL_BASE=''
Can't locate ExtUtils/MakeMaker.pm in @INC (@INC contains: /usr/local/lib/perl5 /usr/local/share/perl5 /usr/lib/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib/perl5 /usr/share/perl5 .) at Makefile.PL line 1.
BEGIN failed--compilation aborted at Makefile.PL line 1.
make[1]: *** [perl.mak] Error 2
make: *** [perl/perl.mak] Error 2

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git.spec.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index c562c62..4d7ac1a 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -101,6 +101,7 @@ Group:          Development/Libraries
 Requires:       git = %{version}-%{release}
 Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))
 BuildRequires:  perl(Error)
+BuildRequires:  perl(ExtUtils::MakeMaker)
 
 %description -n perl-Git
 Perl interface to Git
-- 
1.7.7.3
