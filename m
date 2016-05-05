From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v16 1/7] t0040-test-parse-options.sh: fix style issues
Date: Thu,  5 May 2016 15:19:56 +0530
Message-ID: <1462441802-4768-2-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 11:51:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFwG-0007if-OV
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963AbcEEJvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:51:12 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34388 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493AbcEEJvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:51:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id r5so35396795pag.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q7V8j0imVZ4v62aFjRmphvezQKd19ma06RPbLF1HC2I=;
        b=kBkf/gf6/Kl8bKy9PHWpOURl/AG1pf9UOjiz1JppyQ4ljeoWnErg//DY3ceWDzDbxa
         faxj0M9seCXoaRGBEdX3rFC29xLa0VVi0inE1W0qYAlZL6/+NtCECgArkH89tXNDxxy5
         HBDgLB6eKZdxcgVjUhI/7D9ESJNw+oKQdgkVPvUWC7ruqMe3BoVnkFc+FhJjb4xW7V/y
         L6+m32KnrkVQjdXluoVWvB1CklkCJv1Xc8Kj84MVG9YB+pM9WmuS6OMr8eX5Z1wpHn7A
         0gV2xa7fFWQfzLZzEyXlC7+kY2RM8o6ap8IVdK0GVbiWKOjgZ0pydfaOm7WPc9pW2bh9
         Wdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q7V8j0imVZ4v62aFjRmphvezQKd19ma06RPbLF1HC2I=;
        b=CyJRUZwFojezH7FHgz4lAPHzP6zi62xkIGdIlAIO8jHAq2gUtwJR0vISBgYg18kmUU
         mZedXWQNM9o24kkgWe49tkFX5FH2bAvhelTzEdYWuWRRL1S6jCHeLsVvwPMpVoZBYqg5
         mU5CsFsW5jO5y97JPTeNJMfyrsub/h4KoJ66G9/Xwi5ytyqSYyhdQ62tbF2iTLstr2GM
         4wH3LeXdLjNhsT3zjkM83wJhjd/lx9xaArmLB1L3Vht9UWV+goqqf+w+mbIrTHOOhXtn
         65PmvNets27Be9tgy48+QVfqx/eMM/V9JOk5fm5xjZhyLcU04Hu2DTftBB0IKfH2ajoh
         BbEw==
X-Gm-Message-State: AOPr4FVIGWeWAuO2slwUKkx/j5Buwldp4kotDIOYxW/z/YOieDE9Z57E/w8MgrVnSffVxg==
X-Received: by 10.66.43.143 with SMTP id w15mr19399444pal.76.1462441870385;
        Thu, 05 May 2016 02:51:10 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id zn12sm12255111pab.14.2016.05.05.02.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 May 2016 02:51:09 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293639>

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---

 t/t0040-parse-options.sh | 76 ++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 9be6411..477fcff 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,7 +7,7 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat > expect << EOF
+cat >expect <<\EOF
 usage: test-parse-options <options>
 
     --yes                 get a boolean
@@ -49,14 +49,14 @@ Standard options
 EOF
 
 test_expect_success 'test help' '
-	test_must_fail test-parse-options -h > output 2> output.err &&
+	test_must_fail test-parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_i18ncmp expect output
 '
 
 mv expect expect.err
 
-cat >expect.template <<EOF
+cat >expect.template <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -156,7 +156,7 @@ test_expect_success 'OPT_MAGNITUDE() 3giga' '
 	check magnitude: 3221225472 -m 3g
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 2
 integer: 1729
 magnitude: 16384
@@ -176,7 +176,7 @@ test_expect_success 'short options' '
 	test_must_be_empty output.err
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 2
 integer: 1729
 magnitude: 16384
@@ -204,7 +204,7 @@ test_expect_success 'missing required value' '
 	test_expect_code 129 test-parse-options --file
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 1
 integer: 13
 magnitude: 0
@@ -222,12 +222,12 @@ EOF
 
 test_expect_success 'intermingled arguments' '
 	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
-		> output 2> output.err &&
+		>output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 2
 magnitude: 0
@@ -241,13 +241,13 @@ file: (not set)
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
-	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
+	test-parse-options --int 2 --boolean --no-bo >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
-	test-parse-options --int=2 > output 2> output.err &&
+	test-parse-options --int=2 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
@@ -256,7 +256,7 @@ test_expect_success 'ambiguously abbreviated option' '
 	test_expect_code 129 test-parse-options --strin 123
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -270,32 +270,32 @@ file: (not set)
 EOF
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	test-parse-options --st 123 > output 2> output.err &&
+	test-parse-options --st 123 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > typo.err << EOF
-error: did you mean \`--boolean\` (with two dashes ?)
+cat >typo.err <<\EOF
+error: did you mean `--boolean` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -boolean > output 2> output.err &&
+	test_must_fail test-parse-options -boolean >output 2>output.err &&
 	test_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
-cat > typo.err << EOF
-error: did you mean \`--ambiguous\` (with two dashes ?)
+cat >typo.err <<\EOF
+error: did you mean `--ambiguous` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -ambiguous > output 2> output.err &&
+	test_must_fail test-parse-options -ambiguous >output 2>output.err &&
 	test_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -310,12 +310,12 @@ arg 00: --quux
 EOF
 
 test_expect_success 'keep some options as arguments' '
-	test-parse-options --quux > output 2> output.err &&
+	test-parse-options --quux >output 2>output.err &&
 	test_must_be_empty output.err &&
-        test_cmp expect output
+	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -331,12 +331,12 @@ EOF
 
 test_expect_success 'OPT_DATE() works' '
 	test-parse-options -t "1970-01-01 00:00:01 +0000" \
-		foo -q > output 2> output.err &&
+		foo -q >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 Callback: "four", 0
 boolean: 5
 integer: 4
@@ -351,22 +351,22 @@ file: (not set)
 EOF
 
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
-	test-parse-options --length=four -b -4 > output 2> output.err &&
+	test-parse-options --length=four -b -4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 Callback: "not set", 1
 EOF
 
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-parse-options --no-length > output 2> output.err &&
+	test_must_fail test-parse-options --no-length >output 2>output.err &&
 	test_i18ncmp expect output &&
 	test_i18ncmp expect.err output.err
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 boolean: 1
 integer: 23
 magnitude: 0
@@ -380,18 +380,18 @@ file: (not set)
 EOF
 
 test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
+	test-parse-options --set23 -bbbbb --no-or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --neg-or4 > output 2> output.err &&
+	test-parse-options --set23 -bbbbb --neg-or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 boolean: 6
 integer: 0
 magnitude: 0
@@ -405,24 +405,24 @@ file: (not set)
 EOF
 
 test_expect_success 'OPT_BIT() works' '
-	test-parse-options -bb --or4 > output 2> output.err &&
+	test-parse-options -bb --or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() works' '
-	test-parse-options -bb --no-neg-or4 > output 2> output.err &&
+	test-parse-options -bb --no-neg-or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
-	test-parse-options + + + + + + > output 2> output.err &&
+	test-parse-options + + + + + + >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 12345
 magnitude: 0
@@ -436,12 +436,12 @@ file: (not set)
 EOF
 
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
-	test-parse-options -12345 > output 2> output.err &&
+	test-parse-options -12345 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -460,7 +460,7 @@ test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
 	test_cmp expect output
 '
 
-cat >>expect <<'EOF'
+cat >>expect <<\EOF
 list: foo
 list: bar
 list: baz
-- 
2.8.1
