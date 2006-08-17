From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use common parameter parsing and generation for "o", too.
Date: Thu, 17 Aug 2006 21:13:00 +0200
Message-ID: <20060817191300.GA11477@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <ec1d6q$823$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 21:13:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDnIh-0008Lh-UN
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 21:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWHQTNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 15:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWHQTNE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 15:13:04 -0400
Received: from agent.admingilde.org ([213.95.21.5]:13019 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932134AbWHQTNC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 15:13:02 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDnIa-0003V7-TG; Thu, 17 Aug 2006 21:13:00 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ec1d6q$823$2@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25606>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Aug 17, 2006 at 11:35:18AM +0200, Jakub Narebski wrote:
> > The "o" (list order) parameter was handled special.
> > Now it is generated with the common href() function and parsed together=
 with
> > all other parameters.
> =20
> This was because "o" (sort table by) parameter was used only
> in one place, and valid values of order parameter depends on
> the place it is used.

But I'd really like to have all the parameter parsing and generation
code in one place.

Perhaps we can agree that only the validation should be coupled with the
actual user?  E.g. use normal validate_input() for it and then check
for actual values inside git_project_list (which is already done now).

--=20
Martin Waitz

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE5L+8j/Eaxd/oD7IRAq0QAJ410J3wlOrYaGI313QOfQ0RdcJ2cgCdFx3/
GATeNki4OfwpFDFDWt97YpQ=
=a7yA
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
