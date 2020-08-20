Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EAEC433E3
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DAF2078B
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 11:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Iqqr+Xj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgHTLrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:47:13 -0400
Received: from mout.web.de ([217.72.192.78]:37145 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbgHTLrC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 07:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597923993;
        bh=cRWYLVYph9Q/KeAA4ZeRc3LZaTAwFWpoqcS+W769zFc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Iqqr+Xj0vi5FFxoNE3OBDHNULytCuIS2C1DaWfLCGgviOpoEGa5RCaY3gmUOOX2SN
         VNvq4LRkS5HzycHRw423M4P6hw6nzW0Nlx2urpvpCOhSLkS9hGvvETURezzY6jZfjv
         s7IGIphDmKWIikgE89XxkkY3hLYUWvPcDbg2AhNA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.218]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFc1h-1jugns0dN7-00EaLq; Thu, 20
 Aug 2020 13:46:33 +0200
Date:   Thu, 20 Aug 2020 13:46:24 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'git'" <git@vger.kernel.org>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200820134624.19095358@luklap>
In-Reply-To: <04bb01d6765d$3bb67e20$b3237a60$@nexbridge.com>
References: <cover.1597853634.git.lukasstraub2@web.de>
        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
        <20200819204750.6ce87f7c@luklap>
        <04bb01d6765d$3bb67e20$b3237a60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jDDJm+R0Jgx1tD5oO66cq0n";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:h5cQ5ELuPGWoSZB3lSSsMLFyUoMt5PJ8zwVrrjTQ73OoxO0T5Pl
 5RX4vznHzNoJHAWfWF/4cuoxr0sXD5qCk08EpwSAybDsjPuBrk8Ahz8xVvPlgxJjHIfr5BR
 maww+fM0I9FGNkkp3EyIDMYXOvwIixJT0djgzSR2wbCAgsvxnpo8GlQtrTgvIx67lkw3cUi
 op3EkXkKWVHPbEGNbUQGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XX4aUZsWqus=:DjPKgPTIyirGXmUWHaONzk
 RhREeusRZz+DjAhtO5IKc1dtshDCZQlbdIq2GWpZQiOoyr6HWBKOIv7+26DNXp92LO0oEW1Q9
 YN8/AfEugS0+BiYQW6R0hys1VjeZjiXdG16qrCw5+V0N+26c6uiTAvHlI2FTC7lNtwJ8SKf7T
 QGYhIN4rJ5Ss+cdQoh07+sVtfPxexhwnfY4lpiUNlhNIOeqy9+6RA48c0En8XlI0PwviCB6Uw
 sFdztzi0No+2lLSuJuzAX7NiTaJAc0/vUt86rwr4ejkHReIs89jklXdt28kB8D5KEyRgV8YI8
 ojyccFKC93kmFzQBFw2yEOPcWBT3N6ANrrKIbWKRGEzfivGpNmSLbtIfkNJy/qQXfqFXkBQ4v
 H6U+hXfEjouneEwrL79SWQAYVbW7Sc4ySMSzrsFSNP01mSnKfT9PNkkq5qt0kTt9T68jxIKaF
 hrTj0Vu2m7WQveqLntvnpvGQ/D2P7xupflkv0IJTAhZe8lcrvXsZovfS/C5CEro06pcm/5HTn
 82ABvcEKrvZQiHM93+0SLXykU0PaG1H5ptp+eOLO3W4X8anMmscGY/FKwBQz4p3gKzM5z+GjE
 aq32gbLHb0szBbrIJbMqaRGIcro/4E/obN412uXKrJ9J0o6vCd9vspv7mx5kEhaKxiLzUiH+X
 QSjUN/kBc3MSSe/qHnlzc5g3io0TcvmVwBsSPqcBpX5TbclY1fdl4rjns6P46ivWqrFcUX9wJ
 4FtQNtaQvH6AuTae8y5cSGx/KrQRb1AG2AHmz2IQdqm9GpJ/0BV53j7IqttzhbMBpDcnA83Gj
 OI0DigzB2Rp9gzAOJRGSzq9SRrqVym1V5cuUkcGPUmRLb184tO53bnuzK4ucJvABS4WSKHuOJ
 ZY5TDR3UelpQkOYnJ8KH23OnAeCOCRXXtzQViDMWhYpkZ12Ofbxz6R+EdYMoEoDwEHMhVGkev
 uPWBBkDosZy+Or0o88UASLr4JdMbRLt1WlNadezRIxT7kJ7ugk718eKsCRzUtcqejUNYTq3Lh
 s+uMFm8NYZ6UZbByp3WwLLtSLCOtjPFkZ3LV12TaMMmcfpJRaSycsHTV2WgwXGge/mzzVPB+O
 RSa1l3JzmzSQw3ITyOgFVMe5iHsuhZ5zsK2tiie8PRCk9R+KOaRGyOZVFaGJ6TLOIwDWXQpIY
 tB42JgjOZpYWRxiLxCq7RzjoVtGVsnHAApajsmanrGzDVjxJ3SQ+TpS9G1oHCEseZKqCffgSk
 MoJkCg1WWpFX2TR3cbiHMPb/oHNNYe3d9iMHDOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/jDDJm+R0Jgx1tD5oO66cq0n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2020 15:16:19 -0400
