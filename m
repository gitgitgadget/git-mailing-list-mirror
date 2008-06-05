From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Thu, 5 Jun 2008 11:04:58 +0200
Message-ID: <200806051105.02802.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200806050954.13244.trast@student.ethz.ch> <20080605081126.GA16416@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1489902.vUeXTSJbTa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 11:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4BPt-0008Uv-E8
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 11:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbYFEJEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 05:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYFEJEf
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 05:04:35 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:10439 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbYFEJEe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 05:04:34 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 11:04:33 +0200
Received: from vpn-global-dhcp3-023.ethz.ch ([129.132.210.23]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 11:04:32 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080605081126.GA16416@sigill.intra.peff.net>
X-OriginalArrivalTime: 05 Jun 2008 09:04:32.0956 (UTC) FILETIME=[2B812FC0:01C8C6EB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83886>

--nextPart1489902.vUeXTSJbTa
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry, I sent it in reply to the wrong message accidentally.

(Somehow it seems rather ironic that I'm trying to implement a feature
that provides plenty of live bullets, yet keep shooting myself with
the _MUA_.)

You wrote:
> On Thu, Jun 05, 2008 at 09:53:54AM +0200, Thomas Rast wrote:
>=20
> > On the other hand it would be just as powerful.  Manually splitting a
> > hunk is, in the general case, only possible in "my" scheme.  However,
> > to make any difference, you later have to answer 'n' to some of the
> > sub-hunks.  So in "your" scheme, you could just have deleted the lines
> > in question.
>=20
> Sorry, I've gotten lost in which is mine and which is yours. Yours is
> the original patch or this patch? Mine is the proposal that spawned this
> patch, or my comments on this patch?

I should have provided a definition, sorry.  By "your" scheme, I meant
the one where one is restricted to deleting existing lines, and thus
deletes '-' lines to disable them; by "my" scheme, where one is free
to edit and changes '-' lines to context to disable them.

At least it's my current understanding that, under the above
definition, "your" scheme is what you actually proposed in
  http://www.spinics.net/lists/git/msg67478.html
  [why doesn't Google find gmane?]
but I misunderstood and implemented "my" scheme.

[Let's just forget about the original patch at the top of the thread;
in retrospect, it _is_ clunky, and the UI didn't get any replies in
favour.]

=2D Thomas


--nextPart1489902.vUeXTSJbTa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBIR6w+qUud07tmzP0RApIEAKChPNTrn9PYd8kTS1Pizwl5mSlyggCdHJ5x
FY0RGVcQUKDQtormG7KZt/M=
=rzLk
-----END PGP SIGNATURE-----

--nextPart1489902.vUeXTSJbTa--
