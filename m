Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E416FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 13:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD2B6328D
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 13:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhHPNDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 09:03:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:34601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhHPNDc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 09:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629118978;
        bh=TOtr5ecsZdBf7kryhw6LKVvtFVjb/utSoAuYbNlhI+0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=l9GYy503Ji3zZXKGPv+Owg/+F2CvwxuaWKVbtnydMFAnrbtOzZVTLO63u0Ue1Kb42
         ubJ7+XVY6jCEUNdcRaD9Qi4J1x5M3whNAAAyhGmpEjFNfyw+S1/gYpj6fH3e/H38W3
         aIVzrvV27EMSQDphXdTae+ZpozZ1KMj4oCNzvjLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1mPD3V00oB-00AjKy; Mon, 16
 Aug 2021 15:02:58 +0200
Date:   Mon, 16 Aug 2021 15:02:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Atharva Raykar <raykar.ath@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=93_Week?=
 =?UTF-8?Q?_11?=
In-Reply-To: <m2pmuwrp7x.fsf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108161500200.55@tvgsbejvaqbjf.bet>
References: <m2lf5lxog6.fsf@gmail.com> <m2k0l5xo1q.fsf@gmail.com> <CAP8UFD0V3hoDUkeMyAaeo_=cZ46P-Yka1v67FFNbQ5Me5Hh_+g@mail.gmail.com> <m2pmuwrp7x.fsf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1858048464-1629118978=:55"
X-Provags-ID: V03:K1:EYxsyonncONSU4c0Z8Us+UECXs9et59qCQs3IKn2wok01vke5qZ
 Wb97Q08Vz79Joa1WnAcWmSGr8nQ0GGOzAj0FMG+D+qdThDfV6qge+mFIXmQ/ktiiPqhyq+C
 Qr0HZ9zs/1s8X8B0dbhqSenliQKHCFcBzN4qALJ2LGovp67zTTedfGiqeBF+E5nhDdgsnpS
 +E+1OlpI4tiEz3g5O+XeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mHdQDky8xjY=:ZNLGEycz3aN/59xAiN3eKV
 VgJD4qogR3aypmXabEFV7+01RSXCTHGsGFA5cWoq71HIJMBiErEOS/TinwF3DwoeuLL9RnRoP
 LvrKsxvONWX9zdlvrMnBiMQ22UA6O7qaIWLJp85oMJ8EABFKf56SxJ2UzJEItA+zY/3AA23Ui
 5OIryBqQ37j6ojsoofz6S55LL5teHINIp3oFBXhfCVq5Qbirh10k7wmpdFaYl3cSsjP3KpjMY
 EkZDtwVFUDPn2L8bxO51CcGa1U+uwtWV4aRhhCTutPnoVnYvTCbS/CdCVk34OclpycAeSNouF
 5cyxSZqHc7v0ugdhzJcc8ydHoUSSJiP0YrPrpvcdeT2KIViD3Ut2jex18cNUoI+zkXPjPsl/N
 kGzlG7CwCI5Fh3Cnkeet/6Gci3EzEhxT0E9qc8sk1OXAiE5O05JnTnt34H8TTVhdunFhfbKS/
 EjdqWGM5obA66LGj754zrja5ULXyQVpQy+GXTLOX5t8Vyyi9vBtPXDjenEv9saSHWkDIJw7Mt
 2DZSXcCf26FDX98uWsjrJfFii+NM0glPWy23dAErXIx7yGmM70HmIg0o4NqGbkvBZmfLM5TLR
 OwlGIhBx6E9Om/UQg63ouRa+GAnQA2vqU0umja7iOtRucCqfrVy/POvKxk8fw+344sLu7/OVI
 J5LkZcGap7cbZmvfCVxPjDkPmLJUPCLjLyztHIwgyCm8nbYhVR/3G4UUxo+RXX09HuMVBsjM3
 htC/uizG5FRa9G+SCZWCqVByuarYWKXHXL2lWG1nO9yKSbRa7u2GMbm6IekqWWvsv8VvpE3ap
 K00Tg3sQ5No2RWFyQmzYEenUyichZNUckHN05Q8sIC7uIRYZYg63oxH+5Vu9/n5GQMh9mEfGS
 N9L0JrEDl180D5z9gPJKMNOMTu7k+cCLnN5Ef4/0eoVszsB0+eBdH3ifPYjSIofaiIt+dFtro
 hTYgdONRFEqrElC34VdmIKtultUkf8Z+9CMPh42t9OzPSDEbXmC8BDSCqJVqz6LIQaxapEF3n
 IRe+d/VZLwvllSBX8CB8U3KvlCaZB3VYibzrwGK3neU3G98fuf7pBXXJZBf7oSUWoOIVc1Xpo
 MqAdtxIHUcIFAcs6i1iHliSrrew/cdng85XvELMxkHhrf0u5cI7iGO2GA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1858048464-1629118978=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2 Aug 2021, Atharva Raykar wrote:

