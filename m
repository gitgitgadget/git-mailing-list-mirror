Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1ACF20954
	for <e@80x24.org>; Fri,  1 Dec 2017 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdLAPl5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 10:41:57 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45626 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdLAPl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 10:41:56 -0500
Received: by mail-wr0-f172.google.com with SMTP id h1so10528409wre.12
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 07:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k2IxAw48FpTn4yOeLyuiabomVupJRZUbF7/XtTlFlFM=;
        b=f4BqIEAcukmJAHdokermQi5RMs5flHJb3cN+QcjhzrWURMYhlf30hnxZxCPHyRVaU8
         pFus765dzVhreraHK8sC+AJEev4de5ZgWyupkiF8m2/7mG3Bc+LGM6i9vIFav7yEwrlb
         APjRkOBsbxBYUjzCiJHk4Cg59nT5coYi43SFd7eJSqptXpGylIokZkmRP6vpWaQdn3xa
         0b2YBCSMZvyCUcMZL+5CtY7+VYD5qDDxQBRZSuTp+J4q7FmFcOOat6+rH8/+kWPvPPGI
         zfIbYlEV20pp9sk32AQfXNZOXvGNsmVuWznmOrMkKyW8cE2r0Mr35ZmOQNm13im/1Iwq
         njwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k2IxAw48FpTn4yOeLyuiabomVupJRZUbF7/XtTlFlFM=;
        b=SIUgbI8FxiVpZfyjkWhHgpiR7rQR1k96lKFDNFz41cjwz2SSeyCHP7isl0Cwy4cUlT
         nlrrf9WY9opJ2dFtRcbev9/OSRRAYmO4rh1PIqhgdMKuySF8brWCvesnJjjZqIqGBF9N
         y152ysD0Db9X4vpzqAbALbDqcqtxK+tpXF/pFtfc1oeL7F4ZRtuRqMDualXprlU6Z84Z
         5NHgKNIcL0mmRxs8c5xT+Fg+T48TVTHvWr1zURbOfL5ex0lqSFArRIZtWMt6s3eYs96Y
         iWg/uCK00a/NFi3a5Xfy2oopepoXDjhgZD6yheSH6EyE27WsEQfEhls44H9ZcJv6EnhB
         scxQ==
X-Gm-Message-State: AJaThX7WsojN7cwi2sC0IC1ToMTDdxljpHkxolupXf5resbXkj3+y0OL
        8TWhHZPI7LKfnAqMEXX22+k=
X-Google-Smtp-Source: AGs4zMZQYv5lwuV6bLOaUGW2O1GYKWhlMOOjspH5pDY2ZPigh9w1eYOebXfCTdztrP49nGjndGjqlw==
X-Received: by 10.223.197.131 with SMTP id m3mr6019859wrg.203.1512142915769;
        Fri, 01 Dec 2017 07:41:55 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m50sm10744644wrm.12.2017.12.01.07.41.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 07:41:54 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: jn/reproducible-build, was Re: What's cooking in git.git (Nov 2017, #08; Tue, 28)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.21.1.1712011526490.98586@virtualbox>
Date:   Fri, 1 Dec 2017 16:41:53 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D62C3AE5-D335-4325-AA26-209CA0570479@gmail.com>
References: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1712011526490.98586@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 01 Dec 2017, at 15:32, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Junio & Jonathan (Nieder, there is another active Jonathan again),
>=20
> On Wed, 29 Nov 2017, Junio C Hamano wrote:
>=20
>> * jn/reproducible-build (2017-11-22) 3 commits
>>  (merged to 'next' on 2017-11-27 at 6ae6946f8c)
>> + Merge branch 'jn/reproducible-build' of ../git-gui into =
jn/reproducible-build
>> + git-gui: sort entries in optimized tclIndex
>> + generate-cmdlist: avoid non-deterministic output
>>=20
>> The build procedure has been taught to avoid some unnecessary
>> instability in the build products.
>=20
> I like this, from a purely security-informed point of view. Maybe =
there
> would be a way to integrate this with the Continuous Testing we do? =
Like,
> letting Travis verify that the binaries built from a certain Debian
> package are really identical to the binaries built from the =
corresponding
> commit? But I guess Travis is the wrong vehicle for this, as Travis =
needs
> a *commit* to be pushed, not a new package to be made available via =
apt...

That's a neat idea. We could make TravisCI publish the hashes of our
release builds and then people could check them against the builds that
they have installed. Could that add value as a start?

- Lars=
