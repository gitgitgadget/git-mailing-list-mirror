Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4121F453
	for <e@80x24.org>; Mon,  1 Oct 2018 23:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeJBFrl (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 01:47:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36536 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBFrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 01:47:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id p125-v6so34818oic.3
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GnFFI79GfPZOT3dHBoBdQE/h10WwrAIAPH6MxZUtEvE=;
        b=IfD40++cdOweInc2UTF1bJ+97wjVEfUxpSnIg+QsH3r15ubmoTp/X922CdokeplYeM
         yVo9riH8uuP6PRl2SS7XP+OlD1EmFcDy6R4SRHEJmpVJMi64Y1aPvhwVFY6x9xvhwJAD
         F2P23IKS95NVSh27NAn0aewbLwX9W/lhCv7GIEFAG3Z4eMFkt3zQ+8mE4cnu/wmo6S/9
         /KHQO9I9IkcTZli++Tmld242G3JgB1Q53YMlICBBs/x/i7/OBHrFiT6V4urPihdbPOCu
         3S8iulpLiqajEI+NzUOAVOODVjmaA8i2rYJ3x05ZACIBpD6AeK/f/SmhzrF7QO/0CrpI
         Et8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GnFFI79GfPZOT3dHBoBdQE/h10WwrAIAPH6MxZUtEvE=;
        b=YoksVqIEtOK5aFIlumKvAFLlajutiQ8ddxxKgURLu715Edh5FRMno+erYxaJmEORpW
         hW0JuAUXOVXGgMR86dhEfJd1GNfeOBDihan9d0wdr8ioTvxHiaIodqEC40pZK8vgJzWL
         SsboqeihlgIWb6ZNZxOxQ4ChHRCn/iAQxZsyOXiWxL7OX9zan1U1Ad8OJuj5TUybi41q
         SZIIJJhl3O8qaXTeXdRG6vR4cdEYIw/gq9QETrKmGMrh8jSEmUzZ1OWMx5x76P58gCSR
         +KsICRU0CyusXR/aMChfAymgrNDKxiof9DlhQXzYnG03YhWXMPQr1/bGCLFlZov8mAzP
         7J9g==
X-Gm-Message-State: ABuFfogzlQGpwgctn4uPdpgHtxG0pLfjO/YG+ymIyoWtatU0l3JejpFU
        wdSAO7PD1KGlBwccBBJAxp0OhkylY08Fvq7hYe+o
X-Google-Smtp-Source: ACcGV63Ida2OlvHb9EeJ1N8rMPy57X3kaoZ9YLLbRuUOzMjUtgiIQ7DvQD6+lr6CoEy8PYovvVk1hvmcquuQ4UHETY4=
X-Received: by 2002:aca:f209:: with SMTP id q9-v6mr4188533oih.144.1538435252061;
 Mon, 01 Oct 2018 16:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537493611.git.matvore@google.com>
 <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com>
 <20180924210314.GE27036@localhost> <CAMfpvhJ-chi7OMRKjjk79r0uqCqW67Vj9J=tT7Kz-XUmw41H5A@mail.gmail.com>
 <20180927211826.GL27036@localhost>
In-Reply-To: <20180927211826.GL27036@localhost>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 1 Oct 2018 16:07:19 -0700
Message-ID: <CAMfpvhLcWp_1xxjhBZtsOXYHuBak10K2P8Q1Yy4thfwioYysXw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] CodingGuidelines: add shell piping guidelines
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 2:18 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Tue, Sep 25, 2018 at 02:58:08PM -0700, Matthew DeVore wrote:
> > + - Use Git upstream in the non-final position in a piped chain, as in:
>
> Note the starting upper case 'U'.
>
> > + - Use command substitution in a way that discards git's exit code.
>
> 'U' again.
>
...
> > +
> > +     test_cmp expect $(git cat-file -p $sha)
> > +
> > +   is not OK and a crash in git could go undetected.
>
> Well, this is not OK indeed, because it doesn't make any sense in the
> first place :)  'test_cmp' requires two paths as argumens, but the
> output of 'git cat-file -p' is the whole _content_ of the given object.

I've replaced the example and added "Don't" in front of each new item
(explanation for this below). Here is a new diff for this file - the
rest of the commit is the same:

    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.

+ - Don't use Git upstream in the non-final position in a piped chain, as
+   in:
+
+     git -C repo ls-files |
+     xargs -n 1 basename |
+     grep foo
+
+   which will discard git's exit code and may mask a crash. In the
+   above example, all exit codes are ignored except grep's.
+
+   Instead, write the output of that command to a temporary
+   file with ">" or assign it to a variable with "x=3D$(git ...)" rather
+   than pipe it.
+
+ - Don't use command substitution in a way that discards git's exit
+   code. When assigning to a variable, the exit code is not discarded,
+   e.g.:
+
+     x=3D$(git cat-file -p $sha) &&
+     ...
+
+   is OK because a crash in "git cat-file" will cause the "&&" chain
+   to fail, but:
+
+     test "refs/heads/foo" =3D "$(git symbolic-ref HEAD)"
+
+   is not OK and a crash in git could go undetected.
+
  - Don't use perl without spelling it as "$PERL_PATH". This is to help
    our friends on Windows where the platform Perl often adds CR before
    the end of line, and they bundle Git with a version of Perl that


>
> >   - use perl without spelling it as "$PERL_PATH". This is to help our
>
> Note the starting lower case 'u'.
>
> This is because these are the continuation of the "Don't:" some lines
> earlier, so your new points should start with a lower case 'u' as
> well.
>
>
> Sidenote: I think we should consider reformatting this whole section
> as:
>
>   - Don't do this.
>   - Don't do that.
>
> because it grew so much that when I look at the last points, then that
> starting "Don't:" has already scrolled out of my screen.
>
I didn't like how easy it was to mistake a "Don't" item for a "Do"
(although temporarily until you read the first sentence, but it's
still confusing). So I added a new commit to clean this section up.
Here it is:

Author: Matthew DeVore <matvore@google.com>
Date:   Mon Oct 1 15:30:49 2018 -0700

    t/README: reformat Do, Don't, Keep in mind lists

    The list of Don'ts for test writing has grown large such that it is har=
d
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
