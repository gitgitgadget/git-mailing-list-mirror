From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Tue, 22 May 2007 08:03:02 +0200
Message-ID: <20070522060302.GH5412@admingilde.org>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org> <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="56p9wBiXEyg+KhLM"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 08:03:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqNSf-0001OS-5n
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbXEVGDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756509AbXEVGDF
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:03:05 -0400
Received: from mail.admingilde.org ([213.95.32.147]:46665 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420AbXEVGDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:03:04 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HqNSY-0000J1-Sq; Tue, 22 May 2007 08:03:02 +0200
Content-Disposition: inline
In-Reply-To: <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48071>


--56p9wBiXEyg+KhLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 04:02:42PM -0700, Junio C Hamano wrote:
> I had a feeling that some callers needed to be able to unsetenv
> some.  How would this patch help them, or are they outside of
> the scope?

At first I had the same objection but the putenv documentation
told me that at least in glibc you can unsetenv by providing
the variable name without a "=3D".

But perhaps we should check for other systems?

--=20
Martin Waitz

--56p9wBiXEyg+KhLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUoeWj/Eaxd/oD7IRAvUOAJ9YdQJQNvP70Y2N+tpJpxgSJowTTgCaAwhJ
3uGzc3BAWl77fbBCrMZ65uM=
=3O19
-----END PGP SIGNATURE-----

--56p9wBiXEyg+KhLM--
