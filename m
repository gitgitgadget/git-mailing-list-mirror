Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1D21F859
	for <e@80x24.org>; Thu,  1 Sep 2016 00:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbcIAAI7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 20:08:59 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33988 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbcIAAI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 20:08:58 -0400
Received: by mail-pf0-f179.google.com with SMTP id p64so24545871pfb.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=aim51hN9+JoUjiaRkcxDLFjS3IdqIZD0R64wiQDXIMI=;
        b=Tntv+UXrJ66+kQ210aeA+zyLpEvjkAzp3pCN6o1hQT8PidrS+57FwnZH9x6K4LMbHH
         wHcwcTb73/ofUlz9xJL7CgzcvHEAQxXD20kdMlVaE7stvDydkIcs/WB9O27s4UYgDi1u
         PngiW6ukuKJYsNBOWwYia7Hoha7V/DCR1eEEj0ZaDBgsjOU8VpMovjheCH0A3I1EduIT
         /JUVrtTWvS9PdeIbC44fO/pVHOfYZvT7tof7x/IpOIN+XmiLW3FbgTH9yTEXb9ghFsPx
         28nlgEFC6K407ISNgVP5/PzB9keIBof5mHaccqPA1yt/Xq01zcPV5WTR9sZuUIlTlyPx
         WvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=aim51hN9+JoUjiaRkcxDLFjS3IdqIZD0R64wiQDXIMI=;
        b=NuK0c6IQuJIuYKin6nsoqAlzL6Hbeelo+6zzyUoDjXzHmc8L5LT9wu0SIVPagd2A2m
         ZnFqvKnW/p7JWEIxLDbOKgrTscPQOmXfqA1egxE4/JGbNI2aDae12ZsMiFLhI2lIcBph
         AaHlVieD8NkdIzLVpWGUHfFOgCiuRl9z8afK1Kt64JrsF3vgz/LCCEoOu+/fM8X1wcee
         XijauJlkbI0Iz5JamJ1N29f7meNA6d9TSLBJrrI8eAdw8islpHv/P+1dDA9WdM+uPCQl
         KNS+i42YAW3qsr+qg64EYLoKiPG9PDvNKslcIOBYtOQY+NLfvhBm1w5i2YSMS2wKNEFF
         0iTg==
X-Gm-Message-State: AE9vXwOcwvPytDufR3FcMaUtpnIwNMiDHDuv4PlMilF34iDpTFloGPH9Irn8QmQ/bNXv0g==
X-Received: by 10.98.21.131 with SMTP id 125mr21789359pfv.92.1472688537383;
        Wed, 31 Aug 2016 17:08:57 -0700 (PDT)
Received: from [113.168.12.75] ([113.168.12.75])
        by smtp.googlemail.com with ESMTPSA id a21sm2217543pfe.81.2016.08.31.17.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 17:08:56 -0700 (PDT)
Subject: Re: [GIT PULL] l10n updates for 2.10.0 round 2
To:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CANYiYbGLzg6+pK85gdp3bH7qyrA3BaX1PmjbnbK8Q+23HWuotw@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Vasco Almeida <vascomalmeida@sapo.pt>
From:   =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <b656bb11-680d-b20b-7aeb-99dc4afcb4b1@gmail.com>
Date:   Thu, 1 Sep 2016 07:08:51 +0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <CANYiYbGLzg6+pK85gdp3bH7qyrA3BaX1PmjbnbK8Q+23HWuotw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/08/2016 21:14, Jiang Xin wrote:
> Hi Junio,
> 
> Would you please pull the following git l10n updates.
Please wait! Jiang Xin probably missing pull my one commit[1].

[1]
<https://github.com/vnwildman/git/commit/800d88e2b3dde41ebf34e2e00955bba892419555>


Thanks,

-- 
Trần Ngọc Quân.
