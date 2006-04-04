From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Add git-clean command
Date: Tue, 4 Apr 2006 10:20:02 +0200
Message-ID: <20060404082002.GJ4663@admingilde.org>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 10:20:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQglr-0001Ck-N7
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 10:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWDDIUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 04:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWDDIUH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 04:20:07 -0400
Received: from admingilde.org ([213.95.32.146]:26330 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751837AbWDDIUF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 04:20:05 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FQgle-0004uS-ET; Tue, 04 Apr 2006 10:20:02 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <20060403221841.25097.18242.stgit@dv.roinet.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18377>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

> +-x::
> +	Don't use the ignore rules.  This allows removing all untracked
> +	files, including build products.  This can be used (possibly in
> +	conjunction with gitlink:git-reset[1]) to create a pristine
> +	working directory to test a clean build.

as ignored files are generally generated files, doesn't it make sense
to clean up the "ignored" files, and leave other untracked files
alone?  That way you don't loose files which you forgot to add to git.

What is the use case of cleaning up all untracked files without also
cleaning ignored files?

--=20
Martin Waitz

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEMiwyj/Eaxd/oD7IRAvthAJ4oo5oTcy1ADZ27dVQFemrxgjo2XgCfRtHi
A3oop4sVytySu39lIlIeOEQ=
=J2JN
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
