From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-filter-branch: Add an example on how to remove  empty commits
Date: Thu, 30 Oct 2008 16:10:42 +0100
Message-ID: <20081030151042.GH24098@artemis.corp>
References: <1225326833-15210-1-git-send-email-pasky@suse.cz> <20081030132623.GC24098@artemis.corp> <20081030150617.GA14098@euler>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="N8ia4yKhAKKETby7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:12:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZBn-0003kx-W0
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbYJ3PKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755320AbYJ3PKq
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:10:46 -0400
Received: from pan.madism.org ([88.191.52.104]:58935 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbYJ3PKo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:10:44 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A2E64221;
	Thu, 30 Oct 2008 16:10:43 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7E5FD5EE23B; Thu, 30 Oct 2008 16:10:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081030150617.GA14098@euler>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99485>


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2008 at 03:06:18PM +0000, Deskin Miller wrote:
> On Thu, Oct 30, 2008 at 02:26:23PM +0100, Pierre Habouzit wrote:
> > Why not add an option to filter-branch that removes a commit if it's
> > empty ? It's quite useful, it helps the user concentrating on just
> > keeping what matches *his* criteriums, and not caring about the minor
> > details of cleansing the result.
>=20
> I've thought this would be useful at times myself.  One potential complic=
ation,
> however, is that the history could come from a SVN repository via git-svn=
, in
> which case it's possible that empty commits exist due to an incomplete ma=
pping
> of SVN's changes, e.g. SVN property changes will get their own revision, =
even
> if the file content does not change.

Well, if you want to migrate your git-svn repository to something else,
it doesn't makes sense to add this limitation. I'd rather see this
"problem" advertized in the manual page, rather than a limitation added.

Note that using git filter-branch on a git-svn repository and still
expecting it to work with git-svn is IMHO wrong in so many ways that we
should not really try that hard to prevent the user doing something
stupid anyways.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJznIACgkQvGr7W6Hudhxk+QCfaHVCIqnB5jB2NQY60eH0X081
7pUAn3jaMuR48TAxsTdn1i7PZUQyXG/1
=aeLg
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--
