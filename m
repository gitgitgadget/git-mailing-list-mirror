From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [Illustration PATCH] add -i: accept single-keypress input
Date: Tue, 3 Feb 2009 10:35:00 +0100
Message-ID: <200902031035.04978.trast@student.ethz.ch>
References: <20090203062437.GB21367@sigill.intra.peff.net> <1233651248-26717-1-git-send-email-trast@student.ethz.ch> <7vbptjdh5e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2988810.ipSNgHPmj1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Suraj Kurapati <sunaku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 10:36:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUHht-0008E4-1N
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 10:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbZBCJfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 04:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbZBCJfJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 04:35:09 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:38119 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbZBCJfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 04:35:08 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 10:35:06 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 10:35:06 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <7vbptjdh5e.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 03 Feb 2009 09:35:06.0616 (UTC) FILETIME=[B2D4BF80:01C985E2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108171>

--nextPart2988810.ipSNgHPmj1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Hmm, you could trigger the action immediately after seeing _enough_ number
> of characters to disambiguate instead of stop-and-prompt, I guess?  That
> way, you would get a single-key merely as a degenerate case when the
> choices are all distinct.

I don't think that's very nice.  On the one hand, you'd really want to
allow the user to delete some of the input again if he decides to do
something else instead, and we'd either need readline or need to
reinvent it for that.  On the other hand, some possible choices might
be a valid prefix of some _other_ choices, at which point you need a
terminator (such as the <enter>) anyway.  I expect this to be fairly
common since many of the list_and_choose() prompts are numbered, so
that 1 and 10 run into this problem.

Then again I don't use add -i, so someone else should say what to do.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2988810.ipSNgHPmj1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmID8gACgkQqUud07tmzP3r8QCgnWbpN6yXw8vPUDhwbz+KCnM5
we8An26Hv5NxzZR7HjARBGezsA0J3SlW
=0RZ/
-----END PGP SIGNATURE-----

--nextPart2988810.ipSNgHPmj1--
