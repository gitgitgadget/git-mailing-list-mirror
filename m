From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: Bug: "git rebase --no-autostash" not recognized
Date: Thu, 10 Sep 2015 22:56:07 +0200
Message-ID: <55F1EE67.3090401@thequod.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ARqIktXd0jHrNbDNc7dDR1O5uRl8VCO6a"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 23:06:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za92g-0006Wr-1N
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 23:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbbIJVF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 17:05:57 -0400
Received: from hahler.de ([188.40.33.212]:35938 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbbIJVF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 17:05:57 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2015 17:05:56 EDT
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id 9E1FC62066
	for <git@vger.kernel.org>; Thu, 10 Sep 2015 22:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:mime-version:user-agent:date:date
	:message-id:subject:subject:from:from:received:received; s=
	postfix2; t=1441918575; bh=nKTUoYVLmEkIbFHjTJWaDOe0mC1dYq8rSRT1p
	gXuNcY=; b=joY52r8+XDQBN7BettG2Fcqx0McAFZcFKTybCJQBiw7Ex+gnU1iCd
	4N7JPY1fA0veoEVDfiha/DCm7hwjkNSCJjQ0hBzRT62sK/o3Mm0Kr+sD3tL74ebk
	TiMZIpDF/yASvdKX4akwvcdrtLcoDQQ0eiIhXX1veK7dlFZtGCni1w=
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id s15laKAaiCnT for <git@vger.kernel.org>;
	Thu, 10 Sep 2015 22:56:15 +0200 (CEST)
Received: from lenny.thequod.de (ip5b4039f8.dynamic.kabel-deutschland.de [91.64.57.248])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Thu, 10 Sep 2015 22:56:15 +0200 (CEST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277638>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ARqIktXd0jHrNbDNc7dDR1O5uRl8VCO6a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Although the man page mentions the "--no-autostash" option, it is not sup=
ported:

    % git rebase --no-autostash=20
    error: unknown option `no-autostash'

    % git --version
    git version 2.5.1.dirty


Please CC me in case of replies.


Regards,
Daniel.

--=20
http://daniel.hahler.de/


--ARqIktXd0jHrNbDNc7dDR1O5uRl8VCO6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlXx7m8ACgkQfAK/hT/mPgCtNACfcwN4iYKhjv/6aB+KYXrVFO+f
pOQAoMK2f6NzggUnNBb/I8DPdeoLoRB6
=PMWh
-----END PGP SIGNATURE-----

--ARqIktXd0jHrNbDNc7dDR1O5uRl8VCO6a--
