From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with
 ignore=all
Date: Fri, 6 Sep 2013 00:19:46 +0000
Message-ID: <20130906001946.GC5359@vauxhall.crustytoothpaste.net>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
 <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
 <vpqa9jtayiq.fsf@anie.imag.fr>
 <52279ACC.2070308@web.de>
 <vpqioyf231e.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	jrnieder@gmail.com, judge.packham@gmail.com, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 06 02:19:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHjmH-0000OL-Nh
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 02:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab3IFATx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 20:19:53 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60100 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752944Ab3IFATw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 20:19:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A046C80001;
	Fri,  6 Sep 2013 00:19:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <vpqioyf231e.fsf@anie.imag.fr>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234008>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2013 at 08:30:53AM +0200, Matthieu Moy wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
> > Am 04.09.2013 08:31, schrieb Matthieu Moy:
> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >>=20
> >>> Tests are included which verify that this change has no effect on git=
 submodule
> >>> summary without the --for-status option.
> >>=20
> >> I still don't understand why this is needed.
> >
> > To avoid a change in behavior for "git submodule summary", as that
> > never honored the submodule.*.ignore nor the diff.ignoreSubmodules
> > setting (and I don't think it ever should).
>=20
> I don't get it. If the goal is to keep the old behavior, then "git
> status" shouldn't be changed either. Fixing bugs needs to change the
> behavior.
>=20
> IOW, why was it a bug that "git status" showed ignored submodules and
> not a bug that "git submodule summary" did the same?

I looked at the tests, and the tests expected git status to respect the
ignore settings, but there were no tests that expected git submodule
summary to work this way.  Perhaps this is a failure in the tests.  I
got feedback that git submodule summary should *not* change, and nothing
until now to contradict that.

If the decision is that this should change both, then fine, I'll reroll.
But it's not reasonable to keep going back and forth: we should make a
decision and stick to it.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSKR+iAAoJEL9TXYEfUvaL/EoP+gLnwAlHSxAlkrawZyZjpBTz
QAEkRExQ4D9vsZKPQweBDQq8EUiFauQzouW9YJ2pqWREaFrNrW5vpYbmN9Dd2C+K
f9wqZxkSzdJYLa4YyuD5YJRVSESpvxt6/3ROoitLyoXaTYPB5ct4VXQqDdA5FxSt
Ar8sLdzSPWJmspubfgAK+wrp+sMNKoxNkn4l7vtbqH/w5SYMHF1OZ49VKeyOo+4J
0LW4VD6nd5r/qWWmTaOsIS5QPeRnykxZTkopKZVD5BuF7nBw6pbdiGSZ4mEko7lT
VHRfLTQjqG+EAWOxzgIqgsjIS5Qm21B8S4/muhA5ifgtb4xTHqepTdG/7veEr8A4
5jghdAFpm3Jpndcx1N5KicPSpRKcvIRNgOeDdBY6mzjrG8V8+zBZLJFJ2qxlMKYk
rF3HK6U+/cbDnidzwUivAIywc07tyIWRlmE2vUyDN3p5Elu0ZBqQDEO0QL9BrGBe
GryyHFKV0GCcSJ70KsoJVbmZ4j6t9QPw14m61uvKXHSKY7lHO0Z2mFfDi3ngdxLx
bYNOyHxu7WDEIe0Ef6G3T7tMq8hhzx6i298OADpKl3qXT746p2QYB4+6tuwcgZ8B
JJMpgVR1CZgajDunrmYPYiBQme5yg/gzVQ6bjr/R5FsVwMHO+RjUqcVFEaR22ypV
rTqh/HJK4XM0DwuwgrAv
=Qrba
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
