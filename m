From: "W. Trevor King" <wking@tremily.us>
Subject: pull.prompt or other way to slow/disable 'git pull' (was: Pull is
 Evil)
Date: Fri, 2 May 2014 15:01:07 -0700
Message-ID: <20140502220107.GO28634@odin.tremily.us>
References: <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
 <5364015a94900_135215292ec28@nysa.notmuch>
 <20140502211305.GN28634@odin.tremily.us>
 <53640bc1ee6eb_135215292ec95@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKtYx2Ppz7d1tORf"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:01:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLW7-0000kY-Uz
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbaEBWBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:01:11 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:54424
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750813AbaEBWBK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 18:01:10 -0400
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id x9441n0090mv7h058A19BS; Fri, 02 May 2014 22:01:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id xA171n00k152l3L3XA18gk; Fri, 02 May 2014 22:01:09 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 613B711749B1; Fri,  2 May 2014 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399068067; bh=6fkjVjj7GduF8KYIIZ4urQYU2jhsHJNfDlkUwXe3tUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VJu+VgV4FP5j/5omq9qnlY3ap7NHz85zH2Xx4M22C6My43+aPJB1KTw32NybLiY7f
	 lBtudiNK2HJRdPxHF/PfWo7Y6XgzitKop+pW3S8Vxbhes8w6oXTl2UVNbzQA0rvqv7
	 s33eJ5S/vrQisCJ1695MwkE/Dd0dcANlaPtq66NY=
Content-Disposition: inline
In-Reply-To: <53640bc1ee6eb_135215292ec95@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399068069;
	bh=v3jRB3fQB9V1RBc/0xrpOBU5qgztmoCWrm8zDyR3mSw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=lnwDv3z7i5vCF46w3LLUexi2MDQZBZR5eOXzvziXRnmIWsp0hnowqa2PFdpMR6vqB
	 /9WSYw8AEDkt+6qaObbjWOTEji5VKzysvnkw8XvlTN87SI3okUNgXAIP1Hg3sCO7kX
	 82Xbs+KO7pSPjgTIF7uBjklkc+1N8fbC+FBm8W4x6/QnmR7ZFuDC6cBemyX4Uixeud
	 nl1yookmXIfhEEeBmQYGHPfplYUW0xW/Jr8wVBDfTz8M6yAMqfnbnER52dqVfDM8/f
	 oMzJkzf+g9lhPrFTU4+AK467tMb5TtCImbbsaRgEkeK1KEB8ruHZoncAhR7uT7dvu8
	 Z6Pf8ZppGBHWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247988>


--NKtYx2Ppz7d1tORf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 04:18:57PM -0500, Felipe Contreras wrote:
> W. Trevor King wrote:
> > On Fri, May 02, 2014 at 03:34:34PM -0500, Felipe Contreras wrote:
> > > W. Trevor King wrote:
> > > > On Fri, May 02, 2014 at 02:13:25PM -0500, Felipe Contreras wrote:
> > > > > It would matter almost exactly zero.
> > > >=20
> > > > Some folks have explicit merge policies, and deciding how much
> > > > that matters is probably best left up to the projects themselves
> > > > and not decided in Git code.
> > >=20
> > > Let's make some fake numbers to see around how much this would matter.
> >=20
> > The point isn't that this is a huge flaw, the point is that we should
> > be able to configure Git to match sane workflows.
>=20
> The point is that we are tainting a discussion about how to improve the
> defaults for the vast majority of users

I've renamed this sub-thread (which started around $gmane/247835) to
avoid potential confusion/dilution.

> > The goal is to train them to do:
> >=20
> > >   % git config --global pull.mode none
> > >   % git fetch
> > >   % git merge --no-ff

Sticking to my 'no-ff' topic branch example, this should have been:

  git merge --no-ff remote branch

I want folks to use --ff-only when pulling their default upstream.

> > The 'git pull' (with 'none' mode) explainer just helps retrain folks
> > that are already using the current 'git pull' incorrectly.
>=20
> If you are going to train them to use a configuration, it should be:
>=20
> % git config --global pull.ff false

I don't want all pulls to be --no-ff, only pulls from topic branches.
I think adding a prompt or making the integration a two-step
fetch/merge are both ways to jog a user into consciously evaluating
their actions.  I don't see how a changing the default single-step
pull strategy (whatever it is) will.  I also don't look forward to
explaining an adaptive strategy that tries to get my workflow right
without command-line ff options to folks on their first day using Git.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--NKtYx2Ppz7d1tORf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZBWhAAoJEKKfehoaNkbtWDMP/RfpdUZu67ztIvO2viinQJFj
NzLt/Sri3WKeqV/xPYaqnguV7O8zD0CPLUftp6Sg6IxFbkBgWvYJowS3f7eOMRVI
M3uQ2GWWkNvneqmd2mc5rnz2Cff8nqrk/PUvHu4GgbmDbY2EHJhbpdWuaYlMSsVk
JaJ0mjaem9/xk+iH1R+0CCTzOkeHcZeQEiCbcAYJ3BnQuBjyKjZnP/0XijSTEmig
QiVjZBeZUZp1QlEzMKKiNFII8cuJ2yj8Ahhqb/feplUQGeeFQHR8/CLWTmzaydW+
1u4ayJ/PmrRslsRZKdGwCMOkZTIuGs6vVd/C765SX7vKW3MPnGBKRhSWOI3DhwSu
keR/u0cEH37MpXfirOJVDuqhRee+pKXDq/hxj4+DcC4FD6dxfQDX6LGsSno/RN8X
5seOUsdhUKplWX6Ugzj/ip+H2v1UhCtTGdJaem3FW8qHqScQfqlnQotKiORmPYqK
YPjFscpstD7vYrRzq5SLrdtxdnLox/4Q7+fPLTcZHYl1JFtfRAVBg8fQBPynS2oH
HTFi+Q30SLUJyXsoUKqpjt3u2WOSPyjVVHgurNDlFAC7j4I5jyzVcRUeWFS6XqVF
fg9+XWHKtMm0s03xOsaSikuVCqJRWrbqkrd8zJ4D6Z0ZUuG8HH4kUbGxCIIRiVxf
cnBUnqCsZ/cmR4BASJvk
=8Qs1
-----END PGP SIGNATURE-----

--NKtYx2Ppz7d1tORf--
