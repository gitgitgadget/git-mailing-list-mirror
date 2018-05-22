Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68E21F51C
	for <e@80x24.org>; Tue, 22 May 2018 12:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEVMNW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 08:13:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36053 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeEVMNR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 08:13:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id n10-v6so32807034wmc.1
        for <git@vger.kernel.org>; Tue, 22 May 2018 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=H7dSSLRYPPClUHp0s1Y94eGwGK/Y27i0XdGMfiF2E3g=;
        b=VL7ZLQBn2dw3Aw0s7phrHKjH1YzccOMCiKr2ucugHeQug6wt3yGhDRE7PY3VHSz50y
         LpXmCtFss+x4ALu7r5qPUHggO2CbynYyVDfzaZNYKFNLKAcobalOOLpQ/vHp3oRaKkJo
         2Bg4nMSbKcglqdw7gwh+/gfc1VCKZmknEUt8kZD4xLKY/K5Uoss9LhgC1EFSJ0KLKRmp
         ydQp5Yb33D+ue6gE6ZTXYbuCi7ZzTE1176x6ATq17vHq9+oYDneyrDJrAs2vo5IjpZOc
         u10Z17/H6lpmJeIfnoT25JX6GqNef3a51bwRErJBXn1r/AgpsC/1QEqEumefRfsut/I8
         UycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=H7dSSLRYPPClUHp0s1Y94eGwGK/Y27i0XdGMfiF2E3g=;
        b=SP5g7XLRSPK4qeN+aJCDVx5872n7yNQ/xOBK3rE7+ZGVb35YfxQxbdh+djYSuA/0x6
         CXKHJtBD5IS5A0A6vsxmlLVZRH7jcYla8L0Gw44wqgxtTS69cz0T34z3oDnzu1D0Y/dZ
         NON2ZXpkuuUtnypPlx+O/vXApqWnMP9pqmgdMSMDvc+ak8BnAv7wXzsTzyx65+TDWaLZ
         lShtwSKQnC59ucq8zeWILJzV3R5G2gYe2oAMqfFhNhOkh7Z55OtVn68td58Sx3Df0E5Y
         LMB/u/JtK0Q8RZTq1moO74fW83WIcQ6iIBQcN73kFYEo95YbaiLRSgtHqShGnGGxQsrk
         eYfA==
X-Gm-Message-State: ALKqPweuhhrofH/wF+0rj4IWBCuHix1yXT3xyFuEuLF44RRNDtmuMZqR
        4plzD8inoJeDymK4R7XNwYFa6+5x
X-Google-Smtp-Source: AB8JxZpPhw96bXxOKhZpCK5CvYdZUrfG6KwN1t+mAtwe07VkDL2qeBwB9sc/sZLdCWozpbRimggTVA==
X-Received: by 2002:a1c:5715:: with SMTP id l21-v6mr1093408wmb.54.1526991196422;
        Tue, 22 May 2018 05:13:16 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id m123-v6sm13942264wma.1.2018.05.22.05.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 05:13:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: should config options be treated as case-sensitive?
References: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain>
Date:   Tue, 22 May 2018 14:13:13 +0200
Message-ID: <87h8mz99d2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 22 2018, Robert P. J. Day wrote:

>   in my wanderings, more oddities, such as this:
>
> $ grep -ir blankboundary *
> builtin/blame.c:	if (!strcmp(var, "blame.blankboundary")) {
> Documentation/config.txt:blame.blankBoundary::
> Documentation/blame-options.txt:	be controlled via the `blame.blankboundary` config option.
> Documentation/RelNotes/2.15.1.txt: * Description of blame.{showroot,blankboundary,showemail,date}
> Documentation/RelNotes/2.16.0.txt: * Description of blame.{showroot,blankboundary,showemail,date}
> $
>
> where you can see the single instance of "blankBoundary" in
> Doc/config.txt (with the upper case 'B'), while the rest have no such
> thing.
>
>   for fun, i checked another of blame's config settings, with similar
> results:
>
> builtin/blame.c:	if (!strcmp(var, "blame.showemail")) {
> Documentation/config.txt:blame.showEmail::
> Documentation/RelNotes/2.15.1.txt: * Description of blame.{showroot,blankboundary,showemail,date}
> Documentation/RelNotes/2.5.0.txt: * "git blame" learned blame.showEmail configuration variable.
> Documentation/RelNotes/2.16.0.txt: * Description of blame.{showroot,blankboundary,showemail,date}
> Documentation/git-blame.txt:	This can also be controlled via the `blame.showEmail` config
> t/t8002-blame.sh:test_expect_success 'setup showEmail tests' '
> t/t8002-blame.sh:test_expect_success 'blame with showemail options' '
> t/t8002-blame.sh:test_expect_success 'blame with showEmail config false' '
> t/t8002-blame.sh:	git config blame.showEmail false &&
> t/t8002-blame.sh:test_expect_success 'blame with showEmail config true' '
> t/t8002-blame.sh:	git config blame.showEmail true &&
>
>   thoughts?
>
> rday
>
> p.s. i am not *trying* to be annoyingly pedantic, i am merely
> succeeding.

The issues you note about the docs using foo.barbaz instead of
foo.barBaz should be fixed, but as noted in the "Syntax" section of
"git-config" we already document that the config keys are all
case-insensitive. We just like talking about them as foo.barBaz because
it makes for easier reading.
