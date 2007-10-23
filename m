From: martin f krafft <madduck@madduck.net>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 19:16:11 +0200
Message-ID: <20071023171611.GA18783@piper.oerlikon.madduck.net>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
To: Linus Torvalds <torvalds@linux-foundation.org>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 19:16:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkNN0-0005f1-S0
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 19:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbXJWRQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 13:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXJWRQf
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 13:16:35 -0400
Received: from clegg.madduck.net ([82.197.162.59]:40458 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbXJWRQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 13:16:34 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id C5F8EA800D;
	Tue, 23 Oct 2007 19:16:38 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 5865E9F13B;
	Tue, 23 Oct 2007 19:16:12 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 44B4A4408; Tue, 23 Oct 2007 19:16:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4574/Tue Oct 23 16:57:10 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62138>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.10.23.1850=
 +0200]:
> First off, let me say that to some degree, what you ask for is not=20
> possible. Why?
>=20
> Since you have pushed out the stuff, and don't want to rewrite history=20
> (which would result in trouble for down-streams - and I heartily approve)=
,=20
> whatever you do will always have that merge in the commit history.
>=20
> And that means that while you can certainly undo the *data* that the merg=
e=20
> brought in, git will always know that you already merged up that branch.=
=20

This is precisely what I meant, sorry for not being clear. This is
what git-revert does...

> So you can revert the data, but then if you want to get it back, you'll=
=20
> need to revert the revert - you cannot just merge the branch again.=20

Ouch!

> 	# You now have the "temporary" branch that contains just the
> 	# diff that effectively undoes that one merge. Go back to the
> 	# tip of your development, and cherry-pick it to get git to
> 	# help you do a good job merging it with all the subsequent
> 	# development

Ah, that's a good idea.

Thanks for your time and input!

PS: this question of mine came out of a discussion on using Git for
Debian packaging: what happens when we actually need to remove
a feature from one package to the next:
  http://lists.madduck.net/pipermail/vcs-pkg/2007-October/000059.html

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
#define emacs eighty megabytes and constantly swapping.
=20
spamtraps: madduck.bogus@madduck.net

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHixbIgvIgzMMSnURAvTSAJkBquqn7vFCF51dF4Dq6U2qBLA9KwCbBT4G
3zA7pWuPgeocGIcQaENB5H8=
=grQP
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
