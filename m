Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB8D1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 18:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfGLSBE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 14:01:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35410 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGLSBD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 14:01:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so4874906pgl.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMWr7hAPxyfv5F9UpvRHdvlNuokpEV7SgGQSP6VoJbQ=;
        b=Wmux7QIEGEyTTNBqhcrOdklmPYr3A7alOvcYn1EkLJ+qvzfjGrUq3EYV7q1PP0D2xP
         m3rzZtkmCxEPSIv52EzVN39ZLSury5jdPMsLFwsqLG+P4hLqbqwZi6t8KuX5WwhHk/3f
         XiJfqHUt1FC2EZAVK1B0cXxVe6M0EI8N+RGyQMAs1hbu0hk6jNEwCmVBvlIWOVtKbyoa
         NOjw2A97wN7Jl+BQhXFZrQAmVszBSb6/C76CBFtL7bIDtLu2zoIQiPsNhsoFtn1KuDc3
         UjCQy1AasG/AYPH7bB05zyfqoaV7dQYUcXyk+HKyiMYIYASbnQQOJCwOWU8OFyZXjKlg
         2xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMWr7hAPxyfv5F9UpvRHdvlNuokpEV7SgGQSP6VoJbQ=;
        b=nIaTvua0sX/4uGzE05wREQbe5JmjY+y/MeGtJai2XMX9i3kAPU5f8udPajW5dANVJd
         3UwG4Y+nyPlCNTuSbVUsC3DYW0RAM08dWv7mwihnvuRkSXJR03K1Gysc6xk68h84Uq5Q
         AHM7KTybvQdxP+Ds+UpY+pYwRXXj4oDS1/wQ0G/jCywJO3cjJswTU/TUquOSyK1DJU42
         x/rwm7RE7yaUiYDCgk9azUCJgswVJ40LopGtLpzCFJ/gXEwuzGTpBswUVKyGCymCLxT2
         wfwb3g7jrLtcpEw2z1ehMufwL+buvwLfviFoZLWSLrOiYMd2c7sAnwKGlxuCPESGC7K0
         GYvQ==
X-Gm-Message-State: APjAAAXAxqIjUW/A8OG8PJERtyxZLAQahNZiVp7wyfnEjm+PbEgvcxMV
        WMznCz9qDB0DmUburcKNltxuYkeR3WTVPRn2ge/FLQ==
X-Google-Smtp-Source: APXvYqw0DvrsoGHjAzMcJeg3traqIWd477f8V4oCtlRzRYu4yOnDJoM5ypLxQ9nhMmB5JOgjD6V+oWB+ppbkIEhXE5w=
X-Received: by 2002:a17:90a:1b4c:: with SMTP id q70mr13017694pjq.69.1562954462787;
 Fri, 12 Jul 2019 11:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190712155901.19210-1-ariadne@dereferenced.org> <xmqqpnmfp2gs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnmfp2gs.fsf@gitster-ct.c.googlers.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Fri, 12 Jul 2019 13:00:51 -0500
Message-ID: <CAAOiGNzcNhWmmr+COXhv2p9=KF5k4hHLEsNsfA1H+P0JQOTTqg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] document deprecation of log.mailmap=false default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Fri, Jul 12, 2019 at 12:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ariadne Conill <ariadne@dereferenced.org> writes:
>
> > Based on the discussion of the previous patches, we concluded that
> > changing the default will require a transitional period.
>
> OK.
>
> > As such, I have introduced a deprecation warning that is printed when
> > the log builtin commands are used.
>
> ... used when the user did not configure and did not give --[no-]use-mailmap
> option from the command line, right?  Otherwise the warning would be annoying.

Yes, the default state is changed to -1, which using the command line
options or explicitly configuring the option would change to either 0
or 1.

> Have you run the test suite before posting?  To me, at least t0203,
> t4212, t7006 and t9700 seem to be having trouble with this change,
> that may need adjusting.

I ran parts of the testsuite, but I can go through the whole thing and
will fix the fallout.

> 0203.1 expects that "git show" gives nothing to its standard error
> stream.  Perhaps something like this should serve as a good
> workaround.
>
> diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
> index 0ce1f22eff..76f774c8b8 100755
> --- a/t/t0203-gettext-setlocale-sanity.sh
> +++ b/t/t0203-gettext-setlocale-sanity.sh
> @@ -10,7 +10,7 @@ test_description="The Git C functions aren't broken by setlocale(3)"
>  test_expect_success 'git show a ISO-8859-1 commit under C locale' '
>         . "$TEST_DIRECTORY"/t3901/8859-1.txt &&
>         test_commit "iso-c-commit" iso-under-c &&
> -       git show >out 2>err &&
> +       git show --use-mailmap >out 2>err &&
>         test_must_be_empty err &&
>         grep -q "iso-c-commit" out
>  '
>
>
> 4212.3 is the same way.
>
> 4212.4 raises an interesting question.  It wants to see the output
> of this command:
>
>         git log --format="%an+%ae+%ad" broken_email >actual.out 2>actual.err &&
>
> The question is, when the user explicitly asked for the "true"
> identity values (not the mapped one via %aN, %aE and their friends),
> if --use-mailmap should affect the outcome?

I don't think it should.

> A secondary question is if we should be issuing a warning against
> this command line in the first place, if the answer to the above
> question is "no" (i.e. --[no-]use-mailmap, and the future default
> switch, do not affect the outcome).  There is no point issuing a
> warning if the command line is already future-proofed.

I will disable the warning if a custom format is specified.

> 7006.43 (among others) expects its "colorful" shell helper function
> to be a reliable way to detect if color escape sequence is in use in
> the output but the helper only reads the first line and expects it
> to always begin with the colored "commit 0c9f6db7183a...", which fails
> when an error or a warning message comes first.  I think the best fix
> there should be to make the helper more robust, perhaps by borrowing
> ideas from test-lib-functions.sh::test_decode_color, i.e. find byte
> sequence "\033[m" in there (I think assuming the presence of RESET
> sequence alone is sufficient for the purpose of t7006 tests that
> wants to see "have we tried to color or emit non-colored output?".

The colorful shell helper function irritates me from time to time with
that sort of thing.  I might look into fixing it, but I think for now
it makes more sense to just defang those tests by killing the warning.

A thought I had was to perhaps use isatty(STDERR_FILENO) to determine
if stderr is attached to a terminal session and only issue the warning
in that case.  What do you think?  It should fix all of these tests.

> A possible workaround for 9007 would be to set log.mailmap=true in
> the set-up step, but there may be a better alternative.
>
> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> index 102c133112..a7a336947d 100755
> --- a/t/t9700-perl-git.sh
> +++ b/t/t9700-perl-git.sh
> @@ -36,6 +36,7 @@ test_expect_success \
>       echo "changed file 1" > file1 &&
>       git commit -a -m "second commit" &&
>
> +     git config log.mailmap true &&
>       git config --add color.test.slot1 green &&
>       git config --add test.string value &&
>       git config --add test.dupstring value1 &&

This seems reasonable.

> There may be issues with other tests.  I didn't do any exhaustive
> vetting.

Thanks wholeheartedly for all of your help so far, I know there are
many git users who will be very happy once all of this work is done
(basically anyone who has changed their name).

Ariadne
