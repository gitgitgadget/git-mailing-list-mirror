Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C091F731
	for <e@80x24.org>; Tue,  6 Aug 2019 04:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfHFEwk (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 00:52:40 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:42876 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFEwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 00:52:40 -0400
Received: by mail-lf1-f41.google.com with SMTP id s19so59882474lfb.9
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+l5sFDOOlxsNTZODUD8gyUJb74oS/kvma1IsctA0KBQ=;
        b=A62sphZIIq6Z8cgQtNmprpfFkfTY9OrUY1mHJskYyJwUc3VH3snUigOk7j0qmZ8AUS
         PcHmKWeTX+eTJJH+YsoUus5VFUqGUEevLRn9O1ekOkfRZ/rDE14iGIRS9XGB82hqTD4C
         vxxMH+3hXRDH3sJ6jLbI/sqQnnpBXAnizkMCBqVlVUYmci97tHR7hpU77Q3CfpYvjI1Q
         c7qep5fXFb1bX7O77iN7nQmd5pOpd4ne6LpSAy1vrGXKTf7UfcBvEYgZ7njX840ixpDI
         P0pwOQOwqdFVnSWXc3KRJhuiPhF3xB4jOryesI2/74ioVxlDBzwABkl/aJcMTLTCUn5g
         Etpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+l5sFDOOlxsNTZODUD8gyUJb74oS/kvma1IsctA0KBQ=;
        b=Q/jNGiu/JoViLGMbWZNiO1DjOWH75nzsPTxirMPxsg1wku+9eTvcuczWf0N0gUB681
         VISnsNK+MBIW0b88JgvKKkw2HbKnS3SunmstkMtQ4mupZXyrB/5syLn35EvkMw8B862H
         rexn3nFYJFg7vHHdFqZUyg2pvJSveQXQNxH5CfZGvggTcX5Kcl2U2uyNwJqC1Myz85Ig
         KkekS47XO0H2K2plGyUYa9NWeoqCpQoCZkJs1qsB7Kgyyf1YkttXAV2vbbGqVFHnZ1sO
         VlEpMfM6kZDUwVHEc5esB5xQh9ncFFrDADI+NEyUWBobRRFuh2HnLaWnawL7c7KZDeuH
         bi4g==
X-Gm-Message-State: APjAAAUxg/9/VIm4SW46ChqHKUsK4MN9JikkOaTx80DF3iOGDXNqz7Wh
        QbGjzxh61mkGiZbBwlFLItUpbNvm5sOD4Qjt/J27Rr/p
X-Google-Smtp-Source: APXvYqxxZxVNZcmaPPLfuMOU0ObubOTwscNWCbQ+j5SXI6UQ1NhiMqC99TFGNRtgetg12WPhAL+TiMwNTIAmxGsGUtQ=
X-Received: by 2002:a19:c20b:: with SMTP id l11mr920359lfc.106.1565067158268;
 Mon, 05 Aug 2019 21:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190806014935.GA26909@google.com>
In-Reply-To: <20190806014935.GA26909@google.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Tue, 6 Aug 2019 14:52:02 +1000
Message-ID: <CAH5451=Qa5BGnoRdvtcmT6mXXK+i8iD7WAkKFfNU4b6J-0bX9g@mail.gmail.com>
Subject: Re: RFC - Git Developer Blog
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 6 Aug 2019 at 11:51, Emily Shaffer <emilyshaffer@google.com> wrote:

> Are folks interested in writing and reviewing this kind of content?

The idea sounds great, and I would be happy to review content - even
if it's only for readability and spelling!

In terms of collaborating, I've found the processes over at Git Rev
News[0] straightforward and sensible, if you're looking for ideas.

Regards,

Andrew Ardill

[0] https://git.github.io/rev_news/rev_news/
