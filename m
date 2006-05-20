From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Sat, 20 May 2006 15:18:10 -0700
Message-ID: <446F95A2.6040909@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> <20060520203911.GI6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig08BCF45D60D1EFE38DB47103"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 21 00:18:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhZm7-0001iQ-OB
	for gcvg-git@gmane.org; Sun, 21 May 2006 00:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWETWSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWETWSQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 18:18:16 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:34460 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S932410AbWETWSP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 18:18:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 62F1064348;
	Sat, 20 May 2006 22:18:15 +0000 (UTC)
Received: from smtp.gentoo.org ([127.0.0.1])
 by localhost (smtp.gentoo.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18376-12; Sat, 20 May 2006 22:18:13 +0000 (UTC)
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 457F6642E6;
	Sat, 20 May 2006 22:18:13 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060520203911.GI6535@nowhere.earth>
X-Enigmail-Version: 0.94.0.0
X-Virus-Scanned: amavisd-new at gentoo.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20399>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig08BCF45D60D1EFE38DB47103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yann Dirson wrote:
> On Sat, May 20, 2006 at 10:26:22AM -0700, Linus Torvalds wrote:
>> I'm reading the irc logs, and seeing that people have problems, but (a=
) it=20
>> was while I was asleep and (b) irc use doesn't encourage people to=20
>> actually explain what the problems _are_, so I have no clue.
>>
>> So now I know that "spyderous" has problems importing some 1GB gentoo =
CVS=20
>> archive, but that's pretty much it. Grr.

Hi all,

I just subscribed and this post is the only one I've got from the
thread, so I'm responding to it instead of the original. Gentoo's an
IRC-based community, so I tend to try IRC first for any problems I have
and fall back to the list later if I can't get things figured out.

Here's a rough summary:

Our main repo is actually a bit over 2G (2103621223) now that I check,
but it's not very complex. There's actually just one branch, and I don't
think anyone would care if we lost the history from it because it's a
release branch from a few years ago.

Somebody else tried importing it with git-cvsimport, but he said he hit
some kind of problem and recalled that it was a cvsps segfault. Sounds
about right, since I've never gotten cvsps to run successfully on the
whole repo either.

I tried with parsecvs, but it runs into OOM even on a machine with 4G
RAM after reading in all the ,v files, presumably while it's building
some huge tree of changesets in memory. Keith Packard's suggested that
there are ways to reduce parsecvs's memory use, because it retains the
full tree in memory for each revision rather than just the files that
actually changed. But my C skills are pretty weak; I'm an OK reader but
not much of a writer yet.

Thanks,
Donnie


--------------enig08BCF45D60D1EFE38DB47103
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEb5WkXVaO67S1rtsRAquyAJ4mV/Cc9/uFkH+JQgtO6Zg+0yHSMwCgllLr
5bhJZgQ2Sky39mLNvgTlies=
=Dhux
-----END PGP SIGNATURE-----

--------------enig08BCF45D60D1EFE38DB47103--
