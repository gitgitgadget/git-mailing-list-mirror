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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A65E1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 19:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeDNTrR (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 15:47:17 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:43277 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeDNTrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 15:47:16 -0400
Received: by mail-wr0-f176.google.com with SMTP id y7so15918322wrh.10
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=06mE/XAQ/Jo2YTNITtomRVlvkHFOCERluTzbMW0Us+c=;
        b=rBAC4+AGU1gASXQOi1ZvFucFav+8LmVnpda0/6TBcGSSIAZVSV/YB5DfP1gwUuHf4H
         w99Ay+fUhdY/p+LAHn5oab4A84EcBHyF/4pe4y5kBOE1LC6uu/kcj6EA9drZYG/EIS0t
         9VPFAefFcdzG1jZ2ujch6LeId4SIICPRTa5ObzFQKPGO+KrbducaioB4bR90dZOefQfj
         SpwvcCdJhLkXvmuadOCaw4VaYgWKNSMVuhPeTIAIgzEdsvQ4R9Ji/11+xfaOxHpaIJ+q
         bo0k6mmSkoBAagS075y7nml/vWI9gWPBS63MoQGHKRttELbgBiHHIzBF3es63SoxJ/lj
         CPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=06mE/XAQ/Jo2YTNITtomRVlvkHFOCERluTzbMW0Us+c=;
        b=eUjuIXkSb6dGX3iIN5Qv1c5Xdky/Derq0iKsTaAgfs8GmrY/uhp86n3HQ3X1m8J2U3
         txnQ4ddl2whjUWssxkiCaaq5/OWw6EMzrXk88fNi5TKD31GPakHanspSnNNWgmuEMSFf
         Ey5pJmx9y3rx69bvtjkHKloGwOpJdIITaESf3cnAtE0xznVBZ8/F4IZqCWxY8fLFZyU3
         +2LTnU2AS/an0SahvI08gNQN890irYj2R7fCbADoVIuvD/OrLAcK2DjvBKSMQGm22MtH
         DKamtfaTGPMAaa7yjZylE54/WSwZvsvqUGBl8b/A0WVLnCOYEVea5ACme9oRvzwCK23H
         oZwg==
X-Gm-Message-State: ALQs6tCUhomh60yN9ozmhD6OMESj+BApFgsdvEE/rd2Wg5Ds5HN4IeIR
        uVIpkmwy4rsIeJZGoxorBiNkVcYF
X-Google-Smtp-Source: AIpwx4/mS/00QBfMeFiwfnpkxrMQsZIgf8Ygl/OIo1V0cD4+Eyq7Dr/g5o/4kJTGLQr41iIYlhpehw==
X-Received: by 10.223.178.245 with SMTP id g108mr3562551wrd.147.1523735234875;
        Sat, 14 Apr 2018 12:47:14 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y191sm6649848wme.14.2018.04.14.12.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Apr 2018 12:47:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] nd/repack-keep-pack update
References: <20180414152642.4666-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180414152642.4666-1-pclouds@gmail.com>
Date:   Sat, 14 Apr 2018 21:47:12 +0200
Message-ID: <878t9pfu4f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 14 2018, Nguyễn Thái Ngọc Duy wrote:

> This is basically a resend from the last round but rebased on
> 'master'. The old base results in some conflicts with packfile and oid
> conversion series. This one should reduce merge conflicts on 'pu' to
> trivial ones.

Thanks. I've been running this at work and as noted in
https://public-inbox.org/git/87vadpxv27.fsf@evledraar.gmail.com/ it's
had big performance impact to the better, users even started noticing it
(they'd previously get noticeable slowdowns while doing other task on
GC).

I also tried to see just how much worse this was making performance, my
hunch was that the difference should be trivial but noticeable since
we'll produce a less efficient pack.

What I found was the opposite, under real-world conditions it seems to
be making things 1-2% better on common git operations, which I suspect
is because once we've done a few pulls and coalesced those into their
own pack(s) there's more cache locality for the data we're actually
looking at.

I.e. once you've got a repo has a big pack you're not touching, and a
few weeks of updates from upstream that you've coalesced into another
pack there's a higher density of stuff you care about near HEAD per FS
page in the recent smaller pack, which if you're pressed for memory and
parts of your pack are getting paged out of the FS cache is a win. I
haven't confirmed that, it's just a hypothesis.

The only (trivial) issue I found in the patches themselves was that
between 4/5 and 5/7 you're adding an empty line to config.txt in 4/7
just to erase it in 5/7, better not to add it to begin with, but
hopefully Junio can fix that up (if he cares).
