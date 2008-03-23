From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 18:21:02 +0000
Message-ID: <20080323182102.GA22551@bit.office.eurotux.com>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Mar 23 19:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdUpU-0005kU-O4
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 19:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbYCWSVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 14:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbYCWSVK
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 14:21:10 -0400
Received: from os.eurotux.com ([216.75.63.6]:43097 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbYCWSVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 14:21:09 -0400
Received: (qmail 12722 invoked from network); 23 Mar 2008 18:21:07 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 23 Mar 2008 18:21:07 -0000
Content-Disposition: inline
In-Reply-To: <20080323173841.GA24943@mit.edu>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77933>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2008 at 01:38:41PM -0400, Theodore Tso wrote:
> On Sun, Mar 23, 2008 at 10:15:48AM -0700, H. Peter Anvin wrote:
> > 2. cg-restore
> >
> >    Cogito separated "reset" and "restore".  This is a syntactic sugar
> >    issue, but having to type "git reset --hard -- path" makes me
> >    nervous, especially since hitting Enter at the wrong time could have
> >    serious and irrevocable consequences.
> >
> >    I also note that this particular use of "git reset" is actually
> >    undocumented, but it seems to work.
>=20
> I didn't think "git reset --hard -- <pathame>" was valid, since it's
> not documented in the man page.
>=20
> I have the following in my path as "git-revert-file" (which is easier
> to type and less dangerous than typing "git reset --hard -- <path>"):
>=20
> #!/bin/sh
> #
> prefix=3D$(git rev-parse --show-prefix)
>=20
> for i in $*
> do
>         git show HEAD:$prefix$i > $i
> done

I use git checkout path ...

Isn't that the same thing?

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH5p+OinSul6a7oB8RAvoSAJ9d2pSlLkFmQjKy6mfsMrsRtVhDwACeNB03
asKcyzD9RbaiuShpNg9Qu+4=
=btRG
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
