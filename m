Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB5420248
	for <e@80x24.org>; Mon,  4 Mar 2019 07:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfCDHlE (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 02:41:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46351 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfCDHlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 02:41:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so4295373wrs.13
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 23:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VDiQrrzZBTb1qIXpd7Wqk7SSMdvGv0NGxgR7m4INxBg=;
        b=jbS74aEdGnOZd37cYiEaCx/95IyzMugjOGjsFwslwB/VubqDOl2nSNlgRVlVbQ83b1
         pGEMlKv5CslgAPx7x2xp4eGwz+MTaPvN32gPVyp9fGPo2rRZpLHa3RaejUUdTCN4Xxea
         eJlVtg0/Xdo10KMqNHN9oq4D5QNJZeuMvd1sFq4UaAUmVu28qqkAEKGhy0yzPQ1u92jw
         RSfB99774NJwHlghGIbMBG2rV12iFpm/O4Bx2fsDJYwruC/Ia7Lrpp5gfWRufa0Z1uoW
         Z1mKsjiuAurZkAiIv0uWtmYazS2gHh8y6ex3K1Dx/fp1vjxPTPIRrKXsZ+9hrNlpQr8T
         VGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VDiQrrzZBTb1qIXpd7Wqk7SSMdvGv0NGxgR7m4INxBg=;
        b=mLHobM7HJrpJlwfQ5j9k2/uNs5l5rwLJnXqPRnIQX6wb0Gd8xCTmM0AkapyKnbhLoY
         Y6Ov3NVle78SMHXblVEaSFwhm/SSGb5NK5uAq0FFM1d0IRNesVsp2U8CiucrGsyyf2Rg
         2Nbfws/piUDFRsj0acMc4T+KzF+6DDk7VG20d+5+7ByO+Q6846Sk1VlyzBu7heOmAi9K
         i3+hl154NWB6oSl8Dgds5HZOIR6dIVBI78A5c/RMBYn3dGtF6PF3ZM2Yuxc2Sg1quvG0
         2qdiYOhtD1olhGbUdBPyrOaiidr4U9eCm2hEbUj8C0lTDQV8VwsGsL+zJETyFXmwOISa
         rtkg==
X-Gm-Message-State: APjAAAUUG1h2GqJ6vBWIB6IyLFJfVjTrJcQCDGSbJN8y6uFA8Y11590h
        YJ4m3cO2vJeT42csqs86+7x5k6nFwiQ=
X-Google-Smtp-Source: APXvYqwvY6ObWUymwltYEqinPx5pcMRVLZF/U6Uiamp415jxRst7cqUZFWzDaD8H6rIt79ufvHXKSg==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr12232423wrx.203.1551685262274;
        Sun, 03 Mar 2019 23:41:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i13sm9500287wrm.86.2019.03.03.23.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 23:41:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Umang Parmar <umangjparmar@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC] Query regarding microproject
References: <636CE77F-B137-47EC-A39B-8D70B8C15A22@gmail.com>
Date:   Mon, 04 Mar 2019 16:41:01 +0900
In-Reply-To: <636CE77F-B137-47EC-A39B-8D70B8C15A22@gmail.com> (Umang Parmar's
        message of "Mon, 4 Mar 2019 10:56:50 +0530")
Message-ID: <xmqqd0n7w0he.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Umang Parmar <umangjparmar@gmail.com> writes:

> I am interested in micro project "Add configuration options for
> some commonly used command-line”. So can you point me out to
> implementations of some current commands which have configuration
> options and also for which command to add config options.

It is not a homework assignment.

Studying the current system to

 - learn what commands are available (hint: "man git" and read from there)

 - learn what commands and command line options are commonly used (hint:
   learn from your own use of the system)

 - pick one of the commands and its options that interests you

 - find out where that particular command is implemented

are all part of a GSoC microproject.

Thanks for your interest ;-)
