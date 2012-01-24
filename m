From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 1/5] t0061: Fix incorrect indentation
Date: Tue, 24 Jan 2012 23:32:22 +0100
Message-ID: <1327444346-6243-2-git-send-email-fransklaver@gmail.com>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Frans Klaver <fransklaver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 23:33:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpovQ-0005Nz-Ap
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab2AXWdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:33:06 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab2AXWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:33:04 -0500
Received: by eaac13 with SMTP id c13so1306974eaa.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bu4uaz5pxEKJ3wJCxxBqUQXBmM8l9M+i+6PmJlZjYx4=;
        b=Cyl+BZB03h4j+j6UJSovo9VRq4VV/0AtN529mQLw+oma3PLRbtVZp5r4ZaK0GZDUqu
         lilRP7AOroZ4oIrYlYqN3dWbndAbvHMVvF0qvbcYhhwfDULzH6CyPVQ5UvqJQdvPgV8K
         S/viwJt20GmlznAniOK0WNjwjnNFMLqFmbSuU=
Received: by 10.213.13.214 with SMTP id d22mr2702685eba.148.1327444383289;
        Tue, 24 Jan 2012 14:33:03 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id c37sm18739220eec.10.2012.01.24.14.33.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 14:33:02 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1
In-Reply-To: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189076>

The hello.sh script started with <tab>#!, which is not considered a
correct hash-bang line. The default interpreter happened to be the one
required for this specific test.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 t/t0061-run-command.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 8d4938f..95e89bc 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -8,8 +8,8 @@ test_description='Test run command'
 . ./test-lib.sh
 
 cat >hello-script <<-EOF
-	#!$SHELL_PATH
-	cat hello-script
+#!$SHELL_PATH
+cat hello-script
 EOF
 >empty
 
-- 
1.7.8.1
