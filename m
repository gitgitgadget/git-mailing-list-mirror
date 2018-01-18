Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B92E1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755022AbeARV3f (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:29:35 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36040 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754740AbeARV3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:29:25 -0500
Received: by mail-wm0-f45.google.com with SMTP id f3so25824071wmc.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cpvc711wDW5Js6JGcwOt3chkmKUN71+gbutcc3/3iII=;
        b=g/oOvf1hHJUZpV5tFpu4rsnSa2mMCACSsyoMjg2sJbiz8RAZXH17QGbVQdN843GWLU
         cf3NBUqShVky33qXzx9PUp02MrQHoKv+/GWX/JgLs9uq8vW6ZJjruLDTgFhmZ/V8tunZ
         Ip2yQus+ad54n3UmIVl1+flsa2UMYrXhoNcNX7sINg4bKqRdZjV+8nhMPN1kB/DIiFN0
         PLw/BBgbJ2EpgDa10BaNgDdQbq4h5FGJdPa+vKobj/7x9GOjOFneHAYhHKPiYzRctGOa
         wNZVP6+LPjExQoGnp7YHHnxbg6BBl5pl1/EY/LAJlX4PFByAGexPf5iDzrrpfTb83fB2
         HFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cpvc711wDW5Js6JGcwOt3chkmKUN71+gbutcc3/3iII=;
        b=k/uHH8i0uXabz7Jbd/zjRA19yQdjcaRiE3B8wSjcGCWuz56eherbWEcsStB5KEW8IS
         S4g0FXpkT6W/LiRJLCZNk1nrmvoLs0uNrXuFXvq+G0mdg/3PG7t/RiCcz1kYa26nn1LR
         h5suErVzaSf7P//MhYIiqRUSxFnw824a6YK/tU1djZNBBrTmy3QebjSKIZ5nIyzjPB7l
         ITbohQr8WiE9u/K/quHwMo17AWr1m8cdsauTIwRIkm3PLt7qiZXE2Ko8w9HMT5CWVLKO
         GYZzDirXPZEmjvv0YFfmDu2NzBKaXjqXFS/qnnZ6vg10y4uDmWToTgBynMTOc0mZFghY
         ZMuQ==
X-Gm-Message-State: AKwxytdwrJkhheya0UriPQVIE+ARiZFr/fpeSsHMkYzLLrUr9jQfGi03
        MtL3Z+Zxm8jn0i0iOZ/UjQsCL1FyIn1tnfFpqOQ=
X-Google-Smtp-Source: ACJfBotUnyJBZoHHBK/ZpWiHLwj9eIkgJr8zYFqsg0dZN9QI41ydpYabibi6YMWTrVJSx0pO5f85TfJSZgDjh8yde8w=
X-Received: by 10.80.241.89 with SMTP id z25mr10076580edl.104.1516310963306;
 Thu, 18 Jan 2018 13:29:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 13:29:02 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801182226160.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <219dbf95a8069190abe0986ca66b65a8ae3e670d.1516225925.git.johannes.schindelin@gmx.de>
 <CA+P7+xr0FpgTUa9SgkXM1U86i8f0cParNqGkP=KNPOR_EqNHYg@mail.gmail.com> <nycvar.QRO.7.76.6.1801182226160.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 13:29:02 -0800
Message-ID: <CA+P7+xpAX-pgGAZS84DtOVSk9RfnLtD2JqsSYDKYZ30dcLKYJw@mail.gmail.com>
Subject: Re: [PATCH 6/8] sequencer: handle autosquash and post-rewrite for
 merge commands
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Same for the test here, I can't figure out why this is necessary in
>> this patch as opposed to the patch which first introduced the
>> refs/rewritten/<label> refs.
>
> Woops. This was its own commit, and must have been accidentally squashed
> during one of my rebases. Will re-introduce it;

Yep that makes sense!

Thanks,
Jake
