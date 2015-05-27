From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 00/56] Convert parts of refs.c to struct object_id
Date: Wed, 27 May 2015 00:04:37 +0000
Message-ID: <20150527000436.GA4342@vauxhall.crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqa8wsbgd8.fsf@gitster.dls.corp.google.com>
 <20150525194007.GH26436@vauxhall.crustytoothpaste.net>
 <CAGZ79kbxrPhcMUFx3OY1s_qk4TkUcBgscDwqSvrLtDXmF1YwWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 02:04:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxOq6-0006Q3-S5
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 02:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbbE0AEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 20:04:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52180 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751759AbbE0AEt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 20:04:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d998:91e:96e8:cc94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6F4122808F;
	Wed, 27 May 2015 00:04:42 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <CAGZ79kbxrPhcMUFx3OY1s_qk4TkUcBgscDwqSvrLtDXmF1YwWw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270007>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 10:37:29AM -0700, Stefan Beller wrote:
> On Mon, May 25, 2015 at 12:40 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Mon, May 25, 2015 at 12:34:59PM -0700, Junio C Hamano wrote:
> >> [PATCH 01/56] was authored by you but has Michael's sign-off, which
> >> looked somewhat odd to me, though.
> >
> > Yes, it does.  He picked it up from me, and signed off, and I took his
> > branch.  I don't believe he changed it, but I didn't check for certain.
> > So technically, although I wrote it, I also received it from him without
> > changing it, so both (a) and (c) of the DCO apply.
>=20
> At least in the kernel, the sign offs are also used to track a patchs way
> of life, so essentially whenever somebody touches that patch (either as
> an author, or as a patch shoveling sub Lieutenant), you'd add a sign off.
>=20
> So if we were to handle the sign offs just as the kernel people, I would
> have assumed a sign-off block like
>=20
> Sign-off: you
> Sign off: Michael
> Sign-off: you
>=20
> as that would indicate that Michael did not author it from scratch but
> based his work on yours. That's just my understanding of the sign off
> process for linux and I guessed we'd follow a very similar process. But
> no objections from me regarding the signing.

If Junio would like to add my sign-off to the end, he's welcome to do
so:

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVZQoOAAoJEL9TXYEfUvaLXsQP/izqVAiZYMSfYPooIqsRdq8m
Grn9bMRj1yH+9xSAWCkB/5SXUX2pXWqSyci3vzKpl/CHa9cljKBtDQ0OQ7tlUrbB
UJmErPCHSN5xYDc2Vpaehxf/GbPuNd45MHgMtlmQ/4/9h5nw9bNFXl6bwCdR2vUv
k5MvwOD0OfAKz8Avjx4d6PmHSnVckhjLXkCVnWSK/TZD1eyvg3q2tiibklbMl2Gl
CXRVmIAnMO/wlv8n5fEySILpGFAwZUiku8/c5RdCiCtuVN/k0Pjqyfctr6V6nXKP
o7HN/9RCId7/ToGmwuqjm0+c2MJL1OFZhyiMRp0v6KKtQ7JnV2Ihb1fvRG8KdXYz
dz24hF9CHtu23N6/V2hIHpfxrl1TpmBeYmyBLEjZDMyWyzot49lff9gc/vE38ljG
4RCQ/UIDBbuaaSmVDbb1rPSTdWxrqhSk8gzkxBgvT7/kW2OD+aZKks5jyHQ2A9Iz
Am3sm4qwKweSIvOuZFWUK2I1HguaCZLEqmlNVgxP2bzsUhCQpIUN3ax1AuXYYxXn
X3Al+4I2bH0kMNKT6cw35rwPLV1Ha+vWOPjCV9BoWzMCRAOHMl4FDfil6DscRvjE
bJX6RaX2LN7T6sA/Re6gpKzWVVNtFBpn7bkh/QSrKF5cAqMJUgSgs8m3rgwPMLN7
niymhLyK36k7dr4vdXgE
=GP0d
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
