From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: git svn fetch segfaults
Date: Thu, 10 Jan 2008 02:45:01 +0100
Message-ID: <200801100245.05647.devurandom@gmx.net>
References: <200801082325.45756.devurandom@gmx.net> <200801091353.44630.devurandom@gmx.net> <7v4pdmiwo4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1671775.x4zuRpEKql";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 02:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCmUs-0001m0-37
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 02:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbYAJBpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 20:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbYAJBpt
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 20:45:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:51479 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753037AbYAJBps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 20:45:48 -0500
Received: (qmail invoked by alias); 10 Jan 2008 01:45:46 -0000
Received: from hnvr-4dbbb8b7.pool.einsundeins.de (EHLO ernie.local) [77.187.184.183]
  by mail.gmx.net (mp029) with SMTP; 10 Jan 2008 02:45:46 +0100
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX1+4Y+BNsea4N8CJ/EurPJg2HAA5VTmIe23QiHdtYY
	yPXhwYUALrByhH
User-Agent: KMail/1.9.7
In-Reply-To: <7v4pdmiwo4.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70032>

--nextPart1671775.x4zuRpEKql
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Replying to this, as I haven't recieved the newer mail. (Not subscribed.)
Handcopied the text, hope I didn't forgot anything.

> > > Has anybody determined which executable is the segfaulting one?
> >
> > I just tried to, but it's still running, at r600 now.
> >
> > > If it is svn executable spawned by Perl that runs git-svn, or
> > > libsvn shared object linked to Perl while running git-svn, I
> > > suspect testing with different git versions will not be very
> > > productive.
> >
> > Oh well, anyway, just for the record:
> > doener@atjola:~ $ svn --version
> > svn, version 1.4.4 (r25188)
> >
> > doener@atjola:~ $ git --version
> > git version 1.5.4.rc1.11.gd2f82
>
> It finished by now, no segfault with --use-svnsync-props.
=46or me it always segfaulted at r13 in tags/1.10a.
I crosses r13 before that already (trunk), but doesn't crash there.

I am now recompiling svn,git,perl to create a coredump, will the rerun it a=
nd=20
hopefully get some backtraces from the dump.

Btw, I am running perl 5.8.8, in case that matters somehow.

=2D-Dennis

--nextPart1671775.x4zuRpEKql
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEABECAAYFAkeFeKEACgkQjqfyF1DtJW6pNQCfTQ6lgh06gvZ2IWceuqvFAacb
G/4AnAwL5uKJsEHwYU9p9j4bIy4TkWKj
=pzKC
-----END PGP SIGNATURE-----

--nextPart1671775.x4zuRpEKql--
