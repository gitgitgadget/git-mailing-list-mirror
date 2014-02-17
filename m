From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: Output from "rev-parse --resolve-git-dir" changed: two lines (prints
 original argument)
Date: Mon, 17 Feb 2014 09:13:40 +0100
Message-ID: <5301C4B4.5070503@thequod.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fxc1cDEjuUxkuEAsdIVQlfs409CLhOF0n"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 09:13:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFJKl-0000hl-SN
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 09:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbaBQINn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 03:13:43 -0500
Received: from hahler.de ([188.40.33.212]:38998 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbaBQINm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 03:13:42 -0500
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id 17C9562101
	for <git@vger.kernel.org>; Mon, 17 Feb 2014 09:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:subject:subject:mime-version
	:user-agent:from:from:date:date:message-id:received:received; s=
	postfix2; t=1392624820; bh=PIE2jjEda5lN0956jsnGISrNm6TbK0VkjoxuX
	Thi+Vk=; b=VlFegldBXrk+TFWNGRmxDgMQYrQLedl2m1x7DilPZr9oCIPou1CuW
	oQJnouiMstNqy36hkpHGo+hwIYVxWFQnnmzzsOvSPyIS/TfTxm12WQJSw166pR9U
	NUixcCpZ/6iK/2DkpxaKUSpyuspgGMz71bPO9Z2S16oZPKA7rTsxCo=
X-Virus-Scanned: Debian amavisd-new at amavis.thequod.de
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id d5i2oO14SXIU for <git@vger.kernel.org>;
	Mon, 17 Feb 2014 09:13:40 +0100 (CET)
Received: from lenny.thequod.de (91-65-218-186-dynip.superkabel.de [91.65.218.186])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Mon, 17 Feb 2014 09:13:40 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242247>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fxc1cDEjuUxkuEAsdIVQlfs409CLhOF0n
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have noticed that the output from "git rev-parse --resolve-git-dir" cha=
nged.

While it used to only print the resolved git dir, it now prints the argum=
ent passed to it itself:

    % git rev-parse --resolve-git-dir .git
    /path/to/root/.git/modules/vim/bundle/reporoot
    .git

This is with Git version 1.8.5.3, but also happens with master.

You can use "--flags" to avoid this ("git rev-parse --flags --resolve-git=
-dir .git"), but it is unclear from the documentation if that's the inten=
ded beahviour.

It seems like the "--resolve-git-dir" subcommand needs to consume the arg=
ument passed to it.


Regards,
Daniel.

--=20
http://daniel.hahler.de/


--fxc1cDEjuUxkuEAsdIVQlfs409CLhOF0n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iD8DBQFTAcS0fAK/hT/mPgARApM6AKDEZ9fVBAgSYLlGSRNCfHvH4BkRtACgm7L+
O9kXqe/RJB+obm7906kC96I=
=wJIU
-----END PGP SIGNATURE-----

--fxc1cDEjuUxkuEAsdIVQlfs409CLhOF0n--
