Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E2C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4215F20678
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SY7/KPw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgAHTB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:01:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:52107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbgAHTB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 14:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578510075;
        bh=aSU6sCLoK8bOlOk/40W6c94bZiygbZbKJn4+vFR3mSI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SY7/KPw2P4dQvyxBEm1xsnVWve2Vi/BwpiBUAQlLblA5FMI4l40W3EgisBzCGMGpC
         XZU2EXC1Li27QTBo7fTMlv7xMiJWKcX4n91Li7gAJphLyKt5C+mcBIZUmOk3sqksAL
         ZTpCeGbV1h5fDM6fl+Sl8nWG5p2AA/a+BVYaqGus=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1j6eq135oh-00ITmi; Wed, 08
 Jan 2020 20:01:14 +0100
Date:   Wed, 8 Jan 2020 20:01:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Heba Waly <heba.waly@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different
 branch before deleting
In-Reply-To: <CACg5j260h88bd=W_4EzAn7B0TiU02Y8BzKDQ7w3UJiHkhL60NQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001081945490.46@tvgsbejvaqbjf.bet>
References: <pull.507.git.1577933387.gitgitgadget@gmail.com> <pull.507.v2.git.1578370226.gitgitgadget@gmail.com> <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com> <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
 <CACg5j26jyWnAtM+mZ-FuN7OQWHpKk5nADG+7J-=metJMdO6+2Q@mail.gmail.com> <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com> <CACg5j260h88bd=W_4EzAn7B0TiU02Y8BzKDQ7w3UJiHkhL60NQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l1zNhDcJBSUx6gym2BlRMT6r/QlFAWmnjZvCJT0IZWTOCMpmeCz
 /RE7aA7fIzTzdtzna/eNp1w9wF+poJ/wD1vk+1k0/arnfdtC9ova4nbTAT/nAGdPspdaYyi
 4jFiJ1LHSe4/1m+sTGsH9IW957aUAUoCQclb0BZ6fKwjTSwQk1HbWUFpxHqfF9vMZZo/Ku/
 d9uSkzGDL4y3d1GZtwJ2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a4zU/mfkqSM=:rCfn9uzmesKaBW8R+bX11j
 vZ4Hp+Bq3Dv7oVmbHMP7CLse7lfQKpDT2Hx+/sdf+b3i7PDd6P2SdhOY9vz+caLy6OBggE/mB
 v3raAc+dGHPhtFMgqS5SnKnososmWRsQcdLRgnnRsY0CD4giG/V552DFICNAkfaEu7ecDk2ZQ
 VBiRMOICllJ73S3W0l5ouT1HmUx0Zsha3fDJ35vdTeOjcPY7iWlCUV/Zw+msavAS245loTaSb
 nCQ9SEsGranJMilGSEHXRFMHkeu2DOAvjUf+hY07PKfSknozA/BlxbFbX7yh07RvKTAfxCfHs
 ORlKOPKd5DFYwh8PMR6HPXcxTrUfYDITxQKtIo+Ir4CgIJxZzZs3Cz00KYwCFe8PJ1fw+5lgL
 /jWoiQX8GDeGgCrvQOOzOoQrXy824KjtixPSvM2rL1H/yDtNUTdYUSUjZR2RDncrWq7SFqVyq
 JeG9C1SUMJfaVX/hDAsrxd97scCu1ojQh+lepY7XIS/HwL1Et6ZTJ1M8RRgfirrLRLA70FRvZ
 JuEjm2StPRFt+CDYUZ7EB4HjI8LGchzc44bzHeOEO4sfenlRkRgmG+BkQN/MCsMfn+73vyEKP
 k4kJvd+cs9Dpp/u2oNvIlIhnAFStCW/FNwWbElgkcpEw4Qj6vI1zk9KAU9fV0CjbAznNSURTW
 n0ka9U7tvo/3us2psmoHa6qb96CaJjH4vFpg7y2G6rChR8xX4kcBqaIzZJORFmS8CSgKPHTYs
 MuY1NPLoXwLoZQxzDwB4+LUGOYWt8PR4P+s3mhZjO3L73j/Wjg9mdWnHImqDNPNpK9SRbpg2M
 Q4RZRaJOiFs2V4PVM94i6ef44hD8f3uoQR0PZjoVrRYzIbqhj9YNgIMleU+Co7eULWxGndVDW
 B/nmAVYKUuM5NgVRhAOVxdQ3XcjUMb1GjgffsOZ2magHIMdK4pSfO4LMqXyRHh/OdOiI851Ou
 1tKZTTwtsoOQggcxx6cOA2ruhSpOPeA3EdO76vFgyZkGV4PqqQA3qI+DpI7it9n4sp4uuBxSL
 linViFxOx3EdU1eXn1IcvCCDoS9Ni8sIeZFnX0Z1uynmgfQN5p/bdZTpP8Y044OoU3zZD3yP4
 +s9wVuSbd25DGRviWK+nc1eP36TiRE9SwK6iUO08zzs3lpvjijLLBGBZzWPu48Kg9jOmvMuDg
 yw+O9HtF1MnTDrq+NBF7KKRS8yoA2VPl6gw5t7RXdxK3JeTXG9i3GgpHyhkb1+3UTcq5N7wmf
 OqweqT+R1qjlRhcq3OqFdgSifVEKo8ZSWOMwIphox+saA+Ih2LPae3fMK6hc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 9 Jan 2020, Heba Waly wrote:

> On Wed, Jan 8, 2020 at 10:28 PM Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>
> > advice seems simple on the surface, but every new piece of advice
> > means having to add yet another configuration variable, writing more
> > code, more tests, and more documentation

FWIW I disagree that we need to reduce the number of config settings.
Pretty much all of them have a good reason to exist.

I _could_ however see some sort of categorisation as a valuable goal,
which would potentially make it easier to have chapters in the `git
config` documentation where earlier chapters describe common settings
and the later chapters describe subsequently more obscure settings.

> This raises a question though, do we really need a new configuration for
> every new advice?

I would keep it this way, if only for consistency (a department in which
Git still has a lot of room for improvement).

> So a user who's not interested in receiving advice will have to
> disable every single advice config? It doesn't seem scalable to me.
> I imagine a user will either want to enable or disable the advice
> feature all together. Why don't we have only one `enable_advice`
> configuration that controls all the advice messages?

This is the first time I hear about anybody wanting to disable any advice
;-)

If this is desired, it should be easy enough:

=2D- snip --
diff --git a/advice.c b/advice.c
index 3ee0ee2d8fb..28e48d5410b 100644
=2D-- a/advice.c
+++ b/advice.c
@@ -138,6 +138,13 @@ int git_default_advice_config(const char *var, const =
char *value)
 	if (!skip_prefix(var, "advice.", &k))
 		return 0;

+	if (!strcmp(k, "suppressall")) {
+		if (git_config_bool(var, value))
+			for (i =3D 0; i < ARRAY_SIZE(advice_config); i++)
+				*advice_config[i].preference =3D 0;
+		return 0;
+	}
+
 	for (i =3D 0; i < ARRAY_SIZE(advice_config); i++) {
 		if (strcasecmp(k, advice_config[i].name))
 			continue;
=2D- snap --

I don't really think that this is desired, though. Git has earned a
reputation for being hard to use, so I was personally delighted when we
started introducing the advise feature, and I have actually heard a couple
users say good things whenever Git learns to help them without having to
ask another human being (and feeling dumb as a consequence).

Ciao,
Dscho
