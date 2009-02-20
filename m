From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Blamming a diff between two commits?
Date: Fri, 20 Feb 2009 21:04:31 +0100
Message-ID: <200902202104.37695.trast@student.ethz.ch>
References: <499AB8A1.7090909@datacom.ind.br> <200902171509.21434.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5543725.X2uqaWJKq8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:06:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Labdc-0001ZB-No
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 21:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbZBTUEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 15:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbZBTUEv
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 15:04:51 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37370 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbZBTUEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 15:04:50 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 21:04:49 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 21:04:49 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <200902171509.21434.trast@student.ethz.ch>
X-OriginalArrivalTime: 20 Feb 2009 20:04:49.0346 (UTC) FILETIME=[7C1D9220:01C99396]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110884>

--nextPart5543725.X2uqaWJKq8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> Samuel Lucas Vaz de Mello wrote:
> > Is there any way to git blame (or annotate) a diff between two
> > commits?
[...]
> Call it as './git-blame-diff.perl HEAD^ HEAD' or so.

Any reports from the field?  Does it do what you wanted?  Does it have
other shortcomings than the ones I mentioned:

> This lacks proper argument checking and a chdir to the repository top
> level.  Maybe you could fill in the gaps and shape it as a contrib
> patch?  For bonus points, change it so that the workdir version can be
> used as the new side of the diff, by omitting the second argument.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart5543725.X2uqaWJKq8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmfDNUACgkQqUud07tmzP0e8ACgghLfu+dU6xGRLeH0mxw89Qqq
t/sAn333u7Ko+pROJPeIKHYb1uFp4wkC
=SdIM
-----END PGP SIGNATURE-----

--nextPart5543725.X2uqaWJKq8--
