From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [RFH] NetBSD 6?
Date: Thu, 03 Jan 2013 13:27:34 -0500
Message-ID: <rmiobh6rujt.fsf@fnord.ir.bbn.com>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
	<rmipq1numzj.fsf@fnord.ir.bbn.com>
	<7vd2xnypt6.fsf@alter.siamese.dyndns.org>
	<rmi8v8av05d.fsf@fnord.ir.bbn.com>
	<7vvcbew895.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 19:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqpWE-0001ED-LV
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 19:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792Ab3ACS1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 13:27:36 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:61974 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779Ab3ACS1f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 13:27:35 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 1E9BDAE41; Thu,  3 Jan 2013 13:27:34 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130103:gitster@pobox.com::eccL/Qw+svqJsq2r:000000000000000000000000000000000000000000000Wiq
X-Hashcash: 1:20:130103:git@vger.kernel.org::eccL/Qw+svqJsq2r:000000000000000000000000000000000000000000BQme
In-Reply-To: <7vvcbew895.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 03 Jan 2013 08:17:58 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212599>

--=-=-=
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:

> I forgot to mention that we also ship configure (and keep track of
> configure.ac) so that optionally people can let autoconf machinery
> to create config.mak.autogen to be included at the same place as
> handcrafted config.mak in their build process.  I do not offhand
> know if we do "for p in python python2.6 python2.7; do ..." kind of
> thing, though.

pkgsrc uses the configure method, but it seems not to output a
PYTHON_PATH.  It looks like automake's python.m4 is not used by git's
configure.ac.  But pkgsrc passes PYTHON_PATH in the environment to make,
so it works out currently.

> It refers to the type of the second parameter to iconv(); OLD_ICONV
> makes it take "const char *", as opposed to "char *", the latter of
> which matches
>
>   http://pubs.opengroup.org/onlinepubs/9699919799/functions/iconv.html

Thanks - I now see our extra const and am looking into it.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEUEARECAAYFAlDlzZYACgkQ+vesoDJhHiViMgCYqge6SBz+nJmWStA8fGXu1DGZ
eACfRnG0ezY69vPbZt25TsvsNDKok0E=
=e9e+
-----END PGP SIGNATURE-----
--=-=-=--
