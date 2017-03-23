Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9455B20958
	for <e@80x24.org>; Thu, 23 Mar 2017 16:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756386AbdCWQxK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:53:10 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33727 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756376AbdCWQxH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:53:07 -0400
Received: by mail-wr0-f177.google.com with SMTP id y90so33924279wrb.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LvUF0l24Dn0j7zR3uoYUVtp4P3p/GJ0bEhTxrTKOHpY=;
        b=JqgOkuiRWYcVAkMHmC2gJR1WzRpUdxJ40kh7zAcFX+eKjFqpsbEF1jIPrie0OhsReZ
         bCQYoM1mY5jtHOqaIZNmgDXQIvHmMpkt/yzlIe0inhUVA56AZteK2avYDC40bbJTc+iZ
         DLdWZGNw9CwakLX50ItAZkRTTmz0f7hZRLAWdic4WCkXpOPJwfoxNmC6MnEXDrR77neh
         QYwPVzetohg9k4sRtu2/ddXAl37vLn1Nn7LXg4JZMXN55/WaCXS3Fbf/u+5I8eWof58V
         1tUAXH3QEqCRuM13HEW3RXMaDMfMhFHKlBUhlITOqghellhyNVwcBnCX8CQuedJxoPB1
         HG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LvUF0l24Dn0j7zR3uoYUVtp4P3p/GJ0bEhTxrTKOHpY=;
        b=VP2vQPjKs3PVbJ3a9DSv4qmam9lJADwjT5Ax3Cc62Bb/MliChbqUz+H7gZl0jH3fVO
         ts1E0Pq131NCOxs1zTkVrQoqCvfnCsPQTvVX6oXGJXGLfbJxkAaGLuv0Lrgfjhj9R1dL
         dilbvx8TYVGggyuiG6dgwMw08XRVYiHZ3nNU+rfVvNWLzsvq4GdLOFMsqWBpxmNVUvHP
         TIzatw03GjgDMrcsBHMxNn0+G1+89fqJNF82Elw5xXgCvkIc+QYXPhJIBG3kxCOJCRBg
         S589Ym2z9pI33f589E0F88soRNX6dbSBhDD4m69SZBQZY5PjoLGsSr1wNQBT4QrL2kny
         H5aQ==
X-Gm-Message-State: AFeK/H3mx0RuTulNN4i8JyGOxnh9EX/fL1iJ78z2vsGFku13Qs5pcEubeLNWvBlkr9Ry2O0lfxLtAinvUFUYmg==
X-Received: by 10.223.134.69 with SMTP id 5mr3755339wrw.22.1490287975414; Thu,
 23 Mar 2017 09:52:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.91.2 with HTTP; Thu, 23 Mar 2017 09:52:34 -0700 (PDT)
In-Reply-To: <xmqqfui4f0pp.fsf@gitster.mtv.corp.google.com>
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
 <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com> <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
 <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com> <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
 <xmqqfui4f0pp.fsf@gitster.mtv.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 23 Mar 2017 10:52:34 -0600
Message-ID: <CAMMLpeRtzYM3a639DcNbhqAmz3dNkRebvQps-gusEKx+eQqPgQ@mail.gmail.com>
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-03-23 9:54 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> 2017-03-22 10:54 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>>> No problem. Do I need to submit a second version of the patch with a
>>>> test for `git -p log`?
>>>
>>> You do want to protect this "without an option, we default to
>>> 'auto'" feature from future breakage, no?
>>
>> Yes, but I need to know whether you want a v2 of this patch with all
>> of the changes including the new test, or a second patch that depends
>> on the first patch and only adds the new test.
>
> Sorry, I misunderstood the question.
>
> In general, we prefer to have tests that protects the updated
> behaviour in the same patch that makes code changes that brings in
> the new behaviour, i.e. a single v2 patch with new test would be
> more appropriate in this case.
>
> When people work on a large bugfix, especially one that needs
> multiple steps, we sometimes see a patch that adds new tests that
> describe the desired behaviour as failing tests first, and then
> subsequent patches to the code to update the behaviour flip
> "test_expect_failure" to "test_expect_success" as they fix the
> behaviour.  But for a small change like this one, that approach is
> inappropriate.
>
> When a patch that was reviewed, deemed good enough and has been
> already merged to the 'next' branch later turns out that it needs
> further work (like "we do need some tests"), we do such necessary
> updates as separate follow-up patches, simply because we promise
> that 'next' won't be rewound and are not allowed to replace patches.
> But this one is not yet in 'next', so we can freely take a
> replacement patch.
>
> Hope this message makes it clear enough?

Yes, that makes sense. I assume that when you talk about 'next', you
mean 'master'?

Unfortunately, I think I found a bug. Even when using `git -p`, the
function pager_in_use() always returns false if the output is not a
TTY. So, `isatty(1) || pager_in_use()` and `color_stdout_is_tty ||
(pager_in_use() && pager_use_color)` are redundant.

If we want to use `git -p log` in a test, we'll have to change the
behavior of pager_in_use(). Alternatively, we could use
`GIT_PAGER_IN_USE=1 git log` instead.

-Alex
