From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 06/15] user-manual: Give 'git push -f' as an alternative
 to +master
Date: Sun, 10 Feb 2013 17:04:29 -0500
Message-ID: <20130210220429.GE8000@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <f0f8b77a3487be30ee4c492899fe73af05e20413.1360508415.git.wking@tremily.us>
 <7vsj53sub1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=VdOwlNaOFKGAtAAV
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:04:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4f14-0002En-Fe
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab3BJWEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:04:31 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:64002 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586Ab3BJWEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:04:30 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000EU5YNHQE80@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:04:30 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 8A77B8799CD; Sun,
 10 Feb 2013 17:04:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360533869; bh=A1gaRkTjRgSzI4xDxORLr1+o1KVML7HRrKxDbZYDYDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Go9RJL9IT/+gloGvMJowSYFV/CvmGR7PfG70JmP99AMmL6XkV2OFme2e68WUs5E5C
 xSUq9wsFEHZV/dCmBvNg5wZTKnoaJp7eB8aszNcpgjM1MOspMJxO8QOXyjjL4KnQLH
 iqi1wsfxuP74T81qwF6UvGnJYWmoFOe+6knUTQG4=
Content-disposition: inline
In-reply-to: <7vsj53sub1.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215946>


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:00:50PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > +Note the addition of the `+` sign.  Alternatively, you can use the
> > +`-f` flag to force the remote update, as in:
> > +
> > +-------------------------------------------------
> > +$ git push -f ssh://yourserver.com/~you/proj.git master
> > +-------------------------------------------------
> > +
>=20
> I didn't check the surrounding examples but would it make it a bit
> too advanced to make the example flow push out more than one
> branches here (perhaps he is also updating the 'maint' branch)?
> Then use of "--force" can be explained as "Instead of adding + to
> each and every refs to be pushed, you can use a single -f to force
> everything."
>=20
> The mistake I would want to avoid teaching the readers is to replace
>=20
> 	push $there +master maint
>=20
> with
>=20
> 	push -f $there master maint
>=20
> or even worse
>=20
> 	push -f $there
>   push -f

If you feel the need to explain it to the list, we should probably
have an explanatory example in the manual ;).  What about suggesting
`--dry-run` for sanity-checking forced pushes?

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGBlsAAoJEEUbTsx0l5OMwBoP/1s0nTbm2nEh244H1b8Hz5B3
KUwIO+qhU/K/d4jeqfrTnpbl0iDo4d6vAHpFWmJ4D9dPWfcNle13xPyK+cpmRFYE
2aY6o8kqCU5fzVe8UIrkpzVv3AFVe0y5DCtHEpgOutZDeO10vt23A5TRIAxG3Qe9
O1YKEkG0Wh6T8Yt2rk9HAz2EHXQJQG7qySug3gzWPOV+6YOB1eMz4J66zGyLdHsX
WUN9Ffb3JxcIVJHoPVzoJ6tQOvjokFndh6HmZJlxvgtRm8cmIjGfCDdqUFOCEwdd
lo4u+XsJZ417RKVmiwKvQNiB8Vcy/pp2S98jrxeY4UkeqfkqMOT8hjCozYjoXUXt
nHLA89UvCNZ0XZwV2tLAGcmCAryX/8iI8l0QRjX2UIGJnPQJkGE7naAo/twK0WIJ
o1bGTY7cI29Kp47htan8/aH822ZTCaXz6+SnhtzHLu8yDgRxYCJNPH1C8yTd7lkB
1l3MXNLvp0vraUYz2W78kH6AgoIfBnFfn1UDrN9FjEhMBmJ2P2ezlgTo7xVmjBeR
EOoq/ER9daXumemH4AvI+8+rHUM8n/eTBT7m2qQCHDyCyNboBA0iTZCM+fF/pJEj
fqSrcuQ23TrmNvquzzjKYut/S0JQu5UMRiAWk79mqvo/8nOFCGQ4PCxjCZvn6HVT
cJ3I2Z9XEm+hqXNpsbRE
=Tawg
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
