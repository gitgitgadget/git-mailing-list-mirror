From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] doc/bundle: Use the more conventional suffix '.bundle'
Date: Sun, 8 Feb 2009 04:04:50 -0600
Message-ID: <200902080404.57187.bss@iguanasuicide.net>
References: <1234045309-3626-1-git-send-email-santi@agolina.net> <200902072302.36991.bss@iguanasuicide.net> <adf1fd3d0902080141s11b53127ufa83918c00b4579b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1419816.TnKaCqbjdV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6YV-0001gX-S9
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbZBHKFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbZBHKFA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:05:00 -0500
Received: from eastrmmtao101.cox.net ([68.230.240.7]:35814 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbZBHKE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:04:59 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090208100458.WZFQ15713.eastrmmtao101.cox.net@eastrmimpo03.cox.net>;
          Sun, 8 Feb 2009 05:04:58 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id DN4x1b00S2i4SyG02N4y1b; Sun, 08 Feb 2009 05:04:58 -0500
X-Authority-Analysis: v=1.0 c=1 a=ryI2rUtTaDEA:10 a=VIyw5D3L1boA:10
 a=Fq1VQ0LPAAAA:8 a=t7cSbIdfS0259DAe2HMA:9 a=AYtNikVPnSp88ew8TMQA:7
 a=5VBmqXwGsnNhcM8bR9TMARD6AvYA:4 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=hoPEDgpzxBCMjXXxnxYA:9 a=XDQ9fndE5KxIbtcIfCjLAX66fr4A:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LW6X3-000FZr-FK; Sun, 08 Feb 2009 04:04:57 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <adf1fd3d0902080141s11b53127ufa83918c00b4579b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108944>

--nextPart1419816.TnKaCqbjdV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 08 February 2009 03:41:04 Santi B=E9jar wrote:
> 2009/2/8 Boyd Stephen Smith Jr. <bss@iguanasuicide.net>:
> > On Saturday 07 February 2009 16:21:49 Santi B=E9jar wrote:
> >> Although it does not matter in general it is handled different by
> >> "git clone", as it removes it to make the "humanish" name of the
> >> new repository.
> > I'm mixed on this, particularly with the increasing numbers of MySysGit
> > users we attract.  Perhaps it would be better to teach clone to remove
> > .bdl as well.
> I don't have an opinion as I don't know exactly the situation for
> MSysGit users, but I don't think it is a good idea to have two
> suffixes.

Why not?  It seems preferable to use .bundle since it is more easily=20
recognized, but .bdl is nice for system that are limited to a 3 byte=20
extensions.  Existing MIME types have multiple extensions.  It is unlikely =
Git=20
is run on a system that only allows 3 bytes extensions though, most of the=
=20
ones that I'm aware of don't like 38 byte filenames. =20

I'm warming to this patch
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart1419816.TnKaCqbjdV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmOrkMACgkQ55pqL7G1QFkfyACeNmDVP5Mc9fBLHaL12xskrxvo
sOgAmwRtOurOuQHgEiMpBQ2RyaxrqZHm
=GKCX
-----END PGP SIGNATURE-----

--nextPart1419816.TnKaCqbjdV--
