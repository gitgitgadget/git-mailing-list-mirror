From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: A local shared clone is now much slower
Date: Mon, 8 Jul 2013 14:25:03 +1000
Message-ID: <20130708142503.a95bd540f157569654f8ac39@canb.auug.org.au>
References: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
	<CACsJy8BG0i-ncGTJ+9YkN=R1v6WOqF3MJkv_+572=eDjm-ug1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__8_Jul_2013_14_25_03_+1000_f.t6Y0KHQzSEmCHy"
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Linus <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 06:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw30z-0001vW-VH
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 06:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab3GHEZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 00:25:20 -0400
Received: from haggis.pcug.org.au ([203.10.76.10]:42961 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab3GHEZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 00:25:17 -0400
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by members.tip.net.au (Postfix) with ESMTPSA id 0A395164063;
	Mon,  8 Jul 2013 14:25:09 +1000 (EST)
In-Reply-To: <CACsJy8BG0i-ncGTJ+9YkN=R1v6WOqF3MJkv_+572=eDjm-ug1A@mail.gmail.com>
X-Mailer: Sylpheed 3.4.0beta4 (GTK+ 2.24.19; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229824>

--Signature=_Mon__8_Jul_2013_14_25_03_+1000_f.t6Y0KHQzSEmCHy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Mon, 8 Jul 2013 10:20:22 +0700 Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Jul 8, 2013 at 10:03 AM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> >
> > So commit 0433ad128c59 ("clone: run check_everything_connected") (which
> > turned up with v1.8.3) added a large traversal to clone which (as the
> > comment said) makes a clone much slower.  It is especially noticeable on
> > "git clone -s -l -n" which I use every day and used to be almost
> > instant.  Is there any thought to making it fast again, please?
>=20
> It's done that way as a security measure against repo corruption.
> Although I wonder if we could do connectivity check in background
> instead (reports are stored in .git and picked up by git-status). The
> same mechanism could be used for "git gc --auto". If the repo turns
> out corrupted, the user may lose the last ~10 minutes of work, not
> really bad for the speed trade off. This mode is not the default, of
> course. The user has to be aware of the risk when choosing this route.

Thanks for the explanation.  Now, is there some way I can turn it off
just for the local shared case.   In my case, I check my repo regularly,
so don't need or want this going on while I am working ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__8_Jul_2013_14_25_03_+1000_f.t6Y0KHQzSEmCHy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR2j8lAAoJEECxmPOUX5FEzTIQAKBliBg7CdJsT2rxkOq2KwKt
GlnBr6+/gxPLZdYHeSqWZlTKgQDtCWySRhH91Wtw3Lh4TSAFwWRnMyi7KERhZ6Is
3giwJd0NyWGtFC+MujlSI7g1Kn2zP3d8Ezd0ulB8ZWjIXFtWLH6RMxCKbixVhRLC
zKIgA8oykCNy7S/9Sl9rfG0njljfdJiXcuEFjVgrt9EW6N0h+GRix4M32eUU35wn
YACDoycrWrJtLfahmqQ7y8XX7RiutmVSn1IQpABYxLwlUZTjnHL5D1KRwXJZpcMc
4WTl893tez9n+t28+bSkjFrTZ0clMvMc9U4aeER7uQf6b1SU2CwvCF5N/ZTWfccU
Nuu6mEZkrW/sH+ZlA15OTzSjeniRuJhyd55iuNuQkW6Mk8yBpg37InLRDDYnH3sa
BIiawKjG5kxJwW4Ye0uv1xDS5MOTLKnsv3tEWg1zMligNkj4AE0bHgIRrdLIY44B
Iwl5v5nP+k3d+XXLLcMXfCvVmPtwWsq5EFx2w/a6b1CbBtE9bEtt7hl2qolJkmBM
gcraFfVyr+lAwQpRF7soBlqQqk9gp39vhC3afVgFmX1WdIsM2Zc2/HYaNVK8OVoN
Ukb2BvlzMSY75jWOtZ4sm/Rs2w1tuazGTHWaZzvWh16erC5jKFy1XoG/TrF9pVw4
yi2YeG3cVjxqWPZLgB4/
=KJEB
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Jul_2013_14_25_03_+1000_f.t6Y0KHQzSEmCHy--
