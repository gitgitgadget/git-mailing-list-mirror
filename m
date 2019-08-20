Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC6D1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 02:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfHTCrO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 22:47:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33182 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfHTCrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 22:47:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so10697422wrr.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 19:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dEHi3ukC6tvU4gY9I41bA/SKjm1ebv/tS7cNuQPEpk=;
        b=ZNKxD+kPqVXlHGlBY1xGclfWdxRFZHifboxsk3uIK4ctf3rARlKHEM9xOuxi0ooobX
         T3W+uub2L5WXJL4QRzc9CIi0ay/yCyr1iS5bxLqw4IhYGPg9lbs1OtlyguX1HaQsUOb5
         Wuf6kwS5m3k/NKhJ/xVcYl6N9EXDV4dFnTpQOaLpt65ihMvxBjWVQHB+CtHYccXF57rq
         AmrcRBLF2FitorzSJdgqAy6S72NshaISXtsncAq05qOgrzAiu+NPO0rGB1RPiO0DZhQy
         ou4OWjIdjtiz5wzoZ87WoMr1xRHIH899pDdAtACkQDClN6ZtYhRxHDiJvrl6ilvMNYCV
         nTgA==
X-Gm-Message-State: APjAAAWIZkbwrwCWE+KezTXQoMqSSyP9z5FV7TaTViq3f8CzLr8uRp4r
        yoMuX7UAwTgG5jCGzZTbBlyUNp1BbXQwvcPhg3A=
X-Google-Smtp-Source: APXvYqyHTecdFcEv+P8y4PyIaYDxMz9aScyfDBjLuY+/cF62whbzF+IjcqxDBCukKI+POVZ/R4CnpZFTudSFtQs+MRU=
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr29628477wrs.10.1566269232045;
 Mon, 19 Aug 2019 19:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566258525.git.liu.denton@gmail.com> <94a778c9aa561c8cbe5ef39e21695db3124611b4.1566258525.git.liu.denton@gmail.com>
In-Reply-To: <94a778c9aa561c8cbe5ef39e21695db3124611b4.1566258525.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Aug 2019 22:47:01 -0400
Message-ID: <CAPig+cTA-YzPkDP+pTpZQkwj0UeCuci8aCuXZW_xrS7-CH7Rng@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] config/format.txt: make clear the default value of format.coverLetter
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 7:53 PM Denton Liu <liu.denton@gmail.com> wrote:
> diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> @@ -74,7 +74,8 @@ format.signOff::
>  format.coverLetter::
> -       A boolean that controls whether to generate a cover-letter when
> +       A boolean which lets you enable the `--cover-letter` option by
> +       default when
>         format-patch is invoked, but in addition can be set to "auto", to
>         generate a cover-letter only when there's more than one patch.

Rather than rewriting like this, I think it's more common in Git
documentation to mention the default as the last sentence in the
paragraph. For instance:

    ... when there's more than one patch. Default is true.
