Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899AA20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 20:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLKUfs (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 15:35:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42589 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKUfr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 15:35:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so7175816pga.9
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IZ8Qr0ZufFEI3xNQMrxoYtruwn+eUKxzTMx0cLJHdco=;
        b=Q+GWC14LYFx8YvFtyxKvbGHcdLLyHvcZvELahu0MjXV74Aw+Ei9YzzHAAckzB64j5e
         hYVTwstncc3otoLmsdlqm++Dih/xnkwPNWOdIyP7AtbCf0JPF9Op3PQu7ygyLierevxL
         yKk98jkL4Xx1qrJvysTDMqISv6WMqBqqMaUkKQRl92j5HY1fIjNIstatBz+VyduBEqyB
         oCFFYxdLqe1gvBCxb9bV5m1U8TFDpkXCvoQD5z31jS+a+LRmGndxzNRQMBnwyzvApEt/
         rSUFKD0EUTBrntSaQFHb2+uvb6doS7AmXvhDtDfSOV5WebTEUCrzX1oDRYx8GU3w2ctd
         FIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IZ8Qr0ZufFEI3xNQMrxoYtruwn+eUKxzTMx0cLJHdco=;
        b=oa2KS2mKqfIRB5yZ95KlA4KlNnQReLxFtRtcGVPR0fTjRaqOmv2DQBR2dtZVQJEmO9
         J6G8rhCMcebmwajxyQ3T6K9UEhpRMLUZzZgnxfkhS/695CKE+XCDnHxE35ZOOaoPMNI0
         KoybnCDU+qEsrKUT0lhzu3LBUSqFiR/JJFRWwNfYL6CHZ/SCZPPCG3tW90I6QrKl2Mgh
         YavkGYHjXKjlLfuRT9fmVCpk/R5EiAwpR2B1vpk0Z9FXuPLQWCNEAN/7xbD2kHBHqREY
         SEodvY6TvHeWs4itZeEOH2zxhtzFq5w4L4trrqAu7mjwxq6PId4Oi0QC0Q4uItnaSLYf
         1+kQ==
X-Gm-Message-State: AA+aEWaHo/U8LeWfwFt8SmVE6JW5/OT4dLtIvcnqPuXGsI12M4jbKjgD
        WE/ZuoQqelH2T6kixlkSPCR7tmJY
X-Google-Smtp-Source: AFSGD/UQHwV7JBbF9LEhUmRHbrwiohtqBha+x/SEQTwobyU1+8AXKu9Q9J4dLEKCrep64+tr1fYD6Q==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr15331678pgv.407.1544560546333;
        Tue, 11 Dec 2018 12:35:46 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id g15sm74865766pfj.131.2018.12.11.12.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:35:45 -0800 (PST)
Date:   Tue, 11 Dec 2018 12:35:45 -0800 (PST)
X-Google-Original-Date: Tue, 11 Dec 2018 20:35:42 GMT
Message-Id: <pull.98.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] .gitattributes: ensure t/oid-info/* has eol=lf
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that our CI builds (see [1] for an example) were returning success
much faster than they did before Git v2.20.0. Turns out that there was a
test script failure involving the new test hash logic.

error: bug in the test script: bad hash algorithm
make[1]: *** [Makefile:56: t0000-basic.sh] Error 1
make[1]: *** Waiting for unfinished jobs....

The reason this passed was because we were running this command in our
build:

make GIT_TEST_OPTS=--quiet -j 10 -C t ||
make GIT_TEST_OPTS=\"-i -v -x\" -k -C t failed 

The first make failed, but the test script did not record any failed tests
and hence the second command succeeded.

The test bug relates to this function added by 2c02b110d "t: add test
functions to translate hash-related values":

+# Load key-value pairs from stdin suitable for use with test_oid.  Blank lines
+# and lines starting with "#" are ignored.  Keys must be shell identifier
+# characters.
+#
+# Examples:
+# rawsz sha1:20
+# rawsz sha256:32
+test_oid_cache () {
+       local tag rest k v &&
+
+       { test -n "$test_hash_algo" || test_detect_hash; } &&
+       while read tag rest
+       do
+               case $tag in
+               \#*)
+                       continue;;
+               ?*)
+                       # non-empty
+                       ;;
+               *)
+                       # blank line
+                       continue;;
+               esac &&
+
+               k="${rest%:*}" &&
+               v="${rest#*:}" &&
+
+               if ! expr "$k" : '[a-z0-9][a-z0-9]*$' >/dev/null
+               then
+                       error 'bug in the test script: bad hash algorithm'
+               fi &&
+               eval "test_oid_${k}_$tag=\"\$v\""
+       done
+}

The verbose output included these values. Note how '\r' appears in the
variable values.

++ test_oid_init
++ test -n ''
++ test_detect_hash
++ test_hash_algo=sha1
++ test_oid_cache
++ local tag rest k v
++ test -n sha1
++ read tag rest
++ case $tag in
++ k=sha1
++ v=$'20\r'
++ expr sha1 : '[a-z0-9][a-z0-9]*$'
++ eval 'test_oid_sha1_rawsz="$v"'
+++ test_oid_sha1_rawsz=$'20\r'
++ read tag rest
++ case $tag in
++ k=sha256
++ v=$'32\r'
++ expr sha256 : '[a-z0-9][a-z0-9]*$'
++ eval 'test_oid_sha256_rawsz="$v"'
+++ test_oid_sha256_rawsz=$'32\r'
++ read tag rest
++ case $tag in
++ k=
++ v=
++ expr '' : '[a-z0-9][a-z0-9]*$'

[1] https://gvfs.visualstudio.com/ci/_build/results?buildId=4815

Derrick Stolee (1):
  .gitattributes: ensure t/oid-info/* has eol=lf

 .gitattributes | 1 +
 1 file changed, 1 insertion(+)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-98%2Fderrickstolee%2Ftest-oid-fix-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-98/derrickstolee/test-oid-fix-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/98
-- 
gitgitgadget
