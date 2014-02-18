From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] revert.c: Allow to specify -x via git-config
Date: Tue, 18 Feb 2014 18:38:43 +0000
Message-ID: <20140218183842.GA163138@vauxhall.crustytoothpaste.net>
References: <20140218065620.GA3448@bogon.m.sigxcpu.org>
 <20140218174913.GB7855@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Cc: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 19:38:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFpZJ-0004ee-GG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 19:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbaBRSix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 13:38:53 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52022 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbaBRSiw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 13:38:52 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d86c:b4e1:ccc3:cb33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E6F9628074;
	Tue, 18 Feb 2014 18:38:48 +0000 (UTC)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140218174913.GB7855@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242336>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2014 at 09:49:13AM -0800, Jonathan Nieder wrote:
> Can you say more about the context?  Why is it important to record the
> original commit id?  Is it a matter of keeping a reminder of the
> commits' similarity (which cherry-pick without '-x' does ok by reusing
> the same message) or are people reviewing the change downstream going
> to be judging the change based on the recorded upstream commit id?
> (Like linux's stable-<version> branches --- but those have other
> requirements so I don't think this configuration would work as is
> there.)

I can provide a use case.  At work, we merge into the maintenance and
development branches and cherry-pick from the maintenance to the stable
branches.  We want committers to always use -x -s because we need to
know which reviewer backported the change and we want to be able to
track which commits have been backported and whether any reverts also
need to be cherry-picked.  We also have automated tools that want this
information.

I usually solve this with an alias (backport =3D cherry-pick -x -s), but I
can see how this might be a useful option.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTA6iyAAoJEL9TXYEfUvaLED4P/A5FDYzj0pylAVWv0oOu9rql
F+iLMvKqPE8CCcYag8MseIAT3wboeeq2f8B5KOopP8l+yfiCBQpYHm5AaJjlkDg+
P7wvVuZgJ6jTF+N0dPKHE5ZIiTT1M2LgY44ot9ekPZfG+79MRBV/JySVilRB2POU
mkBqR5a3KQYuj3xUC5MoqshajHp3h3OXCoufrBUcS7gzuVMR2Pnuijl4g9cyZwGy
tNjpsuh6qUCAJOCZeLgX2QbWP1AD+JXXX+lzPTv8ENFhDV8L51aQyYyBtK+MIhyP
DYSs2hrXO+u5CCi0FMUSHHuNcYod4d5hbXjX2MqyeSUAqxoOXHKE25llig4MRzaq
YFvP6OF47MxStaZs+0PuO5sE95G7yemDm7xTyZ5BrBu2Dl1xATBJF868fZPk7Glg
R0I1oZP19atEAsWGCl65v4k6RZTTz/cluTsw5ycjitVVivWuWQZD/FSoXiYUqu6T
Id/UgpNb56ENSXyPg56m5QNQj/OSPyGv991zZlPd4ivOd/0YozmhNNHAtiXFAYwM
7vICZgFu8Dxhzzf65jwRiE+JPCeTKInnlOzRZ9eV5320lsvjsPDhWCFOxPL/MvUi
0+NpwUFgsp6FCLZ1wAAI1EaKVRL1hpUCrYyk56oBCULKtBRINT30g6z9wQI5ftNr
lR/VjYaSo717toDOdOXD
=eI1d
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
