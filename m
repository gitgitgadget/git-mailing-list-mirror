Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040EF211B5
	for <e@80x24.org>; Wed, 30 Jan 2019 17:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfA3Rth (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 12:49:37 -0500
Received: from mout.web.de ([212.227.15.14]:52741 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfA3Rth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 12:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548870574;
        bh=PgTxU69YfMIPMnX1B/D2zht46waFIBhWVzMBodJ4lvA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UPcL59+pS08aRy4E04YLv45XHsmsjreyFiU6BOF7SaZjZegBvsSjhLGLFoaHV3JnR
         ZBfSD8bGSKkq3xlCOQmP+HU8iaitBKgOzXxqxr83KmeAj77V1nYPDoFtuO2bZgx3eO
         +FgqdZU0WRBbbi1RH/bDnAkAHP5LWp70U6NaxzP0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx77p-1hCbps3yTR-016dcJ; Wed, 30
 Jan 2019 18:49:34 +0100
Date:   Wed, 30 Jan 2019 17:49:32 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     git@vger.kernel.org, adrigibal@gmail.com
Subject: Re: [PATCH v3 1/1] Support working-tree-encoding "UTF-16LE-BOM"
Message-ID: <20190130174932.lhs3npztu5tusy3e@tb-raspi4>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20190130150152.23040-1-tboegi@web.de>
 <000901d4b8af$edaccf20$c9066d60$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <000901d4b8af$edaccf20$c9066d60$@pdinc.us>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:1XrVORCNrj0nOV5GVzwYULawAeiXltw94O+OHXyk+6Tvr58/smL
 2vgEuhuWx9K6pFht0AYjpNOJrxJnQYdR7TTXr7iA5YpdRAO5GT82gRAdGY2Sv4HO2OYHlzg
 RiF4caI2P1JNDd2XESBP8Ja2q4umXYcqll5NiimAVAaR7yK/VhOKFCesVNWl7gomit6fC9a
 dTvK23b271GIYcJGsAneQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VAQ1l02vODk=:T1Z3lgOV0j/xtGvwM53z20
 Q5ypADbv6LATATVqjdBeyKY+tWbeJq7SxXPti3LR7XnHeaMUAMwvH7S6U9LGrnrBFBT+rx7oE
 9wSHOvuC2mWcmmy4ccoq/aFv0GrOtLuxQJ3Qb+yEYpgZ0n4kZLCX3i0Ph3sajOwgGm4mWPx9Z
 ARyr+lPBs/LB9xOB7ZMOI28Mk4eAb2Ys9q9PtM1pOe8vaF3nq4ALWpjbir9/6y3jxrXXYsrxf
 9FJLBuUIdKhuNGC2wYQ9HJVojwg/7S/r5KENv7MrliBChMaHX3cS+FTTH+1fLGnFtMMgHsjvd
 CovFjxR4GrGHgLn1mz9fnU6/4Asu0iw08Yz69T24vhRkZ68VP/ZAUe72deeVehutRH5l6Ml6Y
 pkhABzihy9Gk1BftIX3Vmdjxf8Xb9Oa4I6dE6uVydEvrCpAg8eVc7nKE8GDGNAN4C9k1Tyg1v
 Nbt4XaR3ALSB+8enshE7pTGLn0f/pjrzPvechdgRQFYJvxtMOHcYTnKQNEnFfuIx7PnCInZiT
 nuYRY9sETeRr5M5UDr2rzIdbjq78P6JqwZyZoEjhmgIB/3JK0InqTIaISeaGuA6jqNFVFWi+3
 lsf/YWiT6AlN4dzfEN2K9fe97kLnDw7Bw4z4JzMrX+Cs0k6fv/0lzBQKgrjvFnzVEsYdCe4Ok
 LXF1qpBk+J6r3dfxgATc+plCe3skM2uD00pFnJ5yZ7cM2dIpIp6ay4v7u7mXe4ngb/PPRQraB
 hb31/NsVQ0ii92EFBoBwScdKPNxRJmbt5mycRG0xRAXHzjPue7a6ifF47ayjbulbkWBqaG2eo
 IsEwNvY567gpQWBoEczaWp8X4+e8GUDRIWi8k1Col2Cl52c3OVzMoEW4wm+k2u8lKC+vasX/9
 PsTpz/+HjhsnfyUXuiVBKAoC+rwQ6DdLnFxRY8ta1IJqzS78abbVZqRMZFZxXm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 10:24:44AM -0500, Jason Pyeron wrote:
> > -----Original Message-----
> > From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf =
Of
> > tboegi@web.de
> > Sent: Wednesday, January 30, 2019 10:02 AM
> > To: git@vger.kernel.org; adrigibal@gmail.com
> > Cc: Torsten B=F6gershausen <tboegi@web.de>
> > Subject: [PATCH v3 1/1] Support working-tree-encoding "UTF-16LE-BOM"
> >
> > From: Torsten B=F6gershausen <tboegi@web.de>
> >
> > Users who want UTF-16 files in the working tree set the .gitattributes
> > like this:
> > test.txt working-tree-encoding=3DUTF-16
> >
> > The unicode standard itself defines 3 allowed ways how to encode UTF-1=
6.
> > The following 3 versions convert all back to 'g' 'i' 't' in UTF-8:
> >
> > a) UTF-16, without BOM, big endian:
> > $ printf "\000g\000i\000t" | iconv -f UTF-16 -t UTF-8 | od -c
> > 0000000    g   i   t
> >
> > b) UTF-16, with BOM, little endian:
> > $ printf "\377\376g\000i\000t\000" | iconv -f UTF-16 -t UTF-8 | od -c
> > 0000000    g   i   t
> >
> > c) UTF-16, with BOM, big endian:
> > $ printf "\376\377\000g\000i\000t" | iconv -f UTF-16 -t UTF-8 | od -c
> > 0000000    g   i   t
> >
> > Git uses libiconv to convert from UTF-8 in the index into ITF-16 in th=
e
> > working tree.
> > After a checkout, the resulting file has a BOM and is encoded in "UTF-=
16",
> > in the version (c) above.
> > This is what iconv generates, more details follow below.
> >
> > iconv (and libiconv) can generate UTF-16, UTF-16LE or UTF-16BE:
> >
> > d) UTF-16
> > $ printf 'git' | iconv -f UTF-8 -t UTF-16 | od -c
> > 0000000  376 377  \0   g  \0   i  \0   t
> >
> > e) UTF-16LE
> > $ printf 'git' | iconv -f UTF-8 -t UTF-16LE | od -c
> > 0000000    g  \0   i  \0   t  \0
> >
> > f)  UTF-16BE
> > $ printf 'git' | iconv -f UTF-8 -t UTF-16BE | od -c
> > 0000000   \0   g  \0   i  \0   t
> >
> > There is no way to generate version (b) from above in a Git working tr=
ee,
> > but that is what some applications need.
> > (All fully unicode aware applications should be able to read all 3
> > variants,
> > but in practise we are not there yet).
> >
> > When producing UTF-16 as an output, iconv generates the big endian ver=
sion
> > with a BOM. (big endian is probably chosen for historical reasons).
> >
> > iconv can produce UTF-16 files with little endianess by using "UTF-16L=
E"
> > as encoding, and that file does not have a BOM.
> >
> > Not all users (especially under Windows) are happy with this.
> > Some tools are not fully unicode aware and can only handle version (b)=
.
> >
> > Today there is no way to produce version (b) with iconv (or libiconv).
> > Looking into the history of iconv, it seems as if version (c) will
> > be used in all future iconv versions (for compatibility reasons).
>
>
> Reading the RFC 2781 section 3.3:
>
>    Text in the "UTF-16BE" charset MUST be serialized with the octets
>    which make up a single 16-bit UTF-16 value in big-endian order.
>    Systems labelling UTF-16BE text MUST NOT prepend a BOM to the text.
>
>    Text in the "UTF-16LE" charset MUST be serialized with the octets
>    which make up a single 16-bit UTF-16 value in little-endian order.
>    Systems labelling UTF-16LE text MUST NOT prepend a BOM to the text.
>
> I opened a bug with libiconv... https://savannah.gnu.org/bugs/index.php?=
55609
>

UTF-16 may be a), b) or c) from above.
Every unicode compliant system should be able to read all 3 of them.

When writing, the system/application/converter is free to choose one of th=
ose.
Probably out of historical reason, big endian is preferred (in iconv),
and to be helpful to systems/applications a BOM is written in the beginnin=
g.
This is according to the RFC, why do you think that this is a bug ?



