From: Nicolas Bock <nbock@lanl.gov>
Subject: Re: error: cannot lock ref 'refs/remotes/origin/*'
Date: Tue, 17 Jun 2008 15:00:07 -0600
Message-ID: <1213736407.2490.9.camel@localhost>
References: <1213635227.17814.6.camel@localhost>
	 <alpine.DEB.1.00.0806171140470.6439@racer>
	 <1213712520.6400.1.camel@localhost> <200806171629.06570.johan@herland.net>
	 <1213717788.13390.2.camel@localhost> <m3fxrbop4g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aBfC+oWI6apUf8B27Fwn"
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:01:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8iIt-0008CA-KX
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 23:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633AbYFQVAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 17:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758624AbYFQVAT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 17:00:19 -0400
Received: from proofpoint3.lanl.gov ([204.121.3.28]:45698 "EHLO
	proofpoint3.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbYFQVAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 17:00:18 -0400
Received: from mailrelay1.lanl.gov (mailrelay1.lanl.gov [128.165.4.101])
	by proofpoint3.lanl.gov (8.13.8/8.13.8) with ESMTP id m5HL09tM029057;
	Tue, 17 Jun 2008 15:00:09 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailrelay1.lanl.gov (Postfix) with ESMTP id D087816059F;
	Tue, 17 Jun 2008 15:00:09 -0600 (MDT)
X-CTN-5-Virus-Scanner: amavisd-new at mailrelay1.lanl.gov
Received: from [128.165.249.1] (dsl-usr-1.lanl.gov [128.165.249.1])
	by mailrelay1.lanl.gov (Postfix) with ESMTP id 215B416059D;
	Tue, 17 Jun 2008 15:00:09 -0600 (MDT)
In-Reply-To: <m3fxrbop4g.fsf@localhost.localdomain>
X-Mailer: Evolution 2.12.3 
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.7161:2.4.4,1.2.40,4.0.164 definitions=2008-06-17_05:2008-06-17,2008-06-17,2008-06-16 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85321>


--=-aBfC+oWI6apUf8B27Fwn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thanks, that explains it..


nick

On Tue, 2008-06-17 at 12:09 -0700, Jakub Narebski wrote:
> Nicolas Bock <nbock@lanl.gov> writes:
>=20
> > I guess I don't understand refs. I figured that since I have
> >=20
> > remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
> >=20
> > set, I should have a ref refs/remotes/origin/* as well.
>=20
> The above is _globbing_ refspec, it means that it maps=20
> "refs/heads/<name>" branch in remote repository to=20
> "refs/remotes/origin/<name>" remote-tracking branch in local
> repository.
>=20

--=-aBfC+oWI6apUf8B27Fwn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhYJdcACgkQOEV5akt0Npiy7ACdEihoOvIdut7D2PcVtbjUBch4
T8gAoOgWsZKw8z62psyIUUU5aq21Y2JN
=nHbm
-----END PGP SIGNATURE-----

--=-aBfC+oWI6apUf8B27Fwn--
