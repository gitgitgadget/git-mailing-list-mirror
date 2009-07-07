From: Florian Mickler <florian@mickler.org>
Subject: Re: Checking for fast-forward
Date: Tue, 7 Jul 2009 12:46:57 +0200
Message-ID: <20090707124657.1b0fe4df@schatten>
References: <ca4f67be0907060936v7bf7c44y4395717fff854fd4@mail.gmail.com>
	<20090706232614.32602ccc@schatten>
	<4A530594.20100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VJ2NuO6jw5VlJWnXC1abcXq";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Lee Griffiths <poddster@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 12:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO8DB-0007OB-B6
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 12:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZGGKrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 06:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZGGKrO
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 06:47:14 -0400
Received: from ist.d-labs.de ([213.239.218.44]:44237 "EHLO mx01.d-labs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbZGGKrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 06:47:14 -0400
Received: from schatten (f053208123.adsl.alicedsl.de [78.53.208.123])
	by mx01.d-labs.de (Postfix) with ESMTP id 61240C7B27;
	Tue,  7 Jul 2009 12:47:16 +0200 (CEST)
In-Reply-To: <4A530594.20100@drmicha.warpmail.net>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122834>

--Sig_/VJ2NuO6jw5VlJWnXC1abcXq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Jul 2009 10:21:40 +0200
Michael J Gruber <git@drmicha.warpmail.net> wrote:

> If $(git rev-list bar..remotes/origin/foo) is empty then the branch
> foo in the remote repo can be fast-forwarded to bar.
>=20
> Chhers,
> Michael

in that case you could also do=20
'git cherry bar origin/foo'

that shows you all commits that are in origin/foo but not in bar.=20

Sincerely,
Florian

--Sig_/VJ2NuO6jw5VlJWnXC1abcXq
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEUEARECAAYFAkpTJ6UACgkQPjqCkyL3Kv13NACfc/jgugRYuolf552y3GpX8aTC
27EAliJJGO9Bvl9nAxVl2k8ztMV21oQ=
=OqFw
-----END PGP SIGNATURE-----

--Sig_/VJ2NuO6jw5VlJWnXC1abcXq--
