Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733751F597
	for <e@80x24.org>; Sun, 22 Jul 2018 00:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeGVAyY (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 20:54:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34572 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728028AbeGVAyY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jul 2018 20:54:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 487F76047B;
        Sat, 21 Jul 2018 23:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532217586;
        bh=IuYp5knKQAg76tRXB+YDL9YLcEX+zqz54OF+cknRtQw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XVISFasiPx7WIgBS4jn4nTL4TFZRys0mKqD3+s1vGfcT1dw13Un+gYmJ0ezS6KUA2
         Sx0YMou3RyVBOx4MY1EiDMg/Gd5r1Zc5IP726sZ3YzoHn53EvBt1eriNfYvFPOgX6a
         +R1hUNX4XcT44oTQFVBNbCRrMrsAiPFL71xTOKX1WlhnChl8pBh256VQVey8FlMj6/
         gp05JDydLTlbMC2xpHYIduSrE4AwuKq4sodW1ogYRVM9HqUOMf7A8mJOWYRDchmWW8
         DsDpwmvACdyA4gzMYsvaSmLYDymUzk59N1zNRhmla7fZmS6ShujEMCxUsgfSvpcF3L
         V/3aVoYxcHdf/9qCIkZ87Gx52t/O7BgiBGw/D5slPW1c3yGFVp/VypJQYwH8S+F/IC
         JSbefzBwyXH11qTuM6Wb0QdRPDlHlCIwFA/0/zLbW4Y/LzL5R1aJp72KKr6RHwfoqH
         LuprP/6KIyijsEaoJQ8pky6rnzhMl4nUfdUpB/9FYRDboXuTWzs
Date:   Sat, 21 Jul 2018 23:59:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180721235941.GG18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>, The Keccak Team <keccak@noekeon.org>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DNUSDXU7R7AVVM8C"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 12:38:41AM +0200, Johannes Schindelin wrote:
> Do you really want to value contributors' opinion more than
> cryptographers'? I mean, that's exactly what got us into this hard-coded
> SHA-1 mess in the first place.

I agree (believe me, of all people, I agree) that hard-coding SHA-1 was
a bad choice in retrospect.  But I've solicited contributors' opinions
because the Git Project needs to make a decision *for this project*
about the algorithm we're going to use going forward.

> And to set the record straight: I do not have a strong preference of the
> hash algorithm. But cryprographers I have the incredible luck to have
> access to, by virtue of being a colleague, did mention their preference.

I don't know your colleagues, and they haven't commented here.  One
person that has commented here is Adam Langley.  It is my impression
(and anyone is free to correct me if I'm incorrect) that he is indeed a
cryptographer.  To quote him[0]:

  I think this group can safely assume that SHA-256, SHA-512, BLAKE2,
  K12, etc are all secure to the extent that I don't believe that making
  comparisons between them on that axis is meaningful. Thus I think the
  question is primarily concerned with performance and implementation
  availability.

  [=E2=80=A6]

  So, overall, none of these choices should obviously be excluded. The
  considerations at this point are not cryptographic and the tradeoff
  between implementation ease and performance is one that the git
  community would have to make.

I'm aware that cryptographers tend to prefer algorithms that have been
studied longer over ones that have been studied less.  They also prefer
algorithms built in the open to ones developed behind closed doors.

SHA-256 has the benefit that it has been studied for a long time, but it
was also designed in secret by the NSA.  SHA3-256 was created with
significant study in the open, but is not as mature.  BLAKE2b has been
incorporated into standards like Argon2, but has been weakened slightly
for performance.

I'm not sure that there's a really obvious choice here.

I'm at the point where to continue the work that I'm doing, I need to
make a decision.  I'm happy to follow the consensus if there is one, but
it does not appear that there is.

I will admit that I don't love making this decision by myself, because
right now, whatever I pick, somebody is going to be unhappy.  I want to
state, unambiguously, that I'm trying to make a decision that is in the
interests of the Git Project, the community, and our users.

I'm happy to wait a few more days to see if a consensus develops; if so,
I'll follow it.  If we haven't come to one by, say, Wednesday, I'll make
a decision and write my patches accordingly.  The community is free, as
always, to reject my patches if taking them is not in the interest of
the project.

[0] https://public-inbox.org/git/CAL9PXLzhPyE+geUdcLmd=3DpidT5P8eFEBbSgX_dS=
88knz2q_LSw@mail.gmail.com/
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DNUSDXU7R7AVVM8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltTyOwACgkQv1NdgR9S
9ovFTQ//REYkVtnNGIsx4XQOHFd7J489f/3CiOHh3Iv39XmUCSCFsKm2/hALT2ni
nrEjQ2ldiW7wKoV0jjViLkQsLO6+l3MaYSatvvVQuD3pL6ksHKDLe5zIakt/gBtt
4Gd6inz1N4l9/mybS207RoARQN3zq0PyZjnkKtyK4F58dKz7r5v3E6CdDqNT6Dcg
F7UFltSyw5If7cn7n6uDuC3PMsDbrhm2q6dlZm2Cr38sbmqRF/KwxGadfNaENzZd
FDBT6Neknx6qw7QZgtS60qlMeqsZ86kr+2efxubLlvB3DlyfXEC/UXmM+emtcN2m
gWbSqDIDrCw2+vqVnO9+aA5O+9KQ+Exc/VKLcxpY32OnHu2nk1+g0qJK1Mo91oGw
zfcGH58IzSPXm8K+V3roUwX1txPchWsAQWoAhflVoLg9oEjfbUN2qaA5bX/1VL2A
HlWOZIZ72+GpMa6UTNYoHyPhwmKM6a19oX73IH9B4Y11j7r/8yJX2SkaaDJGTP2q
ljGtMORGQdTLh84OW19auQfnypl3hmluGHsfUsLWnBKNAnby+ZMTgGvjBDaqFaMO
sHLgG1/P7ywrgvCV3g9NEL7n+SAu3psRziillGV6fPgs7leUxb0i+5urxBIXAQy8
9rDhIar5Q5FyGGW12x7bKN3ve5AIYc8JpRrPZ8kF6OkjcEXP2dk=
=K5yk
-----END PGP SIGNATURE-----

--DNUSDXU7R7AVVM8C--
