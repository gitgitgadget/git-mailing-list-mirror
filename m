Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C43C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 04:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1C260FF3
	for <git@archiver.kernel.org>; Mon,  3 May 2021 04:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhECEWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 00:22:32 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:37887 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhECEWc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 00:22:32 -0400
Received: by mail-ej1-f50.google.com with SMTP id w3so5879766ejc.4
        for <git@vger.kernel.org>; Sun, 02 May 2021 21:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SuuB3PPS1pwu9JiY2JwwyH9ZCFr7YLf6izAJ10xXF2c=;
        b=BBHG5BKAf2q1wISd4WiK86sOLRiOK36ljgnwYDUnIA7ZWqIyPuzCHsq5hwzTPoc9AN
         o7XlE8nIBkvNsWNPN0zmlPAf5XK7xwX5m62SjuiIxWpkV2iKvQMDjksCeka/rMFL9gnB
         sPSrr7Op4PoXI1yXvLMLNIOqtA+Xgx3qTdGP1mybSWt7Ova5kq8C5ZPQF/l/8AxDe3NF
         WA4iHfOkeRpRT/tpiX4T28n4gpPXcERg8rBtiEdAcHTIniGATjZUfhpPRmBUB8bICe5O
         2l/8QtVOatiMWCWhYUxcgXAYj9icuUxnLwal+DOFuhec/95NEmkVHf8q32ubuT6cOBFj
         4lZA==
X-Gm-Message-State: AOAM530rYdnMK/U4urRVk2flzo6kjTHUL7xSxq9SfnhJlxtqidKa6XsV
        /rCRhfW3JLuL6TXt29VQTsIwWkbSbpAWcToUvto=
X-Google-Smtp-Source: ABdhPJypl0ut81G8p5AMeTXKEFAuHGCTb2cQ68zXanw7sxFxnST5ZtPwA7uN7rQEiprjHXSKxHf/78MlpCzhMJlIH18=
X-Received: by 2002:a17:906:3115:: with SMTP id 21mr7939764ejx.482.1620015698998;
 Sun, 02 May 2021 21:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqfsz4a23x.fsf@gitster.g>
In-Reply-To: <xmqqfsz4a23x.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 May 2021 00:21:28 -0400
Message-ID: <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: explicitly allow "local" for test scripts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 3, 2021 at 12:11 AM Junio C Hamano <gitster@pobox.com> wrote:
> 01d3a526 (t0000: check whether the shell supports the "local"
> keyword, 2017-10-26) raised a test balloon to see if those who build
> and test Git use a platform without a shell that lacks support for
> the "local" keyword. [...]

Double negative whammy. Should be either:

    use a platform with a shell that lacks support

or:

    use a platform without a shell supporting "local"

Or I'm confused and misunderstanding what was written.
