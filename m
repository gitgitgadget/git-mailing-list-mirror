Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04371F453
	for <e@80x24.org>; Mon, 28 Jan 2019 22:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfA1WXp (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 17:23:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33846 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1WXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 17:23:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so11528640wmd.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 14:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wqd/dF45MsZYQeXRatomjHUXQpJFZSU+o/Q51UHV254=;
        b=RBqCF4G2IFRfF4VDN2BJ3606RiyQTaENhCPCdWVa9wG3NCwUqpSF1aui+9OWMbVjju
         0agkYaBcv36CRfR5w3sOmP6IorwmBLIl34KdHuW2jH53TfNTOZScidzMB2lgkGLG/jQ8
         AQxehhHF3/u/2ngrR2OFyeH85WrzxKU4g6RfRXd5G6fm6JlYTy0j5HIcoE3LEY0yavcU
         wq8QX/zMQPYzhwvQqQ6gU9tKFbtWTklvjy8WhIFRGqFdhXyUjD08TJ1O/mSHq/QfK+GX
         BobynT+nRrFWO5P8EZIhsM76F4YNKw6F8BblOM629MvTu2Ctuq6FKnUTZu1hgtAyCCHN
         pWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wqd/dF45MsZYQeXRatomjHUXQpJFZSU+o/Q51UHV254=;
        b=hTEhlIet2pxGK2SMUcn9gQZwDIOof9a6+1w71xtOaX/euCJ8KlBI8KO+36SsOot9wj
         rdxSuLRRkp7n+4F/6jucqTc0w58A3QRnxi8DLgZm8ghXHgC7Fdl7N1e/6PCe3Pm7lQp0
         05+w2ZAyE831hUfAetnC8lOUSowFfoK8fNYUmzI38BvSvrn5x4lQNAcsbYhXrhbuhZ0T
         Bg2j16rIqmy9bN5Sdp+shSArgWapisE9pTtKw7x7TS++iZ2UMHKSG8JgUY9c7EeaSpSk
         KPagAp4c3Onjnx2BQ5xFUD/R2Bc+SgZ67fDiFbZyKCzrFjjYTJMGoBFgZvt8+r+Bte4H
         P1vg==
X-Gm-Message-State: AJcUukfTLkkHe69bjG5OMkBnmIP9Yzu2T50Nhm7HZtEnT5FV3TR3O/4g
        Zgng/du8fe5mIqhWG77e/jE=
X-Google-Smtp-Source: ALg8bN6VJtA69XVgvzCGuxUJ/VBsM2Hok2fBI1lD1nZdJcSsf0JEQj6mxH4bBn/igskDUKjSdpYxTw==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr18583347wmc.138.1548714223110;
        Mon, 28 Jan 2019 14:23:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s8sm128075670wrn.44.2019.01.28.14.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 14:23:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH v2 14/14] trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
        <851aa8f34d7223a3d872033abf2f2a95517b3b23.1548712060.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Jan 2019 14:23:41 -0800
In-Reply-To: <851aa8f34d7223a3d872033abf2f2a95517b3b23.1548712060.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Mon, 28 Jan 2019
        13:47:52 -0800 (PST)")
Message-ID: <xmqqd0oga0b6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'perf stream, return code 0' '
> +	test_when_finished "rm trace.perf actual expect" &&
> +	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
> +	$TT trace2 001return 0 &&
> +	unset GIT_TR2_PERF &&

Do not do this.  Stoppage in any different one of these steps would
leave the state of the process in different state and affects later
tests (e.g. TR2_PERF may or may not be exported).

Is $TT always "test-tool" (i.e. the binary, not a shell function)?
If so, consider using a single-short export, i.e.

	GIT_TR2_PERF="..." test-tool trace2 001return 0 &&

