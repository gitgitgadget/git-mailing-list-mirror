From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 12:47:38 +0100
Message-ID: <20080313114738.GC2414@genesis.frugalware.org>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9hshNW4m6zn79FF/"
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 12:48:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZlvH-0001Xe-Mo
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 12:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYCMLrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 07:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYCMLrl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 07:47:41 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49919 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbYCMLrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 07:47:41 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DE75B1B258A;
	Thu, 13 Mar 2008 12:47:38 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3737744659;
	Thu, 13 Mar 2008 12:44:50 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B5D6A119053C; Thu, 13 Mar 2008 12:47:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77063>


--9hshNW4m6zn79FF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2008 at 11:48:53AM +0300, Alexander Gladysh <agladysh@gmail=
=2Ecom> wrote:
> I want to create a private GIT repo (without working copy) on a
> machine in external data-center. While I do not actually believe that
> it is possible that someone who has physical access to a machine would
> be interested in peeking into my repo, I'd like to play safe and to
> have this issue covered.
>=20
> Please advise what is the best way to do it. Are there any existing solut=
ions?

i don't think but you can write a wrapper around git receive/upload-pack
and use (for example) tar+gpg to keep your repo encrypted on the disc.

--9hshNW4m6zn79FF/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH2RRae81tAgORUJYRAgPFAJ9OqbUqWxxBHdp2aPrUGUDrGQefPgCgoZyh
9sP/gNYygUdetmE75c4/o44=
=8ZJm
-----END PGP SIGNATURE-----

--9hshNW4m6zn79FF/--
