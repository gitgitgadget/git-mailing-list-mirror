From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 14:08:31 -0400
Message-ID: <20080331180831.GA14916@kodama.kitenet.net>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 20:09:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgORe-000286-25
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 20:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbYCaSIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 14:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbYCaSIh
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 14:08:37 -0400
Received: from wren.kitenet.net ([80.68.85.49]:55577 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbYCaSIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 14:08:36 -0400
Received: from kodama.kitenet.net (66-168-92-132.dhcp.kgpt.tn.charter.com [66.168.92.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 7040B314344
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 14:08:33 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id E34F0114112; Mon, 31 Mar 2008 14:08:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/6505/Mon Mar 31 13:27:16 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78595>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> I would *seriously* suggest making this soem kind of generic callback and=
=20
> not Linux-specific.=20
>=20
> How about making it more akin to a pre-auto-gc "hook" - run a script=20
> instead of hardcoding something like this!

FWIW, Debian (and I assume Ubuntu also) systems have a on_ac_power
script that exits 0 or 1 accordingly. It would be a good thing to point
the hook at, or even a good reference when writing your own version of
the hook since it also supports /proc/pmu and apm.

--=20
see shy jo

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH8Sifd8HHehbQuO8RAnwCAKDHhSB+1jtJpmZLh8DjuQc+Bom+mACeJZeQ
K/RroTtvsgEUm03tNCq+3fs=
=pd70
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
