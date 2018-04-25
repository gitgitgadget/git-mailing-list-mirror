Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9E11F424
	for <e@80x24.org>; Wed, 25 Apr 2018 15:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeDYPFi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 11:05:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43931 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbeDYPFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 11:05:37 -0400
Received: by mail-wr0-f196.google.com with SMTP id v15-v6so35570608wrm.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=peoBHOhBnwF+d+uiNOfEXJW0pOjiuyEvHYYNif1ohf8=;
        b=fwHX6UsGncaXoJSB7DG3+mLhstqm6u91tVo3cY7kmiDd+47fgr+nLScCw8TCPxaZz6
         xE3VCVMhZLum62oykGimqMcMiBN0s/aQASadXBuloHbCuX6ID4ExuEfGhzFcXoZl+jKP
         J0LQMie6vTGyONuaVOT025DrVtSfOQme8LRsQqj/oPE0RvukglEGZNBztaxx+6PCmKCM
         KGV6+Nj7cqoz1vpY07wWti+X87WeLdB1k/tCSFZZJrQ3L04pVL4A6dVDums5iWHcko3G
         68rXemtEeJhFP1CFdo4/WfRyPAw95MG4wQbIOEjGfgkvQ2P82kHhSd7NK6zk0i8ut31O
         IlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=peoBHOhBnwF+d+uiNOfEXJW0pOjiuyEvHYYNif1ohf8=;
        b=cpAK4Aq+caH2v/T8AUt3wgxAxCrOjRtYlr36H838xITl/bkNeYAQ2TGeAZXanJWuRG
         PW0aluMH/TUqk1/2DhInpWezHZtayIX0K3TSdaN5scGhtSiRIIZDhsxDIaq0QbvV9Vv7
         JT21QsT0deyRXvV1O2X1kj5k9qAX2x2p/dt2PKyNnJkTa22YHOgumhjLgi1gPW7UVDPd
         KSqfdk2o3hlZ7ZyLjDkkpTAAEqMLsUCPUjZUC66b/ehvkfy9WP+QMPF4xecGNFbk6wN0
         FixoyAG5PIr2S7naXpNahTaSi00sP70GwqtBDs3uxsavf7JOQw6emUycOmvr7wc6a10c
         eIww==
X-Gm-Message-State: ALQs6tAxsqzPTFERffvBZPmdK1SYYW/BSNjobM8z55B60ATRPV6QvsCZ
        9VenW3GIduv7RZ+Fc6UjSFWRfRf8
X-Google-Smtp-Source: AIpwx48BwiRXodPDyizPguOAY0ecRY+Usoi5bdNv/T1xfo9hXPloAnjPy06c5vsnz9B1pVpDrsNxbQ==
X-Received: by 2002:adf:96c2:: with SMTP id u60-v6mr24144497wrb.204.1524668735960;
        Wed, 25 Apr 2018 08:05:35 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-42-160.w86-221.abo.wanadoo.fr. [86.221.49.160])
        by smtp.gmail.com with ESMTPSA id b18-v6sm22716965wrb.55.2018.04.25.08.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 08:05:35 -0700 (PDT)
Subject: Re: java diffs show no method context
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
References: <5AE07A3A020000A10002B5C5@gwsmtp1.uni-regensburg.de>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <aae8d748-101d-1eb2-f8e8-9da2e53e2388@gmail.com>
Date:   Wed, 25 Apr 2018 17:05:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5AE07A3A020000A10002B5C5@gwsmtp1.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 25/04/2018 à 14:53, Ulrich Windl a écrit :
> Hi!
> 
> This is for git 2.13.6, and it may be an FAQ or frequent feature request. Anyway:
> I'm new to Java, and writing my first project using Git, I found that "git diff" only reports the class in the diff context, but not the method (as seen for C, for example).
> I'd wish to have the method where the diff is located.

Hi,

to achieve this behaviour, you have to create a file named
".gitattributes" at the root of your project, containing this line:

*.java diff=java

.gitattributes allows you to configure other things, as described in the
documentation[1].

I hope it helps.

[1] https://www.git-scm.com/docs/gitattributes

Cheers,
Alban
