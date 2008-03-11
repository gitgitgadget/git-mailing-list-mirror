From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: commit 0? (or: create new empty branch)
Date: Tue, 11 Mar 2008 14:45:15 +0000
Message-ID: <20080311144515.GB12258@bit.office.eurotux.com>
References: <20080311123004.GA27577@bit.office.eurotux.com> <alpine.LSU.1.00.0803111350550.3873@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ5k5-0001ki-6P
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 15:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYCKOpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 10:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbYCKOpV
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 10:45:21 -0400
Received: from os.eurotux.com ([216.75.63.6]:60299 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbYCKOpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 10:45:21 -0400
Received: (qmail 18595 invoked from network); 11 Mar 2008 14:45:19 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 11 Mar 2008 14:45:19 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803111350550.3873@racer.site>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76854>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2008 at 01:52:00PM +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 11 Mar 2008, Luciano Rocha wrote:
>=20
> > I'd like to create a new branch, without any pre-existing data, for
> > purposes similar to git's html/man/.....
>=20
> If there is nothing to branch from, there is nothing to branch from.
>=20
> You might want to rename your branch (once you have something).
>=20
> But then, I do not even understand why you bother.  You can always push t=
o=20
> a branch of a different name, and have your principal branch being=20
> "master" locally.

It's not a matter of pushing/pulling. I'm referring to local branches
only.

What I'd like to have is, using util-linux-ng as an example:

branch master: util-linux-ng plus local patches
branch vendor: util-linux-ng upstream
branch metadata: information on util-linux-ng, how to compile,
    dependencies, etc.

I'd have no problems with the first branches. But when I wanted to
create the third, that shares no files with the others, I stumbled with
the problem of creating a clean branch. I really didn't want to create a
branch them do "git rm .".

Johannes's tricks did the thing. Thank you all.

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH1pr7inSul6a7oB8RAqNIAKCeR+4TKXOr8MOdS1BtgfheIqABtACeK2r2
1lL+tsSkcpbXSrqA3Ig5tCA=
=eavo
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
