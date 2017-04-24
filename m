Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D3D207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 23:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979304AbdDXXXq (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 19:23:46 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38002 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S979301AbdDXXXo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Apr 2017 19:23:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9C8D9280AD;
        Mon, 24 Apr 2017 23:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493076223;
        bh=G0q2nBYprCBK/4/OdqlR2SpeQiFcJkIOdGv296c5mYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tcku0at9G18vEWcXyndO0r51GqjMuLUk7wrRIOjqNrzq6/zQS59YuCe+K1+UDWSHh
         0x8FqdIbNPpovEnx7lKTq1hWkOJH9JJb5DBnzDGvrSVqBMt9uWHga1l9sq2BB0iohe
         I6kbRw2KQ3B66qkcLvlawnJTYFVfRXdLwK0Z2hZgoKCwec+THIkF+6zPlCdTfQTCMh
         zn0eg1fEEb91laGOrQ2F+DbvUuxPnafb98b6Y6k4pQHlgESzfqTe/zpB6BA3BhOKJY
         FmaQd7HCM2WE04jbPW5FA+rvzPaRaAemMrHuTYgbECxtI5YDKH0Idg/P8dXPy8tltW
         X+mSC9LwVhz0MKMgAuiSjK37xgvhyruPmTPOPGxPPG4y/ixxUI9pOKE4lKWZZXyuCd
         /IH4lys7naHbO3G4jRz2yW9oKb20ZMzbwjahs1BRu1O6DrV5vMGkJhO2ubvwvaDt9O
         6OCY2axRL+rEbP5euNVLBcxVOMnmCLXxVF4RzmKLY/QLZfZGtIR
Date:   Mon, 24 Apr 2017 23:23:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/53] fast-import: convert to struct object_id
Message-ID: <20170424232337.hg2dbpdt6rrfscko@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
 <20170423213453.253425-12-sandals@crustytoothpaste.net>
 <CAGZ79kbdVEhcxP4dhSR6GaOKjgTD+bPn_+5edV4TjV3A84HQ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eomliucd3genrvon"
Content-Disposition: inline
In-Reply-To: <CAGZ79kbdVEhcxP4dhSR6GaOKjgTD+bPn_+5edV4TjV3A84HQ-A@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eomliucd3genrvon
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2017 at 10:20:27AM -0700, Stefan Beller wrote:
> On Sun, Apr 23, 2017 at 2:34 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
>=20
> > @@ -2823,12 +2821,10 @@ static void parse_new_commit(const char *arg)
> >         strbuf_addf(&new_data, "tree %s\n",
> >                 oid_to_hex(&b->branch_tree.versions[1].oid));
> >         if (!is_null_oid(&b->oid))
> > -               strbuf_addf(&new_data, "parent %s\n",
> > -                           oid_to_hex(&b->oid));
> > +               strbuf_addf(&new_data, "parent %s\n", oid_to_hex(&b->oi=
d));
> >         while (merge_list) {
> >                 struct hash_list *next =3D merge_list->next;
> > -               strbuf_addf(&new_data, "parent %s\n",
> > -                           oid_to_hex(&merge_list->oid));
> > +               strbuf_addf(&new_data, "parent %s\n", oid_to_hex(&merge=
_list->oid));
> >                 free(merge_list);
> >                 merge_list =3D next;
> >         }
>=20
> This is a funny one. The only change is line rewrapping, as it fits
> into 80 cols easily.
> I was reviewing this series using colored --word-diff output, and this hu=
nk does
> not produce any red or green. I wonder if this is the intended
> behavior of the word diffing
> or if we rather want to insert a <RED> - \n - </RED>.

I used Coccinelle for part of this, I think, so that would be why.
Sometimes it doesn't do everything I want, but it lets me do less manual
work.  I'll revert that change in the reroll.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--eomliucd3genrvon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlj+iPkACgkQv1NdgR9S
9otoYg//XCMI7bnJzQeQmfyOj2eSswvcnrOZKU/225X8MU4hC/4MVRGO4WtffuoL
i33sfsFjkVGLm9DH5Mvs6BIs5QyrudBcfknUxun9xHsYWocOVrcCEtFIVJd51ewz
pdPf00C2BD/juYTtw0j4mpfYCko+ea7hHoE2bArZVr3Zgs4vVJkp3D6RsAHLfmUt
0ege6PXx2dD9UAbXXf7FjPGknr0S9znopqAMOKi55w7kTfpcqWYZ31aQ3cz4V0AF
u37oHhZTTkE3RRuc8IZ8ISpBwcVD6YdwTYjM/sNcIo5FShMbqNhWnIT9cmaoAXUJ
scu8yhcb6vsrgIZZwNswagAkyERekC8lSpGx66Z+PXJ9/HlLxSlyoN03EUFd4HNl
8FT8rbRjNtkZ9jE+cMNLBSXCsSqQqMY9eAyVdQ/Vc38KA3w2Gj1TDasFPIpEHRuK
dlINbyUeZHxqe0ySsUCIS/RDblnrEBFwwXDS3pIIcdqVvn9b8VWaX3TxP7NYOplS
xuGYpd6k4InE1zPrVoZUTY9F+cX8qdV+TipCBBgGeSRI+yGKYvl9ssDpQq+mMUIq
Fuo6JxxxL17aaO3BUWLHLAsHI8e2JplZivMTni+mlPrhwHIHgRkCyef2w379WVux
HbQeICjrUYc7F68EtFwZk+MP1Pz7EYHQE0Nz8LA7jWqUSoXowF4=
=WxES
-----END PGP SIGNATURE-----

--eomliucd3genrvon--
