From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Can I enforce required approval on some files
Date: Tue, 20 Jul 2010 22:45:07 +0200
Message-ID: <1279658706.2519.12.camel@kheops>
References: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-CfrsyxjO+QL6KGKygGWv"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 22:46:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObJiG-0001EQ-C8
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 22:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673Ab0GTUpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 16:45:24 -0400
Received: from lo.gmane.org ([80.91.229.12]:51640 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932648Ab0GTUpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 16:45:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ObJgm-0000W3-5k
	for git@vger.kernel.org; Tue, 20 Jul 2010 22:45:20 +0200
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 22:45:20 +0200
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 22:45:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151364>


--=-CfrsyxjO+QL6KGKygGWv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-07-20 at 13:22 -0700, Dominik Gront wrote:
> Dear Group,
>=20
> I have been a happy SVN user for quite a long time, but now I miss
> some functionality in Subversion. I wonder if it could be done in git.
> If so, I convert to git right away :-)
>=20
> There are some files in our repository that all their modification
> need to be approved by a project leader.  In general the desired
> behavior would be (examples given in svn commands) :
> - user runs "svn ci"
> - some files have status "pending" or "waiting for approval"
> - anyone can do "svn up", modifications to the pending files are not
> retrieved, project leader can get the modified versions
> - project leader accepts the changes
> - anyone running "svn ci" sees all the modifications
>=20
> Best,
> Tim

Hi,

Git itself does not allow what you want but the workflow used to work
with git does.=20

Each developer work and on a "copy" of the "blessed" repository (the one
checked out in svn, cloned in git) so it does not matter if
modifications done to a file need approval or not. Once the developer is
happy with his work he has to send his commit(s) to the person(s) in
charge of maintaining the project and this/those people will review the
changes and push (commit in svn language) them to the "blessed"
repository if they are ok with the changes made.

With git, if not used like svn, all modifications need approval.

You can read more about git's distributed workflow here :
http://progit.org/book/ch5-1.html

Regards.

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-CfrsyxjO+QL6KGKygGWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAABAgAGBQJMRgrNAAoJECLlHVUnhaoW12IH/3OHuLJ6ililMdFLpxkKZBpH
pxhegeYz/orNHhcPwR0GpI1MuPosPXd+opL/JDXBVjZ8iJX3KwGJicZPqnE5oEBO
btg/s+2QxuYhDxN431q20KpE9qWbv1TPfnkJcsY56HEz4Ioq0oN1/nr3ki5n8oCD
+QBWONM3sSJ0dzY3YErAQQVn87Q8wujkjDGLwcDddSJV0sPStd0nupjHrH9S00Mh
Gl2Ihn3XSvJa9PSpvtd5CZNoID+Es4tJsukkQWUGKorNsVfbTAJhY6y7iVb2jDyz
qkjFp56fTcgJ9UOt7dqHfCTTQZi2MvYlehJgFehMKp82YizskRnzjWDVHMQc0/A=
=K6Oj
-----END PGP SIGNATURE-----

--=-CfrsyxjO+QL6KGKygGWv--
