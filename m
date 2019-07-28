Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A611F462
	for <e@80x24.org>; Sun, 28 Jul 2019 07:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfG1HaF (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 03:30:05 -0400
Received: from libra.uberspace.de ([95.143.172.171]:34220 "EHLO
        libra.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfG1HaF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 03:30:05 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 03:30:04 EDT
Received: (qmail 28685 invoked from network); 28 Jul 2019 07:23:21 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by libra.uberspace.de with SMTP; 28 Jul 2019 07:23:21 -0000
Date:   Sun, 28 Jul 2019 09:23:18 +0200
From:   Matthias Beyer <mail@beyermatthias.de>
To:     git@vger.kernel.org
Subject: git maintainer workflow tools?
Message-ID: <20190728072318.GO1402@hoshi>
Reply-To: Matthias Beyer <mail@beyermatthias.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hNweOTLwwbnii4NA"
Content-Disposition: inline
X-message-flag: Mails containing HTML will not be read!  Please send only
 plain text.
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hNweOTLwwbnii4NA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello git community,

I write this email because after several attempts over several months of
searching the internet for this, I still fail to find a proper documentation
and/or tools for the workflow. So this is my last resort.

So what I am looking for is tools to automate contributor and maintainer
workflow, especially:

1) Repliying to each emailpatch of a set of patches with
   "Reviewed-by: <user@host>" (or other trailers)

   Szenario: I see a patchset on a mailinglist. I apply this patchset to my
   local copy of the repository, review it and test it.
   I want to send "Reviewed-by" and "Tested-by" trailers for each patch.


2) Applying a set of emails as patches, where "Reviewed-by" and other trail=
ers
   from the tree of emails are automatically included in the commit message=
 when
   applying (how do the kernel people do this? By hand? I don't think so, do
   they?)

   Szenario: I receive a patchset for my project. Contributors have started=
 a
   discussion on PATCH 1/3, fixup commits/squash commits were sent to the m=
ail
   thread. After a bit of discussion, "Reviewed-by"/"Acked-by" trailers were
   sent.  I want to apply the patches, and include all trailers in the comm=
it
   message that were sent for the corrosponding patchmail.


Fwiw, I'm using mutt as an email reader, but of course such tools can or ev=
en
should be MUA-agnostic, right?

I know about git-interpret-trailers, but I fail to see how to use them to
automate the process.

Maybe you know scripts/tools that are ready and available for accomplishing
these tasks.


--=20
Mit freundlichen Gr=FC=DFen,
Kind regards,
Matthias Beyer

--hNweOTLwwbnii4NA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEGg7ZGbdq/6NrnwfOzq8bZH7VayUFAl09TWQACgkQzq8bZH7V
ayVcVw//UHp1u0ESU8jQ0qS+6rdFeXTs/Sp/+W2TWm3QioPHYmlybMxIYvfRvfIh
Me9tKZRoud0oFC1q/HcJr0Mw3d2Ol/XOEPcnC40ARiE4RxpN+PKwvRICg9RmEQcC
ZXubld7ayDwDA4mPrQBplpeBdtJZ6VbPchV537qoS9yEy7BKMe8a8Yao9roKV83C
+o3zvYTp8fRfh1pAjjwi2cvGbRcNf4/I8xOlBblmo8v37gZsbc1KjaglU3doGISg
eDt4f8972+2trM5DKS0l3jg3i4cI2Nup5bEtQ6HLP4uinfeheh3OzzBxEXEAmEBB
gGaPsy5id0BTuZ5sCWHA+adf7nzCArRcwEJujqLIEy4b8FF+c2HXHA8Id4uSAZCn
z1FxV/jh3t1y+LNxLzphLwfK1Mm9Z9RLwFLKMGrujNFRSmcKeytpaQEJ+GXAKDw0
GS1zh8i4e/FoOaz+5JToWi8y9JC7WSEQMAvkAJ2lWAWu2HZZExtvKhGfTozWFu2A
pXfTvrH3dnYyO1zo3hfWwqokkAsEPV3cbxxHNgIyDGYC2UBLm23zdKPztVa2UWXR
pAZgXPHS4se/dnn26gh7pEAp0NGBK5LBc/1X+gQue9xcbHH+40msiy/d1zDkIAmD
Kq1wpa6/kvIxsOjvdB3TFJ80SOcRtv9vpHQtOUpjilO1vTY8ZFM=
=Xq4h
-----END PGP SIGNATURE-----

--hNweOTLwwbnii4NA--
