From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 18:22:26 -0700
Message-ID: <44A9C2D2.6010409@michonline.com>
References: <1151949764.4723.51.camel@neko.keithp.com> <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <20060704002138.GB5716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB1F44A5538655AFA37A789B9"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 03:23:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxZdE-0007cy-0J
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWGDBXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWGDBXM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:23:12 -0400
Received: from h4x0r5.com ([70.85.31.202]:7174 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1750735AbWGDBXL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:23:11 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythryan.michonline.com)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FxZcy-00046f-JV; Mon, 03 Jul 2006 18:23:00 -0700
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.62)
	(envelope-from <ryan@michonline.com>)
	id 1FxZcT-0002qA-9a; Mon, 03 Jul 2006 18:22:29 -0700
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
To: Jeff King <peff@peff.net>
In-Reply-To: <20060704002138.GB5716@coredump.intra.peff.net>
X-Enigmail-Version: 0.94.0.0
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23230>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1F44A5538655AFA37A789B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> On Mon, Jul 03, 2006 at 04:14:10PM -0700, Linus Torvalds wrote:
>
>  =20
>> Well, you could use multiple branches in the same repository, even if =
they=20
>> are totally unrealated. That would allow you to fetch them all in one =
go.
>>    =20
>
> One annoying thing about this is that you may want to have several of
> the branches checked out at a time (i.e., you want the actual directory=

> structure of libXrandr/, Xorg/, etc). You could pull everything down
> into one repo and point small pseudo-repos at it with alternates, but I=

> would think that would become a mess with pushes. You can do some magic=

> with read-tree --prefix, but again, I'm not sure how you'd make commits=

> on the correct branch.  Is there an easier way to do this?
>  =20
You can have multiple source trees, one per 'branch' (which is a bit of
a bad term here), and have completely unrelated things in the branches.

See, for an example, the main Git repo, which has the "man", "html", and
"todo" branches, logically distinct and (somewhat) unrelated to the main
branch tucked away in "master".

--=20

Ryan Anderson
  sometimes Pug Majere



--------------enigB1F44A5538655AFA37A789B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqcLUfhVDhkBuUKURAjz/AJ9E4/XxTabPanZR5ucfQRBQW7jBkACeKHDW
IBmKftCpiGB1UF+Fn26M+sM=
=BSnC
-----END PGP SIGNATURE-----

--------------enigB1F44A5538655AFA37A789B9--
