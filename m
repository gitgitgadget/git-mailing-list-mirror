From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] separate .git from working directory
Date: Wed, 11 Oct 2006 20:14:25 +0200
Message-ID: <20061011181425.GA10922@admingilde.org>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 20:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXib8-0006yp-Og
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWJKSO1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWJKSO1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:14:27 -0400
Received: from agent.admingilde.org ([213.95.21.5]:28560 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1161084AbWJKSO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 14:14:27 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GXib3-0003MP-JY; Wed, 11 Oct 2006 20:14:25 +0200
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28734>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Oct 11, 2006 at 08:23:50PM +0700, Nguyen Thai Ngoc Duy wrote:
> I was thinking about this while reading subproject thread. In a simple
> case, I have a repo A located at ~/project-a and another repo B
> located at ~/project-a/some/dir/project-b. With this setup, command
> "find" and other directory-recursive commands will run horribly from
> ~/project-a when they go inside project-b/.git (no I don't want to
> repack -d everytime I want to find something).

no it won't.

For subprojects you really need a shared object repository.
In such a setup b/.git/objects would be a symlink to the parent
object directory.

On the other hand, you already have the same problem with
a/.git/objects.  If you really want to move .git outside of the
working directory you can always do so by using a symlink for
the entire .git directory.

--=20
Martin Waitz

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFLTSBj/Eaxd/oD7IRAsGIAJ9nJdbgtgGCDcO2gfF8DIFLJb87swCfSxkK
YA59YIjVMVvZOft3iqM22OU=
=UxuH
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
