From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 15:35:12 +0200
Message-ID: <20070524133512.GK5412@admingilde.org>
References: <11799589913153-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0705240039370.4113@racer.site> <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SqEuGDw53xMPnx3c"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, skimo@liacs.nl,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 15:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrDTI-0000UX-7J
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047AbXEXNfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757129AbXEXNfP
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:35:15 -0400
Received: from mail.admingilde.org ([213.95.32.147]:44679 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047AbXEXNfO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:35:14 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HrDTE-0001gW-So; Thu, 24 May 2007 15:35:12 +0200
Content-Disposition: inline
In-Reply-To: <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48263>


--SqEuGDw53xMPnx3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, May 23, 2007 at 05:50:42PM -0700, Junio C Hamano wrote:
> Honestly speaking, I do not think people have no business
> peeking into configuratoin remote repository has, and it would
> be preferrable that supermodule Porcelain stuff does not rely on
> that.

yes.
I would greatly appreciate having one standard repository format,
also for subprojects so that it is not possible to look into the
remote configuration.

However I do see that the site administrator might want to physically
separate the different subprojects which is difficult to support
in one big monolithic repository.  But if additional information
about the physical location of subprojects is neccessary, then
that should be stored in something like .git/info/subprojects or
similiar, instead of the .git/config.

--=20
Martin Waitz

--SqEuGDw53xMPnx3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGVZSQj/Eaxd/oD7IRArSmAJ9jASNXCh0CK72Nhxr0W1x0QlT1WQCfQD0r
3gj/smdiooTrLhiGU5xRyaI=
=wzzg
-----END PGP SIGNATURE-----

--SqEuGDw53xMPnx3c--
