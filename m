From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: [RFC] Update on builtin-commit
Date: Mon, 02 Jul 2007 12:34:48 -0500
Message-ID: <1183397689.10996.11.camel@lt21223.campus.dmacc.edu>
References: <11833861634103-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0707021709120.4071@racer.site>
	 <1183395082.30611.16.camel@hinata.boston.redhat.com>
	 <Pine.LNX.4.64.0707021758090.4071@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bcuJlGUzNckbJ3Y/WnNx"
Cc: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 19:35:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Pni-0007NY-G0
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 19:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbXGBRex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 13:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbXGBRex
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 13:34:53 -0400
Received: from homer.isunet.net ([63.175.164.9]:51817 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbXGBRew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 13:34:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id D103F3882B7;
	Mon,  2 Jul 2007 11:43:49 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 04156-05; Mon,  2 Jul 2007 11:43:48 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 8C3053882BF;
	Mon,  2 Jul 2007 11:43:48 -0500 (CDT)
Received: from [161.210.6.122]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1I5Pna-0006iN-PN; Mon, 02 Jul 2007 12:34:55 -0500
In-Reply-To: <Pine.LNX.4.64.0707021758090.4071@racer.site>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51388>


--=-bcuJlGUzNckbJ3Y/WnNx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-07-02 at 18:02 +0100, Johannes Schindelin wrote:
>
> Hmm. Somehow I think that the getopt solution is not so bad at all. We'd=20
> need some code in compat/, but since we're GPL, and there are so many=20
> GPLed getopt versions out there, I don't see any obstacle there.

If we are going to make this option parser into some complex
general-purpose option parsing library let's not re-invent the wheel.
Let's pick one of the GPL'd option parsing libraries and make it a
dependency of Git.

Jeff


--=-bcuJlGUzNckbJ3Y/WnNx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGiTc1rtk7xyyIQRERAnBTAJ9ECw9MM8JyUsIGtmBPfgkXgw6TPACeOSWh
3z032uWqXOG6/nSAAIwbym4=
=6Bm8
-----END PGP SIGNATURE-----

--=-bcuJlGUzNckbJ3Y/WnNx--
