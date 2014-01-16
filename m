From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 4/6] t7406: Just-cloned checkouts update to the
 gitlinked hash with 'reset'
Date: Thu, 16 Jan 2014 11:32:12 -0800
Message-ID: <20140116193212.GV2647@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <09008c79ecc7d4fd92131b4049a25e65db92a30d.1389837412.git.wking@tremily.us>
 <xmqqmwivzq7n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A+KtNVtgI4x4SWvL"
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 20:32:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3sfr-0007uV-EG
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 20:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbaAPTcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 14:32:16 -0500
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:57059
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751170AbaAPTcO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 14:32:14 -0500
Received: from omta24.westchester.pa.mail.comcast.net ([76.96.62.76])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id Echm1n0071ei1Bg57jYEYa; Thu, 16 Jan 2014 19:32:14 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta24.westchester.pa.mail.comcast.net with comcast
	id EjYC1n00q152l3L3kjYDpZ; Thu, 16 Jan 2014 19:32:14 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 5540AEFF0C4; Thu, 16 Jan 2014 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389900732; bh=NXinh3XhYHheMpTJLhlaW1GqgKG9SzacNY2EKSoKMrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f4sYQxsDfIJVqmwqd3M5w4tygo8XpGWMQfsX3P0dbMrMpfBIdjMkJz60pGZv9pzf+
	 BeERVLEfaIW+ByUAaHIVGGeFQq6V4NM/2j50JMAzmWoTFtTB467thr5yOB1HsigjCi
	 7aaGUaGjfnyUVSbMDdluTweNkWhFMcroQ1WFFQ54=
Content-Disposition: inline
In-Reply-To: <xmqqmwivzq7n.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389900734;
	bh=Bdjh27HZtiozSOjUmV7E3ikMEPUrUuxTMN3gn0IiRmE=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=lELpFWg2aAkZZF8GCiHrAzblHv831uA8GgCqL5+79DesiUyf3BuMlLtcRcAMnNAeo
	 K6Qxz02Ht+/0LUwAGcoCzleLe/O75OgSGALdD9GiU/On3v43qCoFpN/GdphIFftZMi
	 tlSox9+ALKKAfaa1nQvLZFEwYjz2xMlyA+I2/av6z0yL64WQ2u4UJ6nG7XsBeSas6V
	 n6QPBz04KbQbRcJdzVQHrbCQjouN5057bpMKTP9guynO16+xOnTRnhWlvLhv710Lng
	 w4W4XHNHYGmDMKk55qGLZsKVQcEWlVwTsk+VGsgeVaRp4s4qCkuITzT1HQZLi7Ybtp
	 4eBtxhJ8/8a1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240525>


--A+KtNVtgI4x4SWvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 11:22:52AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > To preserve the local branch, for situations where we're not on a
> > detached HEAD.
> >
> > Signed-off-by: W. Trevor King <wking@tremily.us>
> > ---
>=20
> This should be a part of some other change that actually changes how
> this "git submodule update" checks out the submodule, no?

Sure, we can squash both this test fix and the subsequent new test
patch into patch #3 in v5.  I was just splitting them out because
backwards compatibility was a concern, and separate patches makes it
easy for me to explain why the results changed here without getting
lost in patch #3's implementation details.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--A+KtNVtgI4x4SWvL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2DO7AAoJEKKfehoaNkbtT0IQAJ4/Nmhe8tq1JaV2gJqSM0Yw
Yn5A0KcVcr7NmDGHprnS2GCh7UV4v5fGGd+kORrn3+q8n9E3iKtuPuI20n3HLe8C
Uct+Al7PyGNOvGlrPeWpMyJTBoB+wvk2ipNl9II3Smov83jju9kxg/7WZDM3TJkJ
d11vOU5FW60nuyhHlZ2ufJX7MfVcE2s4LM7qeJMqjipi+rXbzMl9E6uccs+n+gi3
dvDjVMPC7iMFKgdR0RUp3IBNUOzZ8F62E7zEu+jFMOP78xXAkBjFb8AVw9dF/UHx
6pyHLXw950s6+h39kB/JEYyWx1P0eWdfnkYKMcaxstRiDGxLZWIaMJ9NzFKYu4+l
Sw1vZ6mkMk73pWKxH1jYRvVvqnXdGmvsIqWuo7VVUjxRTNZasV7cc6MrN4MBqjzT
q3WWQ9GfxF3p5HAG/jS8U9UkKLg3Db89v6CKOcwPxDrZM1i5zPWCaemOudvfH9Sq
4YfJiQBD7KYlX3HpprWE10rnmoO7r1mQzlhG9p9Yae3uu6g7uuZCsIU9hmBFIoCO
XOWahnHIHnEDw1qCQxorXZWaNrpL0GUHKfpXmjO7ZDFKm5babGu59jyZMWYAGkiE
vLL+vfy6YVEHg1OKvQA6LvYaDbBiIb0HtXHWM7R6PUsnqptOh56Ob9z74eKdF7xR
nv88gn6ruiW3Yo/9zGre
=nOdZ
-----END PGP SIGNATURE-----

--A+KtNVtgI4x4SWvL--
