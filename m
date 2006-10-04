From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] git-rebase: Add a -v option to show a diffstat of the changes upstream at the start of a rebase.
Date: Wed, 4 Oct 2006 08:59:43 +0200
Message-ID: <20061004065943.GT2871@admingilde.org>
References: <45228FEB.10602@codeweavers.com> <7v4pulm3j6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i6vqABX3nJKXLk01"
Cc: Robert Shearman <rob@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 09:00:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV0jM-0002on-N9
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 08:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWJDG7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 02:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWJDG7q
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 02:59:46 -0400
Received: from agent.admingilde.org ([213.95.21.5]:31710 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932382AbWJDG7p
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Oct 2006 02:59:45 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GV0jH-0008Gf-CB; Wed, 04 Oct 2006 08:59:43 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pulm3j6.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28315>


--i6vqABX3nJKXLk01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Oct 03, 2006 at 03:35:09PM -0700, Junio C Hamano wrote:
> Robert Shearman <rob@codeweavers.com> writes:
> > +-v, \--verbose::
> > +	Display a diffstat of what changed upstream since the last rebase.
> > +
>=20
> I initially was a bit surprised that you did not show diff
> between onto and our HEAD (i.e. show the damages contained in
> the topic you are rebasing that will be inflicted on upstream),
> but I think your way of showing the upstream changes makes more
> sense.  From the workflow point of view, this is for people who
> rebase instead of pull, and when pulling we show what the
> upstream did while we were looking the other way, so this
> naturally matches that behaviour for rebase.  I would say it is
> a good thinking.

but perhaps we should use the same command line options as pull:
default to show the diffstat and use -n to suppress it?

--=20
Martin Waitz

--i6vqABX3nJKXLk01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFI1vfj/Eaxd/oD7IRAkyjAKCCTetHijbgODfw38fm6jaPhsLSBwCfTrL0
vo7H8rLuFbsF7fQ8TeAflOU=
=TJCP
-----END PGP SIGNATURE-----

--i6vqABX3nJKXLk01--
