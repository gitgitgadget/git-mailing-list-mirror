From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 10:45:30 +0200
Message-ID: <20080729084530.GD32312@artemis.madism.org>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com> <20080729060449.GG11947@spearce.org> <320075ff0807290118o62a6fc1eq3e90e32ef7783a17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="jL2BoiuKMElzg3CS";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:46:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkqo-0001UJ-1B
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbYG2Ipe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYG2Ipd
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:45:33 -0400
Received: from pan.madism.org ([88.191.52.104]:52126 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbYG2Ipd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:45:33 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 722A62F992;
	Tue, 29 Jul 2008 10:45:31 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6CABD5A974F; Tue, 29 Jul 2008 10:45:30 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <320075ff0807290118o62a6fc1eq3e90e32ef7783a17@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90604>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2008 at 08:18:12AM +0000, Nigel Magnay wrote:
> >> I try to keep all my submodules on (no branch) as much as possible.
> >> In a way, I feel like that kind of relieves me of the chore of keeping
> >> mapping superproject branches to submodule branches in my head.
> >
> > At my former day-job we wrote our own "git submodule" in our
> > build system before gitlink was available in the core, let alone
> > git-submodule was a Porcelain command.
> >
> > Many developers who were new to Git found having a sea of 11 Git
> > repositories+working directories in a single build area difficult to
> > manage.  They quickly found the detached HEAD feature in a submodule
> > to be a really handy way to know if they made changes there or not.
> >
> > Most of our developers also modified __git_ps1() in their bash
> > completion to use `git name-rev HEAD` to try and pick up a remote
> > branch name when on a detached HEAD.  This slowed down their bash
> > prompts a little bit, but they found that "origin/foo" hint very
> > valuable to let them know they should start a new branch before
> > making changes.
> >
> > So I'm just echoing what Benjamin said above, only we did it
> > independently, and came to the same conclusion.
> >
>=20
> Hm.
> My developers are (mostly) on windows, so "altering PS1" or even
> writing "shell scripts" is way beyond them.

  More importantly, you don't have all your submodule states in your PS1
so this argument is already moot for *nix users as well.

> They want it to "just work" (where their previous experience is SVN
> superprojects with multiple svn:externals). I have a hard time
> justifying the experience that if we're all working on master, then as
> soon as Joe Q developer does 'submodule update' then poof - his heads
> are disconnected.

  Well, maybe it's not as hard, maybe what we lack are just submodule
aware porcelains (I mean we lack those for sure, but maybe it's also
the _only_ thing we miss to have a better user experience, and I begin
to believe it).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiO2KoACgkQvGr7W6HudhwUyACeMtSVVCnSLqGlGf0Wcw0Dx+tX
icMAn3LHiALrXfAWgwt0jDbiDiT4AM6h
=tPDd
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
