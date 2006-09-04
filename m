From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon, 4 Sep 2006 11:08:33 +0200
Message-ID: <20060904090833.GF17042@admingilde.org>
References: <11573485523752-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Sep 04 11:08:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKARc-0000aM-Kl
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 11:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWIDJIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 05:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWIDJIh
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 05:08:37 -0400
Received: from agent.admingilde.org ([213.95.21.5]:18647 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750826AbWIDJIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 05:08:36 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GKARV-0001cv-Qr; Mon, 04 Sep 2006 11:08:33 +0200
To: Martin Langhoff <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <11573485523752-git-send-email-martin@catalyst.net.nz>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26408>


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Sep 04, 2006 at 05:42:32PM +1200, Martin Langhoff wrote:
> Avoid failing when cwd is !writable by writing the
> packfiles directly in the $PACKDIR.

what if other GIT commands are being called while you repack?
Wouldn't they try to use the new packs, even while they are not
completely written?

Perhaps it is better to create a new subdirectory $PACKDIR/.tmp/
and create the new pack files there?

--=20
Martin Waitz

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE++0Rj/Eaxd/oD7IRAp6JAJ4n0TaQFCCfpOeba/Q5LOxLLn4zbgCffvPP
ZAgIEdQnaN89mbRes+mVsyQ=
=6rFd
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--

-- 
VGER BF report: U 0.606155
