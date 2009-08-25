From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: rebase hint unmerged file removed
Date: Tue, 25 Aug 2009 10:11:46 +0200
Message-ID: <20090825081146.GK5929@genesis.frugalware.org>
References: <20090824140549.GA3973@debian.b2j>
 <4A92A6E6.5060702@viscovery.net>
 <4A939455.5030908@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8QANErTbuLtKTfKg"
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 10:12:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfr8T-0005sB-Ti
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 10:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbZHYILs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 04:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbZHYILr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 04:11:47 -0400
Received: from virgo.iok.hu ([212.40.97.103]:53085 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694AbZHYILq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 04:11:46 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6F8895808B;
	Tue, 25 Aug 2009 10:11:46 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 21316448FB;
	Tue, 25 Aug 2009 10:11:46 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3F24D11F04A1; Tue, 25 Aug 2009 10:11:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A939455.5030908@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127014>


--8QANErTbuLtKTfKg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2009 at 09:35:49AM +0200, Johannes Sixt <j.sixt@viscovery.n=
et> wrote:
> Ok, I bisected it to 6eb1b437 (cherry-pick/revert: make direct internal
> call to merge_tree(), 2008-09-02), which is part of a series around
> merge-recursive: 1ad6d46..ed520a8
>=20
> The commit message says: "One regression is that the status message is
> lost as there is no way to flush them from outside the refactored library
> code yet." But is it intentional that these messages were never recovered?
>=20
> BTW, I miss the messages a lot, too, but I'm unfamiliar with the code in
> question to try to do something about it.

I do not remember too much about this. The point of the commit was to
avoid fork()ing a new merge-recursive process, that's for sure. I tried
to search back the archive to see what was the interdiff between my
patch and Junio's fixup, but I haven't found my patch.

I think it's possible that I was not aware of this limitation at all and
just Junio added it as a note to the commit message, but I'm not 100%
sure.

I also think that it's possible to modify the library code to be able to
flush the status message outside the library, but I can't really send a
patch that implements this right now, due to lack of time.

Sorry,

Miklos

--8QANErTbuLtKTfKg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqTnMIACgkQe81tAgORUJZzHQCfW42QgPCWzKCY2LbOcKYqq5M0
86YAn0hUbWJWCIWo6gD8uPvDvNWRWkpt
=j8TQ
-----END PGP SIGNATURE-----

--8QANErTbuLtKTfKg--
