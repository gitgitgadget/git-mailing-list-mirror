From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: rev-parse doesn't take pwd into consideration
Date: Mon, 26 May 2008 21:52:48 +0100
Message-ID: <20080526205248.GB23396@bit.office.eurotux.com>
References: <20080526195812.GA23396@bit.office.eurotux.com> <20080526201842.GA8194@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon May 26 22:54:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0jht-0004h7-0O
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 22:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYEZUwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbYEZUwz
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 16:52:55 -0400
Received: from os.eurotux.com ([216.75.63.6]:36109 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095AbYEZUwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 16:52:54 -0400
Received: (qmail 1527 invoked from network); 26 May 2008 20:52:52 -0000
Received: from adsl.eurotux.com (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 26 May 2008 20:52:52 -0000
Content-Disposition: inline
In-Reply-To: <20080526201842.GA8194@mithlond.arda.local>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82954>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2008 at 11:18:42PM +0300, Teemu Likonen wrote:
> Luciano Rocha wrote (2008-05-26 20:58 +0100):
>=20
> > Is it difficult to make rev-parse accept relative path specifications?
>=20
> I don't know but let's consider this: The revision user is asking for
> with "git show <commit>:<path>" may not even contain the directory user
> is currently in. Also, there may not be any working directory at all, or
> user may be completely outside the repository and using "git
> --git-dir=3D/somewhere/else". I guess the system is much simpler as the
> "<commit>:" always refers to repository's root.

If <commit>:<path> is valid assuming the repository's root, then use it.
If it isn't, try <commit>:<path_to_git_root>/<path>.

> If you are using Git's bash completions it's easy to complete paths with
> "git show <commit>:". For example, try

I find bash-completion more an hassle than useful, thanks anyway.

>   $ git show HEAD~10:Docum<tab>
>=20
> and the path is completed.

But a user usually thinks relative to the current directory, not to the
project's root.

But I should check the archives before any further discussion, as Junio
C Hamano observed.

Thanks for your input.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg7IyAACgkQinSul6a7oB93uQCfWPnu0JqpnBjwxvHJr7X6uWPP
ErgAoJz25k/vJVYAtM2/SdZlCJp1yBBH
=180d
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
