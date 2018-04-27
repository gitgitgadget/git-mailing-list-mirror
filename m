Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E9D1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 16:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932920AbeD0QVm (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 12:21:42 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40237 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932897AbeD0QVk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 12:21:40 -0400
Received: by mail-wr0-f176.google.com with SMTP id v60-v6so2311817wrc.7
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=24cRAlrJABouz6ecYPyeS6pJXnbL2dPM5Utg2foPg2A=;
        b=Z/7nfStdnoX/Vy3/5jDd+Kk4pV5zqI06TVjKKrKkYTSXP9B27xk+zcepFeIyuv62D1
         5TPTygyvrf8zWZCbSb1op4tuo7bHhzf4u156rIRkhLJS1Z0kdoCRFjFgdAePyTmzaGwz
         NaVfzIqKpx0LfRiCEnQ3iY1d9dbC+q4nasIuFCWeth50o66gnseb/ikAqzmXDt0QRn9P
         N0QDIJQxb/J2JfVooETomh4DDircZ0mh4RikCWcjg79ZhUbAt/RKrb1aQDwFaKE3unm5
         28Ko5SPPMY9lH+ep5QQjC2bjOFmPQsAKFbqBUHsAH3fFeQ16XK6Ukev1E9rOrBVaBpcT
         oDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=24cRAlrJABouz6ecYPyeS6pJXnbL2dPM5Utg2foPg2A=;
        b=HPj7ZZnTSHvIFefE+G0/0P8MATfpkN7n0xZxSOUK/1OJrR69b6sxFNjnZLeuBdSs44
         32oy22GwzO7RCd9lAxZH8iXmYQBO9TanmVNpUkzzs3bwKHflhPMLgzRIKDWtazImZrM8
         vkp2JXC+OoSBhDfCvOFPvi4GT4zW2QBvcdcamyvWJArJpesE8yrlRuMDB8MsCVjjpcKk
         /YAZNjheyJ2BY4bRyDCLAgxRdtTrkQ0BSbF8tGYoNc5NbD1CuuSz6FDLGpp6yN5U+zHi
         NZVDO51GUgfbL4SGK5a+K+hsD+JNCOS5SfDJzvYwU/4vUpD5pqXZUUDYz9199iKUHwCo
         ayPw==
X-Gm-Message-State: ALQs6tDLa7n3KaAj2x7FuJAm79lXcPKoJmLoDY5NyoDaLMkyBPp5EflP
        Dcf524pu2SNHvTlW9lSMul8=
X-Google-Smtp-Source: AB8JxZpe/5aCeL8X6iKQmun66jJYD4fX9JybBQrFJRFzYi8IQJWwoKiYCf7w2xsywNbPUQJXhkVEjg==
X-Received: by 2002:adf:c6c7:: with SMTP id c7-v6mr2223480wrh.104.1524846098828;
        Fri, 27 Apr 2018 09:21:38 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274? ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.googlemail.com with ESMTPSA id k23-v6sm2250862wrc.59.2018.04.27.09.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Apr 2018 09:21:38 -0700 (PDT)
Subject: Re: fixup! [PATCH 1/6] doc: fix formatting inconsistency in
 githooks.txt
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <b227d2b3-dfe8-09cf-2705-da70bfebd268@gmail.com>
 <20180411210857.22598-1-asheiduk@gmail.com>
 <20180411210857.22598-2-asheiduk@gmail.com>
 <CAN0heSpD+TurNsP9Xtwh2OwQaenSCJ2GdpDbZWoifPDBC+tZHg@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <ddf24ddc-d4c0-96a6-ca85-c541df26c532@gmail.com>
Date:   Fri, 27 Apr 2018 18:21:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSpD+TurNsP9Xtwh2OwQaenSCJ2GdpDbZWoifPDBC+tZHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.04.2018 um 21:36 schrieb Martin Ågren:
> On 11 April 2018 at 23:08, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> - reflow some paragraphs
>> ---
>>  Documentation/githooks.txt | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> I have reviewed the resulting githooks.txt. See the diff below for two
> more instances that I found. For the second hunk, I have difficulties
> parsing that paragraph, but I still claim those should be backticks and
> *git* read-tree...
>
> Martin

I've added the fixes for the next reroll and put you into a Reviewed-by
Trailer :-)

Andreas
