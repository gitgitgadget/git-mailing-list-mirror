From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Pull is Evil
Date: Thu, 1 May 2014 09:46:10 +0000
Message-ID: <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 11:46:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfnZM-0002yF-RC
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 11:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbaEAJqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 05:46:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47429 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754014AbaEAJqP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 05:46:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:b5e1:3ff0:63e4:293d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3A3A928087;
	Thu,  1 May 2014 09:46:14 +0000 (UTC)
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53617877b41a9_41a872f308ef@nysa.notmuch>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247807>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2014 at 05:25:59PM -0500, Felipe Contreras wrote:
> Marc Branchaud wrote:
> > On 14-04-30 04:14 PM, Felipe Contreras wrote:
> > > What is wrong when `git pull` merges a fast-forward?
> >=20
> > Nothing.  Everything.  It depends.
>=20
> It depends on what? I don't see how a fast-forward `git pull` could
> possibly have any trouble.
>=20
> > > The problems with `git pull` come when you can't do a fast-forward me=
rge, right?
> >=20
> > Some of them, maybe most of them.
>=20
> Name one problem with a fast-forward merge.

At work, we have a workflow where we merge topic branches as
non-fast-forward, so that we have a record of the history (including who
reviewed the code), but when we want to just update our local branches,
we always want fast-forward:

  git checkout maintenance-branch
  # Update our maintenance branch to the latest from the main repo.
  git pull --ff-only
  git pull --no-ff developer-remote topic-branch
  git push main-repo HEAD

So there are times when fast-forward merges are the right thing, and
times when they're not, and as you can see, this depends on context and
isn't per-repository.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTYhfhAAoJEL9TXYEfUvaL4hYQALnN1cP1gyAwqJrpwROlUu1P
v6ROWRd+6JWWtRMPJsuJwFf7XFGhLJOUyOwt6s//rbhGktW4XGfNN+gGqp4U3xD3
GOfq/yvUV5ENbYb8Q8vZCkt3VPpGc/SOXv9DGbn6D13kh/M1bS6arBJgueyRAg29
4e6m+GSXIT7EcqLLzCDRhUKCld2upsgfa5ZYqNb0bqIJyXiak0ycxjVi8PU2Qfbp
8z22YXc6pN3bM+ABYHJr47Yndg+m+0hd63v9lcCY5ocfCuOw7Wfb4yJGsIIsX510
XFrKeeYAG586Di7g6MXs78NlbBtZX9OziffKvq7rQNCaguRX43t6c0R/H1CfsKr6
0twWZD86pvIP5XYO2U/xh299y1w+MY7FTOxb2L69JaprixyBI0jTOmd3dcJwrAa9
1RN3FA/8bt9L3pOfZeI1OZ3rMfOeTjpfUOjIeNZYE/c8nNuhzBZigB0J/uOUeD/N
XrUf06ARkAvrmp3zespfy687B4oyhujTJs3xnBVdZwD9H3L5ya5ziHsJ+QLjEzy2
w3t5yUTsxvvkM+UF3WrI4kLwHhY6xH/ESCw1IiWAMq9HY63sLgq9y3W0xP/LirPg
vD8ZnZ4jHSLx4+bnSAr1Ty6pN0vISkGi4K8inlOoAmLrKAh71eHPbijF2wrDOLeo
i6EzM2/0PEt+cjVYHMlv
=Dozj
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
