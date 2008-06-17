From: Nicolas Bock <nbock@lanl.gov>
Subject: Re: error: cannot lock ref 'refs/remotes/origin/*'
Date: Tue, 17 Jun 2008 09:49:48 -0600
Message-ID: <1213717788.13390.2.camel@localhost>
References: <1213635227.17814.6.camel@localhost>
	 <alpine.DEB.1.00.0806171140470.6439@racer>
	 <1213712520.6400.1.camel@localhost>  <200806171629.06570.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zwV8UC6BnVwIasBc1DJ1"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:51:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8dSQ-0001Ht-Bt
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 17:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYFQPt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 11:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbYFQPt6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 11:49:58 -0400
Received: from proofpoint3.lanl.gov ([204.121.3.28]:54150 "EHLO
	proofpoint3.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbYFQPt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 11:49:57 -0400
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
	by proofpoint3.lanl.gov (8.13.8/8.13.8) with ESMTP id m5HFnpXw032745;
	Tue, 17 Jun 2008 09:49:51 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailrelay2.lanl.gov (Postfix) with ESMTP id 419AD1A8C536;
	Tue, 17 Jun 2008 09:49:51 -0600 (MDT)
X-CTN-5-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from [128.165.249.1] (dsl-usr-1.lanl.gov [128.165.249.1])
	by mailrelay2.lanl.gov (Postfix) with ESMTP id A26F21A8C513;
	Tue, 17 Jun 2008 09:49:50 -0600 (MDT)
In-Reply-To: <200806171629.06570.johan@herland.net>
X-Mailer: Evolution 2.12.3 
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.7161:2.4.4,1.2.40,4.0.164 definitions=2008-06-17_05:2008-06-17,2008-06-17,2008-06-16 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85309>


--=-zwV8UC6BnVwIasBc1DJ1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I guess I don't understand refs. I figured that since I have

remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*

set, I should have a ref refs/remotes/origin/* as well.



On Tue, 2008-06-17 at 16:29 +0200, Johan Herland wrote:
> On Tuesday 17 June 2008, Nicolas Bock wrote:
> > This is what I get:
> >
> > $ git show-ref
> > a4995ae293fd95697a643cd3ea45585ecc38a19d refs/heads/ACT
> > 3378ccb42c22740b7fcc240ffa0e4f798b8acf1f refs/heads/master
> > 78e33155a0ab4ab0acba4c64758681fe99f1c5ca refs/heads/nick
> > ef66b3aa74b8c1edb55161e01a99dee7cf9edaa3 refs/remotes/origin/*
> > 3378ccb42c22740b7fcc240ffa0e4f798b8acf1f refs/remotes/origin/master
> >
> > in what sense is this ref "bogus"? Is it syntactically incorrect?
>=20
> Yes, According to "man git-check-ref-format", asterisk is NOT allowed in=20
> a ref name.
>=20
>=20
> ...Johan
>=20

--=-zwV8UC6BnVwIasBc1DJ1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhX3RwACgkQOEV5akt0Npj9kwCgulacwfk0SOEa/5daz8+uX+E+
6eQAn1VM2qzWgaolF8RoVnxjNPr3UDzo
=55GC
-----END PGP SIGNATURE-----

--=-zwV8UC6BnVwIasBc1DJ1--
