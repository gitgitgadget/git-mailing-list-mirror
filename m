From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 05/15] user-manual: Add a few references to 'git rebase
 -i'
Date: Sun, 10 Feb 2013 17:00:50 -0500
Message-ID: <20130210220050.GD8000@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <4931d9fc83155b29787a3d33a7ac87dbfaa04795.1360508415.git.wking@tremily.us>
 <7vzjzbsumu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=mSxgbZZZvrAyzONB
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:01:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4exY-0000OI-Fo
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab3BJWAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:00:53 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:51046 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab3BJWAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:00:52 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI00034GYHFGH70@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:00:52 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 150DB87999B; Sun,
 10 Feb 2013 17:00:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360533651; bh=yRNhTM5yBWetWrVV9ky+23Fu7NXtcue57GgApxTTC08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HsJKUBa7cEBoapDBVu0czul5wI14kS5rbyQG6iMBM5tXlXhHMCXH4KTsuT2KJ91bd
 Kq4S9YzQ1Obu5H0Fo94P0I5qHayJepZDUMeLhotvHzhB8trOZkr78Y3cniwoNmpjMb
 KKvsN6BjBqHy3p8ZR6+gnrS//Xpf0NuWrwhDIPbc=
Content-disposition: inline
In-reply-to: <7vzjzbsumu.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215944>


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 01:53:45PM -0800, Junio C Hamano wrote:
> This change is very good (modulo the extra blank line at the end).

Oops.  Will remove from v3.

> Alternatively, we can explain only the amending of the tip commit in
> this section, removing everything else; I think that is probably a
> better option.  The series of sections around here would then look
> like:
>=20
>  * The section before this talked about a straight-forward "rebase";
>=20
>  * This section then talks about "commit --amend", nothing else;
>=20
>  * The next section talks about taking "format-patch A..B", flipping
>    its output around and applying to A.  Enhance that section with
>    the material to be removed from here, which talks about applying
>    "format-patch A..B" on top of the amended A.
>=20
>  * Then add a separate section after that "Reordering or selecting
>    from a patch series" section to discuss "rebase -i".
>=20
> Hmm?

Works for me.  The 'format-patch' section is also useful, because it's
easy to understand how a mailing list could get inserted between
'format-patch' and 'am' ;).

The problem with a section on 'rebase -i' is that it does such a good
job explaining itself ;).  I suppose I could add a few "screenshots"
:p.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGBiSAAoJEEUbTsx0l5OMZwUP/jh74Ssk9BjyQ37jij7a/E+c
kamMS7oFqu5BuTFlB8bu/Kh2AighW3+mGBhsVf+7e6A4oqXCs0L/vco2TQikXqMQ
/8ggkHBfh41WAuVUAythOt+NU4JPIl0tKAVwq23/hclSocklhTV2G1nTJ7vkNpg+
31PiO11ZtUcyyhq4GfzS1CZJtzNPWl3UpZ+KAOFuk0DH5E+ISmh6OuJq5Z6boMMT
iLo2I/5zOguUMkuB6lfEIWe2DJd152YWsvddQ7Zzs5jl3rfDgxRyZsuoio9BubqY
gDTMX4wXRnIY5ZZ/TAl3d8UkObbS0qSrgiFZuRMeYajZVQFkse3rlhRHFeAka+On
QZwyaypaKIM9EgToiwp+ybgeapNrI8g6HFplZbJTJYrR3GfAtw/rfQuf1UHxDhVn
PnraTVFmpOdkRalhEDT6JApKgwJuTMUfO1vSYv6EilJ1J6OEYHR49OTagbjSS3Rz
i6MFwxBC9gymGqipp4L3QhtX77+tFazUJEIv2Hodg62NtSOYzBERC4c6yA8vWlPK
66oztgEDeX44d5OatDRDEvD2jCH1J9IuJNKOm4+XDds/deYGU9TzKK5e70L0IIRa
HRlI/YA+dcd4NGkwyq0Tn4ZYkXyaTahWjIXcoBonjQ9EvLpk9VWtyN3AJBb+5SiD
j3oJtDobKSZIcgYzQsEG
=bXEE
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
