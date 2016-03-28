From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] t7407: make expectation as clear as possible
Date: Mon, 28 Mar 2016 16:28:21 -0700
Message-ID: <1459207703-1635-6-git-send-email-sbeller@google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 29 01:28:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akgaV-0004wc-6F
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbcC1X2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:28:42 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34101 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbcC1X2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:28:32 -0400
Received: by mail-pf0-f171.google.com with SMTP id x3so148641483pfb.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Xhcmv+DfGShnOfsoOBA0L2g2ndwSOswgZw6fQnglK8=;
        b=mDBsuUaOEPQb/KjQqvZIgTZ3P6pqd9W1v4TCh+U8Z25UXHgYVZV6F0y/X0G7QaSjvb
         zB5f/PGLdBrpxAlpjTaMUqyB+1pRG1TUtG5bjQVUNRRh9Z32Hy+Qa9vbgdIAmSQVZ62d
         9YOivMa64uQ1uXBsoXIGZ7QaBX+DSX0UJsJMh/hCa1V9qeeLdnwxx3PhV9dPXAS2al2F
         Qu8j/7RpEeY9La9RS0C+i+ELK8my/dGT9KSyPbjICrZE71gHH84V9EnBpsfxSKhwAHvq
         PES3rHaab5oD+fu9hIB7vBKYBCEW8IYPxv+LmZ49pcnBDnAldls5VqxvCUx4bIhCmMw+
         4z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Xhcmv+DfGShnOfsoOBA0L2g2ndwSOswgZw6fQnglK8=;
        b=gniqjvBmEAFw/yJ3V+O0QAsgfTj7wdTtWj9goSHMcT8kKhASrxexLSfIFwtT8j+6qm
         6+KbdGiPU6aaE+QhOhlo/7LODnf0l6HIKNdL3YO9vjaqftqg955PfA3RbOxaK2QGbQUO
         N9aAU93qreMOdflEyW2AieCdI9VWPZs0NuRY4ws+aLiytNtMs+ilnbGX5ACTXiqUYi3k
         qHbvvyprn4u7U19+sUDBkhMZnLbzTEOKvganNstpopi4Y9z9jnbzQeY6HxyLy4xdAjV4
         UhmMQRkVhW5ok2+u9LzSkjiHF7Ci9IfuYj9tZrDOdaGzpzTgMK2oj7V9lHv4yN64iWRq
         5pJg==
X-Gm-Message-State: AD7BkJJ0kleQe8XcTO7FsK4ht792qKGqhkEY8dJRcbUejCkskPDxx/oBrTE1GibA0YIKF8Gb
X-Received: by 10.98.87.216 with SMTP id i85mr47270353pfj.61.1459207711903;
        Mon, 28 Mar 2016 16:28:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e99f:70e4:359b:ad6b])
        by smtp.gmail.com with ESMTPSA id v74sm38164159pfa.7.2016.03.28.16.28.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 16:28:31 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.23.gd22361a.dirty
In-Reply-To: <1459207703-1635-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290090>

Not everyone (including me) grasps the sed expression in a split second as
they would grasp the 4 lines printed as is.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7407-submodule-foreach.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 776b349..808c6c6 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -262,8 +262,12 @@ test_expect_success 'test "status --recursive"' '
 	test_cmp expect actual
 '
 
-sed -e "/nested2 /s/.*/+$nested2sha1 nested1\/nested2 (file2~1)/;/sub[1-3]/d" < expect > expect2
-mv -f expect2 expect
+cat > expect <<EOF
+ $nested1sha1 nested1 (heads/master)
++$nested2sha1 nested1/nested2 (file2~1)
+ $nested3sha1 nested1/nested2/nested3 (heads/master)
+ $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
+EOF
 
 test_expect_success 'ensure "status --cached --recursive" preserves the --cached flag' '
 	(
-- 
2.8.0.rc4.23.gd22361a.dirty
