Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A4A1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 20:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDDUVS (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 16:21:18 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:55795 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeDDUVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 16:21:17 -0400
Received: by mail-wm0-f50.google.com with SMTP id b127so383399wmf.5
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KLMdaej4OmR8vxDBUar2QfBRHfREVtnZrlBe3pCYvo0=;
        b=CxNXumhA3mQMILJncncqSCa0LlKyU87lOGvmKcosciuDYKPPCZI5XM7VKVbtfugLB+
         dp8gDWYJhHDGC95EawL2s/cvc18UPClGLFOOQsYuIwdG6/WoT9Du2DRjeuFcTbrGkYiK
         FIhl9ny22tlcOPAmNlr6mnAG395lH1oNElCQITh6K4q2Rd4AFmfVHc/vqoC3JuPBxVfv
         6dxUfVRADU24bseQ5j57fz6H/y39ujxUq6LU3hZxnARM5q89Bx0LGwXQq7qUSCGVNdfT
         BpOxEB3HfieetjH73hb6wLW+VqiDjqPyxnne1Kap84F0JWlJK1j2Gnbyr3okUqj33Gpb
         Cmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KLMdaej4OmR8vxDBUar2QfBRHfREVtnZrlBe3pCYvo0=;
        b=Vlpt688AocZ1+NYRoTTl1sDS6tbWoeaiOzoGWYTAAKF6S66BNt3CBkPvw5vCInLuxc
         sWG1aFN8H/2GGZ5VZPprlwjzNEUrtTTZwxU2jaRo18Q6BPWX2MEb2LCLpm13/y1oKWfR
         XIFdrWqT7vuTbGMpqThVlG3RhRCe8wJOMpM8G5aGfZHv5DYH/N2lygXUOXeXbOzFMW8d
         1NvfZJCL02LVOEkoToAx653jcl7FkKPsxC3x4iEQiH4UalbMsTzQ6SovbP45vrdabzDD
         NxlqUWQpe0iyLlKmsWwq71QfIcfn5KZ8H1iL9q6QzJ9ICiLhcBiD/BTklzd9OlRPBfLH
         PhmQ==
X-Gm-Message-State: ALQs6tAZkWMG1YYoYHPzLwz//LxU9ZqTFniyNxXESwU4rn64DGOlleyI
        U/wErS4xzlKvyC6n9iNKbNR3RQOd
X-Google-Smtp-Source: AIpwx4+D69//0KJq6k5lv73QAnoV4i0n7wzO9/iDKEiASJFrleCwjlofVz8zLPIaWQMBPz0iGpM3ZQ==
X-Received: by 10.80.247.4 with SMTP id g4mr334795edn.121.1522873276355;
        Wed, 04 Apr 2018 13:21:16 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id f21sm2152597edm.37.2018.04.04.13.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Apr 2018 13:21:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stephon Harris <theonestep4@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Change permissions on git-completion.bash
References: <010201629243c44a-4a158009-aa68-4e05-ab54-f15a49ffb606-000000@eu-west-1.amazonses.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <010201629243c44a-4a158009-aa68-4e05-ab54-f15a49ffb606-000000@eu-west-1.amazonses.com>
Date:   Wed, 04 Apr 2018 22:21:13 +0200
Message-ID: <877epm205i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 04 2018, Stephon Harris wrote:

> Updating git-completion.bash to include instructions to change the
> permissions on the file when sourcing it in your .bashrc or .zshrc
> file.

But why is this needed? Files sourced by shells don't need to be
executable, and quoting the bash manual "The file searched for in PATH
need not be executable.".

What breaks for you / doesn't work because it doesn't have the +x bit?
