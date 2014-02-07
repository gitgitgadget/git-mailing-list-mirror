From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 8/9] rebase: add the --gpg-sign option
Date: Fri, 7 Feb 2014 23:50:58 +0000
Message-ID: <20140207235058.GJ635004@vauxhall.crustytoothpaste.net>
References: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
 <1391221086-1044384-9-git-send-email-sandals@crustytoothpaste.net>
 <xmqqlhxrdgb5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 00:51:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBvCQ-000813-MX
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 00:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbaBGXvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 18:51:06 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51694 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750745AbaBGXvF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Feb 2014 18:51:05 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3505:3fa4:e66:a69f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 03D9628074;
	Fri,  7 Feb 2014 23:51:01 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Vigier <boklm@mars-attacks.org>
Content-Disposition: inline
In-Reply-To: <xmqqlhxrdgb5.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241815>


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2014 at 01:42:06PM -0800, Junio C Hamano wrote:
> > +	--gpg-sign)
> > +		gpg_sign_opt=3D-S
> > +		;;
> > +	--gpg-sign=3D*)
> > +		# Try to quote only the argument, as this will appear in human-reada=
ble
> > +		# output as well as being passed to commands.
> > +		gpg_sign_opt=3D"-S$(git rev-parse --sq-quote "${1#--gpg-sign=3D}" |
> > +			sed 's/^ //')"
>=20
> Isn't an invocation of sed excessive?
>=20
> 	gpg_sign_opt=3D$(git rev-parse --sq-quote "${1#--gpg-sign=3D}") &&
> 	gpg_sign_opt=3D-S${gpg_sign_opt# }
>=20
> if you really need to strip the leading SP, which I do not think is
> a necessary thing to do.  It is sufficient to remove the SP before
> the variable substitution in the human-readable messages, e.g.

I'm not sure that command line parsing of "-S 'foo <x@example.tld>'"
will work exactly as expected due to the fact that -S doesn't always
take an argument.  Your suggestion to use # seems fine, though.

I'm a little embarrassed to admit that in my fifteen years of Unix
experience, I've never learned the variable modifiers for shell, so it
didn't occur to me to use them in this case.  Guess it's time to learn
them now.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS9XFiAAoJEL9TXYEfUvaLzzIP/3wPpGZff/baoAl3SYUiBl/H
niiQvZTFs+4fp0ccECSnHIeCQrNM02TlONuqtKwLka/eQ7558SbKzgCOMTwVphBl
uhW6sCkJfHyFSSzOWPc3SpQdq6C/q3vju6npQHPbF0dE2lUkLCY9lB2uzfq719/6
xk4Jt0O8oUYwKtoEIOjL2CJiFPJR39czN2LNh5z1k6KL/FAzqkfS0Nc7Q0a9aHr/
l0sqMxxL2xgonVnukxvn03XFFeWfzwHd+Cj63NUrfWAkmffJd6PKIipuZvLjmCIf
UH3ZqZVz/M7FWKtCVU1QNOH9bCDmYj0OhGKnuf5A93l1nWqEsQTI6bL30NpFdf3z
JcrH5mJmUAPfLOUn2xRjG8RT7gNGIqA9+ibioZIvEnd2Il/cpKE2GD3oc7j/mupY
OZcwgVGpuGUnUL3tMOUtzhgPRElJP/1zbWEPQQUcdrqoo5sm+GAu49TD8A9750SN
WHCPNuEwSsbrLFK0Em7HNyojptyHqhus1XWNHtpvGQ/cCwwKnTu7kCJA3Q8BmlCi
KeGNDiM9omj43xUXtecbOBgpHS/KHLRzWvGUO10Rcs1JSFyAopAhMSGKLYfZt3wO
DRYnnWZM+lPK+LQxgWqcrobMXUGPKgP528FuEYrZ2apJ6B11EORSg6H0biFR+e/N
H2+JZjb5oF7rE9cmfazP
=fS4N
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--
