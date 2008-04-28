From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git submodules.
Date: Mon, 28 Apr 2008 23:01:39 +0200
Message-ID: <20080428210139.GH26880@genesis.frugalware.org>
References: <1209412220.29267.22.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:02:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqaUz-0000aA-0f
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934908AbYD1VBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933541AbYD1VBn
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:01:43 -0400
Received: from virgo.iok.hu ([193.202.89.103]:53085 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965050AbYD1VBm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:01:42 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7A52F1B24FB;
	Mon, 28 Apr 2008 23:01:39 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0066344659;
	Mon, 28 Apr 2008 22:57:58 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 14F0E1190AC9; Mon, 28 Apr 2008 23:01:39 +0200 (CEST)
Mail-Followup-To: Victor Bogado da Silva Lins <victor@bogado.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1209412220.29267.22.camel@omicron.ep.petrobras.com.br>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80611>


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2008 at 04:50:20PM -0300, Victor Bogado da Silva Lins <vict=
or@bogado.net> wrote:
> Is there any documentation about how those work?

Yes. There is a chapter in the user manual and there is the
git-submodule manpage.

> What I need is this, I have a already existing git repository, that have
> a subdir that could be seen as submodule (by this I mean that he is
> related, but could have a different commit tree). The git repository
> already exists and has many commits that apply to either the submodule
> or the main module (I would say that there is no commit that touch
> both). So is it possible to separate them easily?

Yes, see git-filter-branch.

> Would it keep my older commits?=20

Not really, git-filter-branch will rewrite history, so the commit hashes
will change. Of course no code will be lost, but after such a migration,
people will not be able to easily just pull.

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgWOzIACgkQe81tAgORUJbMQgCgmxotsJ4BFIoXb/bTOaytnFw1
hPQAnjgifMEsns7BsvyEJ0TQtR0CyCsE
=dyOp
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--
