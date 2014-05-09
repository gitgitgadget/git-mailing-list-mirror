From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Conforming to pep8
Date: Fri, 9 May 2014 09:01:30 -0700
Message-ID: <20140509160130.GA28634@odin.tremily.us>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
 <20140509035759.GA9051@wst420>
 <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
 <20140509051623.GB9051@wst420>
 <536c815ee0b9c_182dd0d3104b@nysa.notmuch>
 <20140509072820.GD9051@wst420>
 <536c8546ed6fd_182dd0d3100@nysa.notmuch>
 <20140509074402.GE9051@wst420>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJwpkiw3F9XLBeML"
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 18:01:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WinEz-0004EX-Fs
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 18:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbaEIQBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 12:01:35 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:51479
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753547AbaEIQBd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 12:01:33 -0400
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id zniK1n0011wpRvQ5As1Yhi; Fri, 09 May 2014 16:01:32 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id zs1W1n00e152l3L3es1Xd2; Fri, 09 May 2014 16:01:32 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 7571711953DE; Fri,  9 May 2014 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399651290; bh=72i+4sy22K4UVJz4ldF+nJxqiCAla3KyRxhdDXtqblQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g25+eW/gm/zNgHzn3zR9dxFdc9qbKc0CMa1gJ4hYoyYD3OI8MtKYC0nNCYFknl0Gp
	 TB+mKIHNeWmmdT0Q7iGP5k+l3VDwXXVVoeYGIr2Q8Y7Rs8SgHdB/0Ok3r4u0n69Qe8
	 Gb2f9bTeV88R0GKSQdhTVpGKa0gwsTjBWKp5/nlA=
Content-Disposition: inline
In-Reply-To: <20140509074402.GE9051@wst420>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399651292;
	bh=7CWQ5xAESCeIJn2ZFZJJWKD9CSAMNkyJIADPLewcA9E=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=XirQX1kKHO1oLAZncixPBxYi8tbiCqRyNiunvtpXEctuM1mA22xoU3L9mgHdAHYlt
	 Xp/UMdTdG1IaoxEIojkkpQWYUXsAisVo3eP98v2QDq3WZh04RKCEGyU7fonmzBPFOO
	 ZmhYeLmaPu4oHLwnwcm47TzxtEXfSmgLBKThkvTl0PZf8davLMIjjulw95COlYshc7
	 X+OvgsEiUjbMssyJTQ45NfuLM15TspdxL9GtFRzvf2rJr3o8HJFJCGaUcZK5/vPNIR
	 KbU3JoAmpFX8iC8sJ319E5zx4iZ5QinNQEHOx2Yn/NE78G2qxNCFVjOUS382Lm/qjB
	 xWm7Qqqm4GZjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248579>


--vJwpkiw3F9XLBeML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2014 at 02:44:02AM -0500, William Giokas wrote:
> Maybe a time to use something like::
>=20
>   from mercurial import foo \
>                         bar \
>                         baz \
>                         ...
>=20
> Would make that import into quite a few lines, but would help organize
> things and let you easily organize things in the future.

=46rom PEP 8 [1]:
  The preferred way of wrapping long lines is by using Python's
  implied line continuation inside parentheses, brackets and
  braces. Long lines can be broken over multiple lines by wrapping
  expressions in parentheses. These should be used in preference to
  using a backslash for line continuation.

So I prefer something like:

  from mercurial import (
      bar,
      baz,
      foo,
      )

The indentation for the closing parenthesis is optional [2].  You can
of course do things like:

  from mercurial import (
      bar, baz,
      foo,
      )

but I prefer the complete specification of =E2=80=9Csingle, alphebetized en=
try
per line=E2=80=9D.  I'm happy to send patches if that style is ok.

Cheers,
Trevor

[1]: http://legacy.python.org/dev/peps/pep-0008/#maximum-line-length
[2]: http://legacy.python.org/dev/peps/pep-0008/#indentation

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--vJwpkiw3F9XLBeML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbPvYAAoJEKKfehoaNkbtj54QAIsbdwktiSujSGJGd1nxWaC1
maakmmSqpylTrObUMwZ4l738jXDUgXF45nmjsmvsrhNRp/+EWfDG8K3MYyux2aUz
Fm0ftR+Sk7Uyk7v9elWNo+rmvrCqC7J2pJkmgozSiW7VaaqCReTcgXLfiHHZv/j1
HFs7u0XtqZlVI9w742iyhvaSRu2TafRRaBD0B4UebEK/PBdQ5tPJip1O0uJWZgH9
jD398/2lvB1xtaEkz75XezxiRyNODZD7p4i2t+DJoFFAZiubtK1dspNnW0prhUJ+
pWljJD8vLYOrp8cziwwoh9Tzd2JKlnvq4JtdiY/P3UpZ3dIM91ZA6PsfSvgKXRjJ
nwLluH8JTaGZEHSfGQ4CeTW9gra2lx8iobViRY33sgHgd2lk5I5wPwOVAw2NRQyz
PqM1KRdT25XI4PW4dQvzot7h9qOEnETP6wL7/1m29xA+1D17c/CC079e+U5dw6fp
T+0tRqAadHNt6kDbWLjHoukNArxZlTtM/efprrVZQoqy4ZevEsc3ELbr5iNA3xYf
vYPXebswGAkuXKsR2gnm09n42aZ4gBkDuBPXebsTOV+uIGqIBWP2gJjG+S+yRFjc
T3LssGDLeENAUmaxb5AT75IuMI1YnzzT6+7JwT8TJiqtjjOu2tuKFcbxoVQP6KrG
hWILKto0D/r2McvGAxUQ
=OaH+
-----END PGP SIGNATURE-----

--vJwpkiw3F9XLBeML--
