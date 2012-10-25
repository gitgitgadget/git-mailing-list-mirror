From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Wed, 24 Oct 2012 20:53:07 -0400
Message-ID: <20121025005307.GE801@odin.tremily.us>
References: <20121023204437.GE28592@odin.tremily.us>
 <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=Q8BnQc91gJZX4vDc
Cc: Git <git@vger.kernel.org>, Nahor <nahor.j+gmane@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 02:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRBhi-0001n8-9l
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 02:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759045Ab2JYAxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 20:53:34 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:32545 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759009Ab2JYAxd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 20:53:33 -0400
Received: from odin.tremily.us ([unknown] [72.68.84.95])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCF0028GBSJP030@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 24 Oct 2012 19:53:08 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 871E067F346; Wed,
 24 Oct 2012 20:53:07 -0400 (EDT)
Content-disposition: inline
In-reply-to: <50883E54.4080507@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208330>


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2012 at 09:15:32PM +0200, Jens Lehmann wrote:
> I still fail to see what adding that functionality to the submodule
> command buys us (unless we also add code which really uses the branch
> setting). What's wrong with doing a simple:
>=20
>    git config -f .gitmodules submodule.<path>.branch <record_branch>
>=20
> on the command line when you want to use the branch setting for your
> own purposes? You could easily wrap that into a helper script, no?

Sure.  But why maintain my own helper script if I can edit
git-submodules.sh?  It seems like a number of people are using this
config option, and they generally store the same name in it that they
use to create the submodule.  This way I can save them time too.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQiI1yAAoJEEUbTsx0l5OMOEIQAJRcR3CLrjexKHf2HP1INanQ
s0H+69G2ISPVN0VO/ga632CT2e+hlUHiu0rjsck22CKy1vPZqX6b1GxZ+cKw5ZG4
ZuE+gA168ki4n/GUNvfqGhsr8BzsrMTlDgX4hZAxQivFX3hjAzcXJwqg+yB0dcSW
hGSQnHmj3pxjWjcN1G37/qE46p8XOawOrlwC0zkPe/Ui2asEuolk16hV/oLNl8aw
ytjonD+BnX2YY0QK94XhkXiS6mkR+wBupFxOuw2AcFdHlIwxeS+NEQZGLItB8mP6
r8K/312VlxlEB4FPrATTXfxqlISVEDzL16+/+QybSF4UmAE/zAkeKVYDHkXd4TUa
TSDioYe9zoXMR+F9BHPrdgSa5htwTgRVmvZPOsUKjetDsa0AR0wynLORm1CvqjEb
ZdySi34sSn7RUTNGs7k0oz544CCcBW6ISP//sHABTWst/v3cKskMs4Wj22luwUX4
51whfjl9aEGMgX+2PV/mDw3IhT5hI4YxJiiJdHxQkS9CFJXPVpCUfC/3Hm9NYmYr
PK53X+K+pJjsFHtJWGoLOeLDijDvD/ayHdIv2ReC1JhmSc+1RMyfrpaLf/5/niZT
P2SR6IfaPaJdqdQ4WjA6XW0g6etba+zBdjWXDuuV1KRSLCskJAQVmWpb//qihe7E
aqjJv6wzaC1hibqIPwGz
=8ge/
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
