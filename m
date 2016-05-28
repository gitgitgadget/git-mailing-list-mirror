From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
Date: Sat, 28 May 2016 16:00:21 +0200
Message-ID: <87bn3qnuyy.fsf@fencepost.gnu.org>
References: <1464356141-3797-1-git-send-email-dak@gnu.org>
	<alpine.DEB.2.20.1605271633230.4449@virtualbox>
	<87d1o7pkyy.fsf@fencepost.gnu.org>
	<alpine.DEB.2.20.1605280815040.4449@virtualbox>
	<87shx2oaaw.fsf@fencepost.gnu.org>
	<alpine.DEB.2.20.1605281430440.4449@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 28 16:01:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6enV-0004X1-LP
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 16:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbcE1OAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 10:00:48 -0400
Received: from eggs.gnu.org ([208.118.235.92]:51442 "EHLO eggs.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbcE1OAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 10:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6en9-0000D5-8m
	for git@vger.kernel.org; Sat, 28 May 2016 10:00:40 -0400
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on eggs.gnu.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_50,RP_MATCHES_RCVD
	autolearn=disabled version=3.3.2
Received: from fencepost.gnu.org ([2001:4830:134:3::e]:39119 helo=lola.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6en1-0000AR-El; Sat, 28 May 2016 10:00:31 -0400
Received: by lola.localdomain (Postfix, from userid 1000)
	id 9576DDFA8E; Sat, 28 May 2016 16:00:29 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.20.1605281430440.4449@virtualbox> (Johannes
	Schindelin's message of "Sat, 28 May 2016 14:34:35 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4830:134:3::e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295814>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi David,
>
> On Sat, 28 May 2016, David Kastrup wrote:
>
>> > The short version of your answer is that you will leave this patch in
>> > its current form and address none of my concerns because you moved on,
>> > correct? If so, that's totally okay, it just needs to be spelled out.
>>=20
>> Yes, that's it.  You'll notice that the code change itself is both
>> minuscule as well purely functional, so it contains nothing
>> copyrightable.
>
> That is unfortunately an interpretation of the law that would need to
> come from a professional lawyer.

A professional lawyer would laugh at "Signed-off-by:" being of more
legal significance than a written record of intent but of course you
know that.  This is mere bluster.

> As it is, the patch was clearly authored by you, and anybody else who
> would claim authorship would most likely be breaking the law.

The _diff_ is not "clearly authored" by me but just the simplest
expression of the intent.  The commit message is clearly authored by me
but is not acceptable anyway.  Whoever gets to write an acceptable
commit message is up for all copyrightable credit in my book.  Feel free
to keep the authorship if you really want to, but when replacing the
commit message it is not a particularly accurate attribution.

> So I won't touch it.

Signed-off-by: David Kastrup <dak@gnu.org>

You don't get more than that for other patches either and it's a few
bytes compared to a mail conversation.  Here is a PGP signature on top.

As I said: I am not going to put more work into it anyway and if it's an
occasion for theatralics, it has at least accomplished something.

=2D-=20
David Kastrup

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAldJpHUACgkQBo350SLJfmgRNgCfe5LUhbIF+tntVu//I1RXRWOV
iugAn0qlv/GvA/ybPp5da0I0AQKbx7+v
=fCxf
-----END PGP SIGNATURE-----
--=-=-=--
