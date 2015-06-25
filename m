From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Thu, 25 Jun 2015 01:08:15 +0000
Message-ID: <20150625010814.GA263667@vauxhall.crustytoothpaste.net>
References: <1435020656.28466.8.camel@twopensource.com>
 <20150623114716.GC12518@peff.net>
 <CAJo=hJsu2b0kmpjOhGwvgRsG3yGK56+U_2RANDi2qoEg7V_PmQ@mail.gmail.com>
 <20150624094919.GC5436@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Cc: Shawn Pearce <spearce@spearce.org>,
	David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 25 03:08:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7veW-0005Q0-9T
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 03:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbbFYBIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 21:08:23 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54318 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752048AbbFYBIW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2015 21:08:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c9d0:403a:aa47:277a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 59E4D2808F;
	Thu, 25 Jun 2015 01:08:20 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150624094919.GC5436@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272632>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2015 at 05:49:20AM -0400, Jeff King wrote:
> I don't know how much that helps for the JGit situation. It punts the
> native code out of JGit, but people using JGit still have to have the
> native helper from git on their system.  I have no problems at all with
> pluggable $FANCY_DB that not everybody supports.  But I think we would
> want _some_ baseline that is reasonably performant, and that everybody
> will support. I'm not sure putting the index into a flat file is
> performant enough. Is there any basic key/value store that is has both a
> C and a pure-Java version (e.g., berkeley db)?

Berkeley DB has switched to the AGPLv3 for new versions.  Besides being
unpalatable for many people, it's also incompatible with the GPLv2.  I
do otherwise like Berkeley DB: it performs reasonably well and is
available on most systems.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVi1R+AAoJEL9TXYEfUvaLWZkP/Ar2JewCCbrqWqlxQA22+oub
p5JvEnD+SCMchvDOhOIVK+xCBZMqtV4rpkIc3LfRFYY0F8An3aDH3jVxU0xxabTN
GUfdEviHc2dw1CWRsEvS0LiSibdu12f6gxLyeq9JocKPDtg9PTINdkkfC5YtzA2w
afLoybtmJdgey4nUUraYl+mPLN3EOoqYtst9i/V9E1jdogkRvZtOo7GDj+naMuKU
GLgJcb914Kkmk8SbaajkKSZHaLkoxeOg0H8ynFjRJ/y5DVgSDMibskBROnoRg5Br
GMv0xd6Ph7FCAKaWpCzL0IVXslsn7XEV4+TKM4+NXBQzzFRpcm/H02W6QquW3bIh
ygqPlSsATt45Q/R3NYlNLQthIb9I87pYbAQOPn6WIIb26SuG1abEDMnKWQ7EBxJD
KxFeLomxXWaCP3qr7QgAnRRx74azRN8lRAPzHnbee0s0zGgI4L9IyE3pud4IZCP3
zY1/enn6/UnsPSmxxRGIuye9qk8l3ICscEvsEgR75CPjX20UiGIIfZT6YRUOQGfr
NBKHWjFxL2E8lnt0Dla+V6M7ZrXIK6pMr/U/G22muxgLpQ5uq8Q51rLJE+GKBnD4
MxJiExAtPNbR3djt7zq44t59DKmihg77Qld52s/w7Gp5B7qd9a3v02HvL525if4o
KOIdVNsA07gF1giAn1X4
=by0t
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
