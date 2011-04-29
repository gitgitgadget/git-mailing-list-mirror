From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH RESEND] git-svn: don't confuse editors with an apostrophe
Date: Fri, 29 Apr 2011 22:51:33 +0200
Message-ID: <20110429205130.GA2727@bee.lab.cmartin.tk>
References: <1304077214-1707-1-git-send-email-cmn@elego.de>
 <7viptxxbr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:51:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFuf7-0002Mg-Ut
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab1D2Uvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 16:51:37 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:57382 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab1D2Uvg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 16:51:36 -0400
Received: from bee.lab.cmartin.tk (brln-4d0c2189.pool.mediaWays.net [77.12.33.137])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4A2EF46132;
	Fri, 29 Apr 2011 22:51:16 +0200 (CEST)
Received: (nullmailer pid 3115 invoked by uid 1000);
	Fri, 29 Apr 2011 20:51:33 -0000
Content-Disposition: inline
In-Reply-To: <7viptxxbr7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172494>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2011 at 09:28:44AM -0700, Junio C Hamano wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> > The quotation mark serving as an apostrophe confuses editors and they
> > think a large part of the rest of the file is a string. Change
> > "you're" to "you are" to avoid this.
> >
> > Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> > ---
> >
> > I sent this on 31-03-2011 but apart from Eric's ack, there was no
> > reaction and I don't see it in the patch queue.
>=20
> It was on purpose that I did not apply it, as the usual mode of operation
> has been for me to pull git-svn changes via Eric, and more importantly, I
> did not think it was important.

 From his reply (adding Ack) I inferred he expected you to apply it.

>=20
> It did not look like a bugfix that needed to be handled quickly (even by
> bypassing Eric if needed), and more importantly, I did not think your
> justification of the patch was sound. So I (implicitly) made it up to
> Eric either to discard it or to include it as part of his pull-request.
>=20
> The explanation Eric gave (Avoiding contractions may make life easier for
> folks less familiar with English overall) makes some sense to me, but
> after re-reading your justification today, it still does not make sense.
>=20
> For one thing, many editors would not even think "you" is not a string and
> "re" and everything follows is a string, when "you're" is given to
> them. Everything is a string in a text editor, isn't it?
>=20
> I suspect that you are talking about syntax highlighting, and some syntax
> highlighter may be stupid to be confused, but in that case, at least you
> would need s/editors/some editors/.

It confuses emacs and vim and I'd be surprised if any weren't, but
I'll change the message a bit.

>=20
> Most fundamentally, I do not see why output from "sub usage" that lists
> available commands when "git svn -h" is asked for has anything to do with
> an editor getting confused. Why do you have that output in your editor in
> the first place?

It's not the output of the tool, it's the perl script. It uses the cat
<< EOF trick/method so there is a stray quotation mark and the editor
thinks that's the start of a string, so half the file is green or red
or whatever color your strings are.

I'll mention this more explicitly in the commit log, as it looks like
it's not clear enough.

   cmn

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNuyTSAAoJEHKRP1jG7ZzTDvgH/RdJm6RAMkqMVaxzEQcq9dIs
WqcX+9w7EdyPeGTZBpneRFDBKS6CN4jsNlU8Ieq4zzNLpRseyEg3YqnIuuqz2DUZ
YeAKuwIeSkPNLtRimzEVsND36HA91jx1HqFtEs435HPRafw4D84wU13yxt1FcJzP
uUe2YyyP6MJmUdaLlDhP/3sNjD0WJAV8CJSNvTK2gL9lOP30I5hP4/dnlAXpYemF
IrWew9OL+cn5i1zhgBaguQbz2fbi2pAwj+yMuAFVigiVH3uvpDX5StDNCv+YlFL2
br4jwJIxjv9r7oR+IuWrCAtClSgzTSyPtETKTswiTn51u/LmKnW712WjHWUxXBY=
=uDi3
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
