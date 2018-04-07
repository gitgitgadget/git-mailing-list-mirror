Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5571F424
	for <e@80x24.org>; Sat,  7 Apr 2018 10:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeDGKIh (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 06:08:37 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55458 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeDGKIg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 06:08:36 -0400
Received: by mail-wm0-f54.google.com with SMTP id b127so7870693wmf.5
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 03:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=KgXV+9IJ3xBoQd0mT8hjA7jK9HNWzMkHsD2gTNZ81jM=;
        b=EYFJ1NrDaqyO2/BhhckkM0oFLFKsnWob6sJ0kdU2h3Z19dVwqAaYj0rslMgNQ3BqwH
         63ITB8/JVsHdu2KBZ+bnsI2jslECsvv62Jy+ZEQEbC7FNWxsRsXw6/zH9Kff1p2huQqn
         O0Gv2x2vZmqlPhFzT6q3vhvwoWu7sqD8Jt4S6Hsk2o43q3KqFPqDtPXTcpP3K4kxtBJk
         psCa5+8HdZTgeC9ciXZlNll+yji4oFm/nELSt8tbxScNdtUwv3j6b6DRpT0XGgAKG7Pv
         RemZuArgTP84VEFuDb44dULBuFz9PfOYWH2zRVZflj5G/wWg0Bz6YTck7HQa94RwLIX8
         Beqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=KgXV+9IJ3xBoQd0mT8hjA7jK9HNWzMkHsD2gTNZ81jM=;
        b=pPH0Ncxx2Opb4WRWNIGJwKyRF2moYHjiTIGRfF87uFaQ4vJNOGt9lWcaazNoc/Woix
         1hcbamon2FizxUfDgpNAd4Xm2teadaoLMXyH+223YKdY0HYF/eW4jlC0VhrENyS4ro88
         yq993Pf2GQb71Z1ljgpMJxY4RpWdMOkkTUHJxCt1BWomHC5sRiOVEyp7TpC6nI4FLzwp
         UJH2Lfidk+GJIc9o+s2X9Bv3oGit8LuyzYarwhqbRlXqSG3emVf1Ci6iUM2aaP8Fc8Cb
         NssfjdQADdM39PGwjdhWcDX52iDveT6VjZZg592eCbaMeNrl4c6jUlSZY4c2R47MJhKD
         tHhA==
X-Gm-Message-State: ALQs6tCEpBTCYQfBRX06FDtcoG4Jbxn5NPFQCLWcLDM/vXp6e5i7xYn+
        fwJ1NxQmJQj25baQeETwTf+l4/nuowioHShm2tA=
X-Google-Smtp-Source: AIpwx4+AwRpyw5WINPWEoSIQ9S3NbiUX9YPoqzY4j2fI2ZGXgS9vreet1wSuHhyrzKKVttcX1m2rwE8/0R+4PeqcQPY=
X-Received: by 10.28.18.206 with SMTP id 197mr14349453wms.22.1523095715127;
 Sat, 07 Apr 2018 03:08:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.133.240 with HTTP; Sat, 7 Apr 2018 03:08:34 -0700 (PDT)
In-Reply-To: <20180404211446.GC15402@sigill.intra.peff.net>
References: <xmqqk1tpxo0g.fsf@gitster-ct.c.googlers.com> <20180402232348.20293-1-mina86@mina86.com>
 <20180404211446.GC15402@sigill.intra.peff.net>
From:   =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mina86@mina86.com>
Date:   Sat, 7 Apr 2018 11:08:34 +0100
X-Google-Sender-Auth: 1Lpf41calqXjQoC2pyTlAO4hRu8
Message-ID: <CA+pa1O1G+TQaKTCDEE_KBtMAMgG+GbsmeGv=mke_9aArL0US8Q@mail.gmail.com>
Subject: Re: [PATCH] send-email: fix docs regarding storing password with git credential
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-04-04 22:14 GMT+01:00 Jeff King <peff@peff.net>:
> On the other hand, I'm not sure why we need to pre-seed here. Wouldn't
> it be sufficient to just issue a "git send-email", which would then
> prompt for the password? And then you'd input your generated token,
> which would get saved via the approve mechanism?

Yeah, this is precisely what I=E2=80=99ve figured as well.  As long as the =
credentials
helper is configured git-send-email will approve the password and it=E2=80=
=99ll be
stored then. New patch sent.
