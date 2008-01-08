From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: Odd number of elements in anonymous hash
Date: Tue, 8 Jan 2008 18:30:22 +0100
Message-ID: <200801081830.25722.devurandom@gmx.net>
References: <200801081738.56624.devurandom@gmx.net> <7vbq7wteq4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14829270.6rYzquiDqy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCIIZ-0004Wb-UA
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 18:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbYAHRbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 12:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756023AbYAHRbF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 12:31:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:57722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755884AbYAHRbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 12:31:03 -0500
Received: (qmail invoked by alias); 08 Jan 2008 17:31:00 -0000
Received: from hnvr-4dbb9fd3.pool.einsundeins.de (EHLO ernie.local) [77.187.159.211]
  by mail.gmx.net (mp033) with SMTP; 08 Jan 2008 18:31:00 +0100
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX1/XpvcqQ6LXfoTS/dDTVUu/Zgy4p7h/nZFvhjyq4r
	j9SeQ9mx9UK2+V
User-Agent: KMail/1.9.7
In-Reply-To: <7vbq7wteq4.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69896>

--nextPart14829270.6rYzquiDqy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 8. Januar 2008 18:21:55 schrieb Junio C Hamano:
> Dennis Schridde <devurandom@gmx.net> writes:
> > Hello!
> >
> > I am getting "Odd number of elements in anonymous hash at
> > /usr/bin/git-svn line 1760." (normal output, no warning/error) during
> > git-svn-clone. I am using git version 1.5.4.rc2.
> >
> > Line 1760 is this (with context, marked with '!!'):
> >     # see if we have it in our config, first:
> >     eval {
> >         my $section =3D "svn-remote.$self->{repo_id}";
> > !!        $svnsync =3D {
> >           url =3D> tmp_config('--get', "$section.svnsync-url"),
> >           uuid =3D> tmp_config('--get', "$section.svnsync-uuid"),
> >         }
> >     };
> >
> > The commandline was "git svn
> > clone --authors-file=3D/var/git/org.gna.warzone.git/authors
> > --use-svnsync-props --stdlayout file:///var/svn/warzone2100/
> > org.gna.warzone.git/"
> >
> > I assume this is some kind of bug?
>
> More than one svn-remote.$your_repo.svnsync-{url,uuid}?
PS: It doesn't happen for every revision and the folders (and thus config)=
=20
were empty before. The config doesn't list any "svnsync-*" during the impor=
t=20
process.

--nextPart14829270.6rYzquiDqy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEUEABECAAYFAkeDszEACgkQjqfyF1DtJW5I7gCePHje80mHcxMXFLmk3tTB5huJ
2ewAl19+GNGszqam3fnWjvOY3ptbPHY=
=gUSW
-----END PGP SIGNATURE-----

--nextPart14829270.6rYzquiDqy--
