From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/8] Rename struct diff_filespec's sha1_valid member.
Date: Tue, 7 Jun 2016 23:12:46 +0000
Message-ID: <20160607231246.GB72717@vauxhall.crustytoothpaste.net>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
 <20160607005716.69222-5-sandals@crustytoothpaste.net>
 <575667E6.7030509@kdbg.org>
 <20160607062324.GA29484@sigill.intra.peff.net>
 <xmqqmvmwq09p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:12:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAQB9-0007HE-7m
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 01:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbcFGXMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 19:12:54 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41544 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751926AbcFGXMw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 19:12:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2F749282A8;
	Tue,  7 Jun 2016 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465341171;
	bh=4MQNr1b4195GzNItTs5BWfv925qf1ydaYCjFcz36vKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fm+oy5ztwuJL5c0umYtt/gpEqAhv3ClFvGpwu60toYsVTA0t/6WTbQ2RPhN/7x0Al
	 GKHHWafUYAJLRt6LMbG7tn24+SeHp+zEr7IJDDI6SiuCPHcSWJKmOUzZ7HZtEc64aH
	 /AzB2+UvGwsj52AZ30oOuezuCMzfo9kuKfKHFnai5dyw0STDOG+jRMlnFhMphha8A2
	 X4hFFPaCXXKUQ+muQBGRztmbYgVVWHOSXj5peBLdHc6w15Bi3up37AqseMcgL4RFWm
	 +L29V1WP+NfUs7DVnj25C1Yph5kp55axoTsRrP4/xMhlgf5uXavPPYosLOslsKRHh+
	 +dpGjt6lCNAHdb4DgqQO6ACYV0nXduc6PxGe+ozYANN1KsjytxyO+oodK/jDKZFwd1
	 yJ+TXawbxHMtsQKpArA3+oqo5S+jtdz8QKOczMJhVFUMk19wcF/uhRD9TqPe8yUUz0
	 VCHLxKPbSRC0hLD41rVQT3DEHE7RAiaaI1vMA3qqDF4u8/29fwp
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>
Content-Disposition: inline
In-Reply-To: <xmqqmvmwq09p.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-trunk-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296749>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 12:14:42PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Tue, Jun 07, 2016 at 08:21:26AM +0200, Johannes Sixt wrote:
> >
> >> > diff --git a/combine-diff.c b/combine-diff.c
> >> > index f39be434..a20caa80 100644
> >> > --- a/combine-diff.c
> >> > +++ b/combine-diff.c
> >> > @@ -1269,7 +1269,7 @@ static struct diff_filepair *combined_pair(str=
uct combine_diff_path *p,
> >> >   		pair->one[i].path =3D p->path;
> >> >   		pair->one[i].mode =3D p->parent[i].mode;
> >> >   		oidcpy(&pair->one->oid, &p->parent[i].oid);
> >> > -		pair->one[i].sha1_valid =3D !is_null_oid(&p->parent[i].oid);
> >> > +		pair->one->oid_valid =3D !is_null_oid(&p->parent[i].oid);
> >>=20
> >> Is this transformation correct?
> >
> > Or the oidcpy() above it, which was introduced in patch 3.
>=20
> Indeed these look wrong.

Yes, those do look wrong.  I'll figure out where I went wrong when I
reroll.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.12 (GNU/Linux)

iQIcBAEBCgAGBQJXV1TtAAoJEL9TXYEfUvaLh9gQAJqu4YVRM07e2ANWnQHpvEkM
CXJVFVUfuOga/751Hi42LYp+2pZdFjoUzvkmgHoYIqEKq9snleVJhNgLqD5Q9Sd8
ozCLHn+urFt95nHD7flj1loOD+xYQaks8y2az1K9Hg0ECXgwactaZ3s6g2cMYCWK
sgh3QhgNG8BXAqhyg9drzYrED6ynu1CovfkmgQyItbWNTGiRpfVuYgxFjObbJtp/
kn2/w+u+H1tiL8F9zlZv/6YXxcs1BYtbfJQ7eApJEw5iJEti2m1JToV5hp+j3wv3
dGjYBhKI/NqFOrwioRn+eEJ9Oo8XoGhYQ0Qv2Wb7j1d/oH8JH+qknqrh/x0Ve21h
9mZrMwRxUg2yy5LrSP7R78iZ8nceR0stkQBM3jGqCGntc/wOVf4lFt5giYffMrug
KIRRaHC6NiyMbjxtEevpPnppiiltb5bh1RzoRrOb1tZBIVqDejuTasIKaZRIUlL0
Ra8BdYei1jMZSUn26/Gm+ayWmeyfIcg8d9nZYAg+uOw0TXf3vLJo9uqhjMAn/zPb
buABg4QEpwj292arIWpmN1ABlU2hulkfyd1r6DI2D1BwcKJGgkIqAKN6Hy5TOb7U
1rqvvTck/KfnNWMUE2DBkvgUhwrQLaefEmxzUzKkdSmpKjmH8MoDt27W3x0qJygH
pXX2dxbUOUXYduSqyXr0
=ThGg
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
