Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCAE61F424
	for <e@80x24.org>; Fri, 30 Mar 2018 10:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeC3Kcv (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 06:32:51 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:47097 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeC3Kcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 06:32:50 -0400
Received: by mail-pf0-f174.google.com with SMTP id h69so5216989pfe.13
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 03:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XseEpzVfmLl+EdTHAeXy12p9PxRBe2pNBow8E4CrZYA=;
        b=OzAYbJpz15HPT48xsCdGCz6NkQmQfHQ43A5ySHjZzkw6aQzYEXsOpsx+Nf4bU8kIWM
         71BuMmvGTRW0kJQ8x5gtGQKeCD8SUTA+QkVAOga9B4nzx0QfwjkfW5i4YRuijnsXnRo7
         ngC7gHwvQNz6gbupoHFbHkJZPxOrpcpc9QEC/Ova9WD3gc0MjzGp7bta3COGc7CDU5dx
         h4kzPW29+IQ8TVo3enngVGWsyX6n2sPd9kgB/Kr036IzkYaYTsPQecMITmasJ6prD1tT
         +qkGGLZM6zGcB4sSo2LIltLjOgSIIf5lP3qkF4dbqiounB1dOUOwMiqxIGrDr0X7jBu2
         RXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XseEpzVfmLl+EdTHAeXy12p9PxRBe2pNBow8E4CrZYA=;
        b=MZm/MJQ7szwiajjR5Ls/b/3U2eQDLPqCy+eFdTIk3We6tBM7maYrrTrxs7Y8k2JZb3
         JRUISRR4Ur5uMmy7fArue08PxURjmCyUUMCzEFA6L0rmhE80ZUV0U9kTeLoPZLMfOkiJ
         muZQ63SCRb73dpMxofja6vSSImrnhDm6OqHMobCjHwjutgqGgLpuBAFXxoDtRvv0q3Of
         hHqjUs3dPuJ1ztMVRIM9agc3zxT1eLy/5CLF7zyC5GOaXiTrEp+1U1F9NYNlrk6Jr57m
         qvT03dc+WH6l5oXij4uyhwDbRtvxAPycZqBKHd3SJ8wXsdqrEomd+zPPvQfk0nS6NuyU
         M/IA==
X-Gm-Message-State: AElRT7EXJdVMbrc5UL9XtLa9xjOICauuQPOpGdFP17E7F9k3PjiK3vJX
        LdKzojGCPRRwPGL/m4BzzRE=
X-Google-Smtp-Source: AIpwx49z9LOXXNQ9Bi6Mj6GJLn01BHYAohyBh5CMMokFZV91DiO5yXXQ6t5pPKVjAwwnLt9oWiIdnQ==
X-Received: by 10.98.17.85 with SMTP id z82mr9480980pfi.206.1522405969784;
        Fri, 30 Mar 2018 03:32:49 -0700 (PDT)
Received: from gnbjdf7qc2.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l19sm14708873pgc.92.2018.03.30.03.32.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Mar 2018 03:32:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2018, #05; Wed, 28)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <87lge9x6e3.fsf@evledraar.gmail.com>
Date:   Fri, 30 Mar 2018 12:32:42 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B86BE818-A385-4E0C-9AE1-1E974471CEB9@gmail.com>
References: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com> <87lge9x6e3.fsf@evledraar.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Mar 2018, at 11:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Wed, Mar 28 2018, Junio C. Hamano wrote:
>=20
>> * ls/checkout-encoding (2018-03-16) 10 commits
>> - convert: add round trip check based on =
'core.checkRoundtripEncoding'
>> - convert: add tracing for 'working-tree-encoding' attribute
>> - convert: check for detectable errors in UTF encodings
>> - convert: add 'working-tree-encoding' attribute
>> - utf8: add function to detect a missing UTF-16/32 BOM
>> - utf8: add function to detect prohibited UTF-16/32 BOM
>> - utf8: teach same_encoding() alternative UTF encoding names
>> - strbuf: add a case insensitive starts_with()
>> - strbuf: add xstrdup_toupper()
>> - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
>>=20
>> The new "checkout-encoding" attribute can ask Git to convert the
>> contents to the specified encoding when checking out to the working
>> tree (and the other way around when checking in).
>=20
> There's an issue in ca16fc3635 ("convert: check for detectable errors =
in
> UTF encodings", 2018-03-15) flagged by Coverity:
> =
https://public-inbox.org/git/CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmPgsdE1=
9q=3DPrQ@mail.gmail.com/

Thanks a lot for pointing me at this!
I'll prepare a new round soonish.

- Lars=
