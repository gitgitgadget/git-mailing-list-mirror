From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] .clang-format: introduce the use of clang-format
Date: Sat, 17 Jan 2015 16:30:21 -0500
Message-ID: <1421530221-39306-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 17 22:30:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCax1-0001Dc-Bf
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 22:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbbAQVaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 16:30:30 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:34954 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbAQVa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 16:30:29 -0500
Received: by mail-qc0-f169.google.com with SMTP id b13so3029935qcw.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2015 13:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iGxb02vWYLwudwCJUWL+jgSikD/hKlgwu1ZEKSr0vJs=;
        b=CZqj091mWbJYft4Z4rCvP6v7dXekhuaUQsWSueCcgYqn2vj3VovXdti9RqADhbbSP2
         xMBm2ACIIK830rVQ2H1JtTqnYbY+M9LM3mBQS6DgqIQwwgpG8wYUiWrKjK7D6gVj4cDr
         6DfsvLNQ/QIVFoeCP6okrKYwVFTaiKyZyIoDF9hY+ofHfseEITwnwOk/EBfBIhWKgPjO
         oAWgVsqgocFadTAukPW/gTlQiF1Nxgp/5uHOzLQTre+494Qpodp4XI41ec5cGh3gD1c8
         P6DMAph/YcIX9tjr/GIJYYDYNDc45OY+7qvdC9OUYOQ6DrkHmNQRy7uPszGJHznur1+T
         4+8A==
X-Received: by 10.140.81.71 with SMTP id e65mr11404539qgd.82.1421530229086;
        Sat, 17 Jan 2015 13:30:29 -0800 (PST)
Received: from localhost.localdomain (cpe-66-65-144-82.nyc.res.rr.com. [66.65.144.82])
        by mx.google.com with ESMTPSA id x5sm3794355qas.7.2015.01.17.13.30.28
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Jan 2015 13:30:28 -0800 (PST)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262592>

Instead of manually eyeballing style in reviews, just ask all
contributors to run their patches through [git-]clang-format.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 The idea is to introduce the community to this new toy I found called
 clang-format. Whether or not it's actually going to be used doesn't
 bother me too much.

 I'm not 100% sure of the style, but I'll leave you to tweak that
 using http://clang.llvm.org/docs/ClangFormatStyleOptions.html

 The current code isn't terribly conformant, but I suppose that'll
 change with time.

 .clang-format | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 0000000..63a53e0
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,7 @@
+BasedOnStyle: LLVM
+IndentWidth: 8
+UseTab: Always
+BreakBeforeBraces: Linux
+AllowShortBlocksOnASingleLine: false
+AllowShortIfStatementsOnASingleLine: false
+IndentCaseLabels: false
\ No newline at end of file
-- 
2.2.1
