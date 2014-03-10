From: Max Horn <max@quendi.de>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 16:51:37 +0100
Message-ID: <84EEAF2D-BCEA-4D02-95BE-31E9C518A0BC@quendi.de>
References: <531D9B50.5030404@alum.mit.edu> <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_FD0232E6-F4FB-44C3-9969-7FB9C6818BAC"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN2UU-00035O-0J
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 16:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbaCJPvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 11:51:43 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48496 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753157AbaCJPvm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 11:51:42 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WN2UM-0005ng-NO; Mon, 10 Mar 2014 16:51:38 +0100
In-Reply-To: <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1394466702;afb1b0c0;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243769>


--Apple-Mail=_FD0232E6-F4FB-44C3-9969-7FB9C6818BAC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


On 10.03.2014, at 15:30, Shawn Pearce <spearce@spearce.org> wrote:

> On Mon, Mar 10, 2014 at 4:00 AM, Michael Haggerty =
<mhagger@alum.mit.edu> wrote:
>> I have started working on pluggable ref backends.  In this email I
>> would like to share my plans and solicit feedback.
>=20
> Yay!

Yay, too!

> JGit already has pluggable ref backends, so it is good to see this
> starting in git-core.
>=20
> FWIW the Gerrit Code Review community is interested in this project.
>=20
>> * Store references in a SQLite database, to get correct transaction
>>  handling.
>=20
> No to SQLLite in git-core. Using it from JGit requires building
> SQLLite and a JNI wrapper, which makes JGit significantly less
> portable. I know SQLLite is pretty amazing, but implementing
> compatibility with it from JGit will be a big nightmare for us.

I understood this as an example (indeed, it is listed under "Wile new =
ideas"), not a proposal to put this into the git core. It might be an =
interesting experiment in any case, and if the proposed modularity is =
truly achieved, it could (if there was any interest in it, that is) be =
implemented in an external 3rd party project.


Anyway, I am quite excited about this project. Usually, I am quite =
skeptical about such large scope ideas ("Yeah, cool idea, but who will =
pull it off, and with which resources?"). But this one seems to have a =
good chance of being implemented gradually and inside the main =
repository, with the help of "feature flags".=20

Thus, I am looking forward to Michael's announced initial patch series. =
I feel that I don't know enough yet about git overall to be of much help =
on my own at this point. But perhaps over time some mini- or =
micro-projects pop up were others can help (e.g. "adapt these 50 tests =
to work with the 'quagga' ref"); if they are pointed out (assuming that =
doing so isn't more work than just addressing them yourself ;-), I am =
willing to help out.


Cheers,
Max

--Apple-Mail=_FD0232E6-F4FB-44C3-9969-7FB9C6818BAC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMd34wACgkQIpJVslrhe1n8MQD/XvcLZz/HcmyZnc6AMDSSR35/
1MdfA4wZb9HGihLAYAEBAMthNiGx50YCPOvtaV/cosHU9/ZKqylN8TsoqAuPK8Br
=5vNA
-----END PGP SIGNATURE-----

--Apple-Mail=_FD0232E6-F4FB-44C3-9969-7FB9C6818BAC--
