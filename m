From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: t0005-signals.sh fails with ksh
Date: Sat, 9 May 2015 20:01:05 +0000
Message-ID: <20150509200104.GB225482@vauxhall.crustytoothpaste.net>
References: <31108626.20150508231514@gmail.com>
 <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
 <20150508205548.GB13457@peff.net>
 <xmqqwq0iixcs.fsf@gitster.dls.corp.google.com>
 <20150508212146.GA16614@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Cc: Junio C Hamano <gitster@pobox.com>,
	evgeny <illumsoft.org@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 09 22:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrAw4-0005Rw-H8
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 22:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbbEIUBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 16:01:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34201 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949AbbEIUBL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 16:01:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:7d3a:6691:d1f:cd1e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 432462808D;
	Sat,  9 May 2015 20:01:09 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	evgeny <illumsoft.org@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150508212146.GA16614@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268709>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 05:21:47PM -0400, Jeff King wrote:
> On Fri, May 08, 2015 at 02:16:19PM -0700, Junio C Hamano wrote:
> > I wonder if zsh is in the same league.  Do we support people who do
> > SHELL_PATH=3D/bin/zsh and bend over backwards when it breaks?
>=20
> I tried "make SHELL_PATH=3Dzsh test", but had trouble seeing the test
> output for all of the errors being spewed to stderr. ;)
>=20
> Certainly this:
>=20
>   $ zsh ./t0000-basic.sh -v -i
>   > [...]
>   test_cmp:1: command not found: diff -u
>   not ok 4 - pretend we have a fully passing test suite
>=20
> is not especially encouraging (it looks like running "$FOO bar" does not
> word-split $FOO). I am not a zsh user, though, so there may be ways to
> convince it to be more POSIX-y (e.g., just calling it as "sh").

I use zsh.  It's possible to convince it to be more POSIXy by saying
"emulate sh" or invoking it via a symlink called sh.  However, having
said that, I don't recommend it.  I set /bin/sh to zsh on my Debian
system and a lot of things broke.  Early versions of Mac OS X did that,
too, and they stopped because it was very broken.

As for ksh, I don't know whether you want to kill support for just ksh93
or mksh as well.  I've generally had good experience with mksh as
/bin/sh when I've tried it, and it's at least semi-supported in Debian
because it meets Debian's POSIX-plus requirements.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVTmd4AAoJEL9TXYEfUvaLnPsQALbKJGNhzKnkfW3oYMHtDopk
kFDKqfNYpkkmeFYMpQVr4bSrq0mspvjyM7rUglhuaJIyv3bIGiDGvgsTUMnDrQ5x
I6qSQoQtlqkjLaFwcKvqVf5XrNqE2cfBXXnHfF1EnoWKL4pM4ZNbkb+vWHCzdd6B
irDmtQFkCwjVK+WrD3GzBS5VEKgcQeC8fTGpKyqKygl1f/9gsY6KUqqjocjLyDqn
FCJ9grYqXJ3GrCV3UAMH5uj39KUjo2UJglGey2j4mjVmIHLz6B+/16RPkpO/HmDI
WS3CGPfze/yJNVjuvGwHjranBdnqVIrDar7EJJdEnfBDnHT/yZRXpL5JTVfRRcvd
a5NL1OzmkG7B65liY94zskBZtj/73Gp9RV0JlDiYZFP4Ru+qXoZf9CCn6Fm8tReF
95DmCe+pkmN3SSaqIKMqF8+xs+ikchyLeE+zF14b3vt0ITbyF/npSqbrkydjgXDx
g1guuGHeqwBTEW6E4CM+EtdNgsHpgH0NrTjdkuyktxWbfIJbIdDHVALi/PjESAVD
V9LT1DNZUMqbz+/0Yq4txIhs8XfpTdjg5hy0HlNkixF1gaLi/l9LYZ3WLuRpzbkG
AFVkn3kwtrGf/eFV7n//Kokjc6bcBGAcjlFAgFaCHCuJR0HsA4FOPKOOvpqFIjUW
L10fmLIhu3V8GNG19FG1
=VrHV
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
