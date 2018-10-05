Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8FD1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeJFEyz (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:54:55 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:38798 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFEyy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:54:54 -0400
Received: by mail-it1-f201.google.com with SMTP id d10so3758226itk.3
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TRBX8qwZ55BtdIRtlv2LiiFwGP4ix4jviC+1rKEfuJw=;
        b=pXoV+nQpZIFVF3tj2SACjjt41E9X5mK+07AfEFgxoCAEoUs8eeIEa0Pqrg7+GutQ2K
         GMgTUseWDZHxw2pwhRM2qCH2co0YeGDu9Bt8QgwnyvABPoKsWZDeVAb5lQEdLoIo4fmO
         2+tLnxqv3dZ7UHJPNn0ahjUoH0un5gB7R997qaE/3JkxplCJ2cDBU+0ulpq/Y8STuq2p
         9Li3VCLnnwE0Eiv9lQyQXvoEKNbKdWPbAsEv1Ll4qYIIAdiikeoH7bA+G9JK1zgtYP9E
         vk05mX8Zzu/HChn5YZS2740ggphkK/BT2DD4I5wdyK2yUMhvHaM0kzj50eR0hj4ue2qZ
         dUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TRBX8qwZ55BtdIRtlv2LiiFwGP4ix4jviC+1rKEfuJw=;
        b=ml49JJ3Rfucs7/SxSf2n9vSCyk5r9OdaKdf6fRRGO5J+Lcqw48iwS2MHNqF4xFR26W
         FawIxH01loq/LWYFtol6eyk/jvP04aGX+xM5eFmHq74VaiZgTdbZGGnfa8lTR9+2fQzv
         FYvct8STtAFZ9A5iOGtkQGihGIChGagQKVI9OQv+5aT2gZmjBj9UMX+CXGItwGOQURDi
         l4Hlz9B9s8tG4TBHouGGmlfohITInc8F2skQbAh49v/CUjWW6/g+GCs9cOUJLPLbzJLa
         eZgn3Yy4/uKpsKSVdERRPM+4twV3qO5ZKLLa+H4RbU0F9P8SxSjQmV46vYYrFGI5sal/
         JQZA==
X-Gm-Message-State: ABuFfohXIpV87DImsYCEhTzchrUBGUgHc4N5RydzLjKKGlLf07f3iSqf
        1gEreQrwtDImp+DF/swBc0bQ0yyknaLeCXxrAj8jW09ZxEj/DQMAJaqwpejiWR39oabq3DztwM1
        UAgjFLcY0YvPda3Y+LHZvq5GVHq6YtLtWRcNbFENykAJP9BlV/LfH/PycYcc=
X-Google-Smtp-Source: ACcGV63OjpXtHXA3t6UB/FALJiPUQk+hqbEvHPNbHuPQVRMRBUYIQqiukRiMPAhvm1t2kgCIREqG9g3cyXI+
X-Received: by 2002:a24:2153:: with SMTP id e80-v6mr9977864ita.1.1538776455472;
 Fri, 05 Oct 2018 14:54:15 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:54:01 -0700
In-Reply-To: <cover.1538775186.git.matvore@google.com>
Message-Id: <8a71066fdf46c9d2297d0211c693f7287251f56b.1538775186.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538775186.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v5 1/7] t/README: reformat Do, Don't, Keep in mind lists
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
 t/README | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/t/README b/t/README
index 9028b47d9..68012d673 100644
--- a/t/README
+++ b/t/README
@@ -393,13 +393,13 @@ This test harness library does the following things:
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
 
-Do's, don'ts & things to keep in mind
--------------------------------------
+Do's & don'ts
+-------------
 
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
+
+And here are the "don'ts:"
 
- - exit() within a <script> part.
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

