From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 18:08:11 +0200
Message-ID: <20070418160811.GD12888@admingilde.org>
References: <11768880622402-git-send-email-junkio@cox.net> <Pine.LNX.4.64.0704181247410.12094@racer.site> <20070418153445.GC12888@admingilde.org> <7vps61isly.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeChw-00029p-SZ
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbXDRQIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbXDRQIO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:08:14 -0400
Received: from mail.admingilde.org ([213.95.32.147]:58508 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbXDRQIN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:08:13 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HeChX-00070V-Ou; Wed, 18 Apr 2007 18:08:11 +0200
Content-Disposition: inline
In-Reply-To: <7vps61isly.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44904>


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 18, 2007 at 08:56:25AM -0700, Junio C Hamano wrote:
> The only reason I did not do it your way was because we would
> need to have three lines per driver (one [merge "foo"] section
> per driver, a "driver" line, and a blank line for readability
> after that), which at the time I wrote it felt a bit wasteful,
> and it was late.

perhaps we can extend the config syntax to also support an entry
on the same line as the category:

	[merge "ancient"] driver=3Dmerge...

This would allow an one-line merge driver definition and would play
nice with your [attr] macro definition.

Perhaps we should also add the =3D to macro definitions?

	[attr] binary=3Dnocrlf nodiff merge=3Dbinary

Hmm, but then we would get multiple meanings for "=3D" on the same line,
so nevermind.

Or use some whitespace:

	[attr] binary =3D nocrlf nodiff merge=3Dbinary

Does this look better?

--=20
Martin Waitz

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGJkJrj/Eaxd/oD7IRAs8TAJ9pHILef751MxKH+4TnqQnL0OCewACfaYDW
S3y2KSAXNJ+2RiYbIkzbiH8=
=MozP
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
