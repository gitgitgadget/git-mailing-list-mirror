From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] submodule merge support
Date: Mon, 7 May 2007 18:44:34 +0200
Message-ID: <20070507164434.GK30511@admingilde.org>
References: <20070506190224.GG30511@admingilde.org> <20070506220745.GA2439@steel.home> <alpine.LFD.0.98.0705061517380.12945@woody.linux-foundation.org> <20070507090346.GI30511@admingilde.org> <463EFFC6.12A1B0A1@eudaptics.com> <alpine.LFD.0.98.0705070857100.3802@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 07 18:44:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl6KH-0005Lv-Ql
	for gcvg-git@gmane.org; Mon, 07 May 2007 18:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934400AbXEGQoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 12:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934406AbXEGQoh
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 12:44:37 -0400
Received: from mail.admingilde.org ([213.95.32.147]:56057 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934400AbXEGQog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 12:44:36 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hl6KA-0004UC-UP; Mon, 07 May 2007 18:44:34 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705070857100.3802@woody.linux-foundation.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46470>


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 07, 2007 at 09:02:00AM -0700, Linus Torvalds wrote:
> But if you have multiple merge-bases and you do a recursive merge to=20
> create a new *combined* merge-base, trying to do that for the submodule i=
s=20
> just pointless.

Ah, now I see your point.
And yes, you are right.

> So not doing it in the low-level merger is right - because it is simply=
=20
> irrelevant at that stage. The low-level merger might as well ignore=20
> submodules.

But where to do it then?
Do a first run which simply ignores dirlinks and then do another run
which looks for all unmerged index entries and processes all dirlinks
by merging the submodule?

--=20
Martin Waitz

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGP1dyj/Eaxd/oD7IRAmAYAJsG1SADEFSnc+ydlCrNVBgXZRPnEgCeJwgh
6BSp3vwS8lYyjPyw82HVkcg=
=ylrz
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
