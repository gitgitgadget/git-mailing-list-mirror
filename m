From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git pull opinion
Date: Tue, 06 Nov 2007 01:46:01 +0100
Message-ID: <20071106004601.GS8939@artemis.corp>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <7vd4uomfn8.fsf@gitster.siamese.dyndns.org> <18223.46848.109961.552827@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="sLx0z+5FKKtIVDwd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 01:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpCaB-0000ua-Tx
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 01:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbXKFAqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 19:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbXKFAqF
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 19:46:05 -0500
Received: from pan.madism.org ([88.191.52.104]:51191 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbXKFAqD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 19:46:03 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B2BAA27053;
	Tue,  6 Nov 2007 01:46:01 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 50BA3746B7; Tue,  6 Nov 2007 01:46:01 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Bill Lear <rael@zopyra.com>, Junio C Hamano <gitster@pobox.com>,
	Aghiles <aghilesk@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <18223.46848.109961.552827@lisa.zopyra.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63603>


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 12:36:16AM +0000, Bill Lear wrote:
> On Monday, November 5, 2007 at 15:33:31 (-0800) Junio C Hamano writes:
> > Stop thinking like "I need to integrate the changes from upstream
> > into my WIP to keep up to date."
> >
> > [...]
> >
> > Once you get used to that, you would not have "a dirty directory"
> > problem.
>=20
> I respectfully beg to differ.  I think it is entirely reasonable, and
> not a sign of "centralized" mindset, to want to pull changes others
> have made into your dirty repository with a single command.

  I agree, I have such needs at work.  Here is how we (very informally)
work: people push things that they believe could help other (a new
helper function, a new module, a bug fix) in our master ASAP, but
develop big complex feature in their repository and merge into master
when it's ready.

  Very often we discuss some bugfix that is impeding people, or a
most-wanted-API. Someone does the work, commits, I often want to merge
master _directly_ into my current work-branch, because I want the
fix/new-API/... whatever.

  I don't believe it's because we have a centralized repository that I
have those needs, I would have the very same if I pulled changes
directly from my colleagues repository. The reason why I need it at work
is because there are some very vivid kind of changes, that only takes a
couple of diff lines, and that you _need_ for your work to be completed.
It's not really a matter of being fully up-to-date.

  Though to my delight, with the current tip-of-next git, I noticed that
many rebase and pull work in a dirty tree now :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL7lJvGr7W6HudhwRAsZoAJ9LA6onmigDyYJpSfVGbSnprK4kgACfYvZf
kMZARe1+qwR5z9+pV0ovxSU=
=/jwF
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
