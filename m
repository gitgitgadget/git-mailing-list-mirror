Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458021F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeJCXPa (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:15:30 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:52612 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXPa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:15:30 -0400
Received: by mail-it1-f202.google.com with SMTP id e9-v6so7623589itf.2
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rV4wWJ305XRANArpdyUjd2wCKftpX5xdjpdSTQOJncU=;
        b=sjhHmNEiwBRkocCQU5kCiDyQhtxhuxTqkEvsKQUiIu7a8MzOKx/tqYLySONtB/nTIW
         WdY8SO963vQYRIJ0RidjI9WzWCdbsKj51pt0BXRdJIn2/OJ+mK3Dhk5oUuDXQ8Pv/vBz
         mdzzgT+L35PgYPZP1mdFLvkCEVEnnUhXJfckOHbgSyRjX7HbujIH8BhD+xzS/oP2H4PM
         m93xadStyq4k2HYMmSwKu7GND8ZbT8N/nXCl9E+ceEgwitoXpL7IGrbeKnsYEUKbyTJp
         H5vAuXma+Qqq+miPQhtDj5tnI1zRjIYMcZzTY4O1Mmifb6o5DX5ulDeTbAagUQ7fS3Gi
         4+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rV4wWJ305XRANArpdyUjd2wCKftpX5xdjpdSTQOJncU=;
        b=n43BOiYpjZEovvQZy61EU4R7xP3x5Mdhk1lyJjg/5fdrUgq3RaJFFMmYVQj6W60RfO
         VPyZeROPsmC4xmzhDuFN/1YTV3E98yKJFeqn6/neoMN7PYHY+Cjny9lR0T0RuaE8/Elh
         wcxeefBGd/H8dB4YNoAnUPPmsd9dvNiShFRCGcqUDaX6SjVOlgHc6xZ/dvcKOYvtoTWI
         iX7KU/lYPqPY1dOiWziKThiUN82fu/R3K+/zC79oEuQwUdNB5qkVLo4fx6VXsQsuXMQI
         8feXs/g+IHQdiKjU0AssUUWEbUmTQ3utyOC6gb947jOT5Pn1nn22EE1NsAavrepay4Rf
         ODGg==
X-Gm-Message-State: ABuFfoj1JSFxuGxvWxSyndLewL/0nU91RUmQhv+vogh/OzOaSL3yl+W/
        fPwQUIb+kNNJq0aL1xMFGtTka1ta7LTkZAK3RbCQCjfPrkFyRltpdNEUdxw4oNYkNWiMyfa+z1H
        Oo1Kirer03GSKploOiNWJv5GxIqW149xJaMTlRbFuTzX5PmMnjsHzQ5KwYf0=
X-Google-Smtp-Source: ACcGV62VKkQX6BFUFBgVSTaOe1hvrCaSmU4o1kK3+UMuwctOAUiG8oyP7/UIdIQ3CZX0IIP90LbkLL1JX5pf
X-Received: by 2002:a24:2752:: with SMTP id g79-v6mr1837204ita.4.1538583983922;
 Wed, 03 Oct 2018 09:26:23 -0700 (PDT)
Date:   Wed,  3 Oct 2018 09:25:59 -0700
In-Reply-To: <cover.1538581868.git.matvore@google.com>
Message-Id: <32f6f14f8d3323468b4255927cca028a82f64b39.1538581868.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538581868.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 1/7] t/README: reformat Do, Don't, Keep in mind lists
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The list of Don'ts for test writing has grown large such that it is hard
to see at a glance which section an item is in. In other words, if I
ignore a little bit of surrounding context, the "don'ts" look like
"do's."

To make the list more readable, prefix "Don't" in front of every first
sentence in the items.

Also, the "Keep in mind" list is out of place and awkward, because it
was a very short "list" beneath two very long ones, and it seemed easy
to miss under the list of "don'ts," and it only had one item. So move
this item to the list of "do's" and phrase as "Remember..."

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/README | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/t/README b/t/README
index 9028b47d9..85024aba6 100644
--- a/t/README
+++ b/t/README
@@ -393,13 +393,13 @@ This test harness library does the following things:
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
 
