From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v4 0/3] Isolate If-Modified-Since handling in gitweb
Date: Tue, 27 Mar 2012 15:55:58 -0400
Message-ID: <20120327195558.GA32699@odin.tremily.us>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <201203221346.35295.jnareb@gmail.com> <20120326110943.GA2951@odin.tremily.us>
 <201203272124.23145.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:56:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCcUx-0003J0-0F
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 21:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab2C0T4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 15:56:01 -0400
Received: from vms173005pub.verizon.net ([206.46.173.5]:13230 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab2C0T4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 15:56:00 -0400
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1K00FWA7DBMEA0@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 27 Mar 2012 14:56:00 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 06F7243A5BC; Tue,
 27 Mar 2012 15:55:58 -0400 (EDT)
Content-disposition: inline
In-reply-to: <201203272124.23145.jnareb@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194080>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2012 at 08:24:22PM +0100, Jakub Narebski wrote:
> No, the status line was omitted unintentionally, thanks for fixing this.
> I guess that web server (at least Apache) adds it if it is missing.

=46rom the CGI 1.1 specs [1], section 9.2:

  If the script does not return a Status header, then "200 OK" should
  be assumed.

So, perhaps it is better to skip the Status header on success (less
for the server to parse).

[1]: http://tools.ietf.org/html/draft-robinson-www-interface-00

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPchtOAAoJEPe7CdOcrcTZoAYH/1bZSuUWdR7VIcCjIHF18u4K
JW+gmVWvAlmYoMksab9WqQS9K/V2QrX9c/MKyIvha8jkkyoC1FfRzzKzgovM42nB
N2MWof3si+9lRGrkzOFfTiH/Vwhwj7cfy8BhTOqsc7qvDnMCw+UbC+BpKJtePJyo
nw/ryD0XkskdtySfcTy/a2KRXciAfPLB+aDJUbPDcZUxpmlJs29RI0xAjbvcd7NB
M+tq5hE1RlSKzyJ2R2PptLeG/SDSoa5UIiurCDFNJyVJ8M/u5+YccHgvpAvNZAg5
53ZxNip/P8GobAYb3BjqOMgu9nZgVoQRROIBkDqlc4nAebvTZ5+eJCRv5ivNP+M=
=IHEU
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
