From: Nicolas Vilz <niv@iaglans.de>
Subject: precise keyword matching for pretty switch
Date: Thu, 1 Feb 2007 23:43:40 +0100
Message-ID: <20070201224339.GA29666@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 23:43:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCkeQ-0002ZH-Ln
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 23:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017AbXBAWn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 17:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933091AbXBAWn1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 17:43:27 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:2838 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933017AbXBAWn0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Feb 2007 17:43:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id A70F43FE4
	for <git@vger.kernel.org>; Thu,  1 Feb 2007 23:43:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ej7KXCsqjVoH for <git@vger.kernel.org>;
	Thu,  1 Feb 2007 23:43:22 +0100 (CET)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id D1CE33FE3
	for <git@vger.kernel.org>; Thu,  1 Feb 2007 23:43:21 +0100 (CET)
Content-Disposition: inline
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38421>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

i noticed today, that the pretty-switch in git-log -diff and many other
tools triggers to "oneline" if you just type an "o" after --pretty=3D

so, not only=20

git log --pretty=3Doneline

but also

git log --pretty=3Donline
git log --pretty=3Doffline
git log --pretty=3Domfg

and finally (just to make it short *G*)

git log --pretty=3Dosolomio

does trigger the oneline-feature. Perhaps this is not intended to work
as it works now. I would recommend, that the switch should only accept
the fully matched keyword and not just a lowercase "o" as the first
letter of the keywords following after --pretty=3D, just to prevent people=
=20
getting bad habbits.

I noticed this by accident, because i made a typo (i typed "online" a few
times, and then noticed that an o is sufficient), perhaps nobody else
noticed before.

Sincerly
Nicolas


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQFFwm0be35PD2X93kMRAnzXAJ9D85h5LlOiBsmXOVcubPzbjj/LyQCfQE2c
u8xvPZmJJ4ZEk6CE/Zc3RZM=
=zq0e
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
