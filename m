Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD62C433E3
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927FD207BB
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Nhe3KRLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHSTXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:23:23 -0400
Received: from mout.web.de ([212.227.15.14]:47311 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgHSTXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 15:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597864962;
        bh=mYDeQF3i/Z4igwu0kL0WAb1BN+48X7u+NYDvtZDQe18=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Nhe3KRLl3Kgi11go/hj2HKCSAWPLUD43MNoi3mCIXtQWBEELKMc6NkJPBFMq5ZUfO
         iGAKtUfdrWX2tFynBpllsVKK3cNbafRDt/F8LHByvcnTo5WOU5dBwQKoT8Cll/ubGb
         UU/4seVVnKCE8fcaVQwYnn6UPO6REvFkBpBolans=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.157]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKr7w-1k8TfW05vU-0000mV; Wed, 19
 Aug 2020 21:22:42 +0200
Date:   Wed, 19 Aug 2020 21:22:32 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'git'" <git@vger.kernel.org>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200819212232.272d7828@luklap>
In-Reply-To: <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
References: <cover.1597853634.git.lukasstraub2@web.de>
        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
        <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jB93fWs2Sl5DAAITCtDJ2u.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:f0Z6kSXENUavvqZ0CFfXebVdlQawKB5YnD3fNyy0J39ckr3BiKJ
 WijD69pjoz+tBKPDjmlTvQtQQKDYaDoc+4u4vMJiEwAWNtdtaEd9/ASqGjHZ0xZz2xh9yyv
 NQvIB7OuIS7eBMnkuq+jCL9rSYPkPisNSNvJyigpdZ4krbHFR3wQkhzH39s5kQHeWGzyIFj
 I9p8nZKm8Q74/BvQV4o7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5NEo3Z9v0Ik=:5hbYslIKD/VDWgPW1zfwZc
 4qW/U85SRPvExbfTxw+1XEyBz/O2I4UEQaSvYyqXLX9QTn+A9/wTt8RVla1blU9Yh7RjQLf/e
 TfQo7m1D27YNR0uJDsf+sjLGf4CY/aKWaUP8DLDHgkb+ZNiA+mQSElrg468aEfQb07JFNOSxJ
 rnDMSLPq4x5uqn7XJ/ai22uila4iie/Se2qgkS7OklJWGyGMWn79l+nbZH7pcWiJfZXRHT++J
 o5c0Qk7+zZW54HRADIPyaq0mdF/SbL3L1u3UwBppQe1NUBB4f1sAfgF9iqUCha3sM4/AY7cVu
 9EFHLDwJQuJwoy/fqFJyrBaLXKJX4lIujyQnwVOzxwcLMySVdP0uNPXMh4xWkGmwOKiesfsdC
 fd21o8qaAg21Tzte6f5XJ8k7J733Fcu6Z3h9uHjki5fF+BpHR3AFxZb3nI9QCKDVpXLEQn6eC
 nQQM5/YxZfxI6EQ+/X/BGnFVmILgNOUIll5z31K/f4ZIV6TuUBC71gwCs5lZfSRmELXfTUVD4
 ZiSZH6R/tHBPT06fYJJPAgEIhqO2CURzqiLlXbRyqhM6ZtVQeCfVi1Ti8STaXiyA4PxUmkAfF
 k60HT2SbalDOrREq7Ma+q040q4CpudMq2QmivYAj5ug1LG3ETGGkJffiHpSqQREHNF7BJsr0s
 hxsWjbJAgiFL3zExmgrJxvTsLChMPdB64yOipiPyM8xu9b92LN6dH7CnzVKgdaXvsNKUkqSlj
 juAEBQi8FGwO4wYh7StG8AMt1bcirWMwkmDG+HbyoBoHNEnXOuSnX/31opKHdKwKtqcFSm1Qp
 dR1RLjY45sZSMwbfzGkn4c6WzSPqXMjEbX4/Ad8ZlCjCjahBTt4Edg1xtTQGgGmLr3/leOSgB
 vOfYz/u7QDB00674c8pKk3fM0CTsPNFCofdun20zM7dcD7IOD4m8qZQyUMfpF69GbWEh9589U
 uU+Lc4GUpJ74a8pfV7qbSG+spcMPR5FaI80lXdAiz/pAGiFDfMd5vEAiW1bz1tuDbexP0x1UI
 0/Pxf220BbqJBGTR/62tHz6TlV15wXZGtfQDZN2wnQWO48HpFXZgYoC8c/5PiLm4+9+Ev1E4V
 MEXjhzlY51ZNjUUNgRDqJJW+TpyMf9J9mdBlU7LHWpYhIaMYmuRFpY4hKYlLRUnA4etwqbNEM
 o0CSPljtk2tG8NnGWG5S8HTSXYa3VehM0FvNfPUBt0AgGud1y04s0TvbDY5l88brhaM6M1Qpt
 3SZApwyzTHkVXr3/vdpxaWSoJPBqIke8J2wwTZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/jB93fWs2Sl5DAAITCtDJ2u.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2020 14:47:18 -0400
