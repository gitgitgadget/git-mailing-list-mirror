From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 11:28:03 +0100
Message-ID: <1331202483.21444.11.camel@beez.lab.cmartin.tk>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
	 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-E4FMQvl9X1R0Np5veC10"
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:28:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5aa3-00053n-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809Ab2CHK2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 05:28:15 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:41735 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2CHK2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 05:28:14 -0500
Received: from [87.77.57.197] (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 4F7C946082;
	Thu,  8 Mar 2012 11:28:05 +0100 (CET)
In-Reply-To: <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192551>


--=-E4FMQvl9X1R0Np5veC10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-08 at 10:13 +0000, Jeremy Morton wrote:
> Right, so I guess I'm saying that the default value for push.default
> should be upstream instead of matching...

Any default is going to leave some people unhappy. If upstream is the
right thing for you, then that's what you should use. Most questions I
see about push not doing what the users expect would actually benefit
from 'current'. 'matching' is a fairly safe default, as it won't try to
push private branches or changes in private branches that track
something upstream.

   cmn



--=-E4FMQvl9X1R0Np5veC10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPWImzAAoJEHKRP1jG7ZzTRsYH/2aA6YQ6M0hEtTBpi7nou38d
LTzfKHufe5FHCWggVgObKCKPLewmHdpQJrDljJQIMiF5/m48rfumHmkdYuburmdr
AGnuV8zLZPc1u+YOVjjZbfcorERVRKZp+OfBcJevdfiiEpiFECWdU3qzmoOs4AiX
cDm8Iu4QP5OnT9SsjhjEKERQucvez6RS4kLv/HpE4c8imNoe0+/6eWhwSSPvIz5Z
4kTquBIsFiErtn15EwJ0Bh91vnyhr5x9xzPVm8nteoyL7YtDdyWKsJb3BtMUqxu9
QTkU50pG+4mVLJgY+UbBCjL/vDQY/vyST947ecTlgSnsjk/8pVW5eTlYMs8ceMg=
=Fcxb
-----END PGP SIGNATURE-----

--=-E4FMQvl9X1R0Np5veC10--
