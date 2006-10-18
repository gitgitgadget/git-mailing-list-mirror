From: Robert Collins <robertc@robertcollins.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 15:26:40 +1000
Message-ID: <1161149200.3423.34.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca>
	 <200610171120.09747.jnareb@gmail.com>
	 <1161078035.9020.73.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610170921540.3962@g5.osdl.org>
	 <1161124078.9020.88.camel@localhost.localdomain>
	 <20061017191838.1c36499b.seanlkml@sympatico.ca>
	 <20061017233305.GG20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NP5/iKZtUZfRbujRqIzp"
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 07:49:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga4In-0001k6-H9
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 07:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWJRFtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 01:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWJRFtN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 01:49:13 -0400
Received: from ipmail01.adl2.internode.on.net ([203.16.214.140]:52405 "EHLO
	ipmail01.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S1750924AbWJRFtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 01:49:13 -0400
Received: from ppp245-86.static.internode.on.net (HELO lifelesswks.robertcollins.net) ([59.167.245.86])
  by ipmail01.adl2.internode.on.net with ESMTP; 18 Oct 2006 14:57:16 +0930
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAPpbNUWBSg
X-IronPort-AV: i="4.09,322,1157293800"; 
   d="asc'?scan'208"; a="31244854:sNHT3252952990"
Received: from ppp112-44.static.internode.on.net ([150.101.112.44] helo=lifelesslap.robertcollins.net)
	by lifelesswks.robertcollins.net with esmtpa (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1Ga3xR-0006zN-R7; Wed, 18 Oct 2006 15:27:14 +1000
Received: from localhost.on.net ([127.0.0.1] helo=localhost.localdomain)
	by lifelesslap.robertcollins.net with esmtp (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1Ga3wv-0001Kf-LB; Wed, 18 Oct 2006 15:26:41 +1000
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061017233305.GG20017@pasky.or.cz>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29190>


--=-NP5/iKZtUZfRbujRqIzp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-18 at 01:33 +0200, Petr Baudis wrote:
>=20
> BTW, I think it's fine to build a system optimized for small-scale
> projects (if that's the intent), simplifying some things in favour of
> mostly straight histories instead of more complicated merge situations
> (although I tend to agree with Linus that if you don't behave in the
> way the users are used to in 100% cases, the more frequently you
> behave so the worse it comes back to bite in the rare cases you do).
> Just as RCS is fine when maintaining individual files for personal
> usage (I still actually occassionaly use it for few files).

revnos visibly change as your work is merged into the mainline - we've
been doing this for years without trouble: ones own commits to a branch
get '3', '4', '5' etc as revnos, and when they are merged to the
mainline they used to stop having revnos at all, but now they will be
given this dotted decimal revno. If you pull from the mainline after the
merge, you see the new numbers, and when you look at mainline you can
see the difference. So while I agree that the surprise the user gets is
inversely related to the frequency with which they see the behaviour, I
think our users see it a lot, so are not surprised much.

FWIW, we're not optimising for mostly straight histories as I understand
such things : our own history has 3 commits on branches to every one on
the mainline.

-Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-NP5/iKZtUZfRbujRqIzp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNbsQM4BfeEKYx2ERAhOfAJ46TfXaTCQDmcIp7W//3SSCsOCs8wCgr4wF
iN22OlNJgipNyMha/h7RdUM=
=eBle
-----END PGP SIGNATURE-----

--=-NP5/iKZtUZfRbujRqIzp--
