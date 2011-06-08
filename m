From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 8 Jun 2011 20:34:33 +1000
Message-ID: <20110608203433.61e02ad8.sfr@canb.auug.org.au>
References: <20110608093648.GA19038@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__8_Jun_2011_20_34_33_+1000_96x3sc2E26WXOL.O"
Cc: git@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:34:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUG66-0001YE-CD
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 12:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab1FHKep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 06:34:45 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:43122 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955Ab1FHKeo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 06:34:44 -0400
Received: from canb.auug.org.au (ash.rothwell.emu.id.au [IPv6:2402:b800:7003:7010:223:14ff:fe30:c8e4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id DA46F144BC2;
	Wed,  8 Jun 2011 20:34:39 +1000 (EST)
In-Reply-To: <20110608093648.GA19038@elte.hu>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.24.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175350>

--Signature=_Wed__8_Jun_2011_20_34_33_+1000_96x3sc2E26WXOL.O
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Wed, 8 Jun 2011 11:36:48 +0200 Ingo Molnar <mingo@elte.hu> wrote:
>
>=20
> This might be a FAQ, but i couldn't find an elegant Git-ish answer=20
> for it, so please bear with my stupid question :-)
>=20
> In an upstream Linux kernel Git repo, with linux-next as a remote=20
> present (but -git checked out), what is the way to find out when a=20
> particular commit was merged upstream?
>=20
> So for example when was 189d3c4a94 merged upstream?
>=20
> The proper Git answer would be:
>=20
>   $ git describe --contains 189d3c4a94
>   next-20080501~97
>=20
> But the next-20080501 tag is useless, and i don't have linux-next as=20
> HEAD, it's only a remote.

You can restict which tags get used:

$ git describe --contains --match 'v*' 189d3c4a94
v2.6.26-rc1~155

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Jun_2011_20_34_33_+1000_96x3sc2E26WXOL.O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN71A5AAoJEDMEi1NhKgbsC1wH/AkYhhpOeetUccu3JX1PhFtl
gPCvz8UVmlyPmc+bSyfmJ8rM9KqRT+8kFFqjZ+0JRgA+J6t6+p92J2xbhVotQPM1
i8I7pJy7Rjoa9d6ahG8LXm110tjvJxyVgGy5n3BktugBvEmFFuFBlajnIBYt1+aP
tInse5qA90AXaYiVBbI4Lfj5a0Q8lcOMPU+AFmwGWqn9czZ+20O/2dxVqyfECiwv
SxjdvmcTDdl6SsON5feWMWcZ9ksXA7uFMYCqQjdwee3h9XsjHg4iUojjVa0SpmA/
AdJDnsuzubbirnfnsooIbS99T/NyhUQA7iGmjfUtMG1oXpX/sVmPdF/L/UCHrIo=
=6EOW
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Jun_2011_20_34_33_+1000_96x3sc2E26WXOL.O--
