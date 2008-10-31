From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Fri, 31 Oct 2008 16:57:29 +0100
Message-ID: <20081031155729.GB627@artemis.corp>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Yylu36WmvOXNoKYn";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 17:00:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvwOb-000334-Ox
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 16:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYJaP5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 11:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbYJaP5c
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 11:57:32 -0400
Received: from pan.madism.org ([88.191.52.104]:52968 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbYJaP5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 11:57:31 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DC7DA3B480
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 16:57:30 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E65005EE243; Fri, 31 Oct 2008 16:57:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225468527-29694-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99596>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 03:55:27PM +0000, Pierre Habouzit wrote:
> * Rename builtin-revert.c into builtin-cherry-pick.c
>=20
> * Add option -R/--revert to git-cherry-pick.
>   Document it by taking the current content of git-revert manpage for the
>   option.
>=20
> * get rid of the no_replay initialization, just ignore it when we're in
>   the revert case, it makes really no sense to error out.
>=20
> * put the warning of deprecation in cmd_revert, #if 0-ed out for now.
>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>=20
>  I've not kept the auto-edit feature of git-revert for the git-cherry-pic=
k -R
>  case as I don't believe it makes a lot of sense. But if people are unhap=
py
>  with that, I can easily "fix" it.
>=20
>  Documentation/git-cherry-pick.txt         |   15 +++++++++++++++
>  Makefile                                  |    6 +++---
>  builtin-revert.c =3D> builtin-cherry-pick.c |   10 ++++------
>  3 files changed, 22 insertions(+), 9 deletions(-)
>  rename builtin-revert.c =3D> builtin-cherry-pick.c (98%)
>=20
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry=
-pick.txt
> index 837fb08..2d92f2d 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -40,6 +40,21 @@ OPTIONS
>  	development branch), adding this information can be
>  	useful.
> =20
> +-R::
> +--revert::
> +	Given one existing commit, revert the change the patch introduces, and
> +	record a new commit that records it.  This requires your working tree
> +	to be clean (no modifications from the HEAD commit).
> ++
> +Note: 'git revert' is used to record a new commit to reverse the
         ^ this was supposed to spell out 'git cherry-pick -R' of course :/
> +effect of an earlier commit (often a faulty one).  If you want to
> +throw away all uncommitted changes in your working directory, you
> +should see linkgit:git-reset[1], particularly the '--hard' option.  If
> +you want to extract specific files as they were in another commit, you
> +should see linkgit:git-checkout[1], specifically the 'git checkout
> +<commit> -- <filename>' syntax.  Take care with these alternatives as
> +both will discard uncommitted changes in your working directory.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLKukACgkQvGr7W6HudhwEbQCghu9oIqRGil0p0F9vvvnRT7Ni
/K8AnjihBnNVhG6oXCjvGMOMiT5VXJRj
=LdQw
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
