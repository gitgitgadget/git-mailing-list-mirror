From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Sun, 18 Jan 2009 03:06:38 +0100
Message-ID: <200901180306.40700.trast@student.ethz.ch>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch> <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6927352.q0XG1OUVTj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 03:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LON4z-0000AS-9c
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 03:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522AbZARCGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 21:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757492AbZARCGY
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 21:06:24 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31480 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757380AbZARCGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 21:06:24 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 03:06:23 +0100
Received: from [192.168.0.2] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 03:06:22 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Jan 2009 02:06:22.0549 (UTC) FILETIME=[5C3A2850:01C97911]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106133>

--nextPart6927352.q0XG1OUVTj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > +		if test ! -z "$GIT_PS1_EXPENSIVE"; then
> > +			git update-index --refresh >/dev/null 2>&1 || w=3D"*"
>=20
> This makes the feature unavailable for people who care about the stat
> dirtiness and explicitly set diff.autorefreshindex to false, doesn't it?

True, and I admit I didn't know there was an option to change that.
OTOH git-diff-files doesn't normally update the index even if the
option is set.  Should I ask 'git diff --exit-code --raw' or some such
instead?

(Why would people want to keep the stat info dirty even though there
may not have been any changes?)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch




--nextPart6927352.q0XG1OUVTj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklyjrAACgkQqUud07tmzP1qiQCeOs7dESdKCbUsJybddo4WSrri
W14Anjnm+rW/8dEYQBpX64mRVjz2eu8k
=jzmx
-----END PGP SIGNATURE-----

--nextPart6927352.q0XG1OUVTj--