-Do's, don'ts & things to keep in mind
+Do's & don'ts
 -------------------------------------
 
 Here are a few examples of things you probably should and shouldn't do
 when writing tests.
 
-Do:
+Here are the "do's:"
 
  - Put all code inside test_expect_success and other assertions.
 
@@ -444,16 +444,21 @@ Do:
    Windows, where the shell (MSYS bash) mangles absolute path names.
    For details, see the commit message of 4114156ae9.
 
-Don't:
+ - Remember that inside the <script> part, the standard output and
+   standard error streams are discarded, and the test harness only
+   reports "ok" or "not ok" to the end user running the tests. Under
+   --verbose, they are shown to help debug the tests.
 
- - exit() within a <script> part.
+And here are the "don'ts:"
+
+ - Don't exit() within a <script> part.
 
    The harness will catch this as a programming error of the test.
    Use test_done instead if you need to stop the tests early (see
    "Skipping tests" below).
 
- - use '! git cmd' when you want to make sure the git command exits
-   with failure in a controlled way by calling "die()".  Instead,
+ - Don't use '! git cmd' when you want to make sure the git command
+   exits with failure in a controlled way by calling "die()".  Instead,
    use 'test_must_fail git cmd'.  This will signal a failure if git
    dies in an unexpected way (e.g. segfault).
 
@@ -461,8 +466,8 @@ Don't:
    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.
 
- - use perl without spelling it as "$PERL_PATH". This is to help our
-   friends on Windows where the platform Perl often adds CR before
+ - Don't use perl without spelling it as "$PERL_PATH". This is to help
+   our friends on Windows where the platform Perl often adds CR before
    the end of line, and they bundle Git with a version of Perl that
    does not do so, whose path is specified with $PERL_PATH. Note that we
    provide a "perl" function which uses $PERL_PATH under the hood, so
@@ -470,17 +475,17 @@ Don't:
    (but you do, for example, on a shebang line or in a sub script
    created via "write_script").
 
- - use sh without spelling it as "$SHELL_PATH", when the script can
-   be misinterpreted by broken platform shell (e.g. Solaris).
+ - Don't use sh without spelling it as "$SHELL_PATH", when the script
+   can be misinterpreted by broken platform shell (e.g. Solaris).
 
- - chdir around in tests.  It is not sufficient to chdir to
+ - Don't chdir around in tests.  It is not sufficient to chdir to
    somewhere and then chdir back to the original location later in
    the test, as any intermediate step can fail and abort the test,
    causing the next test to start in an unexpected directory.  Do so
    inside a subshell if necessary.
 
- - save and verify the standard error of compound commands, i.e. group
-   commands, subshells, and shell functions (except test helper
+ - Don't save and verify the standard error of compound commands, i.e.
+   group commands, subshells, and shell functions (except test helper
    functions like 'test_must_fail') like this:
 
      ( cd dir && git cmd ) 2>error &&
@@ -495,7 +500,7 @@ Don't:
      ( cd dir && git cmd 2>../error ) &&
      test_cmp expect error
 
- - Break the TAP output
+ - Don't break the TAP output
 
    The raw output from your test may be interpreted by a TAP harness. TAP
    harnesses will ignore everything they don't know about, but don't step
@@ -515,13 +520,6 @@ Don't:
    but the best indication is to just run the tests with prove(1),
    it'll complain if anything is amiss.
 
-Keep in mind:
-
- - Inside the <script> part, the standard output and standard error
-   streams are discarded, and the test harness only reports "ok" or
-   "not ok" to the end user running the tests. Under --verbose, they
-   are shown to help debugging the tests.
-
 
 Skipping tests
 --------------
-- 
2.19.0.605.g01d371f741-goog

