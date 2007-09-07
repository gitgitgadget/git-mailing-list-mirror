From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 09:08:33 -0700
Message-ID: <1189181313.30308.97.camel@koto.keithp.com>
References: <1189115308.30308.9.camel@koto.keithp.com>
	 <7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
	 <1189133898.30308.58.camel@koto.keithp.com>
	 <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5OaLu3vo1sw9m3SrKbhi"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITgOT-0002RX-VJ
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbXIGQJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbXIGQJL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:09:11 -0400
Received: from home.keithp.com ([63.227.221.253]:2676 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964896AbXIGQJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 12:09:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id A88B91141EE;
	Fri,  7 Sep 2007 09:09:09 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ewCkGsFEBdNl; Fri,  7 Sep 2007 09:09:05 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 559531141EC; Fri,  7 Sep 2007 09:09:05 -0700 (PDT)
Received: from koto.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 453861141EB;
	Fri,  7 Sep 2007 09:09:05 -0700 (PDT)
Received: by koto.keithp.com (Postfix, from userid 1488)
	id 59BA663454B; Fri,  7 Sep 2007 09:08:35 -0700 (PDT)
In-Reply-To: <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58044>


--=-5OaLu3vo1sw9m3SrKbhi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-09-07 at 04:21 -0700, Junio C Hamano wrote:

> This patch brings in a new world order by introducing a backward
> incompatible change.  When the string the user gave us does not
> contain any slash, we do not apply the first entry (i.e.
> directly underneath .git/ without any "refs/***") unless the
> name consists solely of uppercase letters or an underscore,
> thereby ignoring .git/master.  The ones we often use, such as
> HEAD and ORIG_HEAD are not affected by this change.

It seems to me that instead of introducing an incompatible (but probably
useful) change, a sensible option would be to have the ambiguous
reference be an error instead of a warning. One shouldn't be encouraged
to use names in .git that conflict with stuff in refs/heads anyway.

--=20
keith.packard@intel.com

--=-5OaLu3vo1sw9m3SrKbhi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4XeAQp8BWwlsTdMRAqk+AKDcUQ7qMW5duEoj6hC19Dr93/EcbACgmaet
aTbQsa+gn/aOgir6UmZe7iE=
=RGqf
-----END PGP SIGNATURE-----

--=-5OaLu3vo1sw9m3SrKbhi--
