From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Create a new manpage for the gitignore format, and reference
 it elsewhere
Date: Sat, 02 Jun 2007 09:54:20 -0700
Message-ID: <4661A0BC.2060201@freedesktop.org>
References: <46609BC4.9000508@freedesktop.org> <20070601234710.GW3242@planck.djpig.de> <4660BF65.3000605@freedesktop.org> <20070602105648.GX3242@planck.djpig.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8497AC7CA0FDD9BD4C42D25D"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <djpig@debian.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 18:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuWsL-0006U8-Bi
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 18:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759206AbXFBQyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 12:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760556AbXFBQym
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 12:54:42 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:42335 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759206AbXFBQym (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 12:54:42 -0400
Received: (qmail 20737 invoked from network); 2 Jun 2007 16:54:41 -0000
Received: from host-226-124.pubnet.pdx.edu (HELO [131.252.226.124]) (josh@[131.252.226.124])
          (envelope-sender <josh@freedesktop.org>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <djpig@debian.org>; 2 Jun 2007 16:54:41 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <20070602105648.GX3242@planck.djpig.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48936>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8497AC7CA0FDD9BD4C42D25D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Frank Lichtenheld wrote:
> On Fri, Jun 01, 2007 at 05:52:53PM -0700, Josh Triplett wrote:
>> Frank Lichtenheld wrote:
>>> On Fri, Jun 01, 2007 at 03:20:52PM -0700, Josh Triplett wrote:
>>>> + - Otherwise, git treats the pattern as a shell glob suitable
>>>> +   for consumption by fnmatch(3) with the FNM_PATHNAME flag: any
>>>> +   slash in the pattern must match a slash in the pathname.  For
>>>> +   example, "Documentation/\*.html" matches
>>>> +   "Documentation/git.html" but not "ppc/ppc.html".  A leading
>>>> +   slash matches the beginning of the pathname; for example,
>>>> +   "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".
>>> I realise this is copy&paste but shouldn't that read:
>>> "Documentation/\*.html" matches "Documentation/git.html"
>>> but not "Documentation/ppc/ppc.html"
>>> ?
>> I don't know.  Neither file seems to exist in current Git.
>=20
> The point I was trying to make is that "Documentation/*.html" _of
> course_ doesn't match ppc/ppc.html. What we try to tell the user here
> is that * doesn't match /
> So I think it should definetly read Documentation/ppc/ppc.html

Ah, I understand your point now.

> FWIW, I find the sentence
> "any slash in the pattern must match a slash in the pathname"
> very confusing too. The sentence in fnmatch(3) is much more precise:
> "match a slash in string only with a slash in pattern and not by an
> asterisk (*) or a question mark (?) metacharacter, nor by a bracket
> expression ([]) containing a slash"

I like that better as well.

> Anyway, if you prefer (and if it is okay with Junio) I can send a
> patch of my own for this single issue to not hinder the commit of
> your big patch as the issue is equally present in the old and the
> new text.

Now that I understand the issue you raised, I can easily fix it and
send a revised patch.  Expect one momentarily.

- Josh Triplett


--------------enig8497AC7CA0FDD9BD4C42D25D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGYaDEGJuZRtD+evsRAm2ZAKCSWToS8WXesKMndRK7divO7IFYEwCgkhnT
yQXks0VsZDCi3vzqtc4+V3Q=
=aRoP
-----END PGP SIGNATURE-----

--------------enig8497AC7CA0FDD9BD4C42D25D--