"Randall S. Becker" <rsbecker@nexbridge.com> wrote:

> On August 19, 2020 2:04 PM, Junio C Hamano
> > To: Lukas Straub <lukasstraub2@web.de>
> > Cc: git <git@vger.kernel.org>; Elijah Newren <newren@gmail.com>;
> > Brandon Williams <bwilliams.eng@gmail.com>; Johannes Schindelin
> > <Johannes.Schindelin@gmx.de>; Jeff King <peff@peff.net>
> > Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
> >=20
> > Lukas Straub <lukasstraub2@web.de> writes:
> >  =20
> > > These patches allow this and work well in a quick test. Of course some
> > > tests fail because with this the handling of nested git repos changed=
. =20
> >=20
> > In other words, this breaks the workflow existing users rely on, right?=
  I =20
> do
> > not know if such a behaviour ever needs to exist even as an opt-in =20
> feature,
> > but it definitely feels wrong to make the behaviour these patches =20
> introduce
> > the default. =20
>=20
> I am concerned about broader implications. I might be stating the obvious,
> but a key security vulnerability that would open up here is to put conten=
ts
> of files like .git/config into a repository. This capability would allow
> scripts to be introduced without the explicit knowledge of the user. While
> I'm sure some of the heavy clean/smudge users might appreciate it, this c=
an
> represent a vector for the introduction of hostile code into an environme=
nt.
> While this enhancement seems like a good idea on the surface, if it goes
> forward, it should not be the default and should not be under the control=
 of
> the upstream repository. You would need loads of warnings about potential
> script hazards at the very least presented to the user, beyond what is
> already documented in git. This change would not interoperate with JGit -
> not that that is a huge concern here, but heavy Jenkins and other pipeline
> users could be significantly impacted.
>=20
> Just putting my CSIO hat on here. We would need a system-wide setting to
> prohibit users from using this capability.

Good catch, this is a very valid concern. So at least opt-in via git-config=
 is needed.

Regards,
Lukas Straub

> Sincerely,
> Randall
>=20
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>=20
>=20
>=20


--Sig_/jB93fWs2Sl5DAAITCtDJ2u.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl89e/gACgkQNasLKJxd
sli2VRAAocszkMlVUwZpSACjkzZy5mmMd36sKfV4JeI1l3H1AzJJkLw7FacIWbLl
hg7hWU1graD1XksjHd/kN0DhZq/iW1YktzNNNKhgrGufMvOY8Lafhow1aLkFRY6K
UF403PBZifWuO7EDK+/IkQydctpRlni71cutdJBSKaaqA0ZhIlV209k/TmsG0vab
PjvIDl6zVVWNkfm+qksnrRzRn0kbIVTjO9Nw+GzntDwCiBcter3B4K+c/4F/5Ose
vIJuIxXTNkXHFB/RayNEG1pKbnpWWcy5ic5NC/APoJ3P9QVO58dWcEYznw2G1Gtt
UMqhzVUS1yVuNYKgKSWhSR9KXYUBkL6pL75akhhYlBM65sdTTcs8ymjZIsygTjZT
MiX6PCCt6CLMziSwbiJcQmq36bKUlHBc+ZDEtTLcT94tZyaXIdNxDpPliUiheSik
6ImW83s4XvBP+9//3cGl+bIKDV0fi9F8GaR2P3iEHRVcRkfH1ydp6TwpYIeFw9kp
kdbveZT1ScWSwQhy8CNc+yofNA6HMKcbUDnz4ziSBy2BBtgMNWNc1ZPWTfnTFiSw
5WMKMWXD0p6Mv4ek520x6Qh6r4LDnishEZ0DSOvNhv7MbMemjJFdRXrPgY+QYLIJ
yjPWY7sc50rOPTJvoITNdltecjPbmNGh+7MIYg7IpmbEXCY52Us=
=9T0l
-----END PGP SIGNATURE-----

--Sig_/jB93fWs2Sl5DAAITCtDJ2u.--
