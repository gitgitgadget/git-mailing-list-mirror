Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DEA51F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeK0Cgq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:36:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52835 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeK0Cgq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:36:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so18665783wmb.2
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dfHToGzE092nw/6zqfJg5492exbkoky2EpRwFY/vcg0=;
        b=KMV4wEcLUr+ay8YMyGBQAOIFEp1P7BtaL5chqOjPh4lkoQo1QAelMKpuVBaP4zNLdv
         IGow2Du+a3OnfaKDRLMIIQRYYQloI/Gl3efx/8Oh8OrWjCKlwEDFipwFOxv5sP1V+Tcw
         DGJ9bUoOLq+JUwhkzoirOA0FmEoFrcpWsupGFno8sCsaumoysgJUTPNGkU1r6lxyxV7f
         5XvhrBfmBqIwpdLL1JrsGqQIb918je4PeV8yW9cpVBSBN4h84gmyBjXrfchJa11j0fOz
         C4LgYMHHtCibUENQXHC4wkcNa9hrwOD0qjGy+8r0P7tAw2gt8/wAQw5Vk0bn+QfzKbny
         Y9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dfHToGzE092nw/6zqfJg5492exbkoky2EpRwFY/vcg0=;
        b=ZItUbad3i7OzXOpTrK1hMkayZE69q0lb1Aid2g7fzGBX5jBSZCF/hM3AedOZdGv+5b
         27LUv90ZZT4xHAr2x28HNxnFyrgLijEJiXY+SDnzdpKt3+hAwDOa4nmWXwx5unDtNahc
         Vm7wnRPsuk1Z5fkMXCes1aF+iViM1G5jVZCOv7tEi/wd8p/fPUf4lMEBIpNzfM2vf/tx
         fqwLxIph5QgRlsfK7QFZ5ya5Abj0ZQNfbzm3NiP5WhvyO3uO/jGtwmGyqVl0m2UvO8RK
         U7cRkgFmJl/kDo1uyAFcuqpSOY3aPYV1LZpd1ndncmo1rYz8lQUVyQryProf+X3GWxX9
         GjwA==
X-Gm-Message-State: AGRZ1gImSHGGTtDwi5hsP1IpZ4l6YZakleG293iYfDn9b7ntgIfgVd5D
        FMbVZGAGQL+5gMucVxWOuIg=
X-Google-Smtp-Source: AFSGD/VpkcnoaoJy6nwlRwhXpkZHM7jc50Y5gwGnYgHBNgRCI2CVHwEqc3mn0t6Q1hVb6H+76sC2Dg==
X-Received: by 2002:a1c:a8cf:: with SMTP id r198mr22959317wme.95.1543246936237;
        Mon, 26 Nov 2018 07:42:16 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f2sm862531wru.14.2018.11.26.07.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 07:42:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] test: NetBSD support
References: <cover.1543143503.git.carenas@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <cover.1543143503.git.carenas@gmail.com>
Date:   Mon, 26 Nov 2018 16:42:14 +0100
Message-ID: <87r2f7zvzd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 25 2018, Carlo Marcelo Arenas Belón wrote:

> Likely still missing changes as it only completes a run with a minimal
> number of dependencies but open for feedback
>
> Requires pkgsrc packages for gmake, perl, bash and curl and completes a run
>
>   $ gmake SHELL_PATH=/usr/pkg/bin/bash NO_PYTHON=1 CURL_DIR=/usr/pkg test

This looks good to me, and fixes most of the issues I've encountered on
NetBSD recently. See
https://gitlab.com/git-vcs/git-gitlab-ci/blob/9337ed6f99e3780d1d8dc087dff688f5a68805a4/ci/gitlab/run-on-gcc-farm.sh#L228-239
and https://gitlab.com/git-vcs/git-ci/-/jobs/125476939
