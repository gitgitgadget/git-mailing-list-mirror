Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 332C31FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 22:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756520AbcH2WPo (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 18:15:44 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41330 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754476AbcH2WPn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Aug 2016 18:15:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8375D280A6;
        Mon, 29 Aug 2016 22:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472508941;
        bh=aB/wU1mW66rvMUfBXz8oqVgddIQ5/a5OeZfjinTZwX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=068UhCPfPOvDj8Mi+AJUAAFjF0rJnR0fLODt3d8NIwLP31mQ1ck2RzZhUqCplt7Ax
         dOPbEg3sniTCF7zOMTovcLu2XsYMECH3z+82FJg11AhmhAH736lB08ftXEbsaM+qQS
         68EhkzIAQbamOOqYqmQnQQzpTBBL+dS6SuFvZ67PMKEwlfG87xhblqW3NzB1G7Vno7
         XvRXWrGhQ1nmMUPyDoXUFVOafcCz0fMvsHkBHnlYwMeuLsVdEPxS9fGn7nhmZEjMFm
         Dd7IA5Qve6PaESqEHPETdoEZnxAANMP32Qcf5SgCoflSOj1WYCus6B91vG3jSN9CCt
         KItHtg/lqbL7yFFhnnsbSYoujSm7rm+zD1Knp+5rQ5HawhcK29gcXKpuTJyxE4EqSy
         ACeh17KuAZ3lzKcglo3ONZN8ZmJqBVJR5PnrrHmqldFllCq5NmKamCZfL1H1EmDt/a
         eISo7a43kwDnGoq24GZ78PnLtqtYkYychsBQwZKtdbpKMs/fqtc
Date:   Mon, 29 Aug 2016 22:15:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Paul Tan <pyokagan@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 18/20] builtin/am: convert to struct object_id
Message-ID: <20160829221537.kno6bsjgal4qqeid@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
 <20160828232757.373278-19-sandals@crustytoothpaste.net>
 <CACRoPnQvdq3xaRF9niU-b0qLxVCvmbpv2_roxUaEaDFftt7_wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q7jtth65nwhb3a47"
Content-Disposition: inline
In-Reply-To: <CACRoPnQvdq3xaRF9niU-b0qLxVCvmbpv2_roxUaEaDFftt7_wQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc7-amd64)
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--q7jtth65nwhb3a47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2016 at 03:02:56PM +0800, Paul Tan wrote:
> Hi Brian,
>=20
> On Mon, Aug 29, 2016 at 7:27 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  builtin/am.c | 138 +++++++++++++++++++++++++++++----------------------=
--------
> >  1 file changed, 69 insertions(+), 69 deletions(-)
>=20
> I looked through this patch, and the conversion looks faithful and
> straightforward to me. Just two minor comments:
>=20
> > diff --git a/builtin/am.c b/builtin/am.c
> > index 739b34dc..632d4288 100644
> > --- a/builtin/am.c
> > +++ b/builtin/am.c
> > @@ -1053,10 +1053,10 @@ static void am_setup(struct am_state *state, en=
um patch_format patch_format,
> >         else
> >                 write_state_text(state, "applying", "");
> >
> > -       if (!get_sha1("HEAD", curr_head)) {
> > -               write_state_text(state, "abort-safety", sha1_to_hex(cur=
r_head));
> > +       if (!get_oid("HEAD", &curr_head)) {
> > +               write_state_text(state, "abort-safety", oid_to_hex(&cur=
r_head));
> >                 if (!state->rebasing)
> > -                       update_ref("am", "ORIG_HEAD", curr_head, NULL, =
0,
> > +                       update_ref("am", "ORIG_HEAD", curr_head.hash, N=
ULL, 0,
> >                                         UPDATE_REFS_DIE_ON_ERR);
>=20
> I noticed that you used update_ref_oid() in other places of this
> patch. Perhaps this should use update_ref_oid() as well for
> consistency?

I'll do that in a reroll.

> > @@ -1665,9 +1665,8 @@ static int fall_back_threeway(const struct am_sta=
te *state, const char *index_pa
> >   */
> >  static void do_commit(const struct am_state *state)
> >  {
> > -       unsigned char tree[GIT_SHA1_RAWSZ], parent[GIT_SHA1_RAWSZ],
> > -                     commit[GIT_SHA1_RAWSZ];
> > -       unsigned char *ptr;
> > +       struct object_id tree, parent, commit;
> > +       struct object_id *ptr;
>=20
> Ah, I just noticed that this is a very poorly named variable. Whoops.
> Since we are here, should we rename this to something like "old_oid"?
> Also, this should probably be a "const struct object_id *" as well, I
> think.

I'll fix that.  Thanks for the review.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--q7jtth65nwhb3a47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.14 (GNU/Linux)

iQIcBAEBCgAGBQJXxLQJAAoJEL9TXYEfUvaLM8kQAISVUmV0CLdQVXQrxV3vvpic
XBcEidp2p/VBUmimJfiQDQnzRGdzR1Aa27tqIqwAxry6N5JmXvqRjCAti3DRkTEd
A21xfHsVS5FthESR8YrWG3+nmef+81eYHVcEwjhaSKHWoBmcDbCLwYU7yFWndPpR
Z0jo6ccWC6isSFyTT7P31FJ4j5Clk7NGFoIQd+8UuMGSAPsVdvfUF3bgYugNCqUH
KXsOoD8mNNdNKXvVItkeHB9p2+ZuCoCLXbDSXc6RgVSKlTmSxyC9Gtg+x1PjLjwY
SbUt2BxvWbeETaTjKP39Ii0xx+A+wtCjTIE40RrWssw8bQO5lqW9LMweVUu95veo
fhddWtyNh4POa4vBWxHoPOUTJtxXVCcn3oByGBy1iyv7SdVlihA3WN77ONLXQwqA
o7PYRxzig2+p/1deG3fjcVX/8KKKRa9b+hsvZjsI0Z26tD8NPrLBmthzB51a3ef6
lac49zVI+WKPbxsfmyxDOxTKJvA9b7qgVP5TBL79sxwrsaXCVCWGR/1EcGmxxteM
K8Drlvz3rpTjy2v/oukhv7L0IafCf1N7G8PmR2bpxs4GK/Nk2BJgkXVLTl3DlZQS
2D/Qrtv2/IoHmOcMWHFkEpkwVN++Fc+42/sOCXDpo5S8kRSn4G9RfmK/ucgEj8AJ
BKKOGZtC1V5mp7nLU3Mp
=pu82
-----END PGP SIGNATURE-----

--q7jtth65nwhb3a47--