>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Sun, Aug 1, 2021 at 4:00 PM Atharva Raykar <raykar.ath@gmail.com> w=
rote:
> >
> > > Here it is:
> > > https://atharvaraykar.me/gitnotes/week11
> >
> > Great, thanks!
> >
> > > > Preview:
> > > >
> > > > - Project progress: where I discuss a rough plan for making =E2=80=
=99git
> > > > submodule=E2=80=99 a
> > > >   true builtin.
> >
> > So your plan is the following:
> >
> >   - Rename git-submodule.sh to git-submodule-legacy.sh.
> >   - Create builtin/submodule.c, that will read from a config switch
> > called =E2=80=98submodule.useBuiltin=E2=80=99. If this is set to false=
, just call the
> > legacy shell script, else use the builtin versions.
> >   - Copy the functions from builtin/submodule--helper.c to
> > builtin/submodule.c one by one. Make necessary changes in the flag
> > parsing.
> >   - Once all the functions have been successfully copied, make the
> > default value of submodule.useBuiltin to true.
> >   - =E2=80=A6eventually remove submodule--helper.c and the shell scrip=
t
> > entirely, and deprecate the =E2=80=98submodule.useBuiltin=E2=80=99 opt=
ion.
> >
> > I wonder though how in the tests you are going to check both the new
> > builtin submodule and the old git-submodule.sh? Do you plan to run the
> > tests twice (once with submodule.useBuiltin set to true, and once with
> > it set to false)?
>
> Yeah, that is what I thought of doing--first test only the component
> that was ported with the configuration set to true, and then test the
> whole thing with the configuration set to false. It does slightly
> complicate things more than I'd like, but I cannot think of a better
> way.
>
> From what I could discern from the older threads and other similar
> efforts, this was how it was done.

You can use the `linux-gcc` job for that, imitating how b2627cc3d4b (ci:
include the built-in `git add -i` in the `linux-gcc` job, 2020-01-14) did
it for the built-in `git add --interactive`:

    ci: include the built-in `git add -i` in the `linux-gcc` job

    This job runs the test suite twice, once in regular mode, and once
    with a whole slew of `GIT_TEST_*` variables set.

    Now that the built-in version of `git add --interactive` is
    feature-complete, let's also throw `GIT_TEST_ADD_I_USE_BUILTIN` into
    that fray.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index ff0ef7f08e7..4df54c4efea 100755
=2D-- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -20,6 +20,7 @@ linux-gcc)
        export GIT_TEST_OE_DELTA_SIZE=3D5
        export GIT_TEST_COMMIT_GRAPH=3D1
        export GIT_TEST_MULTI_PACK_INDEX=3D1
+       export GIT_TEST_ADD_I_USE_BUILTIN=3D1
        make test
        ;;
 linux-gcc-4.8)

Ciao,
Dscho

--8323328-1858048464-1629118978=:55--
