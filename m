Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3671E1F597
	for <e@80x24.org>; Sun, 22 Jul 2018 14:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeGVPwG (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 11:52:06 -0400
Received: from goldorak5.eric.deplagne.name ([213.246.56.18]:58936 "EHLO
        exim4.goldorak5.eric.deplagne.name" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728438AbeGVPwG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Jul 2018 11:52:06 -0400
Received: from [192.168.0.4] (helo=mail.eric.deplagne.name)
        by exim4.goldorak5.eric.deplagne.name with esmtp (Exim 4.72)
        (envelope-from <Eric@Deplagne.name>)
        id 1fhFlK-0007M6-Tf; Sun, 22 Jul 2018 16:55:06 +0200
Received: from deplagne by mail.eric.deplagne.name with local (Exim 4.69)
        (envelope-from <Eric@Deplagne.name>)
        id 1fhFlK-0007M1-Sj; Sun, 22 Jul 2018 16:55:06 +0200
Date:   Sun, 22 Jul 2018 16:55:06 +0200
From:   Eric Deplagne <Eric@Deplagne.name>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Deplagne <Eric@Deplagne.name>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180722145506.GL11431@mail.eric.deplagne.name>
References: <20180609205628.GB38834@genre.crustytoothpaste.net> <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com> <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet> <20180721235941.GG18502@genre.crustytoothpaste.net> <20180722093442.GK11431@mail.eric.deplagne.name> <20180722142148.GH18502@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IOdQuxhrWjbL7fBD"
Content-Disposition: inline
In-Reply-To: <20180722142148.GH18502@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IOdQuxhrWjbL7fBD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Jul 2018 14:21:48 +0000, brian m. carlson wrote:
> On Sun, Jul 22, 2018 at 11:34:42AM +0200, Eric Deplagne wrote:
> > On Sat, 21 Jul 2018 23:59:41 +0000, brian m. carlson wrote:
> > > I don't know your colleagues, and they haven't commented here.  One
> > > person that has commented here is Adam Langley.  It is my impression
> > > (and anyone is free to correct me if I'm incorrect) that he is indeed=
 a
> > > cryptographer.  To quote him[0]:
> > >=20
> > >   I think this group can safely assume that SHA-256, SHA-512, BLAKE2,
> > >   K12, etc are all secure to the extent that I don't believe that mak=
ing
> > >   comparisons between them on that axis is meaningful. Thus I think t=
he
> > >   question is primarily concerned with performance and implementation
> > >   availability.
> > >=20
> > >   [=E2=80=A6]
> > >=20
> > >   So, overall, none of these choices should obviously be excluded. The
> > >   considerations at this point are not cryptographic and the tradeoff
> > >   between implementation ease and performance is one that the git
> > >   community would have to make.
> >=20
> >   Am I completely out of the game, or the statement that
> >     "the considerations at this point are not cryptographic"
> >   is just the wrongest ?
> >=20
> >   I mean, if that was true, would we not be sticking to SHA1 ?
>=20
> I snipped a portion of the context, but AGL was referring to the
> considerations involved in choosing from the proposed ones for NewHash.
> In context, he meant that the candidates for NewHash =E2=80=9Care all sec=
ure=E2=80=9D
> and are therefore a better choice than SHA-1.

  Maybe a little bit sensitive, but I really did read
    "we don't care if it's weak or strong, that's not the matter".

> I think we can all agree that SHA-1 is weak and should be replaced.
> --=20
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



--=20
  Eric Deplagne

--IOdQuxhrWjbL7fBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFbVJrKej7DisjVpq4RAvMaAJsFpxb+63/vHG9atKqDAK2lOK4RcgCdFRtF
pSFl3or469na6FU469+dh/k=
=VOvl
-----END PGP SIGNATURE-----

--IOdQuxhrWjbL7fBD--
