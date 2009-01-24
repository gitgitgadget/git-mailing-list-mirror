From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [VALGRIND PATCH for nth_last patch series] Fix invalid memory access
Date: Sat, 24 Jan 2009 23:21:57 +0100
Message-ID: <200901242322.02440.trast@student.ethz.ch>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <7vwscpgi7t.fsf@gitster.siamese.dyndns.org> <200901211019.01493.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3781168.U0ZgYJhIq7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 23:23:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQquL-00018G-5K
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 23:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZAXWVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 17:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbZAXWVu
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 17:21:50 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9737 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642AbZAXWVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 17:21:49 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 24 Jan 2009 23:21:47 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 24 Jan 2009 23:21:46 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <200901211019.01493.trast@student.ethz.ch>
X-OriginalArrivalTime: 24 Jan 2009 22:21:47.0056 (UTC) FILETIME=[25195B00:01C97E72]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107012>

--nextPart3781168.U0ZgYJhIq7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> Thanks for all the work you (both) are doing on this.  I hope to find
> the time to read the current state of the series tonight.

I was off by half a week :-(

The debugging 'git log --graph ...' that I forgot about is still in,
sorry.  I'll follow up with a small patch.  Other than that, I didn't
notice anything, though admittedly it wouldn't have been very hard to
sneak something past me.

By the way, you (Junio) remarked earlier in the thread that we could
forbid any use of 'git checkout -' except in literally that command
(i.e., no options or paths).  I'm midly opposed to it because I can
see myself saying 'git checkout -b sidebranch -' (and @{} is somewhat
awkward to type on Swiss keyboards).  Admittedly 'git checkout - --
file' looks rather confusing.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3781168.U0ZgYJhIq7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl7lIoACgkQqUud07tmzP2yIwCfbX2fbAnLMQAmsVZN4KsNSyWk
hB8AoJjCdHhbTV9VBdIbqR1fonv8t0X2
=XJMq
-----END PGP SIGNATURE-----

--nextPart3781168.U0ZgYJhIq7--
