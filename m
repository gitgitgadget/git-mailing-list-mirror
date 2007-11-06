From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Tue, 06 Nov 2007 10:37:56 +0100
Message-ID: <20071106093756.GH4435@artemis.corp>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com> <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site> <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711060317220.4362@racer.site> <7vode8j7o5.fsf@gitster.siamese.dyndns.org> <20071106084925.GC4435@artemis.corp> <20071106092942.GB3197@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="h3LYUU6HlUDSAOzy";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 10:39:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpKtc-0003qr-TX
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 10:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXKFJh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 04:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbXKFJh7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 04:37:59 -0500
Received: from pan.madism.org ([88.191.52.104]:58561 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbXKFJh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 04:37:58 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 928D928B17;
	Tue,  6 Nov 2007 10:37:57 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 857B8350AC0; Tue,  6 Nov 2007 10:37:56 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071106092942.GB3197@glandium.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63652>


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 09:29:42AM +0000, Mike Hommey wrote:
> On Tue, Nov 06, 2007 at 09:49:25AM +0100, Pierre Habouzit <madcoder@debia=
n.org> wrote:
> > On Tue, Nov 06, 2007 at 04:54:02AM +0000, Junio C Hamano wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >=20
> > > > On Mon, 5 Nov 2007, Junio C Hamano wrote:
> > > >
> > > >> Allowing people to revert or cherry pick partially by using paths=
=20
> > > >> limiter is a very good idea; the whole "it comes from a commit so =
we=20
> > > >> also commit" feels an utter nonsense, though.
> > > >
> > > > No.
> > > >
> > > > When "git revert <commit>" commits the result, "git revert <commit>=
 --=20
> > > > <file>" should, too.
> > >=20
> > > I was not questioning about that part.  "If 'git revert <some
> > > other form> foo' does not talk about commit, it should not
> > > commit" was what I was referring to.
> >=20
> >   Well, I don't really know how closely you read #git, but I'd say that
> > "how do I undo my local changes in a git repository" is among the top 3
> > questions. There _IS_ an UI issue for that.
> >=20
> > If git revert <commitish> -- path1 path2 path3 is going to work at some
> > point, I see no harm in saying that git revert HEAD -- path1 path2 path3
> > work. We can also in that case spit an error message:
>=20
> It seems to me git revert HEAD -- path1 path2 path3 should revert the cha=
nges
> made in the commit pointed to by HEAD, not revert the changes in the work=
ing
> tree or the index...

  Yes, sorry, the `HEAD` in my sentence was spurious.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMDX0vGr7W6HudhwRApKHAKCk5MnezTA77wFxKO1JzidXrIBgcgCdG6c+
f2n+62QuO7wi6lZog6C6oXc=
=4+nZ
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
