From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Help rescuing a repository
Date: Wed, 11 Jun 2008 09:46:49 +0200
Message-ID: <20080611074649.GC28629@artemis.madism.org>
References: <C061111B-1696-4545-A3F0-D0B8B961A352@vicaya.com> <alpine.LFD.1.10.0806101848320.3101@woody.linux-foundation.org> <025E3DB6-D0A8-497E-A5EF-9B4011FA3272@vicaya.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LwW0XdcUbUexiWVK";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 09:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6L3a-0008OG-LM
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 09:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbYFKHqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 03:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbYFKHqv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 03:46:51 -0400
Received: from pan.madism.org ([88.191.52.104]:36456 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbYFKHqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 03:46:51 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5562619CC4;
	Wed, 11 Jun 2008 09:46:50 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5AFB04D33E3; Wed, 11 Jun 2008 09:46:49 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Luke Lu <git@vicaya.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <025E3DB6-D0A8-497E-A5EF-9B4011FA3272@vicaya.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84598>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2008 at 05:04:25AM +0000, Luke Lu wrote:
> git rebase --abort, I think, would actually blow away my last commit (I=
=20
> sneaked in) though. git reset --hard to that last commit is probably the=
=20
> right thing to do. The least confusing option would be to update the=20
> error message to be a bit more informative, like "Did you change the=20
> branch while rebasing? git reset --hard to your last known commit and=20
> redo the rebase". Yet another safeguard would be for git commit to check=
=20
> if there is a rebase in progress and warn or abort the commit.

  OTOH the commit you did has been your HEAD for a moment, so it's
easily cherry-pickable from your reflog. So I'd go for the git rebase
--abort route, redo the rebase, and once done, then run git reflog and
find the commit that you want to get back, and cherry-pick it with its
proper reflog name: git cherry-pick HEAD@{nnn}.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhPgukACgkQvGr7W6HudhxOjgCghDY1A/W6RGGR1CbpnkvWAa8R
acAAnjRMvZJ+1L49k9pVo1Z60BoyIa5S
=3Whm
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
