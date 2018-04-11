Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F691F404
	for <e@80x24.org>; Wed, 11 Apr 2018 15:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbeDKPUK (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 11:20:10 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:38281 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753746AbeDKPUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 11:20:09 -0400
Received: by mail-oi0-f53.google.com with SMTP id c3-v6so2071930oib.5
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K+F4fj+XVpIxxqq4VVG2Sj2IWN2aD46Bs6hctPmjpjQ=;
        b=SOiQamSpV4KPDTdCUfClBxsuFdyGvZbmic8GQrqzjuB+oU9496ptDqBMuGQI734ItU
         v58PvqgxQ9+WAcjHoSppFRf8rwmEVzQlCMSuo84xoVYRe/Hyfeh152Hntz2BBKOE8eXd
         EMQphLd0yJ7z3D1gX5fhs2q4tWaNSDZy3g61MdrKTB7fU3HIhkDc7j7YIRiKjs5IALyF
         cq5NoKR+gly0JMFBeMstQdVMOWBizT3wH6z5GxpWCBNk6PoMvBLegZ/wYEsgM7NKTR+o
         LN6YpmqGfrMLazgdy86zenueEsOdv3MmiUzd4begykmcxRbQTMnQ3UsYJAW1hvnPjzKv
         vvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K+F4fj+XVpIxxqq4VVG2Sj2IWN2aD46Bs6hctPmjpjQ=;
        b=tdDX24sQC1Iis3K2qfg3nEDdxMCYvYHl6QFtIpdVg1mvhIHZJIgWfAMzSvQ3SlmWqD
         ABDoy9mBXQwlvyPZoM5u7ceSNwXfocdqk8KX388KXv97yAC+g29VQW6uwbfhLNCpBWdj
         v56fC6BTL7ElmBtNocF02SqWJO7Jf5Kc0t8+vDlxVJ27eaKDBmKxHNxSH9+PfF5Jj2mI
         ei7nILX3i8p1EpLgaUFTZSKYmUIt63QvRUjMs+waTcCJeziuYULwbjG2GP1wtAjev/hd
         iGk+jK7cM71SCtfJQ0FCX/RIdc5uhATD7SpUuejzr+7T3q/yi2Yg77nnor8HTfpM/QDV
         MoDQ==
X-Gm-Message-State: ALQs6tAxR7pjmOKwshzG4S5bNvlZaRYM0FYigqUcj4/St7Pw6ZbE5k1g
        2eSJ5wAkvK327aMRh4cOkgexSZVrogyJWvAa1kY=
X-Google-Smtp-Source: AIpwx483u9SuEig5Xr8Ni0dUKTIt8eBo+MmNXLBX3q2SYQD0ZauN01W5JCWGZSsUmWjYAD2JU/zowPsq/hQg+JpwLgs=
X-Received: by 2002:aca:5944:: with SMTP id n65-v6mr3391334oib.308.1523460008901;
 Wed, 11 Apr 2018 08:20:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.56.25 with HTTP; Wed, 11 Apr 2018 08:19:48 -0700 (PDT)
In-Reply-To: <xmqqh8oi1zai.fsf@gitster-ct.c.googlers.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-7-mastahyeti@gmail.com>
 <xmqqlgdv2y66.fsf@gitster-ct.c.googlers.com> <CAE=pOyFj+WZBB6Zp35d=mYNsxcJK-LwOxseWXSmY_hs+Lwugpg@mail.gmail.com>
 <xmqqbmeq3h8o.fsf@gitster-ct.c.googlers.com> <xmqqh8oi1zai.fsf@gitster-ct.c.googlers.com>
From:   Ben Toews <mastahyeti@gmail.com>
Date:   Wed, 11 Apr 2018 09:19:48 -0600
Message-ID: <CAE=pOyE29KwsMOt4CepDXHa=rzz2kT45sMKtUrbQT1TAPEuJQQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] gpg-interface: find the last gpg signature line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> That test was fixed a week ago:
>>> https://github.com/git/git/commit/a99d903f21d102a5768f19157085a9733aeb68dd
>>
>> Well, you cannot expect any reviewer to know about a change that has
>> never been sent to the list and has never been part of even 'pu'
>> branch, no matter how old such a private "fix" is.
>>
>> What other unpublished things that are not even on 'pu' do these
>> patches depend on?
>
> Answering my own question after digging a bit more, now I know that
> a99d903 comes from the 'private' branch in peff/git/ repository
> hosted at GitHub [*1*].  The branch builds on 'next' by merging many
> private branches, and 'jk/non-pgp-signatures' branch has that commit.
>
>     peff.git/private$ git log --oneline --boundary 0c8726318..7a526834e^2
>     c9ce7c5b7 gpg-interface: handle multiple signing tools
>     914951682 gpg-interface: handle bool user.signingkey
>     1f2ea84b3 gpg-interface: return signature type from parse_signature()
>     6d2ce6547 gpg-interface: prepare for parsing arbitrary PEM blocks
>     fb1d173db gpg-interface: find the last gpg signature line
>     6bc4e7e17 gpg-interface: extract gpg line matching helper
>     4f883ac49 gpg-interface: fix const-correctness of "eol" pointer
>     ae6529fdb gpg-interface: use size_t for signature buffer size
>     1bca4296b gpg-interface: modernize function declarations
>     a99d903f2 t7004: fix mistaken tag name
>     - 468165c1d Git 2.17
>
> It seems to me that Peff did the t7004 change as the earliest
> preliminary step of the series, but it caused confusion when it was
> not sent as part of the series by mistake.  Judging from the shape
> of the topic, I do not think this topic has any other hidden
> dependencies as it builds directly on top of v2.17.0.
>
> For those who are reading and reviewing from the sideline, I've
> attached that missing 0.9/8 patch at the end of this message.

Sorry for the confusion Junio. I'm not used to the mailing list
workflow and it seems that I missed a patch. I'll make sure to include
that patch in v2.

>
> [Footnote]
>
> *1* I do not know if it deserves to be called a bug, but it
>     certainly is an anomaly GitHub exhibits that a99d903f can be
>     viewed at https://github.com/git/git/commit/a99d903f..., as if
>     it is part of the official git/git history, when it only exists
>     in a fork of that repository.  I can understand why it happens
>     but it certainly is unexpected.
>
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Tue, 3 Apr 2018 17:10:30 -0400
> Subject: [PATCH 0.9/8] t7004: fix mistaken tag name
>
> We have a series of tests which create signed tags with
> various properties, but one test accidentally verifies a tag
> from much earlier in the series.
> ---
>  t/t7004-tag.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 2aac77af7..ee093b393 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1056,7 +1056,7 @@ test_expect_success GPG \
>         git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
>         get_tag_msg blanknonlfile-signed-tag >actual &&
>         test_cmp expect actual &&
> -       git tag -v signed-tag
> +       git tag -v blanknonlfile-signed-tag
>  '
>
>  # messages with commented lines for signed tags:
> --
> 2.17.0-140-g0b0cc9f867
>



-- 
-Ben Toews
