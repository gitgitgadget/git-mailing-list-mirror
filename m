From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: git svn fetch segfaults
Date: Wed, 9 Jan 2008 13:53:41 +0100
Message-ID: <200801091353.44630.devurandom@gmx.net>
References: <200801082325.45756.devurandom@gmx.net> <20080109003307.GS29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2291533.krHo7QfzHA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 13:55:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCaSN-0005eN-AI
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 13:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbYAIMy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 07:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYAIMy2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 07:54:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:34603 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751883AbYAIMy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 07:54:27 -0500
Received: (qmail invoked by alias); 09 Jan 2008 12:54:25 -0000
Received: from hnvr-4dbbb8b7.pool.einsundeins.de (EHLO ernie.local) [77.187.184.183]
  by mail.gmx.net (mp001) with SMTP; 09 Jan 2008 13:54:25 +0100
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX19QbFcQlHhQ7HkOQksnORoDuZGJzmSqxdO01rHKGG
	OxQ5kCAVNJpb7+
User-Agent: KMail/1.9.7
In-Reply-To: <20080109003307.GS29972@genesis.frugalware.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69987>

--nextPart2291533.krHo7QfzHA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 9. Januar 2008 01:33:07 schrieb Miklos Vajna:
> On Tue, Jan 08, 2008 at 11:25:45PM +0100, Dennis Schridde=20
<devurandom@gmx.net> wrote:
> > mkdir org.gna.warzone2100.git
> > cd org.gna.warzone2100.git
> > git --bare init
> > git --bare svn init --use-svnsync-props --stdlayout
> > file:///var/svn/warzone2100/
> > git --bare svn fetch
>
> wget http://svn.kynes.de/warzone2100.bz2
>
> svnadmin create warzone2100 && bzcat warzone2100.bz2 | svnadmin load
> warzone2100
>
> the rest is the same i get a segfault at the very same place.
>
> > If I do not specify --use-svnsync-prop to "git svn init", it gets past
> > r13 in tags/1.10a.
>
> same.
>
> > I am using these versions:
> > svn, version 1.4.6 (r28521)
> > git version 1.5.4.rc2
>
> $ svn --version
> svn, version 1.4.5 (r25188)
>
> $ git --version
> git version 1.5.4.rc2.38.gd6da3
Same with git version 1.5.3.7

--nextPart2291533.krHo7QfzHA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEABECAAYFAkeEw9gACgkQjqfyF1DtJW6HdgCfb+oHDK5ElqLJyUnnU1NR4PL9
xi0Anj0ktwhK3+muy0/3Bd/GJnuWpuSN
=4btd
-----END PGP SIGNATURE-----

--nextPart2291533.krHo7QfzHA--
