From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Sun, 09 Jul 2006 20:24:34 -0700
Message-ID: <44B1C872.3050807@michonline.com>
References: <11524258261798-git-send-email-ryan@michonline.com>	<46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>	<20060709221326.GU29115@pasky.or.cz>	<20060709222308.GA4153@h4x0r5.com> <7vsllae1ik.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3C40148FAC6DF8B27C7A4BE4"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 05:25:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzmOf-0000Hl-PH
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 05:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWGJDZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 23:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161319AbWGJDZT
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 23:25:19 -0400
Received: from h4x0r5.com ([70.85.31.202]:43275 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1161318AbWGJDZS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 23:25:18 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythryan.michonline.com)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FzmOU-0002oe-7j; Sun, 09 Jul 2006 20:25:10 -0700
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.62)
	(envelope-from <ryan@michonline.com>)
	id 1FzmNy-0001Pr-PN; Sun, 09 Jul 2006 20:24:38 -0700
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsllae1ik.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23586>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C40148FAC6DF8B27C7A4BE4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
>
>  =20
>> Comments on a way to make the Makefile less repetitive would be
>> appreciated, though.
>>    =20
>
> One obvious way would be not to have scm/Makefile but have the
> dependencies in the main Makefile to say (the moral equivalent
> of):
>
> 	git-archimport.perl: scm/git-archimport.perl
>  =20
I think that doing that means I still need to duplicate the  actual
build rules, which is what I was hoping to avoid, as they encode all the
magic "path replacement" logic in multiple places.

On the other hand, I can fix *that*, if I break the ability to run in
the build directory, which is bad in its own way.  (Fixing the tests
should be a matter of adapting the test library slightly, I think.)

For the time being, I'm going with ugly, but less disruptive, and I'm
willing/planning on revisiting it when things shake out a bit more.


--=20

Ryan Anderson
  sometimes Pug Majere



--------------enig3C40148FAC6DF8B27C7A4BE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEsch2fhVDhkBuUKURAlBCAKCVJGu0xyyBHl1Z+SkT/AaN+OYtrwCgg0Us
H8DnDrcH1RjxW8U5PAcw3MY=
=q8x/
-----END PGP SIGNATURE-----

--------------enig3C40148FAC6DF8B27C7A4BE4--
