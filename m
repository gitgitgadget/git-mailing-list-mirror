From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git merge: conflict is expected, but not detected
Date: Fri, 29 Nov 2013 18:37:40 +0000
Message-ID: <20131129183740.GB57602@vauxhall.crustytoothpaste.net>
References: <CAO6Ho0d=JHk4ydd1PdcWP1XHxvXpjfYVK+B_QLgd0vpyFTh_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Cc: git@vger.kernel.org
To: Evgeniy Ivanov <lolkaantimat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 29 19:38:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmSwy-0005ze-03
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 19:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab3K2Shw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 13:37:52 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34301 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752741Ab3K2Sht (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Nov 2013 13:37:49 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f85e:b702:8063:7207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AB5CE2807E;
	Fri, 29 Nov 2013 18:37:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAO6Ho0d=JHk4ydd1PdcWP1XHxvXpjfYVK+B_QLgd0vpyFTh_xQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238532>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2013 at 06:26:25PM +0400, Evgeniy Ivanov wrote:
> Hi!
>=20
> Let's say I have two identical branches: master and topic. In master I
> remove some code, i.e. function bar(). In topic I do the same (commit)
> and after some time I realize I need bar() and revert previous commit
> with removal.
> So I end with master with no bar() and topic with bar() in its
> original state. When I merge I get code without bar() and no merge
> conflict (recursive or resolve strategies). Is it possible to detect
> such situations as conflicts? When bar() is C++ virtual there is no
> possibility to catch this with compiler.

I don't believe so.  The problem you're seeing is that by default, git
considers only a small set of points for merges: the heads of the two
branches and the merge base.  So if one side has changed but the other
has not, the changed code takes effect.  This is not specifically a git
problem, but a three-way merge problem in general.

If you rebase instead of merge, then the code ends up the way you want
it, but this may or may not be appropriate for your workflow.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSmN70AAoJEL9TXYEfUvaLI38P/Rhp22QVzt7QmLL+sVM9Sg2l
dRSZcjC9NTAfgqhLQjb3bOx2dUk3LiuU9rc/lBiOxWzwIfeXCvHK4//t/aHUGm7j
yEEok9ale05zjaxAZCqHf3fFfaI/jUgB5jw3GfKV0cEe6GKiCNnqudMCX0X/vtVG
AAr4fwyNjHC0r5RhrDTaoMFMs1qfxo+x3njoa4bFU6d9qLLFZ9bkX+E7MqbhQ8T0
ALLqR/7mMiVPJW9WU8LUJh9Lz0xTzOxvIWkifgcslnny9+JQcgUNa1H1UIR7vqma
grk2kqov6w8GDndvQnaarmX9LdEuPastvCAirQQVqL1JdpNFQj2a32wDTA+bJvyu
Zbm8V2Muvp3TtrvNRn1kozYrr97obysM41HWymCoMcXgK9KfH+XxGnPZ6f391kI8
x6/tzyC818wFCcx39dlKrwwbn3F1VK0OzMrQzHHR/5FxshuEiPDC1Dw2e5bbY8co
NQE28hZr7IdtXd/Ohk6W8gKlvNNHo+EeSgT960gFeSRZPzK8M3TaEyfpvS3Bc/+9
T6ColQFVROvRb+uRWM8R2hJUpC/yKro6p4o6C44s9eCc6Y1pcTyoVpeIR49eXQnP
Vcn+tkebd2VvdE6lHOGETQwO/uJ7Nfw2rJm3HkJNlHojh9SqECpe/kDiKBhyC+Kj
bi25OynwHrjbzug7Jl9q
=5em5
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
