Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559CA201B0
	for <e@80x24.org>; Fri, 12 May 2017 23:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdELXoT (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 19:44:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33700 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdELXoS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 19:44:18 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so9256114pgc.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 16:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kmij/Rtf+jvRLR0/Q2AvnAbvm5p7OeNfui22nQamnqE=;
        b=sb00w5NxAquLrvT/F2xvDaokmTSLZWzwtsftrSmcObrP+WHOQzLAgCe0Gg4d9aHyx0
         quWsHMbs43CeZgYKu5vKR4m38roKirpqWKJXJ3SKCe8tVT5Uql8YzJgfpOCQ8ILTFuEv
         0Oh/dXRsaUMIGCNl8lVFC8U9+Zbf0POvnbB0a3bf/21n2luxxUcvsPbVaBY9X4PTSrSC
         pI54ZCPAYyfhy4B3qHggnxuZPesUqM/1XADaA5VM1NT/flQyJwVj2f6mHDHzcI8L4+E5
         1O0ZX5M4cLJJLWiNyUzRV/TFGPrydyTbrfN+afgxF2h5+V9+uLHdPf2OjHrJxKE8u53X
         T1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kmij/Rtf+jvRLR0/Q2AvnAbvm5p7OeNfui22nQamnqE=;
        b=LwTKhnnoyfwfJpa7o7wzLzxN9DEpgOtSs4WQzBtZ3G4sCPuIr8e2xJPEMa4WcP/aw+
         5AASwB52CH8Z7Cye3zMpI8nDoVoR/kxL+uxzKzZJqtRwQf5FFT/TlXszEP8quB/pTi4H
         OWeaxZ3SCU0lyWzlHt9HYwJToiwy1tAimrXkE0DnkS7zAkkJQ1oCdilvnTw84ASohsFB
         gbX9Fo8FlcwHDiXw/ra/b1QCbr6WvO8AypJeDtXPFjxg7WsiuztJWezxbv/LLujXq1g7
         wcE5oD99o8pqC+7hKpwiBt9S+QtanSB4iKeFypYGOBNdh1usXouY0P+feHCWNhoq+oQS
         ttSA==
X-Gm-Message-State: AODbwcBDv8peUQNby/1qXxb2wGcYpzPUJeCk1PMsErOwqZcPHDFwwQ1C
        DB9HZ7YO3Hb53w==
X-Received: by 10.84.237.8 with SMTP id s8mr9047313plk.163.1494632657327;
        Fri, 12 May 2017 16:44:17 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:fcb1:2bc1:55ad:11f1])
        by smtp.gmail.com with ESMTPSA id m125sm7874872pfc.3.2017.05.12.16.44.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 16:44:16 -0700 (PDT)
Date:   Fri, 12 May 2017 16:44:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style
 options & config
Message-ID: <20170512234414.GF27400@aiede.svl.corp.google.com>
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> On Windows, `(1|2)` is not a valid file name, and therefore the tag
> cannot be created as expected by the new test.
>
> So simply skip this test on Windows.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I wouldn't be surprised if there are filesystems used places other
than MINGW that also can't handle this test.  Isn't this what some
tests use a FUNNYNAMES prerequisite for?

In this example, it's the pipe that's not allowed, not the
parenthesis, right?  (At least I have some memories of naming files
with some parentheses.)  Would something like

	test PIPE_IN_FILENAME '
		>"a|b" &&
		test -f "a|b"
	'

work?

Thanks,
Jonathan
