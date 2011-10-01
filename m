From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sat, 01 Oct 2011 02:05:02 +0200
Message-ID: <1317427503.4331.37.camel@centaur.lab.cmartin.tk>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-qGyCcIQp+8jTKEagoRv9"
Cc: git@vger.kernel.org
To: Grant <emailgrant@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 02:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9n4t-0007lF-SJ
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 02:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab1JAAFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 20:05:04 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:45550 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755251Ab1JAAFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 20:05:03 -0400
Received: from [192.168.1.17] (brln-4dbc5ac8.pool.mediaWays.net [77.188.90.200])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 9AD544617B;
	Sat,  1 Oct 2011 02:04:38 +0200 (CEST)
In-Reply-To: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182528>


--=-qGyCcIQp+8jTKEagoRv9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-09-30 at 16:43 -0700, Grant wrote:
> Hello, I'm trying to decide between git and subversion.  Subversion
> has "Path-Based Authorization" so I can give a developer access to
> only specific files instead of everything.  Does git have something
> similar?

Git's model does not allow the same type "Path-Based Authorization" that
Subversion uses, because git uses secure hash sums to make sure that
people don't try to sneak changes into a pull request or merge, and you
can't selectively download parts of the tree because then you couldn't
check that one of your remotes isn't trying to lie to you.

You can do something that is (or can be) similar with git and
gitolite[0] so a developer (or set of developers) only has access to a
particular set of branches. Depending on what exactly you're trying to
do, this can be more or less complicated to set up. If you only want a
set of developers to access the subdirectory
clients/importantsecretclient, then you create that directory only in
the branch or branches that developer can read. There are many examples
int he gitolite wiki.

[0] https://github.com/sitaramc/gitolite/wiki/

HTH

   cmn


--=-qGyCcIQp+8jTKEagoRv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOhlkuAAoJEHKRP1jG7ZzT2PAH/RE4Vp4QfebqPkDAXHIZrh3a
6JycNVe6DfDVDgCPvwGIYcEr69PF/1CCwgQCUXpKGNnDDtPfYMBBT3ceA25s3jKO
ilyVtnzC/W8oAUM/Eq+JeWxVUBH1z/PX6I42RsEsP2Iw0eqzhfpLO8Ami4UjMRes
A+MB8blA7u/wLk6uMnzVFCDXzgpaUQlNXyA2FtzOhL8SeoYs/Ne/PUTuw4sdczQS
TQQb8V6gquAYU01ALC1k/WJ+0thhsVVxffCl9jBC6PFg/aGn3A69eILCUA0dtf8m
MrNG2tnh3eo/Kf+tfipF96CX/jg2rQU9+1pBy0md93Mi2Zmbhd8zytbc+3LFWUU=
=qHuu
-----END PGP SIGNATURE-----

--=-qGyCcIQp+8jTKEagoRv9--
