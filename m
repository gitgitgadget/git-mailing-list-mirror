From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git pull opinion
Date: Tue, 06 Nov 2007 09:31:44 +0100
Message-ID: <20071106083144.GA4435@artemis.corp>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <7vd4uomfn8.fsf@gitster.siamese.dyndns.org> <18223.46848.109961.552827@lisa.zopyra.com> <20071106004601.GS8939@artemis.corp> <20071106073841.GB3021@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="AqsLC8rIMeq19msA";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Bill Lear <rael@zopyra.com>, Junio C Hamano <gitster@pobox.com>,
	Aghiles <aghilesk@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJqs-00056U-T2
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 09:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXKFIbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXKFIbt
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:31:49 -0500
Received: from pan.madism.org ([88.191.52.104]:41768 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbXKFIbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:31:48 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A3122289DE;
	Tue,  6 Nov 2007 09:31:46 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0288D9BE8; Tue,  6 Nov 2007 09:31:44 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, Bill Lear <rael@zopyra.com>,
	Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071106073841.GB3021@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63641>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 07:38:41AM +0000, Alex Riesen wrote:
> Pierre Habouzit, Tue, Nov 06, 2007 01:46:01 +0100:
> > On Tue, Nov 06, 2007 at 12:36:16AM +0000, Bill Lear wrote:
> > > On Monday, November 5, 2007 at 15:33:31 (-0800) Junio C Hamano writes:
> > > > Stop thinking like "I need to integrate the changes from upstream
> > > > into my WIP to keep up to date."
> > > >
> > > > [...]
> > > >
> > > > Once you get used to that, you would not have "a dirty directory"
> > > > problem.
> > >=20
> > > I respectfully beg to differ.  I think it is entirely reasonable, and
> > > not a sign of "centralized" mindset, to want to pull changes others
> > > have made into your dirty repository with a single command.
> >=20
> >   I agree, I have such needs at work.  Here is how we (very informally)
> > work: people push things that they believe could help other (a new
> > helper function, a new module, a bug fix) in our master ASAP, but
> > develop big complex feature in their repository and merge into master
> > when it's ready.
> >=20
> >   Very often we discuss some bugfix that is impeding people, or a
> > most-wanted-API. Someone does the work, commits, I often want to merge
> > master _directly_ into my current work-branch, because I want the
> > fix/new-API/... whatever.
>=20
> How about merging just that "fix/new-API/... whatever" thing and not
> the whole master, which should be a complete mess by now?

  No master only holds simple patches (few of them, typically half a
dozen a day), or long-lived branches that are tested and ready to merge.

> The way you explained it it looks like typical centralized workflow.

  Well I disagree, it's /part/ centralized. We have a two speed devel
method, one that works the old-centralized way for quick fixes, and a
more decentralized approach for big changes. It's a rather nice and
useful middle ground for a company where all programmers are within
earshot.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMCZwvGr7W6HudhwRAtiJAJ9PevV/9wmzqYL7mNu5wdmzOrqFcwCggSxM
dh59WCFVjpcPiV3hOdFsAe8=
=6/SQ
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
