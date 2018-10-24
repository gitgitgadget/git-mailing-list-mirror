Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E551F453
	for <e@80x24.org>; Wed, 24 Oct 2018 05:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeJXN7l (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 09:59:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38914 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXN7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 09:59:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5-v6so3784647eds.6
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 22:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiIMINNz4DFW6tAaPRwlU6Dj6M+hlSkgNQDDg6ktusY=;
        b=cUTPHTWI1uC+ONUu1IZj34nQximIBa+AD0U8DblBFNiXV1hKzhehZ17BgucKOE/36l
         6y9GAU3OL2o8C2DTDfcUnPaNJ/BIc3wwCAmf7KsObwd1SG4aX5MQt3CBSnyJcZFIgUyd
         PAsFV3Mv6J4+pHalpy9UH2FP4jdlk94g5Cj8fuhR59BKthDOadBsRAJj69FLrV2QQ+sY
         dayFcsRdeLoQbjT9kGfLHX89b3raiRb1HwZVKECP5l/jyn2gWcrs8LFTIM8rEPuJPxtY
         YpWRJuD7JHTHXfGhjo2euTAo+sZF6fufABC1as8VrL/9SS5OmpqsxjjdvXtW0HUXFsvY
         T50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiIMINNz4DFW6tAaPRwlU6Dj6M+hlSkgNQDDg6ktusY=;
        b=SkKkB4/jOoAce4Iw02+pfaBbwMMo7Fu7y3HVx5YzGfSAZeYlywVz0whcHtP70SlMAA
         UkShPYXN1R6dym+wr+ZZ2sh14hcEVMWf1FCTJ0nEUY65taq/vIh6zYGYXdZixPc/ioJo
         M8AQ0TuYenumZFpQOutSW7b6V1YekfLufB6LkGmyyxpGxCf6YZ764HN8lDOip9Pv97pX
         sWTbsNzBq+gjtHUlpTiW+16+VPX8kEIgzT/9FoO7hUrrt2pLqhkLqsiop+GTd41nhHT8
         hqyPDzgrML32vUYaYnKJe1LtTCuXOS0T0uK9NkFje1Eajx9vV1HHh1Tztxfk/ScN4jbn
         +FWQ==
X-Gm-Message-State: AGRZ1gJB0/u+S9Gai2dVW8xcZcyro1t5hWaOkUYBEjLq3+XIlTeZRKLx
        Dr2BdAxXs748OLe1zd5odXhrT36vUzivXXzhs7o=
X-Google-Smtp-Source: AJdET5eItv4maJ21U5H1MvwJK031aSDyazlbgdE4lVzkEZ30dVLBCCmEGvNREUTdAM+bO1tzEzMeCwJ4vlyGRhwWAXk=
X-Received: by 2002:a50:8987:: with SMTP id g7-v6mr2839235edg.257.1540359187892;
 Tue, 23 Oct 2018 22:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGshahkvn3fcyuqtD-WQE9tn+7rSad84+mtA_cfkz+t42xqPdw@mail.gmail.com>
 <CAGZ79kZf8owJUkYF2SsCr_2q8hKxZW_Z3SbUQr6YMgNh8THfXQ@mail.gmail.com>
In-Reply-To: <CAGZ79kZf8owJUkYF2SsCr_2q8hKxZW_Z3SbUQr6YMgNh8THfXQ@mail.gmail.com>
From:   Tommi Vainikainen <tvainika@gmail.com>
Date:   Wed, 24 Oct 2018 08:32:56 +0300
Message-ID: <CAGshahmzPyC65g6dWSqucDckoxyv=uKQLuHR8aKRFdbSp3KaJQ@mail.gmail.com>
Subject: Re: git pull defaults for recursesubmodules
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ke 24. lokak. 2018 klo 0.57 Stefan Beller (sbeller@google.com) kirjoitti:
> On Tue, Oct 23, 2018 at 2:04 PM Tommi Vainikainen <tvainika@gmail.com> wrote:
> > I would expect that if git-config has fetch.recurseSubmodules set,
> > also git pull should use this setting, or at least similar option such
>
> This makes sense to me and the patch looks good to me.
> It is unclear to me if this is a regression or an oversight of
> of a6d7eb2c7a (pull: optionally rebase submodules (remote
> submodule changes only), 2017-06-23)

With my testing, no it was not regression at least from that commit.
It did not work as I expected before that commit.

What was unclear to me is why this config needs to be read as
pull calls fetch, why fetch does not use this configuration as is?
If fetch.prune=1, should git pull command also prune or not during
fetch? There does not seem to be test case for that behavior.

-- 
Tommi Vainikainen
