From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH/RFC] git add: do not add files from a submodule
Date: Wed, 23 Jul 2008 21:02:27 +0200
Message-ID: <20080723190227.GF20614@artemis.madism.org>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com> <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness> <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness> <alpine.DEB.1.00.0807222230490.8986@racer> <7vhcahgl2j.fsf@gitster.siamese.dyndns.org> <20080723081333.GA15243@artemis.madism.org> <7v8wvse9l7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Qz2CZ664xQdCRdPu";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:03:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjcb-0006lh-Bx
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbYGWTCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbYGWTCc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:02:32 -0400
Received: from pan.madism.org ([88.191.52.104]:34017 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbYGWTCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:02:31 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7067A3A786;
	Wed, 23 Jul 2008 21:02:29 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0BDC23B10F0; Wed, 23 Jul 2008 21:02:27 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8wvse9l7.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89740>


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 06:31:16PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Wed, Jul 23, 2008 at 06:40:20AM +0000, Junio C Hamano wrote:
> > ...
> >> If we started the process of diagnosing and fixing these issues earlie=
r,
> >> and had plausible code to address the issue already in 'next' before t=
he
> >> current -rc cycle started, the topic would have been an obvious candid=
ate
> >> for the coming release and I'd further say it would be even worth dela=
ying
> >> the release for a few weeks if it takes more time.  But I have to say =
it
> >> is too late for 1.6.0 now if we are just noticing and starting the
> >> discussion.
> >
> >   Well given that we now use submodules at work, and that git is
> > nowadays somewhere in the top 5 of my most consciously (as opposed to
> > the compiler that I rarely call by hand) used software suites (among my
> > editor, my MUA, my shell and my tiling WM), I'm very much interested in
> > tackling some things about what is (not) done with submodules yet.
>=20
> Surely the effort is appreciated.

  okay I'll try to work on this on the git wiki so that collaboration is
possible.

>=20
> >> This comment goes to the issue Pierre raised last night as well.
> >
> >   You mean the git checkout issue?
>=20
> Oh, no; that misuse of parse_opt() that forgot KEEP_DASHDASH one was not
> what I had in mind.  I meant to say that your "switch branches between an
> old pre-submodule rev and a new one that has a submodule at where a blob
> or directory used to be" issue with a good explanation material was a good
> starting point for submodule improvements for the next cycle.

  ohh that :)

> I'd like the release schedule not too heavily based on "per feature", but
> more time-based.

  Yeah, we've seen in the past how it makes a release slip. Though it'd
be great to say e.g. that we won't do a 1.7.0 release[0] until we have
an UI for submodules we are prood of. It doesn't mean that we won't have
a 1.6.21 because it's slow to get into shape ;)

  IOW I'm all for time based releases, with some big milestones that
when completed bump the git version significantly. And hinting on what
are those milestones would probably be quite nice. I mean git
developpement is kind of a hit and run thing: people have an issue, come
with patches, and go back to their lives (except for a mere 20 regular
contributors with more than 50 patches). Maybe we should hint some
direction we would like to see a bit more. examples of such big
directions are:
  * submodules UI ;
  * sparse checkouts ;
  * ...


  [0] I don't really *mean* we must do it for 1.7.0, It's merely an
      example.

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHgEEACgkQvGr7W6HudhxeFACfRdIT0zEgzAI3uYcY90U3lIF/
jkEAniq3D7qwWdZ1ML/XiBWJnHB+ID/L
=3BS8
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
