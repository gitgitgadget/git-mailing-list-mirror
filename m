From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [IRC/patches] Failed octopus merge does not clean up
Date: Tue, 16 Sep 2008 01:47:42 +0200
Message-ID: <200809160147.45095.trast@student.ethz.ch>
References: <200809160048.31443.trast@student.ethz.ch> <7v63ox9e20.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2064522.2oN8jQ0vEc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 01:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfNoS-0005Pb-CT
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 01:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbYIOXrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbYIOXrt
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 19:47:49 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:26866 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998AbYIOXrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 19:47:48 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 01:47:47 +0200
Received: from [192.168.0.7] ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 01:47:46 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v63ox9e20.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 15 Sep 2008 23:47:46.0675 (UTC) FILETIME=[745B7C30:01C9178D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95959>

--nextPart2064522.2oN8jQ0vEc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
[...]
> >   Should not be doing an Octopus.
[...]
> > Shouldn't it either really clean up, or really
> > leave the repo in a conflicted merge state?
[...]
> Your analysis is correct --- this has been the correct/established
> behaviour of Octopus from day one.

Including not cleaning up the half-merged state?  If the answer is
"yes", then so be it, merge-octopus has been on this project longer
than I have ;-)

However,

> Run "git reset --hard" after that, perhaps.

wasn't immediately obvious to the end-user (jammyd in this case),
which started the discussion.

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart2064522.2oN8jQ0vEc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjO9CEACgkQqUud07tmzP0nKQCfbGgQDQw8Kt5REvtta05Ox/yL
FqcAnislbgqEHcxLEOr2opSfG+2qtcD/
=QrFQ
-----END PGP SIGNATURE-----

--nextPart2064522.2oN8jQ0vEc--
