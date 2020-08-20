Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A8C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CA1207DE
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="kBE2vaHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgHTMjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:39:13 -0400
Received: from mout.web.de ([212.227.15.3]:57331 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgHTMim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 08:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597927095;
        bh=aV9NsqcciGn4jYuq+KI8DriKwJ6F8T4X91k6dhaecrU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=kBE2vaHm2gSMHlSvh90n2J+Jk0xi5NJu7p04jdqjWKb5isOwcZhe2Duv/JtinH0VJ
         o5CAHGweOmF7H8kNKjHfv/2lIIElkmlM0kEPMvhRIm8QY5que8iBi/3zJaxiYNJSCJ
         ULxB0Oky0LOqaKO0H+hLfmN1dJiaJlkQ8quiAZl4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.218]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7ssy-1kvDkM3lbs-00vNDW; Thu, 20
 Aug 2020 14:38:15 +0200
Date:   Thu, 20 Aug 2020 14:37:55 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200820143755.06d39a05@luklap>
In-Reply-To: <20200819201736.GA2511157@coredump.intra.peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de>
        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
        <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
        <xmqqimdetpuw.fsf@gitster.c.googlers.com>
        <20200819201736.GA2511157@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=3y1jbwvUGStPWLL.FdhXZa";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:hVzBmuaVUNOtPcskv6xUyshEgmskfoi0J+1fhdJZeeEhDn+g0j2
 j73WPlF9gvlEBInuVT+qlHtElZ8Gt5FYUl/q4Nj2H8xSwV10EZIsP1eOHPIYHKwa61ik//C
 5G3rTqO53NQMdVzZeV1PRgat9AxBsqZ44G52BeOzNpyqeLFutqZ6DOOYeAVktOGjtaRxiws
 qQassOYz5hLs7MBekfk7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Reb2CTsaU+8=:EfdueCwzk1myT+KCxxT4Kr
 6ZSjF20i4oJYOoC614XrfOFXBprltaVL2+CnB6IP6YywWZQ0rX9gdrU4GAXMc7lGGVyECh0B9
 dJvQqr/CtqGY6ljsExZqPXv+5RnGetgxM/l75mREI+l3Y3UHmMABjLjYD6Be9jrvWLH3IxXNg
 c+Yyksw1Fxqpre3yr7E9WQLsXIXxT1FFJoqo8G840HfStgtuCLVQHD/2oyYHe6Aj5SsEh269e
 jjt45d4y4pNBWiL+dEEEG5mi7RRlbUH8ZgPT5oc/n9aIIArNfouVQMnFraGAMJr6muY695Q+1
 YBa1BvTbFOjQpU8lUyB9KNDa7rCftm/NZEsSIqyiqvUeAAm/ZlaqTrqYv5YB3vhPl5/vUk4bg
 Dy1XKj9SYQXn9OvxAzlokf7cihjCcrebhrGRJYXHG22ZtMtup3eYbTUY4IfyaoncVtPmdy7iI
 qejMEz5rtLVCl/bkEPOgRU8uoQG0vIBlsRDSoB8DgaVp5xb9JqqlVKyjHoJpy/rjFo/3SAwk3
 F4EX3of9SKSvjgIgyzJsm9YaftVzg/rllyk5YlNp5m7KK75BhSAMxAn+C7NkpsIW/HLQRSLdb
 iWNO/mOqv3HVdKUOaFe1yNLFrFVmlvhNyMA3hgykxc9d5N5Nh48L/oA/jawIhdIrpEXBrEHwJ
 JxQ0EmlSPsld615PNxIpTlpI7YzfN7ZO6rzGjfHjsk54jm5ISSbtqfuqYzC4bx27az1KiX2HY
 C0kiq+ZbJ6KZDK9EJasq0S5J8LQeLCKFutLzIxSBmrq3MYQxb0l4ftN31zkWdi8QV+bV+ZTaX
 QEh5FPDhLR4Y9enWItCS5zQGEmALakYpejDugVfyyZQJEKQ7mVCJVoRVgunCs4p4g8+Wo8/dO
 KtHrfx6F7ltXz+MzndYBIbhtxEUpzdH3qBt+MAkgzhjjBxuZXtgn6vUNUPwvO5weSNyMejWhW
 cI176rMQzp0Q61YKeppg93xAxwLCubw9ZO0qq0VRNXMfAQLf/xBfsznb4TdveX96UvaYsJw5R
 g0oTSycP8TkMU/TYO1B6k/MSWposTggazjRHLExPHdlXskNKrQ3iVnGpo5vnt5dO3Bv8x98RH
 VT+SMcPA+n1ARqZOi2DS7Xjrb4EAckuzvBhLd8KDQ0PjTls6SqpAMBzh7QIUNphZqE+vyoH/P
 Ljd7btbnRJJIOUkPIfVLJrqEbCw7ugDqNBHPWqEC3dIw5gDIvvJ0H3VFoDNDe2fcGG8k9dj+E
 NkuuxTpZy7cK20smfM993XZqu66aDLHTWJoZK4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/=3y1jbwvUGStPWLL.FdhXZa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2020 16:17:36 -0400
