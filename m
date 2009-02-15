From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Possible git bug when using filter-branch to remove large binaries
Date: Sun, 15 Feb 2009 22:55:01 +0100
Message-ID: <200902152255.05655.trast@student.ethz.ch>
References: <34854909-55F5-4869-A7A6-0E179F2F7A44@talkhouse.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8957511.YR5lk54ab2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Juan Zanos <juan_zanos@talkhouse.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 22:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYoz0-0001MP-9c
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 22:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbZBOVzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 16:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbZBOVzR
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 16:55:17 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:8775 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbZBOVzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 16:55:16 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 22:55:15 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 22:55:14 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <34854909-55F5-4869-A7A6-0E179F2F7A44@talkhouse.com>
X-OriginalArrivalTime: 15 Feb 2009 21:55:14.0334 (UTC) FILETIME=[14D9C3E0:01C98FB8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110064>

--nextPart8957511.YR5lk54ab2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Juan Zanos wrote:
> I'm trying to remove a directory of large binaries from a git =20
> repository
[...]
> The directory successfully =20
> vanishes. However, the repository + working directory only goes from =20
> 216M down to 133M.   That means the binaries were only removed from =20
> the working directory.

We're in fact trying to make a generic recipe and put it in 'man
git-filter-branch'.  The preliminary patch is here:

  http://article.gmane.org/gmane.comp.version-control.git/109925/

Once you convince your eyes to ignore the leading +, it should be
fairly easy to read in patch form. ;-)

It would be very helpful if you could try the recipe, and report if it
worked.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart8957511.YR5lk54ab2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmYjzkACgkQqUud07tmzP31HgCeNjkQluZThP50AWD1NBWnJ8Qr
P2gAnR4orJUTQKuE3GkBIgA1kNG2seWc
=aj8s
-----END PGP SIGNATURE-----

--nextPart8957511.YR5lk54ab2--
