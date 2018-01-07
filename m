Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CED21F404
	for <e@80x24.org>; Sun,  7 Jan 2018 23:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754778AbeAGXDN (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 18:03:13 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:41691 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbeAGXDM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 18:03:12 -0500
Received: by mail-io0-f170.google.com with SMTP id f6so11107256ioh.8
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 15:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gHxH6vUzT2lXdarjL/4TAS0z/D147vJa6VMv5j95jTw=;
        b=uk8iQScCmwBDnaBs+tbudKNYCX25BRQMSzRS8gzmNg5SGMTOgILM02QiNHJIDZ8RWB
         IArwLEa8kzd628/pg0D3xQiWsDhT6wmB4+PKZ5PJWYwFN9yuEmQ5cj1t7Dg8KdU3OLey
         4MOu3DqHoek/G89oZjSrQ6dD6twyCV3BDwR7M2NJim5JzAM8hyWEVcW1zND5DDLov3sK
         q+66BOlwe+CthUYRoIc6ok/s/iBS/oxxpgb9lP3SANmeuw/fEi3aFMccv8ZZk8gK4hfi
         Bsg+ekTWjA4gITIZwP9MtK0bvb6nNXgGFOO/EARIqh+uoGlVp82hg2DyGQ9f9PrTam+5
         KUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gHxH6vUzT2lXdarjL/4TAS0z/D147vJa6VMv5j95jTw=;
        b=ALxd/XObFSjKDQJidCFqM9UBZ4Unk7RFUR0smn+bZP5bBpZl1/LrgIYIjYmv1ZgzGt
         wpv/j+GM2zw7tO1uRBZtiaKjdpR2ND2A7fNcMLqsvk/wnqvLpztdKr10N9kIzRAQ97E2
         wG+eMIfWJbd1Dqfy8GkME3wooq/6/uDz85Jnpy1gkP47AAAHxt37BOixSJq5I+RjmADT
         Kw/JcFlm7IBPORvSKJc4sqd2mQ6VZLlf5SSLf4hzV8wehcYHKKUeaT+FPyvg0mhGIzj5
         1tS7kd4lp2u4QQTm+V1cnNiH5w0vE6pOSg6ESjeHqMihvsos4kICEv5TfthfeRni1j8r
         UMFQ==
X-Gm-Message-State: AKwxyte7jARzE/GXx/xdI2DQirvXbP4KDkciMDDhu+G9fXWW2YtOUSfM
        KL51JncW5SivpxlhUB4cYaW3wEu3vOjfUgXpb10=
X-Google-Smtp-Source: ACJfBouB6V9XNBy1O99G2DEl2N7/KYW+hce1PzaT/4tZ/wplIB2rG9skHeimD4f7xOSKxv6JDWFMR+1yvMkwAxPJJQg=
X-Received: by 10.107.88.7 with SMTP id m7mr9036873iob.180.1515366191824; Sun,
 07 Jan 2018 15:03:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Sun, 7 Jan 2018 15:03:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1801051217190.31@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <q7h9lghcob2s.fsf@orange.lip.ens-lyon.fr> <alpine.DEB.2.21.1.1801051217190.31@MININT-6BKU6QN.europe.corp.microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Jan 2018 00:03:11 +0100
Message-ID: <CAP8UFD06ZThD=FiccGrYLKpJz6R8NAUzFzMv+zrD4MisfJSbTw@mail.gmail.com>
Subject: Re: GSoC 2018 Org applications. Deadline = January 23, 2018 at 18:00 (CET)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jan 5, 2018 at 12:18 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 5 Jan 2018, Matthieu Moy wrote:
>
>> If we go for it, we need:
>>
>> * Admins
>>
>> * Potential mentors
>
> Count me in as a potential mentor.

I am ok to be admin and mentor.

>> * List of microproject and project ideas
>>   (https://git.github.io/SoC-2017-Ideas/ and
>>   https://git.github.io/SoC-2017-Microprojects/ are good starting
>>   points)
>
> I have spent a bit of time recently to document a couple of Git for
> Windows-specific projects thoroughly, I could easily copy/paste them
> there, too. (Yaaay, Markdown! Now, if only we could use it in Git's man
> pages, too...)

Nice!

I will fill in the application.

Thanks,
Christian.
