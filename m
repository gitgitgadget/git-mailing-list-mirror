Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE919C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9492223F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Tt9Sy4Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKMOKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:10:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:37777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMOKP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605276612;
        bh=J0SlujaNdritzhYa3PskDQx/4uqS/0iuJzCpGMUzefQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Tt9Sy4ZpNYzqYPZFrdOUB13RJUQwxiY8v3BHyHksBeNshrVEuR6lEqz8MTViVd4Z7
         d83U0RIOmsFO/A5zscLDWx1RuxDS2vIlinP14jGizzp2UJb2kDfcCMPKlOjP+AAF0E
         EtX1qKqNj+ta1wk8d/24Bdb5joz0J93piXZjjqSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1kdIWt0kDb-000u7e; Fri, 13
 Nov 2020 15:10:12 +0100
Date:   Fri, 13 Nov 2020 15:09:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: [PATCH 28/28] Change the default branch name to `main`
In-Reply-To: <87v9e9fujk.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011131500020.18437@tvgsbejvaqbjf.bet>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <f853fa946f5840518577584a5b8c51660da06928.1605221040.git.gitgitgadget@gmail.com> <87v9e9fujk.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-169209211-1605276555=:18437"
X-Provags-ID: V03:K1:NNleY5S0QRESTO6tC1TWwZTWQ0co2YIk8rkSR0TuamzjM+B4uzd
 Cf9GW6G9GiUkzfSILhrfo3GmYhfEx9vKDt8ALV9rI6VV5A5myhHTo0nezfhB+Q8uGtv81jm
 4wDDD971f77VC1MbRfpigE27FHpg8G+gi9b9xdFC3e/U/vJ20MYBbvL68pryU72QYLBb2fK
 NtxsFLW3uC3PCtfWO+/Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:APs+4Y1fSfE=:oID3kUMwhvUqauo5HGJme6
 yxSrs5FL6Gfh1g4aHjTwwnEAqCEiWm34dDWiCY2SkSRqQCvM0qmj9Anb89Ke3chbTgSWl6aPp
 qygLQgnYwBxvI83/W49eBXvqTSiUEGtoZAuWTw9UAi2F/9sYwR+OnkMl5m8WGKnF2xqfsC7er
 SePzaGzUw5KCYT1qo8caDX7RmW5KznRhlmXT7zukp9iZs4kGCEsAllna+3gOJv47ORVOK6zxT
 yBWQPap0D1ihVnp8Q2GzmS5OS4iPLnmF0kJrElX7E8C4kUqGQo46u+abkViuFCnTBwLL1rERW
 4Ovb2c1LeMzAkNiLHe8rtO9iGb/xUsw5QzDNh3wGmLZg2PZQw8zjVungHGx6fuwPbcutgN8gs
 g4KJ9PL9GZsH4G68dlyRgqFBJuGgvz0aCLqkEZE22rs08ZhxWHAZeEJwujaRldFFqVM7eTyMO
 ziKxGIBkURFA+J/Q1XCaduZ3XnCuctO1QVpHp+zScrxQp+oVo48bGmEILr+mKO5lWKgn0Pwoz
 9yvEOt5aKG3Z1ydSEMzx52AmxX/f4IQMS7BpQ5Cnt18oR9cG7xuxdMTYGA7e0IWIWTNQEsFD2
 wbfmrNWDj0uHCNCObHmm6/lJ6gmiQrXpMmgiG8FjXZbFW/ut7cnSN0QI2BsfRVidogQvAFejf
 ugMOQ95ptbYAi7oRKmE/7xz2ymo36RJeJtvPIKsebgsrs8GIR9mpyfTbvjIoYsqgaKQVmlf/f
 RMCaNJIUdLy52b7xRZCT/ubAOQ2lYbmr//X2hfkA6HJXXX7x0GQTilLD1cLavnVIABpOmEogv
 NbgbowcDDfSLk0MsiBJ30OxsjZJsu7ha10pJ4xTthr9Gi09bBIOjgGMbKAe2zPH/iQX6++A17
 hJ1+eHb6Zo9pfMSzzksyPpsxdf8SdJIh3cUKFB8ac=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-169209211-1605276555=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 13 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Thu, Nov 12 2020, Don Goodman-Wilson via GitGitGadget wrote:
>
> > The current default name for the initial branch is a loaded term, and
> > many Open Source projects renamed their principal branches already. A
> > common choice appears to be `main`.
> >
> > Let's follow their lead and change the default of `init.defaultBranch`=
.
>
> I think it makes sense to split this change off from a 28-series test
> cleanup series.

It is not a test cleanup. It is a series of 27 patches preparing the test
suite for the change made in the 28th patch.

I don't think that it is a good idea to split off that 28th patch from
the patches whose entire purpose is to prepare for that 28th patch.

>
> > diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> > index bd3fa3c6da..1b0abcb0f8 100644
> > --- a/t/lib-submodule-update.sh
> > +++ b/t/lib-submodule-update.sh
> > @@ -144,7 +144,7 @@ create_lib_submodule_repo () {
> >  		git checkout -b valid_sub1 &&
> >  		git revert HEAD &&
> >
> > -		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
> > +		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-main}"
>
> Earlier in that function we're doing a "git init". With all this test
> cleanup I wonder why not just "git rev-parse --abbrev-ref" to get the
> default name, instead of carrying the hardcoding forward.

My goal was to keep everything as close to its original as possible. In
v2.29.2, this line reads:

		git checkout master

See https://github.com/git/git/blob/v2.29.2/t/lib-submodule-update.sh#L147
to convince yourself.

Personally, I would have used something like

		main=3D$(git symbolic-ref --short HEAD) &&
		[...]
		git checkout $main

instead of what you suggested. That's a topic for another patch (series),
though.

Ciao,
Dscho

--8323328-169209211-1605276555=:18437--
