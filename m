From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC 0/6] sort tags by date (git tag -l -D)
Date: Mon, 23 Feb 2009 10:04:23 +0100
Message-ID: <200902231004.25784.trast@student.ethz.ch>
References: <e29894ca0902221006s1c1af9f9o8c13ff9e06670d95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3602218.sc872Qqi63";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?utf-8?q?Marc-Andr=C3=A9?= Lureau" <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 10:07:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbWlN-0006hu-GX
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 10:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbZBWJEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 04:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZBWJEk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 04:04:40 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:35807 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbZBWJEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 04:04:39 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 10:04:37 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 10:04:36 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <e29894ca0902221006s1c1af9f9o8c13ff9e06670d95@mail.gmail.com>
X-OriginalArrivalTime: 23 Feb 2009 09:04:36.0814 (UTC) FILETIME=[C0721EE0:01C99595]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111123>

--nextPart3602218.sc872Qqi63
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Marc-Andr=E9 Lureau wrote:
> I needed to sort my tags by date, and not only the annotated tags.

As others have pointed out, there's no sane way to sort=20

> I was surprised that git tag didn't know how to do that. May be it
> could be handled simply by some shell script. Please tell me :)

Modulo timezone differences

  git for-each-ref --format=3D"%(taggerdate:raw)%(committerdate:raw) %(refn=
ame:short)" refs/tags | sort -n | cut -d\  -f3

=46or some neat reason only one of the dates is displayed, depending on
the type of object.

(Interestingly, the v0.99 tag in git.git doesn't have a date or
tagger...)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3602218.sc872Qqi63
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmiZpkACgkQqUud07tmzP00oQCgiLGIkX9FNFkTIxDLAYnbuf63
idAAoI23uRTHYM7TPuvEmneMuE+CAsN0
=IRL4
-----END PGP SIGNATURE-----

--nextPart3602218.sc872Qqi63--
