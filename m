From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v3 3/4] submodule: Teach 'add' about a configurable
 local-branch
Date: Tue, 14 Jan 2014 17:02:08 -0800
Message-ID: <20140115010208.GF2647@odin.tremily.us>
References: <20140108040627.GD29954@odin.tremily.us>
 <cover.1389247320.git.wking@tremily.us>
 <75e8c98df73273c2c8174e726e3fc961fbebd6a7.1389247320.git.wking@tremily.us>
 <CALas-iiLQHVpH9-KbWHVJzYSho3cV-ELmG4+R_8XGT7Pb+=gWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 02:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Es5-0002kZ-9C
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 02:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbaAOBCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 20:02:14 -0500
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:46358
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751068AbaAOBCM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 20:02:12 -0500
Received: from omta17.westchester.pa.mail.comcast.net ([76.96.62.89])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id E0WE1n0041vXlb85E12BsE; Wed, 15 Jan 2014 01:02:11 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta17.westchester.pa.mail.comcast.net with comcast
	id E1291n00e152l3L3d12A2q; Wed, 15 Jan 2014 01:02:11 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id CDFDAED210E; Tue, 14 Jan 2014 17:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389747728; bh=KltOnp0vVWLvMu745oBPhJZamZxglxbDYi1Tc/e+uV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gJH+34s0s4FHk7BOlPps3kKlHKuwgZ/SxbadDAWsog4CkEWf9sUhfqmUMjqWF4ZqV
	 KEOYSCIRNlgcXY6C4bWx1EiGcPihYXUoA/S9GNwIUWGzsajd12zyBN6aKvEv4amyG/
	 ZxpkJIZeiz+2SrX3p8fXvPt96x8fK4ASaMxnGEwQ=
Content-Disposition: inline
In-Reply-To: <CALas-iiLQHVpH9-KbWHVJzYSho3cV-ELmG4+R_8XGT7Pb+=gWQ@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389747731;
	bh=W/pcJlpAjDbAucoyXMdDTAEQxEc6YVlCE+ZCHwXbdEU=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=pcqyi70lQ6Jg9D46qOm08a43fltzgJgpQuaSpBwldq381psuTlx+alimO++MubMAu
	 9po1GeplJj/Bi5pnHuKS/myu3fcJ6mQZEF87s0qM2Eo2KzC6DA3DqVXCAIxwySi7A5
	 6RRZu8qWi5KGIMMzy3hQilVe96jkk9NP+s/HTo+Z0KO2hhV8RAisuu8mD2GMtaTeyG
	 fPi3yfSTtpsME66ZQfmkepdneHyC1Ws2HWqJMwdC4z/Ssh336V7kSXFhWB2FmPSRBd
	 ZIXms1XHddUzaIUmwsRbJgnXJyN3DuKfNPnmc87iC8J4/INzqFhOreRLU8V5+bEHlN
	 D3qcQMrQVTqLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240428>


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2014 at 01:18:12AM +0100, Francesco Pretto wrote:
> I've matured this opinion about "local-branch" some days ago, but I
> couldn't join the discussion because I was extremely busy. Hope it's
> is still current (and correct).

I think the discussion is still open, but actions are postponed until
'checkout --recurse-submodules' lands [1].

> The "local-branch" feature means to my brain the following: I,
> maintainer, decide for you, developer, what name should be the
> branch you are checking out.

The goal is to have =E2=80=9CI, your faithful Git command, check out for yo=
u,
oh wise developer, the superproject branch you requested, along with
the local submodule branch associated with that super project branch.=E2=80=
=9D
;)  Maybe that would be more clear if the localBranch settings are
purely local (stored only in out-of-tree configs), and not contained
in the superproject's .gitmodules file?  As this series stands, that
would just drop step 3 from the lookup chain [2].  That step is below
all the local out-of-tree locations though, and I see no
non-psychological reason to keep folks from sharing reasonable default
names for local branches.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240420
[2]: http://article.gmane.org/gmane.comp.version-control.git/240251

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1d4NAAoJEKKfehoaNkbt9X8QAJpkCaATvUK20iaCEEdt6ZIF
vtXHdo0v3bU3XT8XQzL/Q6qh3ljr5D1T5WgtoF6FYmHG8rqRl252mlzjwwn2lTwQ
HeHhSpYqotQJl+Lu7uJm3Tsjf0Wu8rX/deTvK0IdDt6Q6lEn4OMvLrncZex3ET9p
0/wFWS5nPcqBkB+d4BSND7BvGWHieQJnIHTJhPJE1H+bNyr0pXzq/ILChUMwMTIg
iKfW0itZn+3P1cWwFOMFeEhLB95gLVHT34UNb7SdGbT4HyRxp1tDJu1dOWx+eOVK
JQoE0VEGswR4ikTpKcr1Lru8JkjSTRpGojP3FGdjIJkCFVvbxkoF3V1rk61vq/wG
Cw3o9Bm7QM9zJFWLzh3+02/8uZUnsWF+4PGuwZl942NxkaF0oSbYu/3br1u0cMAR
cNSjWJzU+LObpsQeuCumxwRalrRBUIqim9a1MeMZ0KA7SvAThDiv1Z5uoWucRFy2
zgqZ344rg8emkAgH9AO4sBnJzxFAuV05hNflHaUiTFOMLpPSsRjTvzXq2fuQS4n9
HoT/wRuCetea/KB8fGKjtVkLzjb3BSRRXhdozJvRwwpgqzRVFdRJ0JvQZ4rR1eSy
kH+m1uev1UfgChQ7VE/Kk/QWNMTYvmFi5X3pRzo9iCI7n4lIipk1mACIkrOultBY
6y04/D59G6t/ia4LUBkI
=irFS
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
