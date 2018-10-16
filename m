Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD731F453
	for <e@80x24.org>; Tue, 16 Oct 2018 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJPRDr (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 13:03:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43461 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPRDq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 13:03:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id q41-v6so24777988qtq.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaIwGKK73GGiof/0LYTRD2kiVP2s8CKGhwKU8JSWTWg=;
        b=C00EtRBkQOUSZ4Zpv/wyH0ie+UKRyKAwflfuGS6ZfMSi/7qO5EUaXIk0ZZ49P/XGZP
         T+Zzvc/FSYPojglV/38vz1k8oTjj9EAir9PbyyssLaCTKqdIu+PtizU4Qt2VcCrjDoXa
         eW+76D+LS3M3Lu/PNNhLmu81REw9JU3MJaCGjDJz8dxyaKshYajn2WU608UcfQuqGgzw
         DX1g5wO8R5fYiwuE54oF41HmjbgB6xwobobxuXFkcHByMIGMJwwtoRJsVs5R9iUzUsdF
         uSWjuvd3hokqhlNakONhUk3lwucQTfQNNQMoOtYLXrgUZb36bXEY4FvGfHaQhLhOZDnc
         hqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaIwGKK73GGiof/0LYTRD2kiVP2s8CKGhwKU8JSWTWg=;
        b=LU7Gcxp7+oNWB8WSy79XaUvNmQDn7LtHfGOU73YSWcHnN/mGSFxCFxsfFzIZ3ehkkE
         uz9b4XGkjlfUEGq3FRIKOoCEiAWVCDt0mljQgkesK78BHDYkZLDXmpH4ZRAMPYwQZgU4
         QV6llJ1fkTypLr8/PXGLgd7Z6Jh5yOaM4hUQmMttJY17aDx84RoCp12ZjRuybfc7nBzP
         fx21QNSjYErsyGtHURNaK9awi8lyt0a8a+ku/rzUOPIoakmfG+WlCTZnPTmVYwE6AvHQ
         FaoSHMl4DI7ikt11uCIaRxee6iqH/FmMQkHaC3fZ8QNegoAsPe2Ldd4yIVE8heJbgKwU
         184g==
X-Gm-Message-State: ABuFfohKzkNq5vFlxzoZYAwSRnXQBUjJo2xdYw8ZPwYZgcsYY6RGeTGU
        YDU5QwqKuMrEQX8nrrR6lrjED0Us/oyD8UgHjpw=
X-Google-Smtp-Source: ACcGV60HqbwmgksELEnPhe2eS/cdsZ/d2VWLOapHRj35zp74TJm7dvZCmdeDnBzdHpfTg5IpoD/ZIYiu61pu2MEnSYQ=
X-Received: by 2002:a0c:d1d6:: with SMTP id k22-v6mr21261343qvh.156.1539681257973;
 Tue, 16 Oct 2018 02:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <8736t7dzan.fsf@evledraar.gmail.com>
 <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
 <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet> <xmqqd0sa1omm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0sa1omm.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 Oct 2018 11:14:06 +0200
Message-ID: <CACBZZX59vT1CTiUPfPZDJUSRH=NSzmWiabux=KRdTUFa1R=5bw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 6:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > AFAIR Junio does not push to github.com/git/git, it is an automatic
> > mirror.
> >
> > GitLab could easily do the same.
>
> It used to be in the early days but these days git/git and
> gitster/git are updated in a same for loop that pushes to various
> destinations.  You are correct that GitLab or any other hosting
> sites could do the same polling and mirroring.  I am just too lazy
> to open a new account at yet another hosting site to add that for
> loop, but I may choose to when I am absolutely bored and nothing
> else to do ;-).

Do you mind if I squat gitlab.com/git/git in the meantime (i.e. create
an org etc.) and have it mirror github.com/git/git?, I'll hand the
keys over to you if/when you'd like to update your for-loop :)

In the meantime sometimes GitLab's UI s better than GitHub's, or the
other way around, so it would be useful to have it there as mirror for
that reason alone, and then we can always experiment with a
.gitlab-ci.yml in-repo.
