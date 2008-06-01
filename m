From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH v3] perl/Git.pm: add parse_rev method
Date: Sun, 1 Jun 2008 23:54:49 +0200
Message-ID: <20080601215449.GC29404@genesis.frugalware.org>
References: <1212241932-28605-1-git-send-email-LeWiemann@gmail.com> <1212290243-19393-1-git-send-email-LeWiemann@gmail.com> <1212290243-19393-2-git-send-email-LeWiemann@gmail.com> <4842DE78.7000006@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re7H+V5lQR2Zv/pu"
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 23:55:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2vWi-0003I5-8O
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 23:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbYFAVyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbYFAVyv
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 17:54:51 -0400
Received: from virgo.iok.hu ([193.202.89.103]:41858 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbYFAVyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 17:54:51 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 961A91B254C;
	Sun,  1 Jun 2008 23:54:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AA5EB446A9;
	Sun,  1 Jun 2008 23:37:33 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 198C31190A46; Sun,  1 Jun 2008 23:54:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4842DE78.7000006@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83471>


--Re7H+V5lQR2Zv/pu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2008 at 07:38:00PM +0200, Lea Wiemann <lewiemann@gmail.com>=
 wrote:
> Terminology question: Is there *any* kind of agreed-on name for the=20
> identifiers you pass into git-rev-parse (like HEAD^2 or=20
> master:test/foo.txt)?  I called it "revision name" before, but that's wro=
ng=20
> for the "...:<path>" syntaxes, and "object identifier" is reserved for=20
> hashes only (according to the glossary).  If there no better suggestions,=
=20
> I'll probably go for "extended identifiers", since rev-parse --help calls=
=20
> this the "extended SHA1 syntax", and it also seems to be an unused term.

`man git-rev-parse` calls them "revisions". Yes, even the commit:path
ones. So I would use "revision", or if you introduce a new term, I would
strongly suggest updating not just the glossary but git-rev-parse.txt as
well.

Thanks.

--Re7H+V5lQR2Zv/pu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhDGqkACgkQe81tAgORUJYICgCeOHiMDGNxku8Nt7aEyzvpTW9x
HusAoJXCndcQ75z0IKIyQ4kMBZ8rU3/O
=YqtP
-----END PGP SIGNATURE-----

--Re7H+V5lQR2Zv/pu--