Jeff King <peff@peff.net> wrote:

> On Wed, Aug 19, 2020 at 12:09:11PM -0700, Junio C Hamano wrote:
>=20
> > "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> >  =20
> > > Just putting my CSIO hat on here. We would need a system-wide setting=
 to
> > > prohibit users from using this capability. =20
> >=20
> > Or just discard this patch, which is a lot simpler.  I don't see any
> > need for this one. =20
>=20
> Yes. Configurability is a lot more complicated than you might think.
> Because it's not just system-wide, but _ecosystem_ wide.
>=20
> Right now git-fsck complains about ".git" appearing in a tree, and that
> check blocks people from pushing such trees to any hosting sites that
> enable transfer.fsckObjects (which includes hosters like GitHub). So
> you'd not only need to allow the behavior to be loosened for all of the
> people using the feature, but you'd need to convince server-side hosters
> to loosen their config. And because part of the purpose is to protect
> downstream clients from attacks, I doubt that public hosters like GitHub
> would do so.

I guess they can add a checkbox to their (secured) web-ui to configure
this.

> It _could_ still be useful in a more isolated environment (e.g., your
> company server that is serving only internal repos to employees). But I
> have misgivings about a feature that lets people intentionally create
> repositories whose history cannot ever interact with other users who
> haven't set a special config flag. It's one thing to say "to take
> advantage of this feature, we must all agree to have version X, or set
> flag Y". But it's another to bake that restriction into the repository
> history for all time.

Good point. I don't know how we can resolve this, so I will add warning abo=
ut
this (and the security concerns) to the config docs.

In the worst-case where the hosting sites don't adopt this config, the user
enables and uses this feature despite the warnings and then wants to use a
hosting site, he can still rewrite the history. Not nice, but no disaster
either.

Regards,
Lukas Straub

>=20
> -Peff

--Sig_/=3y1jbwvUGStPWLL.FdhXZa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8+bqQACgkQNasLKJxd
slg90hAAkffygIXWVXaoBK07cQFrlYE3knE2d5HU14rgoG6XcJf4uA2IqlmyGCL7
pnBjM1OTJscmQ8xidCLjHgiKS6eCnycHPK5NjFJnvjWLu+WFCeqsZ8T3Fnv7R2V4
hS6oHyml+rgNtDF+/ie0sldRDZy7VX1UTJbvxsCpg035cDTfwRQwZjR8AjNrsYqe
qJwmGpyZ2i76X/VD+KkIMCREzoGUjcSPuHg0t+5iPzcMTbVPjmWD8OdcfBka23HY
3fYVkolpgSlNHo0cIbbzKUHAiX+rth2NYUyISAfrkyjh3AImFJNTwJT+UBCJf6M2
rhNymReGpeahm/1kf6negU12d5d7lsOBrR8aBtJzhA4L2USIND1ccpgLGv8k1Bg1
RWsfNubkPc8+f+fxPfoJmG6zcztbk4L7VccwhQkg6bJSTlvDD17BJjq1DSnK6B3m
g07IDX99HxsxV9ahhJs3zgpRg4O255wnrKHxPornqhYA0NYIk9GqgeWBhN8Y/2rJ
sUWdxgAmprT116b3a2FK1QgqrGtntWa/O0EQLAGvYT1fsgj5Wwp5GudXZnUVUOX0
0kKsXLLx4z/ad3H+rbzUmeqna0E0Ep/ENP4LDVFV59TD+5Jwvw+dZ2R5Tnv0aiLZ
ZrKhDvIUnkd708lDz2sx5YXtEuxcw+GzTbVuJMxhQB1VmMeKD5E=
=FPlO
-----END PGP SIGNATURE-----

--Sig_/=3y1jbwvUGStPWLL.FdhXZa--