"Randall S. Becker" <rsbecker@nexbridge.com> wrote:

> On August 19, 2020 2:48 PM, Lukas Straub wrote:
> > To: Junio C Hamano <gitster@pobox.com>
> > Cc: git <git@vger.kernel.org>; Elijah Newren <newren@gmail.com>;
> > Brandon Williams <bwilliams.eng@gmail.com>; Johannes Schindelin
> > <Johannes.Schindelin@gmx.de>; Jeff King <peff@peff.net>
> > Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
> >=20
> > On Wed, 19 Aug 2020 11:03:30 -0700
> > Junio C Hamano <gitster@pobox.com> wrote:
> >  =20
> > > Lukas Straub <lukasstraub2@web.de> writes:
> > > =20
> > > > These patches allow this and work well in a quick test. Of course
> > > > some tests fail because with this the handling of nested git repos =
=20
> > changed. =20
> > >
> > > In other words, this breaks the workflow existing users rely on,
> > > right?  I do not know if such a behaviour ever needs to exist even as
> > > an opt-in feature, but it definitely feels wrong to make the behaviour
> > > these patches introduce the default. =20
> >=20
> > Well, the current behavior is that nested repos (that are not submodule=
s) =20
> are
> > completely ignored and none of the files within can be added. So the old
> > behavior can be restored with .gitignore. The same goes for files/dirs =
=20
> named
> > .git.
> >=20
> > Of course I don't know what the current policy for behavioral changes i=
n =20
> git
> > is, but I see that there have been such changes in the past. =20
>=20
> I honestly am concerned about a repeat of things like
> https://nvd.nist.gov/vuln/detail/CVE-2019-19604 (the submodule update
> problem). This change in behaviour is of serious concern from a risk
> standpoint. To be blunt, I don't think users on my platform will move to a
> version of git that supports this by default.

As discussed I will make it opt-in via git-config. I hope this resolves you=
r concerns.

Regards,
Lukas Straub

> Sincerely,
> Randall
>
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>=20
>=20
>=20


--Sig_/jDDJm+R0Jgx1tD5oO66cq0n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8+YpAACgkQNasLKJxd
slgQrQ/+K54eAzLkTLk1cYxVQ2Twg2ajXyLPI/8J01HoIjH3NkiCKTMW+5mMXDZL
QYqBvOFiJr5NB70KSyhh50krA9orLriC/gebJ2B9faQTn5SSMPttsCdrKuHvYqQl
F+3rFsrah//ynVPJs2Q7Jq0rc9zmfPrthtmpthEX/xvFNXROEnSFSKnaMbb9/s0B
16SAGkntPQMls6y5G2ApbMkxuYJVye1KftrRPiKISgtdWiXIUEWYLziYvRPpMfDR
ik8dQAgS3PUBh1PW/nH+N/NCXwqK63SeHWFAUiLH3iozqDN1g6s8o+UmzJtc1DGI
yRxdUD5sRlabAyDeT9lwg3496CtOGyJTbXl51dAELGOPZAHwDyY6AuFVq3Z7jgMZ
bMMI2okFcIc/McXjdJqSrJMHZ2FtMoICycZgruqGi5loCPvEzwFvzfqvf/Ua1Xul
epynjavcOuvO1M7uMLHB8EKj+stPkzXxdO1REdqudupnmF1XF4/sJCRuICMhDS+d
cX3PK2DEptN1TONdD0Tp2JFrpeNN6U9QhX3+hKgltPTOoarh4n66BGm8FitdOWUo
J6fptAT2sNZGqY0HjjjyxVMymmfcvwC4vsfu6rPSAD74QFEdYpPYLO7pSCPwCfUX
+84C7cC6SiXihpzf+pTslY7Z4r3lccb45A/WJe7FpE/+t/+7RRA=
=duHQ
-----END PGP SIGNATURE-----

--Sig_/jDDJm+R0Jgx1tD5oO66cq0n--
