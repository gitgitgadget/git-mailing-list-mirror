Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3A1C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 22:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91D82223F
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 22:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgJNWea (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 18:34:30 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45212 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJNWea (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 18:34:30 -0400
Received: by mail-ej1-f67.google.com with SMTP id dt13so738224ejb.12
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11NWabKun++KgCv6LiIIuPf65u6EaBHBVTwC8JNnGA0=;
        b=V7egqfaq7sHdXVhcx6NjJx9mkl7pU/XJXNWKGuxOWYqw4dDtGMqaEtRokZG+cU+I6g
         Si0XpG3Gd00BLSqNYm7uhk6+3jseApNfY9QbLjPuzhWSHUc7CtsBRKmedbWqWOdoUsy8
         3uzDBWq2IXS2vwjY8Vfi9t3/uObGIw2iE/YENwd64sgkUJRVQUylDFh05iwL7y6uTlW1
         vfUnx5IA2rkPomsoDGBN6lCI60bStAQBRsPvOOQHnA4ZeLmYECSZQ+xXoeXH2Xs79urv
         1inPIsaaTxBEGUTPLrZT5srVhEp6RYxDK6aV+vmy99B63WPD87SBcDYgHLzuw6HXE0Qm
         +y3w==
X-Gm-Message-State: AOAM531jQRQT1wjTi9GfziOF1CqIBHB1tbktM1xxyWbzU00TWD7CfRX0
        BuFLhrvw4MacxesDS81AY7HHrP9BVI28ObFkYYMKgefO
X-Google-Smtp-Source: ABdhPJzV7ad/vDkPaJuM+s08PHpRiWnnu6ecA4ZU6H2//GosX+Aj7miQ0VjdWJ8RaNJ+D7u2T4LwFRfhX0nyUiLrvQs=
X-Received: by 2002:a17:906:5f96:: with SMTP id a22mr1351414eju.168.1602714869034;
 Wed, 14 Oct 2020 15:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201014145506.45449-1-stefan@haller-berlin.de>
In-Reply-To: <20201014145506.45449-1-stefan@haller-berlin.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Oct 2020 18:34:18 -0400
Message-ID: <CAPig+cSRX+5o645fxBZunm4hiBM-1Gr8jChijyUNgNkO1wHKdA@mail.gmail.com>
Subject: Re: [PATCH] gitk: Add options --select-file and --select-line
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     Paul Mackerras <paulus@ozlabs.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 10:55 AM Stefan Haller <stefan@haller-berlin.de> wrote:
> These can be used in combination with --select-commit to jump to a given
> line in a patch on startup. (They don't have any effect when
> --select-commit is not used.)
> [...]
> ---

Missing sign-off.
