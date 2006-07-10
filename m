From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Sun, 09 Jul 2006 17:20:18 -0700
Message-ID: <44B19D42.6030701@michonline.com>
References: <11524258261798-git-send-email-ryan@michonline.com>	<46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>	<20060709221326.GU29115@pasky.or.cz> <20060710013405.54fbe6bb.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig822890DC6675FCD885472A7E"
Cc: pasky@suse.cz, martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 02:21:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzjWZ-0003WF-2E
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 02:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWGJAVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 20:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWGJAVB
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 20:21:01 -0400
Received: from h4x0r5.com ([70.85.31.202]:17421 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1161231AbWGJAVA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 20:21:00 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythryan.michonline.com)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FzjW9-0008J4-8i; Sun, 09 Jul 2006 17:20:53 -0700
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.62)
	(envelope-from <ryan@michonline.com>)
	id 1FzjVd-00060X-Pt; Sun, 09 Jul 2006 17:20:21 -0700
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060710013405.54fbe6bb.tihirvon@gmail.com>
X-Enigmail-Version: 0.94.0.0
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23577>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig822890DC6675FCD885472A7E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Timo Hirvonen wrote:
> Petr Baudis <pasky@suse.cz> wrote:
>
>  =20
>> I've been meaning to do something like this for some time already; my
>> itch have been the builtins. The tree size _is_ getting out of hand an=
d
>> a little more categorization of the sources would certainly help.
>> Although I'd take a different approach:
>>
>> 	libgit/
>> 	builtin/
>> 	standalone/
>> 	scripts/
>>    =20
>
> Please don't.  One directory is much easier to work with.  At least
> don't split the Makefile.  Also moving files makes "git log <file>"
> stop at the rename.
>  =20
By "don't split the Makefile", do mean, "Don't use recursive make"?

I'm fine with that (and if you look at my patch, I "include
scm/Makefile" to do just that), but if you mean "keep only a top-level
Makefile", well, I think that continues the problem of "there is too
much stuff going on here", but I can be persuaded otherwise.

--=20

Ryan Anderson
  sometimes Pug Majere



--------------enig822890DC6675FCD885472A7E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEsZ1FfhVDhkBuUKURAgnTAJ9R3gLTTHB4rCLJPHq/+6AYzxZSfwCgvS9a
vYkFKXjpvftjCJPzHs0GYUA=
=Jkbi
-----END PGP SIGNATURE-----

--------------enig822890DC6675FCD885472A7E--
