Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2AC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiEYKiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiEYKiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:38:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA403980BF
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653475068;
        bh=aOqlD959IogzbYjKBSed7LWFW+wXKB6REg4ADtOvnrw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e/2hTNDu9dUFNUU4mAgjB4dFePfh4dOY+w7tAmWOxpLyKfgV9m82EyCP6V/a3aPQp
         amKXlPVQ6DnnPvlu23y0hnQHtZLwgsSKn1omEK6y0NIanOYd8hxYOAFncsrQaH/DTS
         whPS+ENULd6Zo55czdml3yh8rPNTKFEH2NfW4xxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1nmvRe26Wo-016uGM; Wed, 25
 May 2022 12:37:48 +0200
Date:   Wed, 25 May 2022 12:37:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Ed Maste <emaste@FreeBSD.org>
Subject: Re: [PATCH] ci: update Cirrus-CI image to FreeBSD 13.0
In-Reply-To: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205251236380.352@tvgsbejvaqbjf.bet>
References: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rkJ0H/rprD95QPyc18KWdM8zm6074OyP9kCVGLqt342lTnTLkkY
 3C0UX5HMduIckTM8ICuZSrQIUStHJSYsvJDNT9bS999ZCViOGeGKasQSO0HPX3mQXWYku7K
 5GbIG8u8ptXGDD6ImJzR4Mq/UaMh01OFS9rV+p9crmoHtH38sdXRAS8g5ypiW9abcJdWTtG
 C8si370c90P7MAZYyL6YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XZ8UY7Z5MPQ=:jUIegST6oqftieTtB3xm8C
 HVZSEP3hTnVrB28WvyzQz7nBu2bczPYxFoUNgTAwJg/6UNTHnlC2CUV2C9nHpRn95xEAPofZi
 /EWz2XVdutD8sisReI7bW8q9UBE4Gof6zlPprDtpQOV4Kv0OpEKlGVbKYla/yMP2i4B1AKrDx
 kmT+HCcYFnHFcPhrA262vJhK6RHDUBRutMqlJoC/tkK3OIpx6jMhln9+P4GBUkp4zH2Zx1wOw
 ye2VrimAgd2ZAMfa2u0CqTjE4VdWGEdWheM4r4X5wxxnkBNCAKV3kqgudM12p+BLPEaARP/Yi
 mu+ggLZ1TTKhvN2MsXPfuQ7/Py3lxnsXH5GDItTZTmgUqniRFxfL8vvFahcshWZ83XgBGX4/C
 tTI8VTtuB+IZwavvMmTadsztjCuqPQCr76DmEVs23ciIO4/Sf1ky/nD3c828DJZbN29egDGmk
 qmI+oNG4PJz6bmI3WLx/nak/yWtsxCI2/MBJsAFxenXeWjQCgmuaA+I1oJtR0fq7T66NaOM2p
 dYhYhBRnUaaOCOLPUgB34NjXemV0SfR75j5qSUVNE5SWkYhfZeE4SGy1akZAL0Qx8SAvoowp8
 I+QqvPNJUlgWTQ1Ds+uUKE2pm+HYy9MwzQTvuY7IpSnUk/3eerTuQLngQZ/Tx7oCjbN0NOZ5L
 Y4qL4S7zwWp40vniwNQsO4bG0LUFdCrupPRGgbLK4YiNoufJz4soUomZfqQbNXOkHh0bRhr31
 gqtyBBzSSEOl+TSj4q7Y1tHZi260AXbtHAq892R2owSPbu8eSpMeUVOPsTIt68rZ9x77miHQr
 JkqyF5FksQGONf86kcXeMXoVw8lfp6DfZejZumTVRBWvbjioBFV57e+qca6lAZzPsDhmntNWy
 3ru+NPPuvZ7u3VScHS6okrSw/P9hH/6EEAgkAvNLphynIWyqHRAJ2++8eYkXZyX1WkXfSGXRo
 OM6S6ssqk3QhZLbLVro7V1WlbnLXqv/aJuNbNI9js8VqCYLkcm9or4ET5qIxfz3LZP7ev4PJ5
 3kn2zMfdBWHcwiMMg3xkkOhbbzEzyLQ//WIEBI8YFsjKcP+ou1dnhx3CyLa/vrTOYtoQvDSsG
 iP3ydCkSkAKrbAfTnF6eTYwwdbm2Z5jmnMqBZ7kf2A1F7ihmHDeleIw2Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Tue, 24 May 2022, Philippe Blain wrote:

> The FreeBSD CI build (on Cirrus-CI) has been failing in
> 't9001-send-email.sh' for quite some time, with an error from the
> runtime linker relating to the Perl installation:
>
>     ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Un=
defined symbol "strerror_l@FBSD_1.6"

Thank you for taking care of this. It has been bugging other GitGitGadget
users as well.

>
> The first instance is in t9001.6 but it fails similarly in several tests
> in this file.
>
> The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
> March 31st, 2022 [1]. Switching to a supported version, 13.0,
> makes this error disappear [2].
>
> Change the image we use to FreeBSD 13.0.

I like this minimal fix, and would be fine with using 12.3 instead (as
Carlo suggested), too.

Thank you!
Dscho
