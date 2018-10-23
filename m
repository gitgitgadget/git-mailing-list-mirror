Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1018D1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 04:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeJWMYo (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:24:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45493 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeJWMYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:24:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so4097620qtj.12
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 21:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArBsTAGdFQOBhkclymTnMPakbZylao8cJ3TM7YET2wA=;
        b=k6lOW8lBtAQTZei/fUyCy3uvsdive7tQSSmTIuOiU6s9IMROhhuLZ67Gw2cuoOxjap
         mvPTop5TS+O78yZSOqZS8JQXIRHRT9v+Bb7jC0wXVZlsvdXwy8oJ3IiFvP14jyXj3t8O
         Ck52V591S4BPD5OD1uLMYNBW6EgjHlBE/HjNvIYawySRUoRVz8YGPyb+VXB7eBIkYFk6
         MNIWmV5s17v9GY3gwICxsEBJpb+esK7mOOhIPUY+Fsgqvj9td2K0eoadPJGGcAIHGRBd
         knpXHzA7L/mq96kSGMajMTM7V1HCSOXWJVCWxJBT7lYdeZBh/ZSbUgyYUqcvZHug6xJE
         urWA==
X-Gm-Message-State: ABuFfojscEzwcTe79e4mdhlDgEQPosqQ0fAST8hv6HVq7evXqBxPIdPx
        kJYuEontLIN7DBxWJbIRdolc+V4gBepryQXwa6A=
X-Google-Smtp-Source: ACcGV60bLpx50Fs/FJMkI6YBll8uQtkxO7Fw1QHFQUz88NCVTQEpsPyfPPct+Tnvv7V/XuNYnn7M97YYgfvkVj5EcR4=
X-Received: by 2002:ac8:73c5:: with SMTP id v5-v6mr40796693qtp.352.1540267392711;
 Mon, 22 Oct 2018 21:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com> <20181023035341.15398-3-ischis2@cox.net>
In-Reply-To: <20181023035341.15398-3-ischis2@cox.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Oct 2018 00:03:00 -0400
Message-ID: <CAPig+cThnimYhojPQ37U8tb2EyRa-izMe-4PAvzE5MmTms6ixw@mail.gmail.com>
Subject: Re: [PATCH 2/5] t7509: cleanup description and filename
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 11:53 PM Stephen P. Smith <ischis2@cox.net> wrote:>
> Rename test and update the test description to explicitly state that
> included tests all relate to commit authorship. The t7509-commit.sh
> file was not rnemamed when other scripts were updated in compliance

s/rnemamed/renamed/

> with the test naming convention.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
