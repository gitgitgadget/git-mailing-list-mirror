From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC v3 0/6] N-th last checked out branch
Date: Sat, 17 Jan 2009 14:38:17 +0100
Message-ID: <200901171438.22504.trast@student.ethz.ch>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9130883.kuWCCXC85g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 14:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOBP4-0004cL-IT
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 14:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760296AbZAQNiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 08:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754388AbZAQNiJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 08:38:09 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52673 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbZAQNiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 08:38:07 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 14:38:05 +0100
Received: from [192.168.0.3] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 14:38:05 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 17 Jan 2009 13:38:05.0106 (UTC) FILETIME=[D3440920:01C978A8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106049>

--nextPart9130883.kuWCCXC85g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Sat, 17 Jan 2009, Thomas Rast wrote:
> >  9 files changed, 387 insertions(+), 122 deletions(-)
>=20
> Let's quickly compare that to what Junio sent:
>=20
>  builtin-checkout.c |   10 +++++-
>  cache.h            |    1 +
>  sha1_name.c        |   78 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 87 insertions(+), 2 deletions(-)
[...]
> - the '-' handling you seem to want.

Let's be clear that the handling *I* wanted is this big:

 builtin-checkout.c                     |   27 ++++++++++++++++-

In any case, I'll follow up with a version that still traverses the
logs twice and thus doesn't need the first two.

> I really have to ask: why did you not work on top of Junio's patch, just=
=20
> adding docs, tests, and checkout -?  And then -- maybe -- the=20
> string_list...
>=20
> Although I have to admit that I am not _that_ convinced the string_list i=
s=20
> worth it: reflogs are not evaluated all the time, so it is definitely not=
=20
> performance critical.

I take it you have some idea where and how string_list fits into this
topic?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart9130883.kuWCCXC85g
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklx304ACgkQqUud07tmzP2BSgCeJs4MgeXx7ZCW8nkbNyGvkVZG
Ey8AnRPB/BA52kKzfh8JAht1x/jkVWWm
=Qh+M
-----END PGP SIGNATURE-----

--nextPart9130883.kuWCCXC85g--
