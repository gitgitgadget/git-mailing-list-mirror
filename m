Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15841F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 23:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbcJKXQm (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 19:16:42 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34215 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754688AbcJKXQl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 19:16:41 -0400
Received: by mail-qt0-f172.google.com with SMTP id q7so5947048qtq.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 16:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XeUnB9IWR3X3egw3U0yqDyJNQw8buoexQQAH3djGB0Q=;
        b=N8G/sfQY5HcQz9YVRaGKodQnY8od2dvZywE1ees8ufIk7dNkvbtNnegccP4uZA1SiZ
         kST1ZqZeE5zRJWmtA/DtuGpPRR7JdwUqogCxBkHWbC/B4UNd/Vh0c544OizvVnlt1AL7
         XIsosDCxMkanfOx9kpxpWSYZl+VgkaMIYA2jbehXxnbtdxbThGU355GCilHO1h6ldqar
         hjJ0I1GcBPXMN6ObdWeGyk4fM4Jp6vhrFcJy5NY/d7D0/MGecXQ3CpD40VdMoEZeqFnM
         29p7GWdB9Enrj+g2Rgv1UraP8CvHqFZK5WpzB+EXNfb4eAyUGVyTX4Shd8gW+wS1a4CJ
         pN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XeUnB9IWR3X3egw3U0yqDyJNQw8buoexQQAH3djGB0Q=;
        b=Jw3xuAoqRyOYvRpxYuPj3/lWRKVK5mHd6Z3HoSI9r1TRdj3aykwWgZy5oUtiSSLhBl
         dkjCCaEHDSjsfknhNW0cp20Tq0Dvy4BT3rzN8z/cEf1xQR3Sx6jGBHt6r1zZZHpTCzJ5
         1e0DxwXw8Fc777arYEXj1hZ7H2bN0PdHdWX2TwI0kDk0aCk21BErb7asma325RvoQ88w
         TlKfFqEbpkmeU49GvbebaTbnweDh9YWmSYPOaPk8P2+3K+AyaBVAjAh9dI2Qt259Mjiz
         ziGCpofQOnBSI6w8GMysthd9S4aSyon9tBSiH6a0ztddy+opTO2U/x8eRCVF0PzZct+l
         uv7w==
X-Gm-Message-State: AA6/9RnS6wleaL1Sz1GXg0QhToneI6OZzvXuqtkdvk+mOl4xTDN+JF0iiECa7fE1khw8xnK2k6tBQUMbf05IXw==
X-Received: by 10.200.37.177 with SMTP id e46mr5607651qte.14.1476227800711;
 Tue, 11 Oct 2016 16:16:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Tue, 11 Oct 2016 16:16:20 -0700 (PDT)
In-Reply-To: <20161011225942.tvqbbzxglvu7lldi@sigill.intra.peff.net>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
 <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
 <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com> <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
 <20161011225942.tvqbbzxglvu7lldi@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 12 Oct 2016 01:16:20 +0200
Message-ID: <CACBZZX6pFbu_CWMG+OTxx8L2OEy4X4RqGfQ_+z4zFOhS-zx8zA@mail.gmail.com>
Subject: Re: Make `git fetch --all` parallel?
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ram Rachum <ram@rachum.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 12:59 AM, Jeff King <peff@peff.net> wrote:

> I'm not altogether convinced that parallel fetch would be that much
> faster, though.

I have local aliases to use GNU parallel for stuff like this, on my
git.git which has accumulated 17 remotes:

    $ time parallel -j1 'git fetch {}' ::: $(git remote)
    real    0m18.265s
    $ time parallel -j8 'git fetch {}' ::: $(git remote)
    real    0m2.957s

In that case I didn't have any new objects to fetch, but just doing
the negotiation in parallel was a lot faster.

So there's big wins in some cases.
