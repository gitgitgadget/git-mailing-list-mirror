From: David Clymer <david@zettazebra.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 23:24:51 -0400
Message-ID: <1161660291.22276.209.camel@zepto.home.zettazebra.com>
References: <45357CC3.4040507@utoronto.ca>
	 <200610222206.13973.jnareb@gmail.com>
	 <1161604564.22276.173.camel@zepto.home.zettazebra.com>
	 <200610231454.06355.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-25e6ceoxDgpF7yDHfeNp"
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 05:23:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcCtS-0005PQ-5t
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 05:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWJXDXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 23:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWJXDXz
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 23:23:55 -0400
Received: from zettazebra.com ([72.36.162.130]:44258 "EHLO zettazebra.com")
	by vger.kernel.org with ESMTP id S932404AbWJXDXy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 23:23:54 -0400
Received: from 67-23-48-101.chvlva.adelphia.net ([67.23.48.101] helo=[192.168.11.100])
	by zettazebra.com with esmtpa (Exim 4.50)
	id 1GcCtF-0006Wt-SX; Mon, 23 Oct 2006 23:23:46 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610231454.06355.jnareb@gmail.com>
X-Mailer: Evolution 2.6.3 
X-SA-Exim-Connect-IP: 67.23.48.101
X-SA-Exim-Mail-From: david@zettazebra.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29918>


--=-25e6ceoxDgpF7yDHfeNp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 at 14:54 +0200, Jakub Narebski wrote:
> On Mon, Oct 23, 2006 David Clymer wrote:
> > On Sun, 2006-10-22 at 22:06 +0200, Jakub Narebski wrote:
> >> David Clymer wrote:
>=20
> >>> 2. bzr does not support fully distributed development because revnos
> >>> "don't work" as stated in #1.
> >>
> >> Bazaar is biased towards centralized/star-topology development if we
> >> want to use revnos. In fully distributed configuration there is no
> >> "simple namespace".
> >=20
> > So revnos aren't globally meaningful in fully distributed settings. So
> > what? I don't see how this translates into bias. There is a lot of
> > functionality provided by bazaar that doesn't really apply to my use
> > case, but it doesn't mean that it is indicative of some bias in bazaar.
>=20
> First, bzr is biased towards using revnos: bzr commands uses revnos
> by default to provide revision (you have to use revid: prefix/operator
> to use revision identifiers), bzr commands outputs revids only when
> requested, examples of usage uses revision numbers.

Agreed. Of course, I want the simplest case to be the simplest. When
working on my own branch, regardless if it is a standalone project or
part of a distributed one, I don't want to have to type SHA hashes or
revids. Numbers serve my purposes best in this case. When I communicate
with other distributed developers, I can and should use revids.

>=20
> In order to use revnos as _global_ identifiers in distributed development=
,
> you need central "branch", mainline, to provide those revnos. You have
> either to have access to this "revno server" and refer to revisions by
> "revno server" URL and revision number, or designate one branch as holdin=
g
> revision numbers ("revno server") and preserve revnos on "revno server"
> by using bzr "merge", while copying revnos when fetching by using bzr "pu=
ll"
> for leaf branches. In short: for revnos to be global identifiers you need
> star-topology.

Ok. Let's not repeat this again. I think I said this once, and you've
said it in two following emails. It's a given. Assume that we all know
it.

>=20
> Even if you use revnos only locally, you need to know which revisions are
> "yours", i.e. beside branch as DAG of history of given revision you need
> "ordered series of revisions" (to quote Bazaar-NG wiki Glossary), or path
> through this diagram from given revision to one of the roots (initial,
> parentless revisions). Because bzr does that by preserving mentioned path
> as first-parent path (treating first parent specially), i.e. storing loca=
l
> information in a DAG (which is shared), to preserve revnos you need to
> use "merge" instead of "pull", which means that you get empty-merge in
> clearly fast-forward case. This means "local changes bias", which some
> might take as not being fully distributed.

"local changes bias" I can buy that. I even like it. I don't even care
if that makes bazaar "not fully distributed." I don't think the
distinction between "fully" and "almost, except for some technicality"
distributed is one that has much practical value.

-davidc
--=20
gpg-key: http://www.zettazebra.com/files/key.gpg

--=-25e6ceoxDgpF7yDHfeNp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPYeD2XpGgG+SNaERAkupAJ41HBz7LOn8NBKf6Ow02a0DWNZSXACeKNTT
qUYZZyk4eRdc+j0CYRE2Nkk=
=3QoA
-----END PGP SIGNATURE-----

--=-25e6ceoxDgpF7yDHfeNp--
