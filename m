From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH/RFC] git add: do not add files from a submodule
Date: Wed, 23 Jul 2008 10:13:33 +0200
Message-ID: <20080723081333.GA15243@artemis.madism.org>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com> <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness> <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness> <alpine.DEB.1.00.0807222230490.8986@racer> <7vhcahgl2j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ReaqsoxgOBHFXBhH";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 10:14:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLZUc-0008Iv-Ll
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 10:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbYGWINj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 04:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbYGWINi
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 04:13:38 -0400
Received: from pan.madism.org ([88.191.52.104]:59006 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbYGWINg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 04:13:36 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B0F713458F;
	Wed, 23 Jul 2008 10:13:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 22D2D1426F0; Wed, 23 Jul 2008 10:13:33 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhcahgl2j.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89610>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 06:40:20AM +0000, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > Do you plan to apply the split-up builtin-add enhancments you did a few=
=20
> > nights ago,...
>=20
> I have a few updates to that one, I'll be sending them out shortly.
>=20
> Switching branches between revs that have and do not have submodule at a
> given path has always been broken.  It is not even a "known breakage",
> which is a word used for something that has a sensible design already is
> worked out but the implementation does not do so.
>=20
> If we started the process of diagnosing and fixing these issues earlier,
> and had plausible code to address the issue already in 'next' before the
> current -rc cycle started, the topic would have been an obvious candidate
> for the coming release and I'd further say it would be even worth delaying
> the release for a few weeks if it takes more time.  But I have to say it
> is too late for 1.6.0 now if we are just noticing and starting the
> discussion.

  Well given that we now use submodules at work, and that git is
nowadays somewhere in the top 5 of my most consciously (as opposed to
the compiler that I rarely call by hand) used software suites (among my
editor, my MUA, my shell and my tiling WM), I'm very much interested in
tackling some things about what is (not) done with submodules yet.

  I sent a mail some time ago about those issues, in short words, those
concern git-checkout, git-reset, git-fetch and git-push for starters.
I'm not sure I can help with the code a lot, but I can for sure provide
a comprehensive list of things I would like the porcelain to do with
submodules if that helps.

> This comment goes to the issue Pierre raised last night as well.

  You mean the git checkout issue ? Because the issue is twofold, one
there is the missing warnings that users can shoot themselves in the
foot unnoticed, and there is the fact that "git checkout -- $foo" does
not what it should when "$foo" is a valid revision (and *that* is a
really really bad bug, that if I'm correct changing parse_options flags
to KEEP_DASHDASH fixes alright).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiG6CsACgkQvGr7W6Hudhwa7gCfVa1avEGDRN2ATXek0lW4/Tr2
8e0AoI0ppRLAn0sSIBbS5LezY98cgPcG
=VqBT
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
