Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5F41F453
	for <e@80x24.org>; Wed, 19 Sep 2018 20:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbeITBo3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 21:44:29 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44815 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeITBo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 21:44:29 -0400
Received: by mail-ed1-f43.google.com with SMTP id s10-v6so5910646edb.11
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=s5maaV/8oVmeQkmhRVJyLWPwNrLKtI29EjnvQp9Ubrg=;
        b=U1Vn+JQzw/ydZvcDK0vTPDi9j0pu7vMioXhHqh99Da/zGc0z0q0c6OVo83ZYpqwNJx
         voV43SyKK8B829wNsd2OtkgdGajd63pOiz5c6UkfkYG4dwPjX2hIgDpIv6PKMmcn7SX9
         oy3ZZKnbkyEnFhwYxoV/RF27WFgWoycG/u4Y8PIaimQ14Z4YPU53LxvOfF4gh8FDCoGX
         4Rt9vlW1T3TqQdeZxkYN9aSPOMBJUB1m8dMU5o3UShFuAJHdWOQt0xIIjEHtAImSobrQ
         5IwisQ0bgwiRK1Bz4ysC/qPyzNai1ZzZXt00OrGF4Ea6lda4E/uMEK+kA3DXw32ify64
         hFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=s5maaV/8oVmeQkmhRVJyLWPwNrLKtI29EjnvQp9Ubrg=;
        b=CiJgBSVea19+e98X0SoC/SnWJLvK8X+tqVqOu4mkcQdt7T/T/4M/fyYgo0mu/1utpU
         0RNVGofmDlL+I+AyjC7Rq76RJRanaSqlXEnz3pwj4U1o87Yskc89Wakqi3oTiRW4ZRzK
         Ed6YAGdF/ua0SJ0TyFZcLoLCWa/Ea6dcBA+QqlC8ZSBlbuoc966Tf4LjX0xfgS03/jZM
         yyKJqqnhy0/SFvrn2T5q6bsxkqA/OcEXoL3T99kxTHw/cClfJh+Oa80b0QFGYs4jdokZ
         L7JgCVksm7FOrt9fPG1o1vTzR1kQaCq/dyVSS5Z94Z9znwzVtaEXaEbVspj66s4ey7Lc
         7ZcA==
X-Gm-Message-State: APzg51CT1xy2bIAR1YM/qGSCrPwnRHjHRKNs7zc2xSir/ul5PRlk+2EH
        ehhhq9gujzTzdHhI5mW0/LY=
X-Google-Smtp-Source: ANB0VdZ9NPzAQJ3qPObHYGTm2Wt+zNA/t3nSgiXzfNgG5BFJXp1HUdK+kIMoJUmNeIGKA16cX0pKWA==
X-Received: by 2002:a50:d619:: with SMTP id x25-v6mr60252144edi.178.1537387498355;
        Wed, 19 Sep 2018 13:04:58 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id r44-v6sm2971008edd.87.2018.09.19.13.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:04:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Leonardo Bozzi <leonardobozzi@gmail.com>, git@vger.kernel.org
Subject: Re: Access Git ssh on port 8822 ?
References: <CACrY0PAM=Ek5T_3oYkT0zMoAsULDfu9JAYm3xJdEqaxvxpQiwQ@mail.gmail.com> <20180919175045.GA10005@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180919175045.GA10005@sigill.intra.peff.net>
Date:   Wed, 19 Sep 2018 22:04:56 +0200
Message-ID: <87sh25jlsn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 19 2018, Jeff King wrote:

> On Wed, Sep 19, 2018 at 02:47:09PM -0300, Leonardo Bozzi wrote:
>
>> Good afternoon, I'm trying to set up a git server, but I want to use
>> ssh access to connect clients on my server, but because of a
>> limitation in my internet provider it blocks access from outside on
>> port 22, so I changed the same from ssh to 8822. But when I give the
>> command:
>> 
>> $git remote add origin bozzi@bozzi.net:/opt/gitcurso
>> 
>> The server blocks me because I would have to access via port 8822. How
>> do I make the connection correctly?
>
> You have two options:
>
>   1. You can use the more verbose ssh URL syntax, which allows a port
>      number:
>
>        git clone ssh://bozzi@bozzi.net:8822/opt/gitcurso
>
>   2. You can use a host block in your ~/.ssh/config to set the default
>      port for that host.
>
>        {
>          echo "Host bozzi.net"
> 	 echo "Port 8822"
>        } >>$HOME/.ssh/config
>
> -Peff

3. GIT_SSH_COMMAND="ssh -p 8822"  git clone bozzi@bozzi.net:/opt/gitcurso
