From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] completion: Add --full-diff to log/gitk options
Date: Wed, 3 Jun 2009 16:30:01 +0200
Message-ID: <200906031630.09962.trast@student.ethz.ch>
References: <pan.2009.06.02.00.34.36@fedoraproject.org> <7vzlcrihew.fsf@alter.siamese.dyndns.org> <20090603122230.GZ28808@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1911456.iiFmVBVxxa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Spura <tomspur@fedoraproject.org>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 16:30:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBrTy-0006GO-RU
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 16:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757949AbZFCOaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 10:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757610AbZFCOaL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 10:30:11 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:38763 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756378AbZFCOaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 10:30:10 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Jun 2009 16:30:10 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Jun 2009 16:30:10 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <20090603122230.GZ28808@inocybe.localdomain>
X-OriginalArrivalTime: 03 Jun 2009 14:30:10.0565 (UTC) FILETIME=[CCC6FB50:01C9E457]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120611>

--nextPart1911456.iiFmVBVxxa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Todd Zullinger wrote:
> I *think* __git_log_gitk_options is the proper place for it, but it's
> early in the a.m. and I'm not averse to being proved wrong.
[...]
>  # Options that go well for log and gitk (not shortlog)
>  __git_log_gitk_options=3D"
> -	--dense --sparse --full-history
> +	--dense --sparse --full-diff --full-history

Gitk has its own setting in the Preferences called "limit diffs to
listed paths", and ignores this option, so it should go directly in
_git_log.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1911456.iiFmVBVxxa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkomiPEACgkQqUud07tmzP220wCfbMajJYE+BVE+Ws0DmX0jush5
hiEAn1ceNns3INjayNo8MsE17Cd6JdKO
=vy/D
-----END PGP SIGNATURE-----

--nextPart1911456.iiFmVBVxxa--
