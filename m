From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-am: Mention --abort in usage string part of OPTIONS_SPEC
Date: Fri, 25 Jul 2008 20:22:23 +0200
Message-ID: <1217010143-15765-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 20:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMRxM-0007W5-NV
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbYGYSWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 14:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbYGYSWe
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:22:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:58439 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755350AbYGYSWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 14:22:33 -0400
Received: (qmail invoked by alias); 25 Jul 2008 18:22:31 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp065) with SMTP; 25 Jul 2008 20:22:31 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX195DbllMhx5gRFQfPE7mdmuUiqTOLFCqqf7+1/yJi
	3hcRP9EeQtfHkf
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMRvr-00046j-DM; Fri, 25 Jul 2008 20:22:23 +0200
X-Mailer: git-send-email 1.6.0.rc0.49.gc74bff
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90083>

The three separate lines for --skip, --resolved and --abort
are merged into one so that it is easy to see that they're
alternative and related options.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

I could've sworn this had already been in fcab40a38 (git am --abort)
but it wasn't. So here it is.

Regards.

 git-am.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index f4abd9d..6aa8192 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -6,8 +6,7 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git am [options] [<mbox>|<Maildir>...]
-git am [options] --resolved
-git am [options] --skip
+git am [options] (--resolved | --skip | --abort)
 --
 d,dotest=       (removed -- do not use)
 i,interactive   run interactively
-- 
1.6.0.rc0.106.g0f5bf
