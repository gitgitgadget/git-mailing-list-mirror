From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [RFH] NetBSD 6?
Date: Wed, 02 Jan 2013 19:30:24 -0500
Message-ID: <rmipq1numzj.fsf@fnord.ir.bbn.com>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:30:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqYhp-0004o7-7f
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 01:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab3ACAa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 19:30:26 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:64845 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015Ab3ACAaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 19:30:25 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id E9466A7B8; Wed,  2 Jan 2013 19:30:24 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130103:gitster@pobox.com::3g2k1kQXncjXFGFL:000000000000000000000000000000000000000000003KML
X-Hashcash: 1:20:130103:git@vger.kernel.org::3g2k1kQXncjXFGFL:0000000000000000000000000000000000000000003MtN
In-Reply-To: <7vd2xn18p5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 02 Jan 2013 15:11:50 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212565>

--=-=-=
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:

> I would appreciate if somebody with more familiarlity with the
> platform can suggest a better alternative than applying the
> following patch to our Makefile.  Right now I have an equivalent of
> this change in config.mak locally when building on the said
> platform.

I realized after sending my previous reply that you are probably trying
to have a way to build and run tests on NetBSD-6 from a git checkout as
part of development testing.

One approach I've taken with other programs is to have a README.NetBSD
file which is actually an executable /bin/sh script with comments,
explaining the prereqs in terms of pkgsrc and invoking configure to get
dependencies from pkgsrc (-I/usr/pkg/include plus -L/-R).

So in the git case, this could set PYTHON_PATH in the environment.

I realize a README.foo file for N different systems could be clutter,
but having these checked in would provide the concise help that people
on any of those platforms need.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDk0SAACgkQ+vesoDJhHiVzzwCfYmnjdOGqbsw4vFrGlUk6i4fW
+p8An1x+KWAdChco+rexOByfxwHTUB0a
=e27x
-----END PGP SIGNATURE-----
--=-=-=--
