From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How to Import a bitkeeper repo into git
Date: Tue, 16 Oct 2007 21:15:49 +0200
Message-ID: <20071016191549.GG26127@efreet.light.src>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <20070709173720.GS29994@genesis.frugalware.org> <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org> <4713FA4A.5090501@bluelane.com> <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Cc: Pete/Piet Delaney <pete@bluelane.com>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihrtl-0007hM-9W
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 21:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935569AbXJPTQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 15:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935581AbXJPTQB
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 15:16:01 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:44788 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935579AbXJPTQA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 15:16:00 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 67F47572EE;
	Tue, 16 Oct 2007 21:15:58 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 2QD2kIKScywt; Tue, 16 Oct 2007 21:15:55 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5E9EE5725C;
	Tue, 16 Oct 2007 21:15:54 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IhrtN-0001vi-NL; Tue, 16 Oct 2007 21:15:49 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61239>


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2007 at 17:45:44 -0700, Linus Torvalds wrote:
> I don't actually know of any sane programs to view unified diffs, but you=
=20
> can script one with little trouble. Here's a really hacky one I just came=
=20
> up with:
>=20
> 	#!/bin/sh
> 	cat "$@" > /tmp/diff
> 	grep '^[ -]' /tmp/diff > /tmp/orig
> 	grep '^[ +]' /tmp/diff > /tmp/result
> 	meld /tmp/orig /tmp/result
>=20
> which fools 'meld' into showing a unified diff in a nice graphical manner.
>=20
> [ Quite frankly, I don't understand why tools like meld and kdiff3 can't=
=20
>   just take the unified diff directly - they have *all* the logic, it=20
>   should be trivial to do, and very useful to view diffs for those people=
=20
>   who like that graphical bling. ]

Kompare (KDE analog of meld) can. It is even bound to text/x-diff in
konqueror, so opening patches with konqueror yields side-by-side diff view.
On the other hand it still keeps a unixy behaviour:
 git diff | kompare -
works.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHFQ3lRel1vVwhjGURAhQJAKCSY7t/PxO2PHxvQuvMDFPWmB0RMgCgq46O
pP14xQyGblSlUmjmBXhCLvA=
=oeni
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
