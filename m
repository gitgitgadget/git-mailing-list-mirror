From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Email address from username and hostname preferred over $EMAIL
Date: Thu, 05 Jul 2007 20:44:21 -0700
Message-ID: <468DBA95.3070101@freedesktop.org>
References: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beck man.com> <alpine.LFD.0.98.0707051357360.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC87A38D50E22B26AB68FFD27"
Cc: mkraai@beckman.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 05:44:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ekE-0003zI-FF
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 05:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761250AbXGFDoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 23:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761173AbXGFDoc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 23:44:32 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:36925 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760102AbXGFDob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 23:44:31 -0400
Received: (qmail 25399 invoked from network); 6 Jul 2007 03:44:29 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <torvalds@linux-foundation.org>; 6 Jul 2007 03:44:29 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <alpine.LFD.0.98.0707051357360.9434@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51720>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC87A38D50E22B26AB68FFD27
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Thu, 5 Jul 2007, mkraai@beckman.com wrote:
>> Git prefers to use an email address constructed from the username and =

>> hostname to the value of the EMAIL environment variable.  I think it=20
>> should prefer the latter to the former.  This problem was introduced b=
y=20
>> ec563e8153cba89728a271a26c8a94e7a42d8152.
>=20
> It did that very much on purpose. "git_default_email" must take=20
> precedence, because that's the one that is filled in by the config file=
=20
> syntax.
>=20
> So just use
>=20
> 	[user]
> 		name =3D ..
> 		email =3D ..
>=20
> and be happy. Only in the absense of that will git start guessing, and =

> yeah, it will not generally use EMAIL, unless it cannot get anything at=
=20
> all from username/hostname.
>=20
> If you want it to prefer $EMAIL, you'd need to change the initializatio=
n=20
> of git_default_email, methinks.

When I originally wrote the patch, I did so intending that $EMAIL would a=
lways
override git's guess of user@hostname.  I set GIT_{AUTHOR,COMMITTER}_EMAI=
L in
my environment specifically so that git would stop using guesses like
josh@josh-mobile and start using my actual email address.  I submitted th=
e
$EMAIL patch in hopes that eventually I could stop setting the git-specif=
ic
email addresses and just set $EMAIL, which I already do for other tools. =
 In
order for that to work, $EMAIL should always override git's guesses.

- Josh Triplett


--------------enigC87A38D50E22B26AB68FFD27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGjbqWGJuZRtD+evsRAruJAKC0mV76LIhnwqFwBKG84RhtSxPu2gCfd3tW
kQvG7vw0tGJGMe9ZnQ64MZ8=
=e16O
-----END PGP SIGNATURE-----

--------------enigC87A38D50E22B26AB68FFD27--
