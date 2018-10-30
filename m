Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890031F453
	for <e@80x24.org>; Tue, 30 Oct 2018 02:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeJ3LiE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 07:38:04 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:42603 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJ3LiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 07:38:03 -0400
Received: by mail-lf1-f44.google.com with SMTP id q6-v6so7667171lfh.9
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 19:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rIJXSgKBM6KIwuLZd3fufz5z5lYd0uYlOUV4CAXSQz4=;
        b=NL7VrvnZb6SMR1Zbf22pyv0/BTnnErGsuShq52aETlsj3wmI4qTuL3c0w4vS6Gy/D0
         dkhcEo+dAFnxgKnrnbnTko1hvPJ9xlkXysT4MFdXeHLjEjZmo+KF/IcvW18LGEqIu5/B
         lVHjrYs+sAcq4vQrngT7AKsE349TyN28v+jEnajX/mssC8x7uLumKm4kF1NC4BdVN8D5
         Jxor/lpSs9mPKZxtE8+eqDyFeU7Way53YqW1jF2VaiQGzbgyTKuoRL9EQ6pEs5NtvVKF
         wYnAhoN9n3NzX3eNRZMkKhoAizpGRBGypAj+iE8WP2s3oXRjumekaOa6O1uD8TKPR1xS
         swug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rIJXSgKBM6KIwuLZd3fufz5z5lYd0uYlOUV4CAXSQz4=;
        b=UTbgBscyNhnxKNZ5ydZGGfQRP6rFtIiGWucli5FPsF9mku9EGWCcCiqVnwpu4TwOxZ
         i9a4anMCNhEat2E79zDB4H10UiQ86CXHHD7cG8qd3P8/3NpLNc4hOhv5yJjbbB5VdtSm
         v5bWfrZVnxcJ7aT5U3IvbaPGXC4bnmQ1q6m+5lU6Sedy2iEV5kPM+06VDlYdXdYGjJB/
         HR7FDRblOcVEet8hZAC9tv7EnsWolvb1BqtzmU1vHgncxLzDTw/ajYRunR9sg9YQLpK/
         QBC5nZddKN3XKDwyzKbjOWRsqkJthhnpv2z4ccPsulXSIDoftWEROWwcwbLOIn02pP1q
         wKsA==
X-Gm-Message-State: AGRZ1gJZquj+O8OrwEndWYdSLJUqSVsFNBNk8o+pOQbB96fULbWP/p5l
        wXAJBNxQESskO6rpGGv4mz/PcqhsGaajlHYKh9ETXw==
X-Google-Smtp-Source: AJdET5c7SCBLnPLYF4EXLc16oPBnYsZzcVwUMh0U2mXmJTrg03sL5xUcszQYlDP6zNb9TEo6wG6lLWEWrRfQOhigpl4=
X-Received: by 2002:a19:1cb:: with SMTP id 194mr628243lfb.61.1540867588809;
 Mon, 29 Oct 2018 19:46:28 -0700 (PDT)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Oct 2018 03:46:28 +0100
From:   Gray King <grayking.w@gmail.com>
In-Reply-To: <20181029141804.GC17668@sigill.intra.peff.net>
References: <CAP1N1j7P83XVPx6dDGMSeRbwjdixAdBNZab=TP94=9LSfmsrRQ@mail.gmail.com>
 <20181029141804.GC17668@sigill.intra.peff.net>
X-Mailer: Airmail (528)
MIME-Version: 1.0
Date:   Tue, 30 Oct 2018 03:46:28 +0100
Message-ID: <CAP1N1j7AbiYLfe4EiFn-4zdBd-nD2paXx1hZhqiUCOq4iLh9zw@mail.gmail.com>
Subject: Re: Lost changes after merge
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, seems the link has been expired, here is the new one:


* Before merge run `git log --format=3D"%h %p %d" -n 20 --all --graph`:

https://cfp.vim-cn.com/cbfq6

* After merged run `git log --format=3D"%h %p %d" -n 20 --all --graph`:

https://cfp.vim-cn.com/cbfq7

=E5=9C=A8 2018=E5=B9=B410=E6=9C=8829=E6=97=A5 =E4=B8=8B=E5=8D=8810:18:07, J=
eff King (peff@peff.net(mailto:peff@peff.net)) =E5=86=99=E5=88=B0:

> On Mon, Oct 29, 2018 at 09:49:20AM +0100, Gray King wrote:
>
> > Hello,
> >
> > I have a very strange issue described below:
> >
> > * Here is the tree before I merge via `git log --format=3D"%h %p %d" -n
> > 20 --all --graph`:
> >
> > https://upaste.de/9Pe
>
> FWIW, neither this nor the other paste link in your email seem to work
> for me (which makes it hard to comment on the rest of the email).
>
> -Peff
