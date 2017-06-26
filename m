Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA6020401
	for <e@80x24.org>; Mon, 26 Jun 2017 09:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbdFZJyX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 05:54:23 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33732 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbdFZJyU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 05:54:20 -0400
Received: by mail-wr0-f171.google.com with SMTP id r103so141919517wrb.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 02:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+ki3YRe3zRuEPL+TGmJ4H/52UIZJ3cAwp0REy9J633M=;
        b=Kh+bnjV9GYj8tS+kcdD/hrQvRTDhZXpWWKHkqOrb1ycCInpYXs16iRoMZC7mu4nH+e
         S4Ef0GVTYLZktqYg8aqN6VtoxFrGAEERZ97ercTqmBwBDqeHkI0vyImSv7mFq+epPPhf
         3p9TGUwaF0wkFjwhrFmtnLpJQI206bbwvJAUlrf9LD1vr+JjVENd62Fz+DBWfJFOs+tY
         PNc/dXaA7yO4HxrNj/8OqQBBmR5mTcgksuYnUTmkM9VZqZPYo/C8fWPyXnS0x4YoLOnz
         LpYrcNumhuNQMTNC/egvoUJUEgeU+3YVlRIeNv6+RTHRxysa9MaEVefQ3HL2sg8HCuZw
         UfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+ki3YRe3zRuEPL+TGmJ4H/52UIZJ3cAwp0REy9J633M=;
        b=bpC0ZEOW7B5UWaY5beHDQVthIsg7PP7R2bB95exnnXczMnRRwjsW6fABNU/xWBElOY
         Dr2/0bBBbrBWXz1TKG0WDJWqC14foupdgMQM1tBk9M863t7maRD3BjRWMObSZnNn5J4e
         b+h0mzO5E845o6+FcO/9kge7KxqDyoR9V8GlONLf52SvKH0br/qiGanhmEi2czMH3iz6
         zc6WZ16lNveNv9GtF3kuM9gAbBefrblhB74PYFsjziVzymaORHtRPI0xRm9kbEJqRaFD
         +4zxRFSV4h8R/o0MGQyghYuJP0hZ4G8bAKSmXCVdDmUq/kdyW1D2LXYL5koDdnPYVOXq
         ynRQ==
X-Gm-Message-State: AKS2vOz5BEIg+aqQiWk45r7//WnCPiAFR93vUWnb8JyY96ZAEvRu3E1A
        LOdfEI7MkrX8LQ==
X-Received: by 10.223.163.92 with SMTP id d28mr14014302wrb.98.1498470858602;
        Mon, 26 Jun 2017 02:54:18 -0700 (PDT)
Received: from [10.32.249.40] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 201sm18066552wmy.15.2017.06.26.02.54.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 02:54:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2017, #07; Sat, 24)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <87k23zccc2.fsf@gmail.com>
Date:   Mon, 26 Jun 2017 11:54:16 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0D3C60B-84E3-431B-A600-546ABA1D1209@gmail.com>
References: <xmqq4lv57ypx.fsf@gitster.mtv.corp.google.com> <BDD05B04-C845-43B5-8E22-D215403D2A6E@gmail.com> <87k23zccc2.fsf@gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Jun 2017, at 11:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Mon, Jun 26 2017, Lars Schneider jotted:
>=20
>>> On 25 Jun 2017, at 01:25, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>>> ...
>>=20
>>> * ab/sha1dc (2017-06-07) 2 commits
>>> - sha1collisiondetection: automatically enable when submodule is =
populated
>>> - sha1dc: optionally use sha1collisiondetection as a submodule
>>>=20
>>> The "collission-detecting" implementation of SHA-1 hash we borrowed
>>> from is replaced by directly binding the upstream project as our
>>> submodule.
>>>=20
>>> Will keep in 'pu'.
>>> cf. <xmqqefuab571.fsf@gitster.mtv.corp.google.com>
>>>=20
>>> The only nit I may have is that we may possibly want to turn this
>>> on in .travis.yml on MacOS before we move it forward (otherwise
>>> we'd be shipping bundled one and submodule one without doing any
>>> build on that platform)?  Other than that, the topic seems ready to
>>> be merged down.
>>=20
>> What do you mean by "turn this on in .travis.qml on MacOS"?
>> The submodule is already cloned on all platforms on Travis:
>> https://travis-ci.org/git/git/jobs/246965294#L25-L27
>>=20
>> However, I think DC_SHA1_SUBMODULE (or even DC_SHA1) is not enabled
>> on any platform right now. Should we enable it on all platforms or
>> add a new build job that enables/tests these flags?
>=20
> If we're cloning the submodule, which from this output, and AFAIK in
> general happens with all Travis builds, but correct me if I'm wrong
> we'll set DC_SHA1_SUBMODULE=3Dauto due to this bit in the Makefile:
>=20
>    ifeq ($(wildcard =
sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
>    DC_SHA1_SUBMODULE =3D auto
>    endif
>=20
> So if (and I think this is the case) Travis just does a clone with
> --recurse-submodules then this is already being CI'd.

Do you see some other way to check if this is part of the build?
Would it make sense to add this info to "git --version --build-options"?

I am not familiar with the SHA1 machinery... but does it work on macOS
even though we generally use APPLE_COMMON_CRYPTO?

- Lars=
