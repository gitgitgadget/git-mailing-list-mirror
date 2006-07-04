From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 18:55:49 -0700
Message-ID: <44A9CAA5.4050602@michonline.com>
References: <1151949764.4723.51.camel@neko.keithp.com> <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <20060704002138.GB5716@coredump.intra.peff.net> <44A9C2D2.6010409@michonline.com> <20060704014441.GB9061@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7C3B05EFF28372A9E8A2A9D4"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 03:56:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxa9P-0004Yi-H7
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWGDB42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWGDB42
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:56:28 -0400
Received: from h4x0r5.com ([70.85.31.202]:65040 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751302AbWGDB41 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:56:27 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythryan.michonline.com)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Fxa9E-0004hQ-PG; Mon, 03 Jul 2006 18:56:20 -0700
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.62)
	(envelope-from <ryan@michonline.com>)
	id 1Fxa8j-0003Xt-If; Mon, 03 Jul 2006 18:55:49 -0700
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
To: Jeff King <peff@peff.net>
In-Reply-To: <20060704014441.GB9061@coredump.intra.peff.net>
X-Enigmail-Version: 0.94.0.0
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23239>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C3B05EFF28372A9E8A2A9D4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> On Mon, Jul 03, 2006 at 06:22:26PM -0700, Ryan Anderson wrote:
>
>  =20
>> You can have multiple source trees, one per 'branch' (which is a bit o=
f
>> a bad term here), and have completely unrelated things in the branches=
=2E
>>
>> See, for an example, the main Git repo, which has the "man", "html", a=
nd
>> "todo" branches, logically distinct and (somewhat) unrelated to the ma=
in
>> branch tucked away in "master".
>>    =20
>
> Right, I know, but my complaint is that I can't then turn that into a
> directory hierarchy of .../man, .../html, .../todo that are all checked=

> out at the same time (there are obviously ways of playing with it, say
> by setting GIT_DIR and doing a checkout in those directories, but then =
I
> can't use git in the normal way).
>
> The best I can come up with is having man, html, and todo repos pointin=
g
> to the one (now local) repo which contains everything. But then pushing=

> is a two-step process.
>
>  =20
Hrm, if I understand CVS at all, the old workflow was "cvsup a copy of
the repository, update a working tree against that", which is, I think,
actually even worse than the Git equivalent, since you can't reliably
even commit to that local clone of the CVS repository.

What am I missing?

You can still push directly upstream, I suppose, and just do 2-stage
pulls down.

--=20

Ryan Anderson
  sometimes Pug Majere



--------------enig7C3B05EFF28372A9E8A2A9D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqcqlfhVDhkBuUKURAvVHAKCq3RgEnQV8eTfWbipuL3oAI6btDACeNGef
ZAJaQppNtdfoOq0X1qydVnE=
=Xi4V
-----END PGP SIGNATURE-----

--------------enig7C3B05EFF28372A9E8A2A9D4--
