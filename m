Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94F21FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 00:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbdBHAeL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 19:34:11 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:32957 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbdBHAeL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 19:34:11 -0500
Received: by mail-ua0-f175.google.com with SMTP id i68so97886260uad.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YMkfxo1bc3/kpAUXxOi0XpzGaIBhgjJ62v7M55W+slk=;
        b=I9rGn0SkLxa93QrGwPIEFFi3Q3nXGDd7n+hWj+nogLejtaWQU+EqLM6fLhhOgHQMRI
         B4X3tm7sGsCUzZCB0zyQvUZJ6pzP0pXF7jMCO0+rK2kzAdEin/VBvJnw9gIVXssBPtuc
         jMtCXy/f1ivtNRrGMnMhbQskOroTbb5z3DEZDM7P6jhlZtq94tO//fXXV7reJS1Kslpd
         sylx9mLHU5jcchQxcMvOUerOvO8pzZ94dPyMu3a7ZkEj+7uimH5Am3unB1ntioh3ZaRO
         NOKDd+jXBq7H3Awh72fhCrtBZfrVPPZWNoIaFwwV6yF4ND2tsyLdOc4PnXGKkp5ztbMR
         vxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YMkfxo1bc3/kpAUXxOi0XpzGaIBhgjJ62v7M55W+slk=;
        b=hZlaFrfO4HspOTPYVfuuNL7YZ2q6Uyq3RYvraBalXeuBVxiUtzrOgUo6sCGcNCuQiN
         1yAmurIdAeIGY4ZwwtrUnKqNgGezk6XVBnpmPeaNkgBiDB4dTO3m3zg33fUTd6v/RFWo
         Akf4mX7CJSUyOLbJgYFlw8AEGPU+udbUq7IaWtqlMMdRixaqNXaOrPcO4sTOMxLpuFXK
         ouPHN+0cL8lhYEK7D0ehss10LzqpFZU/ik7KH++vc0MmMmnoxdpihE8sCYmRlhGZqx9T
         dKa1LqS2I83TlxlX15JJJJSlnsRya/xUbkW0AsbV3WYKMc5wnuHOdOKeZfI3jcP9Ht1+
         xOgg==
X-Gm-Message-State: AMke39lv8BgaECxtZXegXjw484ZDqjskzKDXnK40g5B9YtcGZP3UaY5x/2eqstNQT/wMm6Jj0Log2pu+PJO/xw==
X-Received: by 10.176.6.106 with SMTP id f97mr9455013uaf.118.1486514050045;
 Tue, 07 Feb 2017 16:34:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Tue, 7 Feb 2017 16:33:29 -0800 (PST)
In-Reply-To: <20170206183429.sd7255b3ovvg746c@sigill.intra.peff.net>
References: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
 <20170206183429.sd7255b3ovvg746c@sigill.intra.peff.net>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 7 Feb 2017 18:33:29 -0600
Message-ID: <CAJZjrdU-UsWpNvjQ=eZi1wMUSWxRXLr5YNsgAce=z7Zt3yCTSA@mail.gmail.com>
Subject: Re: git/git-scm.com GH Issue Tracker
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finished going through and nailed the rest of the open issues!


# Irrelevant but it seems like someone should take a look

511 466


# Irrelevant to git-scm.com and should be closed

599 596 570 565 563 558 538 537 520 511 509 507 501 494 465


# Resolved, duplicate, or non-issue

596 593 592 588 587 585 583 576 575 573 572 547 546 543 540 539 529 521
516 515 504 503 502 496 491 490 476 473 470 467 463 460 456 454 451 413
377 265 257 95



# Relevant and should be kept open

597 595 591 586 578 544 532 518 513 512 500 493 466 448 416 410 381 379
140 13 12 11


That's all of them!

- Sam

On Mon, Feb 6, 2017 at 12:34 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 06, 2017 at 12:15:08AM -0600, Samuel Lijin wrote:
>
>> I've went through a bunch of open issues on the git/git-scm.com repo
>> (specifically, everything after #600) and I think the bulk of them can
>> be closed.
>>
>> I've taken the liberty of classifying them as shown below.
>
> Thanks, this is incredibly helpful. I'll close the appropriate ones you
> identified.
>
> -Peff
