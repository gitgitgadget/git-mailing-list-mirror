From: Nicolas Bock <nbock@lanl.gov>
Subject: Re: error: cannot lock ref 'refs/remotes/origin/*'
Date: Tue, 17 Jun 2008 08:22:00 -0600
Message-ID: <1213712520.6400.1.camel@localhost>
References: <1213635227.17814.6.camel@localhost>
	 <1213667245.14393.3.camel@localhost>
	 <alpine.DEB.1.00.0806171140470.6439@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o5ZNpOUz1fOQgeqptXAQ"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8c5f-0007rG-0X
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757709AbYFQOWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 10:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbYFQOWY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:22:24 -0400
Received: from proofpoint3.lanl.gov ([204.121.3.28]:49803 "EHLO
	proofpoint3.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250AbYFQOWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 10:22:23 -0400
Received: from mailrelay1.lanl.gov (mailrelay1.lanl.gov [128.165.4.101])
	by proofpoint3.lanl.gov (8.13.8/8.13.8) with ESMTP id m5HEMK59009999;
	Tue, 17 Jun 2008 08:22:20 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailrelay1.lanl.gov (Postfix) with ESMTP id 89E23160507;
	Tue, 17 Jun 2008 08:22:20 -0600 (MDT)
X-CTN-5-Virus-Scanner: amavisd-new at mailrelay1.lanl.gov
Received: from [128.165.249.1] (dsl-usr-1.lanl.gov [128.165.249.1])
	by mailrelay1.lanl.gov (Postfix) with ESMTP id 5BB531604F2;
	Tue, 17 Jun 2008 08:22:13 -0600 (MDT)
In-Reply-To: <alpine.DEB.1.00.0806171140470.6439@racer>
X-Mailer: Evolution 2.12.3 
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.7161:2.4.4,1.2.40,4.0.164 definitions=2008-06-17_03:2008-06-16,2008-06-17,2008-06-16 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85303>


--=-o5ZNpOUz1fOQgeqptXAQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is what I get:

$ git show-ref
a4995ae293fd95697a643cd3ea45585ecc38a19d refs/heads/ACT
3378ccb42c22740b7fcc240ffa0e4f798b8acf1f refs/heads/master
78e33155a0ab4ab0acba4c64758681fe99f1c5ca refs/heads/nick
ef66b3aa74b8c1edb55161e01a99dee7cf9edaa3 refs/remotes/origin/*
3378ccb42c22740b7fcc240ffa0e4f798b8acf1f refs/remotes/origin/master

in what sense is this ref "bogus"? Is it syntactically incorrect?



On Tue, 2008-06-17 at 11:41 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 16 Jun 2008, Nicolas Bock wrote:
>=20
> > > $ git gc
> > > error: cannot lock ref 'refs/remotes/origin/*'
> > > error: failed to run reflog
>=20
> This is a bogus ref name.  Hrm.  Can you look with "git show-ref" if you=20
> have (by some funny accident) an invalid ref there?
>=20
> Ciao,
> Dscho
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-o5ZNpOUz1fOQgeqptXAQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhXyIgACgkQOEV5akt0NphbuQCfRY08wLH8DtNz1cLZSuriNWDT
ImkAoJEwoBi9SPDnJjj9nhvSTT4fvEN8
=YCen
-----END PGP SIGNATURE-----

--=-o5ZNpOUz1fOQgeqptXAQ--
