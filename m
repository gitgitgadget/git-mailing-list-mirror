From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 18:23:31 +0200
Message-ID: <20080728162331.GB4584@artemis.madism.org>
References: <20080728162003.GA4584@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="+g7M9IMkV8truYOl";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 18:24:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNVWU-00039N-97
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 18:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbYG1QXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758204AbYG1QXd
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 12:23:33 -0400
Received: from pan.madism.org ([88.191.52.104]:43025 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758125AbYG1QXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 12:23:32 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 198183BCC8
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 18:23:32 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 16BAFA28A; Mon, 28 Jul 2008 18:23:31 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080728162003.GA4584@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90472>


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2008 at 04:20:03PM +0000, Pierre Habouzit wrote:
> It also has the absolutely nice property to share objects, so that
> projects that replaced a subdirectory with a submodule don't see their
> checkouts grow too large.

  Especially it "fixes" git-new-workdir, which becomes really
inefficient (storage and typing-wise) when submodules are in use, since
it doesn't share git_dir's for the submodules (this could also be hacked
together, but again, it's so much more convenient if we have only _one_
git_dir per repository that ... oh well)



--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiN8oMACgkQvGr7W6HudhwnCwCgmy2aOjrwXaEEQg/w+JaF1Y6u
I7IAn1hOz7xk3Iv77U5tV3Qbwhg0UHC0
=GDkm
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
