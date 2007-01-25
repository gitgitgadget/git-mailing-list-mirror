From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: cvsimport/cvsps: wrong revisions in branch
Date: Thu, 25 Jan 2007 15:35:30 +0100
Message-ID: <45B8C032.7020004@fs.ei.tum.de>
References: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig41FC0FDE164E48733427D080"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 15:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA5hW-0004Ct-OC
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 15:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965380AbXAYOfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 09:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965387AbXAYOfj
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 09:35:39 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:32984 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965380AbXAYOfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 09:35:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 0E8CA281C0
	for <git@vger.kernel.org>; Thu, 25 Jan 2007 15:35:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Wmfa00U9gcLe for <git@vger.kernel.org>;
	Thu, 25 Jan 2007 15:35:36 +0100 (CET)
Received: from [62.216.203.191] (ppp-62-216-203-191.dynamic.mnet-online.de [62.216.203.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 40F4E281BB
	for <git@vger.kernel.org>; Thu, 25 Jan 2007 15:35:36 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37725>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41FC0FDE164E48733427D080
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Gerrit Pape wrote:
> Hi, I struggle with importing a CVS repository into git to switch over
> development.  In some branches there're differences in the source code
> after importing into git.  We tracked this down to tags and branches
> that where tagged partially in CVS, first a tag was set on one
> subdirectory tree (sources), later on another subdirectory tree (docs).=

> This confuses cvsimport or cvsps, the tag in git after import doesn't
> match the tag in CVS.

how do you expect this to ever work?  your tag is not a time stable one. =
 the tag spans multiple change sets.  best forget the whole tag thing, se=
riously.  my cvs converter [1] already has a hard time reproducing branch=
es correctly.  doing this with tags is impossible.  svn can do this becau=
se they don't have tags, so it is a kind of fake.  of course you could do=
 this in git as well by actually creating a branch for a tag, but it is r=
eally messy.  just don't do that.

good luck
  simon

[1]: <http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs>, not 100% yet, but pr=
obably the best you can get at the moment.  i'm a perfectionist, so i mig=
ht never call it "done".

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig41FC0FDE164E48733427D080
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuMA1r5S+dk6z85oRAsqhAJ9t6Jb0c+VC+hM0r002/sxud9oueACcDnJ9
1gO45OOQp2GTX0pOBuxTeec=
=Fcck
-----END PGP SIGNATURE-----

--------------enig41FC0FDE164E48733427D080--
