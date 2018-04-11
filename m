Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183FF1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756164AbeDKUkA (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:40:00 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:38789 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756048AbeDKSsG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:48:06 -0400
Received: by mail-lf0-f49.google.com with SMTP id u3-v6so4101835lff.5
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LyjTf7j69CCt/h5TL99infJ8YmjrmpNi8/kWMv6bmE8=;
        b=Qei8lyM/jop+NMr/y4uMOSytpzGMTTLEwTTPMIUcW4eO8/+3lFCIbDwRxDP9mkpJrU
         VJEOfHTIDFhgcn9443CO5zusKyw/hqHKChKx4bEyCZxIA5j08nGWdqCxELpebxEGqfQm
         b6Aivf6CgJU7uHXyGdCoZRX4GEPZSxRoOGn+LF6H1hlls3hfvgNPtaG7ILignzrGC501
         pFcFVnP78KNY1Qnpvo4Sd7gdZsywnP2C34KtoW5zUfr2pZUHy2WgOXu3zECLrQToYcor
         U0aQ1dkmodUA6/plxVCZiceakHS3d1y7kAG+PotMzeDQ4Ht6md813ZOmwFY7x5a35jpN
         s0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=LyjTf7j69CCt/h5TL99infJ8YmjrmpNi8/kWMv6bmE8=;
        b=HqOUGSkjQ3Nce2JyaXp5e3rnehBNrmo28sBu7z6J5Njp5GrPt5jSx7w2n8SUV3Kt76
         wZzIyF7D3Nz9ThUQ3Hhfo6LpF/QAedW1gI+56MnXRc9Jdz0u2hCa7eRtjJCMCfcccAUk
         8NivOs8q3q3MvBR9vdd+eFJoMls8tmjN27fwbomyHB8cyEfs3SOHFULPggoApwlXInn2
         86jYF3X7cXfwSIWf87X8Jvrg93TIhvRSZedb1YG8zws6p+WZcnMbdCZAnacek3Fz3bx3
         pq4aJhYc8xsk3JS05Jw+ftXistGppjUtWEBjvBrjzkwkFekq9VC3DkvQnF4nk+fHqoWj
         QKbQ==
X-Gm-Message-State: ALQs6tBtYlLtL/ex4UnFecpWR7JOQCWD/t2SROLXaCy5RODQylrYY13G
        /ucFYUvw/qzlr7gasCaV1lAkRL/Z
X-Google-Smtp-Source: AIpwx4/717caHRNyi2hhoiclUrzxi+t0y9UsaiXY2tyrQrcxWOGSDgzgPWD+jb2e1mELqqAX8bYgOg==
X-Received: by 2002:a19:d202:: with SMTP id j2-v6mr3682946lfg.68.1523472484407;
        Wed, 11 Apr 2018 11:48:04 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrk101.neoplus.adsl.tpnet.pl. [83.8.104.101])
        by smtp.gmail.com with ESMTPSA id b67-v6sm364501lfh.26.2018.04.11.11.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 11:48:03 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 11 Apr 2018 20:47:59 +0200
In-Reply-To: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 09 Apr 2018 19:21:11 +0900")
Message-ID: <86d0z560m8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:


> * ab/nuke-emacs-contrib (2018-03-13) 1 commit
>   (merged to 'next' on 2018-03-15 at 13eb4e2d8b)
>  + git{,-blame}.el: remove old bitrotting Emacs code
>
>  The scripts in contrib/emacs/ have outlived their usefulness and
>  have been removed.
>
>  Will kick back to 'pu'.
>
>  There were some noises about better migration strategy that lets
>  git.el to nudge users to magit or something when used.  Is it
>  something we want to pursue further?

Maybe simply delete all files, leaving only README pointing to Magit?

Best,
--
Jakub Nar=C4=99bski
