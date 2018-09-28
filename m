Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22921F453
	for <e@80x24.org>; Fri, 28 Sep 2018 22:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeI2ExX (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:53:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54322 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeI2ExX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:53:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so3592475wmb.4
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FChaoacNLkzl8M0YmYeFq8CH1Rc2N0oqqz1S2BIN5z8=;
        b=Y3KMYcLg/JBDNgGiFaVEXUpAvYT8TE/hvaiABpph3kLNuvY1GsDH74l2eIYYyUfosk
         wYDt0oMkmguuCbUZPlrJiguFN6kH6JuM6dY2GCPYPOMWxMIYplx/63pyQpzS7TEMOcjE
         3JetLEKLjP48CW/CWioqK33dPkQGLVYm4XXEb46GomzVxX47S3hiVlCiJ1mvvVrU8OEw
         LYnAPywkdMb/OB5bODcUAr8R+34JIkznjDOFF5UnoWWWN7UhcGYz5+0bXBEyDdzW2vli
         mBR2oXa2+UJvx24FPtAWmDXP5tMXzn9bcxjEh7w2Do5IvkEySM1xgs9fu06XpFmidKPq
         KZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FChaoacNLkzl8M0YmYeFq8CH1Rc2N0oqqz1S2BIN5z8=;
        b=XDDPKIOxpix42UKGmpqIl7jzHlc/7TFMngd2Zs1OEzYO9hv8/HxDrbuBeR6CewygDO
         YF8Y7SVsn93hWKNryikNbolgMx3+SDnK2Fh/TCedYk0pw9EKSS41WsBVIzz9adOAVmt1
         KkqDxr6kd/UzyDDZUZmuZ/2quBvUQ4rNDOuvrl6fCIX8E/NUFzg6Q5sKLxShjPSKKvLX
         3xYNPnOXO8iDmajtKYp6D0tyFHZCSI9jnREYuWOKRbzFGeVzruG+fUvgtX7JacA8dtIw
         gm+McYvCpWC4K0uHH8mSpcVcpSlvfE0NFm2JeBQ9XGICZU8h6DDJiGa/prTrjKraH0w+
         9q/Q==
X-Gm-Message-State: ABuFfoia3bWgeudzlbXfy65VMYdbWYXvIocAUR7jlVDs0ssCoj0Nm5oz
        Cajq8VLtjP1WYRxeMYjRvkjSVLEO
X-Google-Smtp-Source: ACcGV61QY2KLMjy07+BdMKf3J3ziqLiStZPBFFTNa2WMkQ6c/6O/aKgIHKnmbLv36Yr0nowIjTpiog==
X-Received: by 2002:a1c:a386:: with SMTP id m128-v6mr2907774wme.139.1538173651468;
        Fri, 28 Sep 2018 15:27:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j133-v6sm3936650wmd.12.2018.09.28.15.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:27:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] git doc: direct bug reporters to mailing list archive (Re: [PATCH v2] git.txt: mention mailing list archive)
References: <20180926134717.GC25697@syl>
        <20180927055018.6683-1-martin.agren@gmail.com>
        <20180927063735.GC220288@aiede.svl.corp.google.com>
        <CAN0heSpG2jewXuzcZQAeFydW4zanzymSGVqVz2u0myW3Z7Wcrw@mail.gmail.com>
        <xmqq1s9def2p.fsf@gitster-ct.c.googlers.com>
        <20180928212049.GD193055@aiede.svl.corp.google.com>
Date:   Fri, 28 Sep 2018 15:27:30 -0700
In-Reply-To: <20180928212049.GD193055@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 28 Sep 2018 14:20:49 -0700")
Message-ID: <xmqqd0sx9s19.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> My experience is that bug reporters are very sensitive to hints the
> project gives about what kind of bugs they want to receive.  I'd
> rather make use of that lesson now instead of waiting to relearn it in
> the wild.  Here goes.

OK.  This unfortunately came a bit too late for today's integration
cycle, so I'll leave this in my inbox and replace what is queued 
with it later.

Unless there is another one to supersede this proposal comes before
that happens, that is.

Thanks.

