From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to chmod.
Date: Thu, 4 Oct 2007 10:42:37 +0200
Message-ID: <20071004084237.GE20800@admingilde.org>
References: <20071003105501.GD7085@admingilde.org> <470388DC.4040504@viscovery.net> <20071003231941.GA20800@admingilde.org> <Pine.LNX.4.64.0710040053380.28395@racer.site> <470482A2.3080907@op5.se> <7vr6kbbdph.fsf@gitster.siamese.dyndns.org> <20071004071751.GD20800@admingilde.org> <7vir5nb89d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 10:42:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdMID-0007be-Nt
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 10:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbXJDImm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 04:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbXJDImm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 04:42:42 -0400
Received: from mail.admingilde.org ([213.95.32.147]:53973 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbXJDIml (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 04:42:41 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.63 #1)
	id 1IdMI1-0001K3-EU; Thu, 04 Oct 2007 10:42:37 +0200
Content-Disposition: inline
In-Reply-To: <7vir5nb89d.fsf@gitster.siamese.dyndns.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59933>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Oct 04, 2007 at 01:21:02AM -0700, Junio C Hamano wrote:
> FWIW, I did not mean it to be an example for preferred
> indentation nor code layout, but as a better way to explain what
> the logic is computing.

sure, and I think it makes sense the way you wrote it.

> I do not think git on Cygwin nor WinGit creates $GIT_DIR/config
> with executable bit set.  Is this pretty much a workaround only
> for vfat-on-Linux ?

I just checked Cygwin, it creates files without executable bit and
disregards a chmod +x.  So yes, this seems to be a Linux-only problem.

--=20
Martin Waitz

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBKd9j/Eaxd/oD7IRAoF0AJ9aQDHu4JsfkGdWicNfoj/AvIqYLACfZ1gB
N5lC7hG5MmKU+Y1LWfwTj4M=
=Pmnw
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
