Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	URI_TRY_3LD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A8C1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 16:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbdJFQOD (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 12:14:03 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:48529 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdJFQOC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 12:14:02 -0400
Received: by mail-wm0-f42.google.com with SMTP id i124so8467917wmf.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=q9ebhLBZ9odkYveJLorMzwk8dtGlUCNXQl80kESESZM=;
        b=DU3AXO98Ey/IETGbbHeb2f8OZ8vjYjx50ChQsMKZbVJofg+2A3LWTXbi43eSEyUTqA
         +t8LzoTVFey4uspxpV/muvScxwRkxMK5ayMYhHOrxyx6Mh8TdjPbNcgj7tPgMmyR7OBM
         DO2oL3gJDbNla8Plfc6nq14/aAS8Cbsr7OzCvKH0iDkIcWTKccyeZWHyKVxZ0gCsK1t1
         2HuKIuyQQjAON0lxB6bUHS5UezQRQrN0sbN18YN+uTELZ53yIpt7SgMiYckeJbtL4dB5
         Hqsi1jGWFQZy6qHuUEB/e0Cs5z+mL2Y4M4HGN91PaVyOq+TBaQI5/6Lm4NtImx480f7m
         464Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=q9ebhLBZ9odkYveJLorMzwk8dtGlUCNXQl80kESESZM=;
        b=RUPnSuKmsefsDnO09ihazsgDE3DaUtWsjVChU2Mf188aUctUVSGbshYAKou+zYyAb+
         gmdRhoXVIQWitCQ92RgYs60v50lyfud0kE82+HO1kTQHvTx4EMgGu21BMObHycJ36VYD
         7Kr2MwYzv4Lz9FsUbBvO4zPFzS9jehEe9cqB393MtTRM3Ko3ZsT8Xg8ekpqNaxrBzybX
         eElTxVrm7+7QUp0cZwiY55rYgDZM6apCiInDVwgUBj+GKuzxFDoCpJXB/42jTVzh8Ptb
         6awNHqRuV9UH7m8wmrixBaxcfvrGs833bqLg90dOz5yVL5t+hWbR2zJE8rXC0rvAgvrT
         nq0Q==
X-Gm-Message-State: AMCzsaX/w1s5rhrYRSZllQdiFgVZqq9/+kroyMVGxAvLXwgiLv14eiC+
        gZzIXxXF6BGQXc3jBXwetpU=
X-Google-Smtp-Source: AOwi7QDxqCNk2Df7XIMAFH8xyuDH/5rSFjWDVjm7s7Rp98f+oOTY1K1Zk42VjdFTALeddtd8gLvb1Q==
X-Received: by 10.80.243.17 with SMTP id p17mr3977907edm.38.1507306441670;
        Fri, 06 Oct 2017 09:14:01 -0700 (PDT)
Received: from evledraar (dhcp-077-250-131-208.chello.nl. [77.250.131.208])
        by smtp.gmail.com with ESMTPSA id m8sm1871400edl.74.2017.10.06.09.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Oct 2017 09:14:00 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1e0VGB-00059f-NW; Fri, 06 Oct 2017 18:13:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git send-email does not work with Google anymore?!
References: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
User-agent: Debian GNU/Linux 9.1 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
Date:   Fri, 06 Oct 2017 18:13:59 +0200
Message-ID: <878tgo6ypk.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 05 2017, Lars Schneider jotted:

> Hi,
>
> I used to use the Google SMTP server to send my patches to the list with
> the following config:
>
>     [sendemail]
>         smtpencryption = tls
>         smtpserver = smtp.gmail.com
>         smtpuser = larsxschneider@gmail.com
>         smtpserverport = 587
>         from = larsxschneider@gmail.com
>         chainreplyto = false
>         suppresscc = self
>
> Apparently that stopped working today. I get this error:
>
>     (mbox) Adding cc: Lars Schneider <larsxschneider@gmail.com> from line 'From: Lars Schneider <larsxschneider@gmail.com>'
>     Password for 'smtp://larsxschneider@gmail.com@smtp.gmail.com:587':
>     5.7.14 <https://accounts.google.com/signin/continue?...token...
>     5.7.14 ...> Please log in via your web browser and
>     5.7.14 then try again.
>     5.7.14  Learn more at
>     5.7.14  https://support.google.com/mail/answer/78754 ... - gsmtp
>
> Of couse I tried to log in via web browser etc. Does anyone else use
> Google as SMTP server? If yes, does it work for you?

It still works for me. Just sent myself an E-Mail now via
git-send-email.

    Password for 'smtp://avarab@gmail.com@smtp.gmail.com:465':
    OK. Log says:
    Server: smtp.gmail.com
    [...]
    Result: 250

My settings are:

    [sendemail]
            smtpserver = smtp.gmail.com
            smtpEncryption = ssl
            smtpuser = avarab@gmail.com
            confirm = always

And my https://myaccount.google.com/apppasswords lists an app
password.

If you see this E-Mail from me that means my local Exim instance (which
also has an app password) is able to send E-Mail as well.

I have 2fa turned on on my Google account, I just have these app
passwords for GMail.
