From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 16:49:14 +0200
Message-ID: <20080729144914.GI32312@artemis.madism.org>
References: <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com> <20080729082135.GB32312@artemis.madism.org> <20080729083755.GC32312@artemis.madism.org> <20080729085125.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807291413460.4631@eeepc-johanness> <20080729130713.GF32312@artemis.madism.org> <alpine.DEB.1.00.0807291511400.4631@eeepc-johanness> <320075ff0807290631l1f9a1e70jcb73bde7e2c86000@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="CNK/L7dwKXQ4Ub8J";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 16:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNqWq-0003k9-Nw
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 16:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbYG2OtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 10:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYG2OtU
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 10:49:20 -0400
Received: from pan.madism.org ([88.191.52.104]:45418 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbYG2OtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 10:49:19 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E8B9D3BDFC;
	Tue, 29 Jul 2008 16:49:15 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8981A498BD4; Tue, 29 Jul 2008 16:49:14 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <320075ff0807290631l1f9a1e70jcb73bde7e2c86000@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90642>


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2008 at 01:31:23PM +0000, Nigel Magnay wrote:
> > I do not understand.  We are talking about three different things here:
> >
> > 1) the committed state of the submodule
> > 2) the local state of the submodule
> > 3) the state of the "tracks" branch
> >
> > We always have 1) and we have 2) _iff_ the submodule was checked out.  =
We
> > only will have 3) if "tracks" is set in .git/config (for consistency's
> > sake, we should not read that information directly from the .gitmodules
> > file, but let the user override it in .git/config after "submodule init=
".
> >
>=20
> I think the implication is that .gitconfig states "I'm expecting that
> submodule X will always be tracking branch name 'Y'" and that you
> wouldn't ever override it in .git/config. If you then switched
> submodule X to branch Z, then committed the superproject, that commit
> would contain a change to .gitconfig also (to say I'm expecting to
> track Z rather than X') ?

  Yes, tracks branch in .git/config doesn't fly. Or you need a
branch.$supermodule_branch.$submodule_name.tracks setting (oh god!)

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiPLeoACgkQvGr7W6HudhyuFgCfVy3f/Ifxpfaqeb9MM/hnr7zZ
1rIAoKh7Qu1767hLKxO60DVfNIcal/C0
=Fozm
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
