From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 02:35:02 -0500
Message-ID: <44264426.8010608@michonline.com>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFD27DDFDE582FAA2C36C2816"
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 09:35:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNPmY-0004Fn-4g
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 09:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWCZHfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 02:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCZHfU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 02:35:20 -0500
Received: from mail.autoweb.net ([198.172.237.26]:42469 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751146AbWCZHfT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 02:35:19 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FNPmI-00063S-P3; Sun, 26 Mar 2006 02:35:12 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FNPmU-0000sd-PT; Sun, 26 Mar 2006 02:35:22 -0500
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FNPmD-0004d2-Vw; Sun, 26 Mar 2006 02:35:06 -0500
User-Agent: Mail/News 1.5 (X11/20060228)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18030>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD27DDFDE582FAA2C36C2816
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Sun, 26 Mar 2006, Petr Baudis wrote:
>  =20
>>   In [1], Linus suggests a non-core solution. Unfortunately, it doesn'=
t
>> fly - it requires at least two git-ls-tree calls per revision which
>> would bog things down awfully (to roughly half of the original speed).=

>>    =20
>
> No it doesn't. It requires one git-ls-tree WHEN SOMETHING IS RENAMED.
>
> In other words, basically never.
>  =20

A simple example is the first loop in git-annotate.perl.  (Which was
basically written by Linus, I just translated it from a
shell/pseudo-code example into Perl)


--=20

Ryan Anderson
  sometimes Pug Majere



--------------enigFD27DDFDE582FAA2C36C2816
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJkQpfhVDhkBuUKURApU5AKCIGQP++aUGVSy1aXHXviCE7F63NgCgxExW
gE1ctJYtvQBPPiikmNT2ybg=
=kVth
-----END PGP SIGNATURE-----

--------------enigFD27DDFDE582FAA2C36C2816--
