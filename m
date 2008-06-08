From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Mon, 9 Jun 2008 00:33:47 +0200
Message-ID: <200806090033.51167.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <20080606051026.GA18257@sigill.intra.peff.net> <20080606060318.GE18257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1575289.gq1uLoBfuu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 00:34:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5TT0-0004uk-D8
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 00:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbYFHWdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 18:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbYFHWde
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 18:33:34 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:22649 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999AbYFHWda (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 18:33:30 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Jun 2008 00:33:29 +0200
Received: from [192.168.0.11] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Jun 2008 00:33:28 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080606060318.GE18257@sigill.intra.peff.net>
X-OriginalArrivalTime: 08 Jun 2008 22:33:28.0875 (UTC) FILETIME=[AC67EFB0:01C8C9B7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84336>

--nextPart1575289.gq1uLoBfuu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
>
> I wrote this after reading just your first patch, and it looks like
> you've made much progress since. It seems like Thomas' patch could just
> get rid of all the recounting entirely, and just pass off the edited
> hunks to "git apply --recount". Which should make his patch much smaller
> and more straightforward.

I think there's no way to split hunks, in the way I currently "help"
with @@ line guessing, using just the --recount feature.  Unless the
editor helps you with adding complete correct @@ lines in the middle
of hunks (Emacs does that).  I don't think it is at all possible to
remove the middle part of a hunk in Johannes' scheme without somehow
figuring out the corresponding @@ line (or at least its old line
number) or editing away every +/- line.

Then again it's not always easy even with my patch: you may have to
manually insert extra context because of the rule against zero lines
of context.  We could guess the context too if we already guessed the
line numbers, but that would mean even more complexity, which you
don't seem to like...

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch







--nextPart1575289.gq1uLoBfuu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBITF5PqUud07tmzP0RAqVMAJ95TYbWHZjHGi4KdLoohsKp9aXZ7wCeKFL+
A0Ds10poyXhNdobC6lP62zY=
=L+Wl
-----END PGP SIGNATURE-----

--nextPart1575289.gq1uLoBfuu--
