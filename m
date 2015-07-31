From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Jul 2015, #07; Mon, 27)
Date: Fri, 31 Jul 2015 21:37:17 +0000
Message-ID: <20150731213716.GA488564@vauxhall.crustytoothpaste.net>
References: <xmqqpp3dgurr.fsf@gitster.dls.corp.google.com>
 <20150730002925.GF809807@vauxhall.crustytoothpaste.net>
 <vpqoaiu9dci.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 31 23:37:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLHzh-00074u-Lq
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 23:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947842AbbGaVhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 17:37:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34601 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1947833AbbGaVhV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2015 17:37:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:48ea:e153:11e5:6f04])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AEE2128295;
	Fri, 31 Jul 2015 21:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1438378640;
	bh=krmbBW/WGupDWmaBSYABgv8ikWQBfh40Lk04llgdTZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOCxcN8R4SQWrAGFjjkGq4LRHzpML9HCJ8AA3MlyTqOHjoGXER6SX8+MdaYgBso8k
	 /fcRjZ+iZ40UJ0J19bWHWqEQjM2DTH7Xaoh0v8YCFlEMXKZA11FIUSm2aesSkqjHzX
	 +LnxD5he/lqhM1JRfqdJAYDqSqpWXK4hS2KNsqnqBSh/LSXnllBirsEkPedGauSzfE
	 ZvzMoxBXsh40fSwRrvZ+mbixayrcwua25EHOwoPmMXs8C8VkvzRFp2qawQxfG63sGZ
	 u3zSJUoc8zq1kiC/oaFqKnXl5pTngXVuyi66lvzeWT23H+XMKCZpSMEMqb9CUGTZ59
	 L5mu0n9qQUUFuByCFdIBKOhdVFCUY3yGDSBOZEqTBUNnWbSTkDms1pSrjtuBcrJHmz
	 u9cowJ+dOZ8khdtLtRJwm3WRRwV6mL0NTDXVuCll2zsLgVNZCnXm3K/sg5Y8ErjJsT
	 sRn36r9mZUOwQ3k7LMUL4RjbI+6G+eog8wNA6p5DrX3J4jaO6il
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <vpqoaiu9dci.fsf@anie.imag.fr>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-2-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275080>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 11:58:05AM +0200, Matthieu Moy wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On Mon, Jul 27, 2015 at 02:23:04PM -0700, Junio C Hamano wrote:
> >> * bc/object-id (2015-06-17) 10 commits
> > Is there anything I can do to make this series less painful (e.g. a
> > reroll or such)?
>=20
> For the GSoC part, "Suggested 'pencils down' date" is August 17th. The
> "Firm 'pencils down date'" is on 21th, so things should stabilize.
>=20
> On the "unify ref-listing commands" side, the big code movement is in
> kn/for-each-ref which should hit master soon, but there are other less
> intrusive series active.
>=20
> (That doesn't really answer your question, but may be relevant
> information)

It's certainly helpful to know the timeline.  I'm fine with waiting, but
I anticipate that there will be pain when it finally goes into pu, and
if there's anything I can do to minimize that, I'd like to.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.6 (GNU/Linux)

iQIcBAEBCgAGBQJVu+qMAAoJEL9TXYEfUvaLbJ0P/1DUQZNLZV06J1rErh4zXLsA
cK9a3su4ozmx0f+UzpNwo/VrvGLr5MsF+p3ctXm3S7RlcXpA/Gy0atRnEgsZMqa4
twBhbj7k3IUXJOQAEj8ko8eSK0y8QcJrYN9KO1TQ8ESyq0ynZPPnuOWHN2nmFwzP
P2oq2JhEVDWezNy+orNlJ0/WfV2wBpROxYNQbcBgFqLY3JQ3ZU9iG564mf6qxwDv
ei1jzSao49z4pibdXzM+IOsRSon6aHsQ+kEP/6NqMEHu8IABVkE3ELSFPzYGaA+P
t19wZ2d0uW0J8mR9ewxtSaTsx5yB2R1YMZnn0sJiHQ/l+gxu8SVNVP9rUCxW6OUD
nM2ieL8C586FEL1Aoy3+L3aC/Wo3mw+HfJqump6OCh2AyiIbW9tj599eKNvXvKHU
ZkQuFv7Y41FjG0ydFNMUanufj+IEqu2IoT0YlKquXl5s2AKl13Pqtor7GZbTqDsN
sKc3SF6Yy3/bSHBB6WtEVyj0gR+yQBi/SRwY2aJ9crh452rkqMMHBW1jLUhSq3lz
Pd4zBLUGWAoWPXWalmkEb0vTc4Inms279oHW6GtvxWT0SNJXMXpJFQOIuur0jKWl
q1wFWoIsle611BS/T4d1ZEZogriSwkGeiSnXqOJwPDhcyjjSQZPenFFoG80oYaGb
6xzv5XdhX6t7R0fhsC4/
=GSj9
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
