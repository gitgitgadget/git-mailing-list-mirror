From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [3/5] Add http-pull
Date: Sat, 23 Apr 2005 01:24:42 +0200
Message-ID: <1114212282.27940.11.camel@nosferatu.lan>
References: <Pine.LNX.4.21.0504221911340.30848-100000@iabervon.org>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s3PklWagnjNAxYWaPYp/"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>, tony.luck@intel.com,
	Brad Roberts <braddr@puremagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:17:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7OE-0005Jg-52
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDVXVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVDVXVR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:21:17 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:3254 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261303AbVDVXUz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 19:20:55 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg1.saix.net (Postfix) with ESMTP id 0925F52C5;
	Sat, 23 Apr 2005 01:20:47 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id D70EE3A2430;
	Sat, 23 Apr 2005 01:27:09 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02751-13; Sat, 23 Apr 2005 01:27:04 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id C919D3A241A;
	Sat, 23 Apr 2005 01:27:04 +0200 (SAST)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504221911340.30848-100000@iabervon.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-s3PklWagnjNAxYWaPYp/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 19:12 -0400, Daniel Barkalow wrote:
> On Sat, 23 Apr 2005, Petr Baudis wrote:
>=20
> > Dear diary, on Sat, Apr 23, 2005 at 01:00:33AM CEST, I got a letter
> > where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > > On Sat, 23 Apr 2005, Petr Baudis wrote:
> > >=20
> > > > Dear diary, on Fri, Apr 22, 2005 at 09:46:35PM CEST, I got a letter
> > > > where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > > >=20
> > > > Huh. Why? You just go back to history until you find a commit you
> > > > already have. If you did it the way as Tony described, if you have =
that
> > > > commit, you can be sure that you have everything it depends on too.
> > >=20
> > > But if you download 1000 files of the 1010 you need, and then your ne=
twork
> > > goes down, you will need to download those 1000 again when it comes b=
ack,
> > > because you can't save them unless you have the full history.=20
> >=20
> > Why can't I? I think I can do that perfectly fine. The worst thing that
> > can happen is that fsck-cache will complain a bit.
>=20
> Not if you're using the fact that you don't have them to tell you that yo=
u
> still need the other 10, which is what tony's scheme would do.
>=20

Any way (like maybe extending one of the web interfaces already around)
to first get a list of all the sha1's you need, and then starting from
the bottom like Tony/Petr wants you to do?


--=20
Martin Schlemmer


--=-s3PklWagnjNAxYWaPYp/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaYe6qburzKaJYLYRAtbkAJ41ej+lzTtJ3RKkxkJRgi1VgBu68ACffEBq
rvPd+6KZszsg16mg5/3Iqq0=
=Jyl5
-----END PGP SIGNATURE-----

--=-s3PklWagnjNAxYWaPYp/--

