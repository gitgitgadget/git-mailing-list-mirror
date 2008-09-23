From: Frederik Schwarzer <schwarzerf@gmail.com>
Subject: [PATCH] typo (dashes)
Date: Tue, 23 Sep 2008 13:59:17 +0200
Message-ID: <200809231359.17068.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 14:00:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki6ZD-0007l4-Ac
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 14:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbYIWL7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 07:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbYIWL7W
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:59:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:30278 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYIWL7W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2008 07:59:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2046859fkq.5
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=HHEcMtXLQ3p6EqK83x17V0nj/H7UKEmQRFsrwKrzxHc=;
        b=HLqnMYtw1MBmFBBZxxz2ClbMHVOsMD1SIOeDOgRYK4Rs9/NNaub+82Ol4dS+Dotetn
         1NOwc38gaH+RNB4pE1eYrGM8fgCjwSaGpaz289vWGIV70UXc1dmNdqlQK4BJrHukGjfk
         aDQ/0RI2rMrV32gagpQa62NZS2QmQ7sbOaA5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=tUSj/9MnwbpomzWxUZMCcxled/lbhCyx6Cr+fpsd7STwpvNa/BEweubT8XW9rrdrX2
         5xONSUctOqBAGlmwMLVz4Qi5UmYqfz49DsMfBLwc3gM48y6Nl0ArhU9NGWoOWsTCPsDF
         vi8bxFCVqQorgOHJz4hAcI4+JMqcWQmTHARKc=
Received: by 10.181.4.17 with SMTP id g17mr3510297bki.67.1222171160336;
        Tue, 23 Sep 2008 04:59:20 -0700 (PDT)
Received: from pino.localnet (e179110241.adsl.alicedsl.de [85.179.110.241])
        by mx.google.com with ESMTPS id b17sm1259204fka.7.2008.09.23.04.59.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 04:59:19 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26; KDE/4.1.1; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96554>

>From 0d511a231d150ecb20308cb346da1432b1db2646 Mon Sep 17 00:00:00 2001
From: Frederik Schwarzer <schwarzerf@gmail.com>
Date: Tue, 23 Sep 2008 13:54:37 +0200
Subject: [PATCH] typo (dashes)

Signed-off-by: Frederik Schwarzer <schwarzerf@gmail.com>
---
 git.c  |    2 +-
 help.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 905acc2..bab0c0b 100644
--- a/git.c
+++ b/git.c
@@ -495,7 +495,7 @@ int main(int argc, const char **argv)
 	if (errno == ENOENT) {
 		if (done_alias) {
 			fprintf(stderr, "Expansion of alias '%s' failed; "
-				"'%s' is not a git-command\n",
+				"'%s' is not a git command\n",
 				cmd, argv[0]);
 			exit(1);
 		}
diff --git a/help.c b/help.c
index 300cd38..e1dd449 100644
--- a/help.c
+++ b/help.c
@@ -330,7 +330,7 @@ const char *help_unknown_cmd(const char *cmd)
 		return assumed;
 	}
 
-	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
+	fprintf(stderr, "git: '%s' is not a git command. See 'git --help'.\n", cmd);
 
 	if (best_similarity < 6) {
 		fprintf(stderr, "\nDid you mean %s?\n",
-- 
1.6.0.1
