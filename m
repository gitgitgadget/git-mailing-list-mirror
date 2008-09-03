From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Calling ssh from git-gui
Date: Wed, 3 Sep 2008 19:22:04 +0200
Message-ID: <200809031922.07083.trast@student.ethz.ch>
References: <20080903165455.GU10544@machine.or.cz> <20080903171543.GC28315@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6840201.4UhbySS8l9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaw4b-0008Do-4I
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbYICRWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbYICRWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:22:09 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:20206 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbYICRWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:22:08 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Sep 2008 19:22:06 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Sep 2008 19:22:05 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080903171543.GC28315@spearce.org>
X-OriginalArrivalTime: 03 Sep 2008 17:22:05.0278 (UTC) FILETIME=[960D87E0:01C90DE9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94820>

--nextPart6840201.4UhbySS8l9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Shawn O. Pearce wrote:
> Damn annoying for git-gui to be invoking a new terminal window, but
> maybe that's what we have to do.  Be nice though if the window only
> was opened because we couldn't do "git ls-remote url" but its hard
> to tell "hanging because SSH needs the user" and "hanging because
> the network is a 2400 baud modem".

You can set BatchMode (ssh_config(5)) to at least prevent it from
hanging, can't you?

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart6840201.4UhbySS8l9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAki+x78ACgkQqUud07tmzP2geACfbRunPVvOLA/oG4F+S1klmFZT
Tm0AoJPTnn9e6MmFljHC/GTa9DHkaThy
=HzDz
-----END PGP SIGNATURE-----

--nextPart6840201.4UhbySS8l9--
