From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next  CLI revamp
Date: Thu, 30 Oct 2008 15:43:21 +0100
Message-ID: <20081030144321.GF24098@artemis.corp>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030143918.GB14744@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="L2Brqb15TUChFOBK";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:44:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYlN-0001F2-5J
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbYJ3On1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754279AbYJ3On1
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:43:27 -0400
Received: from pan.madism.org ([88.191.52.104]:44511 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbYJ3On0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:43:26 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 728F03B3CD;
	Thu, 30 Oct 2008 15:43:22 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5B01C5EE23B; Thu, 30 Oct 2008 15:43:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081030143918.GB14744@mit.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99475>


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2008 at 02:39:18PM +0000, Theodore Tso wrote:
> On Wed, Oct 29, 2008 at 08:48:05PM -0700, Sam Vilain wrote:
> > From: Sam Vilain <samv@vilain.net>
> >=20
> > For cross-command CLI changes to be effective, they need to be
> > cohesively planned.  Add a planning document for this next set of
> > changes.
>=20
> Here are my favorites:
>=20
> * Add the command "git revert-file <files>" which is syntactic sugar for:
>=20
>         git checkout HEAD -- <files>
>=20
>   Rationale: Many other SCM's have a way of undoing local edits to a
>   file very simply, i.e."hg revert <file>" or "svn revert <file>", and
>   for many developers's workflow, it's useful to be able to undo local
>   edits to a single file, but not to everything else in the working
>   directory.  And "git checkout HEAD -- <file>" is rather cumbersome
>   to type, and many beginning users don't find it intuitive to look in
>   the "git-checkout" man page for instructions on how to revert a
>   local file.

This is what is currently proposed for undo, but yeah, revert-file or
maybe rather revert-changes may be suitable.

> * Change the argument handling for "git format-patch" so it is
>   consistent with everything else which takes a set of commits.  Yes,
>   it means that where people have gotten used to typing "git
>   format-patch origin", they'll have to type instead: "git
>   format-patch origin..", but's much more consistent.  We've done the
>   best we can by documenting the existing behavior, but if'we re going
>   to make major, potentially incompatible, CLI changes, this is
>   something to at least consider.  Maybe with a config file for people
>   who really don't want to retrain their fingers to type the two extra
>   periods?

git format-patch origin/next.. works already. I'm used to the asymetric
git format-patch origin/next syntax, and I would be sorry if it
disappeared though, and I see no really good reason to get rid of it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJyAkACgkQvGr7W6Hudhy9gACdE8nc2KpA1g7MLTJEO8fBm+wD
AroAoIVkXnR46tsMfP9K8nOeUCNOdVfR
=VdyY
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
