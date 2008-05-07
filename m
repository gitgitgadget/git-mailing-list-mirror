From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: How can I specify multiple refs on one line in the config file?
Date: Thu, 8 May 2008 00:27:51 +0200
Message-ID: <20080507222751.GC23672@genesis.frugalware.org>
References: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com> <18071eea0805071433j5bde8868w305d9a80c00bd2bd@mail.gmail.com> <588192970805071519i76c23367ue497e37445fa7c74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YMf7pJGz0wcApMUv"
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:29:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jts8F-0001J2-Tm
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933290AbYEGW17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933033AbYEGW16
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:27:58 -0400
Received: from virgo.iok.hu ([193.202.89.103]:33501 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763440AbYEGW14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:27:56 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2AA281B253A;
	Thu,  8 May 2008 00:27:52 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E6F704465E;
	Thu,  8 May 2008 00:22:54 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id ED1D01190ACB; Thu,  8 May 2008 00:27:51 +0200 (CEST)
Mail-Followup-To: Steve Hoelzer <shoelzer@gmail.com>,
	Thomas Adam <thomas.adam22@gmail.com>,
	git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <588192970805071519i76c23367ue497e37445fa7c74@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81485>


--YMf7pJGz0wcApMUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2008 at 05:19:30PM -0500, Steve Hoelzer <shoelzer@gmail.com=
> wrote:
> On Wed, May 7, 2008 at 4:33 PM, Thomas Adam <thomas.adam22@gmail.com> wro=
te:
> > I might be misunderstanding you, but to push tags, there's:
> >
> > git push --tags
>=20
> True, but I only want to type "git push". No, it's not _really_
> necessary, but I'd like to set it up that way so I don't have to
> depend on my coworkers (new git users) remembering "--tags".

are you sure pushing tags by default is a good idea? people regularly
create local tags to mark a commit before a rebase, to mark a commit as
a fix for a given bug, etc. those tags aren't interesting for others.
tags which should be pushed usually rare. then you can use git push
origin tag v1.0, since you know which tag you really want to push.

--YMf7pJGz0wcApMUv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgiLOcACgkQe81tAgORUJatgwCfc1ncZU7aX/IOsqe89PoYIF1x
YGkAn36If/PVepw0GAzsyXzNoW0NNZJq
=xkVK
-----END PGP SIGNATURE-----

--YMf7pJGz0wcApMUv--
