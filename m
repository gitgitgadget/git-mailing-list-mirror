Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1A41F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeCERmr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:42:47 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:41297 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeCERmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 12:42:46 -0500
Received: by mail-lf0-f50.google.com with SMTP id m69so24384854lfe.8
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=Hs0zlxHhzb/klztOqcWmPzy0MEpAclsEDEJZfkeXA10=;
        b=dq8dGgKHGBVrNHp7hiWq/GYGcFpB1JUi9kqCGHyz5TJp04UjZchS2sCTjyOt3HIEsx
         81eQufxODXObFRZ3zZzCW1gu/EeQ8dWdYeio764n2wgItEFnUyIrNKGfM49M0QnyEUaD
         +EpRvS0TXp/2JQpCm2u6i4F7SwYCKz7R/ZTnkYeeodpiwuvChYgtNRF9qF3T55NJ1grD
         20wJ3gVJ7O45V04SOsye19l2+5VLXSu8kuaib4Yuo0gk+qzAzL+tE9KtdzrnS7cUhgrD
         ic2DCg6IxrJabJvrsvD19USP3dF+hmgoAFdrEj2AxMzc3ZasQezeIlr5wzO6uU19+1D4
         KT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=Hs0zlxHhzb/klztOqcWmPzy0MEpAclsEDEJZfkeXA10=;
        b=dAHHGkaqr+Y3C9QO+GH2QY3+KEbEZDKoos9sMExFqQcDyNOVlt8NTVyTuUYoy84Gts
         zzFxuhgnC0KnZXue+i4YG1w1eRm9LsTFRT8/nRxiAuie7oSVjCykPqfV5fOtH5WdawUD
         6aWwez3JFihcehXKGegm1fjetJdVcq6EDo7AzzfTIFzabJfh1B/0BYT9DvRDTQ+8E0SE
         0LMU4qZb3WEwl0txs7YUJod7uITt9WksOM+TNwGFhtAZzW0dSrczapuvxZWV05R/aVrR
         JREYJbYR9os0IOmeYkVe3R86Q8sGYsgDHjkzZo9gJ8yI2eQ+x5GbeycOk2Xm6vD9fpoo
         qbZw==
X-Gm-Message-State: AElRT7Ft3yNz+FTWoY1iYNm2NL6+JKa1bi8nQtP4HmwFyU7PJFwzUS43
        dIRr+8d27fOdajiDuLVVmpg3mCkp4Apu/3CQ21w=
X-Google-Smtp-Source: AG47ELu/FP+YsAng7Kna9FSptd5LL8qBt3lQPHyhvaRpckhhFPRazT7woDQlWSAvoLHFb+ZGcugSaE5zR+s6xNdIsps=
X-Received: by 10.25.34.81 with SMTP id i78mr10161227lfi.50.1520271764864;
 Mon, 05 Mar 2018 09:42:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.80.67 with HTTP; Mon, 5 Mar 2018 09:42:44 -0800 (PST)
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
Date:   Mon, 5 Mar 2018 18:42:44 +0100
X-Google-Sender-Auth: zmRiF5wVM8p9N1bawZn4WKPxEOs
Message-ID: <CAGr--=+77Ny31TkWp3zE6MYBxAo1zwZsqxmzbXb_8RU86NcPPw@mail.gmail.com>
Subject: Re: [FEATURE] git-gui: Staging path(s) should re-select a new path in
 "Unstaged Changes"
To:     Birger Skogeng Pedersen <birgersp@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My apologies.

Seems there was some error causing this, I see now that paths are
automatically re-selected by default. Can't reproduce the error.

Please disregard this thread.


Birger
