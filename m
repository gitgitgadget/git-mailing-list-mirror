Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F5771F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 02:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfHOCUd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 22:20:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35340 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfHOCQC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 22:16:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so149272oii.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 19:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TsEm6gy/rdsys4YO+JiWb0kaXpvao8PBzfva7VPiJg0=;
        b=rE3uj1VKn/lC95ZTqjELtgInl+yRV6ECoO/HR4oLprxr+CVIOrGzvcQLHS14g90zQM
         Q31Bc6KF7OYBlwUOOOJvJuInYT3zXXPXP6N7dQmvgrthOLabMC8zAf1EKn4lX+OkOOns
         oPFwrDAnq0k/XkRdcRD37cnWBAjvglrMrDOtvwzeA0Nrk8b4Fcdb+hqWBqUrcHEqBYus
         WRvUTX3E4KLGUy+NmJsmo55LcMormBs98lwfExzBhGbEsEPJ+67I82CdFSRcMeMXnTro
         Lhii10X1dKYFmICML0cW8z4KJa6gHevttPb7Nvo5qASbrsPfrPEzHM5qhAMgEMMnWPPM
         HqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsEm6gy/rdsys4YO+JiWb0kaXpvao8PBzfva7VPiJg0=;
        b=rGkWm0wbY1w14LWrzteOasWO4yju3exM43/WgDAOXYSywhYmpgAkAzxJYNuQdkm/ME
         4Z6z++vYvyE3w1i/iPSmjfmsIczJ4b9eyhWXczVSeAjO2p0HuCNrfk6yJKSti8ZFKdz6
         H5Lin4mlANCWP4T8TBV5ESq0Ue2KM+kOmUFamh0srUYj3nHl/TV2IcZJrtPoAt6yckUd
         M0nX3gKee7/MahYwBB8e1ANuPOT1XAD15ixOhFig7CC2/o6Fme0Rra3koeGbH/i42FgU
         Yo+H4Ncq0gQ9PY8sLdgQpsShg6RBARlOTEo//HoDxZKVOitMVJ+BliZFT/es7HAhP4lP
         7rgw==
X-Gm-Message-State: APjAAAUnHFm4z9djH08X4kSz1WWPRllx6nVZXc93fzTxPhwSRMY6jhpk
        EqGG8yoyyQSsOGYak9Fpj9NFPsBFmddk8MKtUKI=
X-Google-Smtp-Source: APXvYqzga/asXQoFyG5ZH+dYAmzToP7GJrE35rL52y6TExaPCxNYj+7J3moZL3Psq0vNCKKURo53Uf4ASSrKszDp+P8=
X-Received: by 2002:a02:ce35:: with SMTP id v21mr2638427jar.108.1565835361543;
 Wed, 14 Aug 2019 19:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36i35tfv.fsf@gitster-ct.c.googlers.com> <CAHd-oW4kMr+Q1GhNQ7B7RW2hafqokvUoxg9qkXXyt98L53=Ahw@mail.gmail.com>
In-Reply-To: <CAHd-oW4kMr+Q1GhNQ7B7RW2hafqokvUoxg9qkXXyt98L53=Ahw@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 14 Aug 2019 19:15:50 -0700
Message-ID: <CAPUEspjWbHC2md3kFu8O88275pYSzpFmu9kjHEn4_0_hjxZ8MA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2019, #04; Wed, 14)
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 14, 2019 at 4:58 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Wed, Aug 14, 2019 at 6:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> [...]
> > * mt/grep-submodules-working-tree (2019-07-30) 1 commit
> >   (merged to 'next' on 2019-08-02 at e1a46a195f)
> >  + grep: fix worktree case in submodules
>
> There is a new version of this patch here[1], addressing the comments
> you and Christian made.

since it is already in next, would be better to submit a patch on top
of the current topic instead (more details in
Documentation/SubmittingPatches).

Carlo
