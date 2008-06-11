From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-rebase -i: have an option for amending the commit  message only.
Date: Thu, 12 Jun 2008 00:27:44 +0200
Message-ID: <20080611222744.GD16439@artemis.madism.org>
References: <1213196490-7762-1-git-send-email-madcoder@debian.org> <48501B3D.3000405@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="eheScQNz3K90DVRs";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Thu Jun 12 00:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Yo7-0004QA-HW
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 00:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbYFKW1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 18:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYFKW1s
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 18:27:48 -0400
Received: from pan.madism.org ([88.191.52.104]:34116 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbYFKW1r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 18:27:47 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9BEAC2BA63;
	Thu, 12 Jun 2008 00:27:46 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C222BCFC9; Thu, 12 Jun 2008 00:27:44 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Olivier Marin <dkr+ml.git@free.fr>, git@vger.kernel.org,
	gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <48501B3D.3000405@free.fr>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84674>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2008 at 06:36:45PM +0000, Olivier Marin wrote:
> Hi,
>=20
> I like the feature and I have just two comments:
>=20
> Pierre Habouzit a =C3=A9crit :
> >
> > +	comment|c)
>=20
> Is "comment" the right name? I'm not sure, I just ask.

  Well, edit would have been better, but it's taken already. 'message'
has m as a shortcut, already taken by merge, so 'comment' felt like the
best I could come up with.

  To be fair, if someone has a better name, I'm all for it. I quite care
about the feature, edit needs me to run the --amend myself, whereas I
often just want to fix a typo in a commit log.

> > +		comment_for_reflog comment
> > +
> > +		mark_action_done
> > +		pick_one $sha1 ||
> > +			die_with_patch $sha1 "Could not apply $sha1... $rest"
> > +		output git commit --no-verify --amend -e -C HEAD
>=20
> It does not work with an editor that opens in the current terminal
> like vi. Just remove "output" should fix the problem, I think.

  I'm surprised because I used it this way, but maybe it was on the
machine where my git editor is gvim and not vim =E2=80=A6

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhQUWAACgkQvGr7W6HudhwmPgCgjeXH1PjrdGQVNx5hBZgnWvoQ
+egAoJYHXb+xrsjZKtqXyYr4i53GoycP
=BUbd
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
