Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4842220437
	for <e@80x24.org>; Tue, 31 Oct 2017 01:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbdJaB1U (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 21:27:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55724 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751871AbdJaB1T (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2017 21:27:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1B29E6046C;
        Tue, 31 Oct 2017 01:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509413237;
        bh=5hYfWs5c/nP5kNm221IUXMv8G5pcNBodLNG9sz5XZ+8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=acqnEX7ga4X9auG1ycrUiNUTwcW46BSzTkFZ2G+h7dW2W9NMGq6+bKPdF15sPWILW
         VPQ/pzuJ9Z58gLpCmIYDW9ojIV0I8PCgC2R4X6s/pUnoDb1aQOlZV+xEmK8SNmhXko
         VTULGjfou5zcYj8aAXc4s97RNUHeQoY/IFQTtLbQURxmJcKyR6W9FM3fJqw9BwCJMi
         9q2+Zxq4sJdKA9qHpdhgun5tNks6siwmPvRfn2i3VujfD+j+uxa/NBllHdZIaeCSCp
         8h+5TT29+ZUx2SRf/7IvpnHzxYCsiFNUQ8zTh+Zy7SYzR9L/3TpadrIOVWuQzy/BC/
         2C16MpMnDGczExGit8TIqqyPiDs78Fa1Val2l37slE4sN5QSxU7rbTZRSQvqWP8O31
         g+V1ju0KnxGlcbEOpcSLFC1Ms+ibMtD1L82C310wRlafQqZFY6KWMvLQQdjoy9NVU4
         2CYUqFDHHEYQvmaqx0zim6/gt8+R5kNOW4ywYcTCCFklC4CxLRw
Date:   Tue, 31 Oct 2017 01:27:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: convert SubmittingPatches to AsciiDoc
Message-ID: <20171031012710.jfemqb6ybiog4sbz@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20171029211308.272673-1-sandals@crustytoothpaste.net>
 <20171029211308.272673-3-sandals@crustytoothpaste.net>
 <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pdipjojxtxrzgxi4"
Content-Disposition: inline
In-Reply-To: <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pdipjojxtxrzgxi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 01:28:05PM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> Thanks.  I personally prefer the plain-text original, but I do
> understand the need to have a version with ids that you can tell
> others to visit in their browsers.  Assuming that this goes in the
> right direction, here are a few comments.
>=20
> > @@ -58,8 +65,9 @@ differs substantially from the prior version, are all=
 good things
> >  to have.
> > =20
> >  Make sure that you have tests for the bug you are fixing.  See
> > -t/README for guidance.
> > +'t/README' for guidance.
>=20
> I am guessing that, from the way you updated 'next' to `next'
> etc. in the previous hunk, you are typesetting in <tt> anything a
> reader may type literally without substitution.
>=20
> Should this be `t/README`, as it is a part of something a reader may
> type literally (as in "less t/README")?

So this syntax provides italicized paths, but I agree that the <tt> is
better here.  I'll make those changes throughout, and fix up the
instances of that you mentioned.

> > -(4) Sending your patches.
> > +[[send-patches]]
> > +=3D=3D=3D Sending your patches.
> > +:1: footnote:[The current maintainer: gitster@pobox.com]
> > +:2: footnote:[The mailing list: git@vger.kernel.org]
>=20
> Having to see these footnotes upfront is somewhat distracting for
> those of us who prefer to use this file as a text document.  I see
> these become part of the footnotes section at the very end of the
> document (as opposed to the end of this section), so even with the
> rendered output it does not look ideal.
>=20
> I am not sure how much these two points matter, though.

AsciiDoc requires that the attributes appear before their references.  I
can move the attributes just before the paragraph they refer to, or I
can inline the footnotes.  I could also just turn them into links if
that works better.

This is actually one thing that I think Markdown does better.

> > @@ -191,7 +212,7 @@ not ready to be applied but it is for discussion, [=
PATCH v2],
> > ..
> >  Send your patch with "To:" set to the mailing list, with "cc:" listing
> >  people who are involved in the area you are touching (the output from
> > -"git blame $path" and "git shortlog --no-merges $path" would help to
> > ++git blame _$path_+ and +git shortlog {litdd}no-merges _$path_+ would =
help to
> >  identify them), to solicit comments and reviews.
>=20
> The +fixed width with _italics_ mixed in+ mark-up is something not
> exactly new, but it is rarely used in our documentation set, so I
> had to double check by actually seeing how it got rendered, and it
> looked alright.

I thought it provided some hint to the reader that this wasn't meant to
be typed literally.  It's a preference of mine and I think it aids in
readability, but it can be changed if we want.

> >  After the list reached a consensus that it is a good idea to apply the
> > -patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
> > -list [*2*] for inclusion.
> > +patch, re-send it with "To:" set to the maintainer{1} and "cc:" the
> > +list{2} for inclusion.
> > =20
> >  Do not forget to add trailers such as "Acked-by:", "Reviewed-by:" and
> >  "Tested-by:" lines as necessary to credit people who helped your
> >  patch.
>=20
> Should these "Foo-by:" all be `Foo-by:`?

I'll make these changes as well.

> > -An ideal patch flow
> > +[[patch-flow]]
> > +=3D=3D An ideal patch flow
> > =20
> >  Here is an ideal patch flow for this project the current maintainer
> >  suggests to the contributors:
> > =20
> > - (0) You come up with an itch.  You code it up.
> > +. You come up with an itch.  You code it up.
> > =20
> > - (1) Send it to the list and cc people who may need to know about
> > -     the change.
> > +. Send it to the list and cc people who may need to know about
> > +  the change.
> > ++
> > +The people who may need to know are the ones whose code you
> > +are butchering.  These people happen to be the ones who are
> > +most likely to be knowledgeable enough to help you, but
> > +they have no obligation to help you (i.e. you ask for help,
> > +don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
> > +help you find out who they are.
> > =20
> > -     The people who may need to know are the ones whose code you
> > -     are butchering.  These people happen to be the ones who are
> > -     most likely to be knowledgeable enough to help you, but
> > -     they have no obligation to help you (i.e. you ask for help,
> > -     don't demand).  "git log -p -- $area_you_are_modifying" would
> > -     help you find out who they are.
> > +. You get comments and suggestions for improvements.  You may
> > +  even get them in a "on top of your change" patch form.
> > =20
> > - (2) You get comments and suggestions for improvements.  You may
> > -     even get them in a "on top of your change" patch form.
> > +. Polish, refine, and re-send to the list and the people who
> > +  spend their time to improve your patch.  Go back to step (2).
>=20
> Not a complaint, but it is a shame that we have to spell out (2)
> even though we are using auto-numbering feature here.

It is.  I'll see if there's a way I can refer to an element of a list,
but I don't think there is.

> > @@ -452,23 +475,24 @@ should come after the three-dash line that signal=
s the end of the
> > ...
> > +=3D=3D=3D Pine
> > =20
> >  (Johannes Schindelin)
> > =20
> > +....
> >  I don't know how many people still use pine, but for those poor
> >  souls it may be good to mention that the quell-flowed-text is
> >  needed for recent versions.
> > =20
> >  ... the "no-strip-whitespace-before-send" option, too. AFAIK it
> >  was introduced in 4.60.
> > +....
> >  (Linus Torvalds)
> > =20
> >  And 4.58 needs at least this.
>=20
> This line alone in the entire section for pine is done in regular
> text, which looked somewhat strange.

Ah, yes.  I misinterpreted that as not being part of Linus's email, but
I suppose it probably was.

Since these are emails, I can turn them into quote blocks with
attribution if that makes things more readable.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--pdipjojxtxrzgxi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln30W4ACgkQv1NdgR9S
9ovfQhAAg3wc9IL59mij1BWU6WncBXMvf8lkvTmA+4qZxVhFIoZCIUaxH/yC3tXA
qTKUGcxnyOIhEwaGrJxaYnKMA8s1o3MSBGbw3lMxkJJdh6pFiaeZuBEzHA3Wp1n3
BkA8svr/qhWGRhxEPZZLF0zRyMksnLYA3I4hr3kaiEISZy5o45y03PyXTOzgBThk
PlOcQOyNQGGbjFXp5pVpBB3w7b7tcql2Ey5tkn+SwrNRxwbeFo5qNJtIrrJMNGi5
69GHy6+GqxgaPJ/QSC8xW0929km/jX8AbrTR+njUH4zyr3y+/eLN3G/0FVqumkR5
EFWuVioXPYcmsNA+pk0l88MT0toZ4jDiSh/njuFpFigqYwrNqUM0Ay5FZmmlxKZW
jjioMWnikZYnFK3bw6bgPB6fuf+d2f+iXWpuYJEVH1PpFOeTnzbvBYJsRb29geSj
F3uVDA3nSqTmGOIyQQkoSvmuiI8sbQ3/aQXkI9/7RgMkn3K72neXN0CCSsDMlGqv
hZ8VoNgf4i0YIW5ysxrM6vjQD2406HefKQP4vXHII/1EMVgjZSfPktHpAYJf4R9m
eytW3pP1L5l8nrb6ig66hOeUDlJzx0YO+3gkYR4CiXsn1CQKKH9o9DnFHJsHIT2Q
Ak7MaPkpoLboBq2aCMdBeBFm0RKNkg583VERekfpod8hMZ1gshY=
=6tq5
-----END PGP SIGNATURE-----

--pdipjojxtxrzgxi4--
