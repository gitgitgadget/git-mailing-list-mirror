From: =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
Subject: Re: [PATCH v2] log-tree: use custom line terminator in line  termination
 mode
Date: Tue, 01 May 2012 01:28:28 +0200
Message-ID: <4F9F201C.40509@jk.gs>
References: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org> <1335817705-24718-1-git-send-email-jk@jk.gs> <7vd36oesjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_cthulhu-15966-1335828521-0001-2"
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:28:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP01Q-0001RV-8s
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414Ab2D3X2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:28:44 -0400
Received: from zoidberg.org ([88.198.6.61]:36548 "EHLO heapsort.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757298Ab2D3X2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:28:43 -0400
Received: from [IPv6:2001:4dd0:ff1a:0:21b:77ff:fe59:7168] ([2001:4dd0:ff1a:0:21b:77ff:fe59:7168])
  (AUTH: PLAIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu with esmtp; Tue, 01 May 2012 01:28:40 +0200
  id 00400E82.4F9F2029.00003E5E
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <7vd36oesjr.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196635>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_cthulhu-15966-1335828521-0001-2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/01/2012 12:58 AM, Junio C Hamano wrote:
> Having said that, are we sure that
>=20
> 	printf "add bar\0initial"
>=20
> works per specification, or merely works by accident in some
> implementation?

I don't know for certain. In these cases I go by what dash (Debian's sh
implementation) does. To quote its manpage:

"Only features designated by POSIX, plus a few Berkeley extensions, are
being incorporated into this shell."

It does support this syntax for printf. That's enough for me personally.
Is it enough for everyone? I don't know.

-Jan


--=_cthulhu-15966-1335828521-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPnyAgAAoJEAVZW7fqaBptcKgP/0L8P30Ql4m9C5vfpLEx5y7A
lQEmuM6tOpMXGTQcakiY0Wmbsuq+tbk8AMane8cmjUW3A23Tjx/wjdlJ17njFrGV
l+8qEwKBbL6wv1Rrd6LaZVL9eUpSYy72R+aAYosYEevqIX6RSsQ6/WZ3LH41oZJA
6/rwRVLKcoaSPr0WgPF5nnPaEPMQdZNaM4ntsw1cAJ/FtiqyKWPQFyyYoZ5aPWmq
QiyTE6XHlAijYZLP0ry5HmttvCvZRXQQnSj+UNZeEOBM9C10FNUYr00s70MBKkRn
zGCLGTzvA7FZDkmFhh1bURYq0PyOCKirN/KFvKXJCl51q/4ruZINSfvCY9739WjC
qJQkMtuCaJi5cWI+84r7iww+58h/c9cSEOwN69OAJ3aLaDWivZ9PRhU6wEcaIY3T
ubn1ZENptkxYgZM9zz7enrB6St1DxuJOrJilZ1kYDMxtdc49S9knp0A+n2SNMSDl
y2gkdtpxQjao6fmsgtMPEn6pzD4GI3Jhvi3TOpSxf/3FDfNyxCv3cHuiX4vtZmdI
VV5hhm39vo5oEjSLT/2FrYfn4rswbJB7LZ2jFZnIv73/IfS7mfhkQJ5kWRswI8bH
s4Essa5ZHe05hEM2jJg8hzVIhrBqt6EJ0Bk4as7m1vOt7PGD0DuvUqZ5yfMn+ir0
LbEs+aR1zDzBdesXY6Od
=Se/f
-----END PGP SIGNATURE-----

--=_cthulhu-15966-1335828521-0001-2--
