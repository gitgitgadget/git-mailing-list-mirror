Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3211F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbeGWW2c (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:28:32 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39119 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbeGWW2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:28:32 -0400
Received: by mail-yb0-f196.google.com with SMTP id k124-v6so837566ybk.6
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 14:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+goZjgGHJpDcN+Bi0lnN3CnoevWKT1+qTojq53MQpQ=;
        b=TrFnXdtOdADPdm9YdPi3AaVsGWPZWCImaDnMNfgyupnHnBuhUj37gu41dCbUojIsoA
         Sv5tnkHUlrQ/+LZeDFuDyCSQ0CWRFjDBu+cxGpQom299HHBe9t8EG5flIRfNWHcjylPy
         ixSSLBgqRYrnneZQ2r6oAI4iEKsMeZpGLFop0wRSDl4cIqrEJPZxOPJXeksmUMZHzyW5
         EcJOTwGL2pJLSpflQwO5g4fMxlmujil5AGat6CqqlmfWbffpGfjqyuNcp0u/d0elIrjG
         WPB82cO3BS0p48ixFxLOX4dzFRB8YiOkCDFZESRsWs4r2KcmxSO289MHFcmdT2FF1mmo
         NcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+goZjgGHJpDcN+Bi0lnN3CnoevWKT1+qTojq53MQpQ=;
        b=KSoLP4z5DrqUcrQfAQuAzTyqW2oizoGzCxnZaMxcDPEj5HSusx3Vw4u0vcOkBtJqua
         JvyQxTuRMPCMXcBmZKzI1JAlzl97dtP2LXvNGdPABFHxvH22EKu9FhRnovNdAjHZqt8c
         oD7gjdQqJHD62QxBdHdqE//wqnkjfsGJkEG1NTdBLoHARhHh/3NpNT9ajknNfJAM9jyK
         VzA9GyAZEPm7Qn7+MvPF7tN/UCELSxdAoqQ5cem0YODYcwFUTVYA23yxcBQMGPILWmjc
         3+h0PH66P3P2muqe8ZDkpObFAoRkymHHDwCk6aUmNyz+GBBuabYXUIb7n5YRWB3MVGZq
         3mTg==
X-Gm-Message-State: AOUpUlFDYs+I6cdQ95gv1FsOVs5qPvbPV//61hUYazRSDIfikXv/WRny
        clD18uVgvasKcS6ETRU0upF96x6wKGKMWMZiO2YpTQ==
X-Google-Smtp-Source: AAOMgpdONaaDYuQAz47rpG4UHGgPtWxu2pBlm6YBd9AwlAolbe7O8qNHXQ2bJQL21mSoYAJ8Y8b8u7l3hdcUsFMpUF8=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr6863387ybb.292.1532381125961;
 Mon, 23 Jul 2018 14:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 14:25:14 -0700
Message-ID: <CAGZ79kbebFenJYTvReZV+TuehUfTWDYx0gr+ZnTdw00BBUKm-Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/21] range-diff: add tests
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'simple B...C (unmodified)' '
> +       git range-diff --no-color

I wonder if we want to have tests for colors, too, eventually.
(Feel free to push back on it or put it into the left over hashtag.
But given how much time we (or I) spent discussing colors,
this would be a welcome extension for the tests)

Stefan
