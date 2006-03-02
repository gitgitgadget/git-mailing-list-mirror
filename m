From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 3/3] annotate: --rev-file (-S) is not a boolean parameter
Date: Thu, 2 Mar 2006 00:23:37 -0500
Message-ID: <11412770173678-git-send-email-ryan@michonline.com>
References: <11412770172128-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Thu Mar 02 06:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEgId-0001Ff-HQ
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 06:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWCBFYU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 00:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWCBFYT
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 00:24:19 -0500
Received: from mail.autoweb.net ([198.172.237.26]:44986 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751230AbWCBFYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 00:24:18 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FEgIR-00033Y-Vc; Thu, 02 Mar 2006 00:24:17 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEgIO-0000qn-Cq; Thu, 02 Mar 2006 00:24:12 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEgHp-000477-Op; Thu, 02 Mar 2006 00:23:37 -0500
In-Reply-To: <11412770172128-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17053>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 git-annotate.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

75846f79f31c9833303ff7d44b87b53c39f4bf9a
diff --git a/git-annotate.perl b/git-annotate.perl
index d6028c9..30f9a71 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -31,7 +31,7 @@ our ($help, $longrev, $rename, $starting
 my $rc = GetOptions(	"long|l" => \$longrev,
 			"help|h" => \$help,
 			"rename|r" => \$rename,
-			"rev-file|S" => \$rev_file);
+			"rev-file|S=s" => \$rev_file);
 if (!$rc or $help) {
 	usage();
 }
-- 
1.2.2.g1070
