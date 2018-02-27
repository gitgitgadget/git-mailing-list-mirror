Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9051F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeB0Wfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:35:31 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50837 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeB0Wfa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:35:30 -0500
Received: by mail-wm0-f50.google.com with SMTP id w128so1532703wmw.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 14:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=inrJwhSsW58pXWaMOr190zBQ8QyUID55L7aqHmlYe8c=;
        b=K17Li9hFHzM1yat+JNpHGsYkjq+1ATPlH+Pa25NaV12SGlOOoP1Nyh3ix8Vuo2Z1TW
         FvgBI1iZ+p2U8ituwXV9k6wPgT22DRtOkwpvvBMXKBu02eKZ0NnIy1POUKpnVy3dmEIN
         laQ0Rf+dcqb8WdPRV5HYMgDMyyX+7sOgrxD9kMT//b5vm/omgGE4csP1v+9B5fb9HXW0
         SwwzoHPwxbB+yEQbw+J5BjTEouEfRBVFUcEWHFjaaCTbpkmSMeD+Dz9EbdK9blY9pJRk
         pbCzfZHPK/V+1CWyah4NRs0R38cZt0nGYeAk8RecMGZqUZ+332yHpNAAuEnq/dwmfmGe
         nI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=inrJwhSsW58pXWaMOr190zBQ8QyUID55L7aqHmlYe8c=;
        b=bVanHECSaf041vTNefs/F0CfjVuMg6FSNkb4e71HlvSBd9TP/hVm61+mCp/ZYzL1Hb
         VXHLDfgbyknpQhsQGK8o+09I3gfX9odpiOYHTUc24eVxWTfioa1DmuD/HtiVZEuV8Rck
         bfpH1ioxNZyNKv/lX6p+K8HYt0/v+xjup31WFbT4ayHQW7AAxWg3FSr1l89Kb7sekUdB
         LxegfxOnWMWH2z47nOmfnee7+m9qzxEye7TlmefzuihoTIldroaiNRQnu7qGkGhpX+bZ
         CQxDeBiNB15S2qNiKjECuQ1Oly2eovga2mEZg3FU7t38YZLVV5OsNsLSx2hFSbsw+9Pf
         0oKg==
X-Gm-Message-State: APf1xPBeY6ZEr9yFEzqRglVVM+ppMiMUWudbBUDWhqGgkguX/tJ2YTEK
        zT85SduXcX0op5L5dL+eIfY=
X-Google-Smtp-Source: AG47ELu5rrpkLSpJYMtBIDXGbsHgflkWvJWerML0NsR62XnuFj8TKidap5Yj2VvyNW/XRKC7Wms7hA==
X-Received: by 10.28.11.70 with SMTP id 67mr11414497wml.158.1519770928418;
        Tue, 27 Feb 2018 14:35:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y8sm551102wmb.48.2018.02.27.14.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 14:35:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/9] t3701: indent here documents
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180227110404.16816-1-phillip.wood@talktalk.net>
        <20180227110404.16816-3-phillip.wood@talktalk.net>
Date:   Tue, 27 Feb 2018 14:35:27 -0800
In-Reply-To: <20180227110404.16816-3-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Tue, 27 Feb 2018 11:03:57 +0000")
Message-ID: <xmqqo9kanjrk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Indent here documents in line with the current style for tests.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

This loses the hand-edit-while-queuing done based on Eric's comment
for the previous round (see what has been queued on 'pu' for quite a
while), which is not very much appreciated.

Also you lost the title fix done while queuing on 6/9 (see 'pu').
