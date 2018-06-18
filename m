Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7695C1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 15:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965104AbeFRPBT (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 11:01:19 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:37625 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964921AbeFRPBR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 11:01:17 -0400
Received: by mail-qk0-f179.google.com with SMTP id j12-v6so9505154qkk.4
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I109Vq1JJfPFKcTwLCqRVFusXcSW3yrcmznVjINKIaE=;
        b=Yb1V+wFyleh7zkfgl3tmUbDGeoaHZzH9adaYeIbGiR2j+ydo8aTW1V+pAq2tRrS/Wk
         VQQesz71EFm50mZos4Q+VJ+pkN1PsWgG98Hzii0NW1Ck6vul9f+FqmOZXa/jGhyAGXJK
         PLB9xwIzvsuKwUckhMCuV5CCcjBiYZEp/O3E+/ARaehyyp2SoqtyzNAC03D5nFWg9WGZ
         9o/ChhuJeYNS17DJ8uGZk0hLy704BDIvGczmM239xxQ9+WXsO3HO8rYOiYUF/Rju21/T
         TqfUA6782BUxD/FV6pQo7A/mhIy1CSrWXRrKBI5oEOlawU8jHVd3KMnBKjK8rgfnscbq
         l5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I109Vq1JJfPFKcTwLCqRVFusXcSW3yrcmznVjINKIaE=;
        b=BgrRT4/kAR3zY8pDKSwYhdeSHudXM03gXgpy1eUXKRWc/oGLMSqH2MpHzc+w8EB0DG
         Ola/ybSKq9SYAZSt6jTQEOw9IpbGCUs6LN5fIK0XwdPMddsEN1B/QKl6sjBaHil2eTUs
         p1vA/LOfzHbNsWxChnShCMu8Hn3Ie3OpSkexy2v75mY0OkJPN2jY27pM5hsOqYAFKkDZ
         Jjeq7EqtOwS5wMt6v86gbaGrNBPzktqfGcMRN/xM61FV7ChcVqyy0dZNvBPGQdnNU+Gf
         otqddKyiNAoIfV5Wq5E671HP/4EjvSApIryzHGROByvN0FBUHRC4/EWJeysdlWtC2uJN
         25+g==
X-Gm-Message-State: APt69E10gonm04PZ7a8WPosWbjRceI0IYQqP1rNFXR4nfB5O6SMjywbZ
        dyCdZEZ18jXX2ne4jagJp0h87Wsb
X-Google-Smtp-Source: ADUXVKJ681J28OhHgloTCoxTTx8p2Hdawm+SRtwcQjmd6lKhxxWs38sguoPQDgeyhotjdq1aaWM3Ew==
X-Received: by 2002:a37:4bd8:: with SMTP id y207-v6mr9884182qka.98.1529334076670;
        Mon, 18 Jun 2018 08:01:16 -0700 (PDT)
Received: from [192.168.0.138] (cpe-108-182-30-78.nyc.res.rr.com. [108.182.30.78])
        by smtp.gmail.com with ESMTPSA id z202-v6sm10061172qka.8.2018.06.18.08.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:01:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: Git diff --no-index --no-prefix output loses leading slash in
 paths
From:   George King <george.w.king@gmail.com>
In-Reply-To: <CACsJy8Cgm6gryO=X2GmztynbkkEEV=nz_J+QZG-93fS7D4eDRQ@mail.gmail.com>
Date:   Mon, 18 Jun 2018 11:01:11 -0400
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9852F27B-0FB8-4A7E-97C1-52B5D0D9377E@gmail.com>
References: <DFDB0568-9543-4135-A56D-821D4244DC8A@gmail.com>
 <CACsJy8Cgm6gryO=X2GmztynbkkEEV=nz_J+QZG-93fS7D4eDRQ@mail.gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a feature request; sorry for the confusion. My guess is that =
it's a corner case that was not considered due to the default prefixing.


> On Jun 18, 2018, at 10:59 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>=20
> On Mon, Jun 18, 2018 at 4:36 PM George King <george.w.king@gmail.com> =
wrote:
>>=20
>> As of 2.17.1, `git diff --no-index --no-prefix relative/path =
/absolute/path` produces the following:
>=20
> I checked as far back as v1.4.0 and git behaved the same way too. What
> version did it work for you? Or is this not a regression, rather a
> feature request?
>=20
>> diff --git relative/path absolute/path
>> index XXXXXXX..YYYYYYY ZZZZZZ
>> --- relative/path
>> +++ absolute/path
>>=20
>> The leading slash on `absolute/path` is lost. This is unfortunate; my =
use case is a diff highlighter that parses and reformats paths so that =
code editors can autodetect them and link to the files.
>>=20
>> Would the maintainers please consider fixing the output to preserve =
absolute paths?
>>=20
>> Thank you,
>> George King
>>=20
> --=20
> Duy

