Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77DA61F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934475AbeGJQch (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:32:37 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41721 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934101AbeGJQcg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:32:36 -0400
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so8847292ybe.8
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iQrwl70qs4iAaAPf+0DBZdEgB1QgxNPN3pJC7I7OFw=;
        b=WOIaKrhGKY3RnSKdc4m+s7EMzMzBUYiYxmjxoeYNTjtMZ+rBc0GDnpi1oZ92fEeuXd
         WI+rBEEiufi9e2IpKn52vlae0glYwGK7LbEsMJ/eeU1Pk+8KJ9bWM44ZluaXwS56ZCBm
         CPcAmCNxFLQvX105RcXUnwldodWGE0AKskYWkSbbUK0M/gMxC5MvEdwZE9Dssqiv4rXy
         dbuLuZf/LmjmeF3qlQpZ8QZLLABCm431ghwZTGS5pInPcPyx8cZgXXNZWb/WXxTMGipV
         oO6Jpq7ZHSkWshPYHMCsPYihcutpDjGrwNTRhVY502+0XdX9n/oHH1gSJ5wp2ehLJYc3
         gFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iQrwl70qs4iAaAPf+0DBZdEgB1QgxNPN3pJC7I7OFw=;
        b=sOJNo9EVkFII7DCD9zU+/AvMbTPyrLh/73HYGb0HOxZnwCvMTc/2OgUiRlVtYki/Vw
         Amf7CZFnNLwJHrQ4L5ArOLPWhdlhI6rDonxbJLiix6IN/ckubCpi7n44Xn/hqF1g75GO
         Tr4MNmXrD2MzYhMoME5z+jVHWmvHqUk8h86Y8IzMhkg2JzB+NPRf3krPQArPi6+T3dKr
         0342BQ1JMvCm0OCkecLPzncws5Wx4kPYluN2geNo+PVxSCGIoi8FmecWlVPFnpYNTZy0
         yR94Ed993LF7yN/WJIwxUy/9aFOh/q1frORXhZ0y2LLpjEHitug7qoT9iGVNRPVogReA
         YmCw==
X-Gm-Message-State: APt69E0hINJY1InyyOAzFZVdLcHFICEEWOMFggUhiC28ajAJrWSwozur
        mbajy+glPBLfOvc+92eG8BlW/OR0B8GysIDuqeHgeQ==
X-Google-Smtp-Source: AAOMgpdqsZj+OU/f78uzD2Tf7CJTQHOJFk6Zc387V7Of46n/vvQ8WU0jzO2D6nqSQcf1rEMT/bib7yAWQLHWba6v43A=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr13961815ybm.307.1531240355227;
 Tue, 10 Jul 2018 09:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <dfa7b1e71f7a39dfa608e1e205579d3b95d8a34f.1530617166.git.gitgitgadget@gmail.com>
 <CAGZ79kYQTTjipfBn3oAbpjZGnszWNiTKN3Ai4Pp-QA+i_xigbg@mail.gmail.com>
 <xmqq601ocecs.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807101149130.75@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807101149130.75@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jul 2018 09:32:23 -0700
Message-ID: <CAGZ79kbG0QZZSstC85pqSPS1awXq44vsBSvn_gfgP=22fdpzcA@mail.gmail.com>
Subject: Re: [PATCH v3 16/20] range-diff --dual-color: work around bogus
 white-space warning
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 3:08 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Mon, 9 Jul 2018, Junio C Hamano wrote:
>
> > I also wonder if we should be feeding the context lines to ws.c
> > machinery in the first place though.
>
> It *is* confusing, I know. The entire "diff of diffs" concept *is*
> confusing. I just don't know about a better alternative.

I agree, but I am sure we'll get used to it quickly.

> So hear me out, because there is a big misconception here: there are *two*
> levels of diffs. The outer one and the inner one.

Yes, the inner diff is just input that was generated before because it is
so convenient to generate. Recently when using this too (back then
when it was called branch-diff), I came across the following:

Patch 1 looked like:

    line 1
+    new line
    line 2
    line 3

and in the next iteration it looked like:
    line 1
    line 2
+    new line
    line 3

such that the diff of diffs showed the move correctly, but as the inner diffs
had different context ranges, other lines looked like added/removed
in the outer diff, though it was both context.
So I wonder if eventually (not in this series) we want to tweak the context
lines, generate more than needed in the inner diffs and cut them off in
the outer diff "at the same line".

I digress again w.r.t. white space.

> Context lines of the outer diffs have no problem [*1*].
>
> The problem arises when the outer diff shows a - or + line (i.e. the line
> is present *either* in the old patch set or in the new patch set, but not
> both), *and* that line is *not* a context line of the inner diff.

So an actual change in the patches; an incremental reviewer would want
to spend most care on these.

>
> Let's illustrate this via an example. Let's assume that both the old patch
> set and the new patch set add a comment to a statement, and that the
> context of that statement changed between old and new patch set. Something
> like this would be in the old patch set:
>
> ```diff
>         int quiet = 0;
> +       /* This is only needed for the reflog message */
>         const char *branch = "HEAD";
> ```
>
> And this would be in the new patch set:
>
> ```diff
>         int quiet = 0, try_harder = 0;
> +       /* This is only needed for the reflog message */
>         const char *branch = "HEAD";
> ```
>
> So as you see, both old and new revision of the same patch add that
> comment, and it is just a context line that changed, which a regular
> reviewer would want to *not* consider a "real" change between the patch
> set iterations.
>
> Now, let's look at the "diff of diffs":
>
> ```diff
> -       int quiet = 0;
> +       int quiet = 0, try_harder = 0;
>  +      /* This is only needed for the reflog message */
>         const char *branch = "HEAD";
> ```
>
> Please understand that in the dual color mode:
>
> - The first line's `-` would have a red background color, the rest of that
>   line would be uncolored (because it is a context line of the inner
>   diff),
>
> - the second line's `+` would have a green background color, the rest
>   would be just as uncolored as the rest of the first line,
>
> - the third line would be a context line of the outer diff, but a `+` line
>   of the inner diff, therefore that rest of the line would be green, and
>
> - the fourth line is completely uncolored; It is a context line both of
>   the inner and the outer diff.
>
> That's it for the diff colors. Now for the white space: The first two
> lines start with a `-` and a `+` respectively (outer diff marker), and
> then most crucially continue with a space to indicate the inner diff's
> context line, *and then continue with a horizontal tab*.
>
> As far as the inner diff is concerned, this *is* a context line.
>
> As far as the outer diff is concerned, this is *not* a context line.
>
> And that is the conundrum: the whitespace checker is called because the
> outer diff claims that the second line is a `+` line and the whitespace
> checker has no idea that it should treat it as a context line instead.

Spelled out this way, we might want to add more symbols to
enum diff_symbol, such as
    DIFF_SYMBOL_DUAL_DIFF_PLUS_PLUS
    DIFF_SYMBOL_DUAL_DIFF_PLUS_MINUS
    DIFF_SYMBOL_PLUS_MINUS
or so.

These would need to get generated when we create the diff of diffs
in emit_{del,add,context}_line or even fn_out_consume; and then have
their own treatment regarding white spaces in emit_diff_symbol_from_struct.

I am not sure if that would help for the series as-is, as I am
thinking already how
to move these diff-diffs in-core (as that would help a lot with the context line
cutting mentioned above).

> I'll try to find some time this afternoon to study Stefan's reply, as I
> have a hunch that there is a deep insight hidden that helps me to figure
> out the proper path ahead (because I do not want to uglify the `diff.c`
> code the way my current iteration does, and I'd rather have a way to color
> the diff more intelligently myself, in a function in `range-diff.c`).

I considered trying a cleanup on top of your series as I had the impression
the move detection added some ugliness as well.

Thanks,
Stefan
