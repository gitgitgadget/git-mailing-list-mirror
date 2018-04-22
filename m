Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705A01F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbeDVXix (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:38:53 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32786 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeDVXiw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:38:52 -0400
Received: by mail-pg0-f49.google.com with SMTP id i194so7086228pgd.0
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6IIiyEQljE44ed4uO+3+Q1UXGtEpD9eT2kNoUXna4z4=;
        b=qk91QGO8PR0ioR1QUMqnw84PvQCvewV/aCM8PTT3G6MkZ7H2+yhNq2mKkvMZ0y80i8
         bWKImJbnchnngb/xupcviCa9zCD6aU2AuhtRXF3hFkHuBcI5wH8G4m725NxTW7BXdIjq
         iWj9mQOVX/EX6oZUrPinaKUq43fCdBMZsmzXxjr0eCjbyRXYYGaTcLfkZ4SBCOQp58ph
         5k4OdbgppFVb5zr/hqCQj0LwqIlo/qm9VKCxRu32afpPDRyxDRVLU5FdISpUolxa/O+K
         sFVLBT9213T6vrj8L05UaulfnNm/aYDh1wM9jmLjyLygMV40Ht4ZLdVvgPYB+O7yy6Xd
         nQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6IIiyEQljE44ed4uO+3+Q1UXGtEpD9eT2kNoUXna4z4=;
        b=WbmF0Ex3DClKWCJOB8c/rm8to1cHZefwJ2gH3ketTaCrf9tQipFhH3r0As7LcZ0gjO
         q107i0nOIfULSXD/AIZeAiBV4kfZO2Jh7lEbIuCQdZz/m5eur0vrpd3UWKVIkrdRsYvx
         h/Yj2Ms0UTruEZ29vQy7+VPC8h1zs4UfT+7fAzRKlO5T1phsZoXDwiFEPU0h/z2x6fnX
         Ul0KjYdfhCiGV+s1KEo8HlK1YJtUD+Lq35clZjkxhxpZYDm33DY6c85GjiS8WuyLZ8BB
         SYmH5kdKtfpF/6CpzEiRkPOA69EinBIWPhMkFKXbqSKHegLpSO3vp7BjGLsaSxDIM+9V
         SQgw==
X-Gm-Message-State: ALQs6tA5oWovjbajAmb7PQsHocXAcn3AmGLrhw6woOLep4X6XCQ4h24f
        AjcGouQQ/8PSdHhnuIeTNl26tA==
X-Google-Smtp-Source: AIpwx4+Twq+oqwucoBYqXMi74VAgnxHKqw1CVPK0spxwvl6LlrVPvISZ02Gse/rdqdUclG19xc7Xrw==
X-Received: by 10.99.158.85 with SMTP id r21mr15282586pgo.312.1524440330691;
        Sun, 22 Apr 2018 16:38:50 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id k63sm22887463pfj.12.2018.04.22.16.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 16:38:49 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Sun, 22 Apr 2018 16:38:48 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
Message-ID: <20180422233848.GA50345@syl.local>
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
 <20180422201755.GA92212@syl.local>
 <xmqqo9iaakaw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9iaakaw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 08:33:11AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I noticed that tb/config-default, however, only landed two commits:
> >
> >   - builtin/config: introduce `color` type specifier
> >   - config.c: introduce 'git_config_color' to parse ANSI colors
> >
> > but not:
> >
> >   - builtin/config: introduce `--default`
>
> Whenever something like this happens, especially the patch was
> original sent more than several days ago, it is helpful to give the
> message-id of what you are referring to to identify and retrieve it.
> More often than not, it wasn't explicitly rejected but was simply
> dropped, either by mistake or got delayed in delivery and got
> forgotten.
>
> Also for a pair of small series like these, when rerolling the
> preparatory series for the final round, it is helpful to also send
> the other series that depends on the preparatory one at the same
> time, even if the latter hasn't changed since the last time.
>
> Thanks.

Thanks, these are both helpful to know, and I will be sure to include
the relevant bits in the future.

For now, the Message-ID that I was referring to is:
20180410001826.GB67209@syl.local. [1]


Thanks,
Taylor

[1]: https://public-inbox.org/git/20180410001826.GB67209@syl.local/
