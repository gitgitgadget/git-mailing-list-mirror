From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash: remove fetch, push, pull dashed form leftovers
Date: Fri, 3 Oct 2008 22:13:01 +0200
Message-ID: <200810032213.06005.trast@student.ethz.ch>
References: <fc113d400810030825l75f9451dwc4cbf68807be0b5b@mail.gmail.com> <1223051705-30347-1-git-send-email-trast@student.ethz.ch> <20081003193449.GA24821@neumann>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2142877.5Sv8fH2FVr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Rob Sanheim <rsanheim@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: SZEDER =?utf-8?q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klr2Y-0006er-Di
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 22:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYJCUNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 16:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbYJCUNI
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 16:13:08 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:12583 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbYJCUNH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 16:13:07 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 3 Oct 2008 22:13:04 +0200
Received: from [192.168.0.7] ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 3 Oct 2008 22:13:03 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20081003193449.GA24821@neumann>
X-OriginalArrivalTime: 03 Oct 2008 20:13:03.0796 (UTC) FILETIME=[70FFA740:01C92594]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97450>

--nextPart2142877.5Sv8fH2FVr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

SZEDER G=E1bor wrote:
> We don't provide complation for git-commands in dashed form anymore,
> so there is no need to keep those cases.
[...]
> On Fri, Oct 03, 2008 at 06:35:05PM +0200, Thomas Rast wrote:
> > I do wonder if there's a better approach to those functions
> > however, so that the "obvious" fix suggested by Shawn would work.
>=20
> Maybe something like this?

That's indeed much simpler and better.  FWIW,

Tested-by: Thomas Rast <trast@student.ethz.ch>

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart2142877.5Sv8fH2FVr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjmfNEACgkQqUud07tmzP0BzwCgo2Mmy1w5UDvaSa6Cb2zed5AE
SfwAn2T9tSzlwjtH1iytuZxb4UTl7z9f
=+HXg
-----END PGP SIGNATURE-----

--nextPart2142877.5Sv8fH2FVr--
