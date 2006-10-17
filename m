From: Robert Collins <robertc@robertcollins.net>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 19:37:45 +1000
Message-ID: <1161077866.9020.69.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	 <200610170119.09066.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Iu+3rsy7DOiPy2jW3htc"
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 11:37:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZlOT-00008H-By
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 11:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423197AbWJQJht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 05:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423198AbWJQJht
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 05:37:49 -0400
Received: from ipmail02.adl2.internode.on.net ([203.16.214.141]:9762 "EHLO
	ipmail02.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S1423197AbWJQJhs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 05:37:48 -0400
Received: from ppp245-86.static.internode.on.net (HELO lifelesswks.robertcollins.net) ([59.167.245.86])
  by ipmail02.adl2.internode.on.net with ESMTP; 17 Oct 2006 19:07:46 +0930
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAGRANEU
X-IronPort-AV: i="4.09,319,1157293800"; 
   d="asc'?scan'208"; a="30435942:sNHT121084180"
Received: from [192.168.1.5] (helo=lifelesslap.robertcollins.net)
	by lifelesswks.robertcollins.net with esmtpa (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1GZlOK-0000J6-K8; Tue, 17 Oct 2006 19:37:44 +1000
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by lifelesslap.robertcollins.net with esmtp (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1GZlOM-0004RG-Fh; Tue, 17 Oct 2006 19:37:46 +1000
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610170119.09066.jnareb@gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29042>


--=-Iu+3rsy7DOiPy2jW3htc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-17 at 01:19 +0200, Jakub Narebski wrote:
>=20
> I wonder if any SCM other than git has easy way to "rebase" a branch,
> i.e. cut branch at branching point, and transplant it to the tip
> of other branch. For example you work on 'xx/topic' topic branch,
> and want to have changes in those branch but applied to current work,
> not to the version some time ago when you have started working on
> said feature.=20

Precisely how does this rebase operate in git ?=20
Does it preserve revision ids for the existing work, or do they all
change?


bzr has a graft plugin which walks one branch applying all its changes
to another preserving the users metadata but changing the uuids for
revisions.=20

-Rob

--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-Iu+3rsy7DOiPy2jW3htc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNKRpM4BfeEKYx2ERAuHPAJ9jLHVVrZpFWN2eVkixTmnYPd6znQCfevBh
j9drp1q7FhYR8eMrykPtJNA=
=87MH
-----END PGP SIGNATURE-----

--=-Iu+3rsy7DOiPy2jW3htc--
