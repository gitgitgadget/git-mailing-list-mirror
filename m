Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540FA20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbdCVWIw (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:08:52 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:33928 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdCVWIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:08:51 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so7021104itc.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=78eNaqu5R813DeveetbF/juBQkumItwnHCNn9E4WElU=;
        b=uAjsNye5fwC0Cjq7IgB3ZODeINUEko0SP6t9ggxOCWRRs2Cf0LjlRA8nQDH+yogVh0
         oFDizNvMKQLYjKqoi//t6P6gzZcDdf0DCzNvY9jUyg2cIFGiJSYVMFKy9pxLE48zDTfA
         i3qa0q1ui63ONRL+G0iGm2ctCJ/uOcpInunxSP9Cl2TEcHwnnvmfQobcrMXHUhcagoHQ
         6bReaZ5Pp9ejawMo64zvFokwATI+wgO64Pwyl7rLcgaUBSkPE7gW6GShJSYSPvTt8iOo
         kirFg5os72wes+Nh5ElJmn3xprX6YOoQQVWkfQjO6ln3OyA5M5HuEP5IQK+RQjJ9bUs1
         rp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=78eNaqu5R813DeveetbF/juBQkumItwnHCNn9E4WElU=;
        b=DwjaK7jm8bf9zlbQMoTNcj47gpFroe9QxD37kRJmF4KzxxCjuLC44lHxgh2iJO2Yff
         MeRDnLgrknzJlCsIVcwE6LJsUuIZl41QFJnrvbRxydFTMOjeCzOAQhnuqdzi/e4sxPOs
         IL/meysdkTIDAaioTV6x8GB84dTtNCCr04SgNrq64zPVnqiVuhBSx0xHCJ0hJiFwUGS7
         Jwp9E9eQVZdaGhDwtf1xmFkgYTb1V7fV6e6ocyM4mK7dX+iN2l6JAvyV/3xmHp6wCy02
         dkWjWad9qOUtqSQ6LcpSyUNnrCulrAzVxoAvizenjjIzu/KLeH3Z7KihoZUDSiyZjbI3
         Yoag==
X-Gm-Message-State: AFeK/H0aDWZX5OKKRVrGy3j8idOnivZ63ggfGOfPkhbgIZ4AuSy80slLmE/1a2pPZ25mPBEpoqSvk/0cvJvE5g==
X-Received: by 10.36.29.66 with SMTP id 63mr9845253itj.91.1490220529615; Wed,
 22 Mar 2017 15:08:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 22 Mar 2017 15:08:28 -0700 (PDT)
In-Reply-To: <xmqq1stpj9xv.fsf@gitster.mtv.corp.google.com>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-11-avarab@gmail.com>
 <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com> <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
 <xmqq1stpj9xv.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 22 Mar 2017 23:08:28 +0100
Message-ID: <CACBZZX4rofOquS4q0NDCb8cHOF=E7iPzFMxj3bre6CTB7=b_MA@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] tag: change misleading --list <pattern> documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 10:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Please drop "interleaved", as we are not encouraging GNUism.  We
>>> just tolerate it but do not guarantee to keep them working.
>>
>> This brings up the same point you made in
>> <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>, I replied to in
>> <CACBZZX5LN8nhs85K18XVg4Y9_qb9zKGBoFnnQHSsRZVOP=3DOkDw@mail.gmail.com>,
>> and that you didn't get back to me about.
>>
>> Rather than split the discussion or me copy/pasting large parts of
>> that E-Mail could you please reply to me over in that thread?
>
> There is nothing to reply.  We know some people favor GNUism, but we
> do not actively encourage it, period.

I'd understand the objection to encouraging if I was proposing to
include mentions of "--list <pattern> --list <pattern>" in the
documentation, but what this patch is about (and this wasn't clear
enough from the beginning, I'll reword it), is essentially:

"So for the last 5 years of Git releases if you'd read the git-tag
docs you'd think `--list <pat> --list <pat>` was the blessed way of
supplying multiple patterns. That's not actually needed, or
encouraged, so here's a change to the docs & a test addition to make
sure we know if we break this long-documented pattern in the future".

You'd like the doc change but not the regression test. If so I'm fine
with that. The reason I'm asking you follow-up questions about it is
because I'd like to know in general, for future submissions, what sort
of things you think we should be putting in the test suite. I.e.
should the tests be:

a) Only be a collection of invocations of git we'd be comfortable
showing to someone as "this works, and this is how you should do it",
or things that explicitly fail marked with test_must_fail.

b) or a) && also various surprising combinations of things we don't
necessarily want to encourage or even support in the future, but which
are in there so if we change them, we at least know our change changed
something that worked before.

Now. I think the policy should be "b". The main reason is that as I
noted in [1] people do write scripts against the porcelain. There's
doubtless scripted invocations out there that use multiple GNU-like
"-l <pattern>" options, and it's worthwhile for us to know if we make
a change that breaks that.

But if you think it should be "a" obviously that's the project policy,
but then I'd like to know that it's "a", both because it'll save me
time authoring future patches, and I'd like to submit some change to
SubmittingPatches or t/README describing to others what sort of tests
are acceptable for inclusion.

The reason I brought up a hypothetical "test_might_get_deprecated"
feature in my original message [2] is that even if you think we should
only do "a" now and not "b", I think that perhaps that's only because
of some limitation of the current test suite. I.e.:

1) Maybe we shouldn't run these ("b" && !"a") tests by default unless
some flag is provided, so that someone who's working on an otherwise
worthwhile new feature isn't dissuaded by some failing test that's
checking for an obscure and historically unintended feature of git.

2) Or we could run them, but e.g. turn them into TODO's for failure to
mark them as things we'd like to deprecate.

1. <CACBZZX59KXPOEjiUKtZLN6zjO_xpiWve7Xga6q-53J2LwvfZyw@mail.gmail.com>
2. <CACBZZX5LN8nhs85K18XVg4Y9_qb9zKGBoFnnQHSsRZVOP=3DOkDw@mail.gmail.com>,
