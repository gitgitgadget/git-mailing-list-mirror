From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [RFH] NetBSD 6?
Date: Tue, 08 Jan 2013 14:08:38 -0500
Message-ID: <rmiip774hmx.fsf@fnord.ir.bbn.com>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
	<rmipq1numzj.fsf@fnord.ir.bbn.com>
	<7vd2xnypt6.fsf@alter.siamese.dyndns.org>
	<rmi8v8av05d.fsf@fnord.ir.bbn.com>
	<7vvcbew895.fsf@alter.siamese.dyndns.org>
	<rmiobgz4icr.fsf@fnord.ir.bbn.com>
	<7vy5g3cx9v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 20:09:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TseXj-0003Ji-FU
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 20:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab3AHTIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 14:08:39 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:55511 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756605Ab3AHTIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 14:08:39 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 6D744AE89; Tue,  8 Jan 2013 14:08:38 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130108:gitster@pobox.com::aeje5Ec5NcDwUN1p:0000000000000000000000000000000000000000000006uC
X-Hashcash: 1:20:130108:git@vger.kernel.org::aeje5Ec5NcDwUN1p:0000000000000000000000000000000000000000003aHq
In-Reply-To: <7vy5g3cx9v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 08 Jan 2013 11:03:40 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212999>

--=-=-=
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:

> Don't get too offended by the "OLD_" prefix to that symbol, by the
> way.  I do not think "old" means "old and broken hence fixed in
> newer version and you are low life if you live on a platform that
> has to define it" ;-).

Thanks - it did throw me at the beginning, because I expected that it
lead to using a copy of GNU iconv and not using the native one.
But it will probably confuse few enough people that changing to
CONST_ICONV is not warranted...

> We just needed to have a boolean to tell which variant it is to let
> the compiler build objects without complaining, and we named that
> switch as OLD_ICONV.

I get that, now that I read utf8.c.  It's amusing that git's own
function is const, and on non-OLD_ICONV platforms has to cast away the
const for standards-compliant iconv.


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDsbrYACgkQ+vesoDJhHiXsnQCfSUYnxAMP5Qz11D9sZ4WWHhQh
ev8Anj0rmzMtizbU0cme54JxMpIFrahE
=05tE
-----END PGP SIGNATURE-----
--=-=-=--
