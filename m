From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: diff: use built-in patterns by default via git attributes
Date: Tue, 09 Dec 2014 21:18:30 +0100
Message-ID: <54875916.7020107@thequod.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LvE9IcINm8Hpw4cG3CgDvFrGpJFSpMSfJ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 21:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRLY-0006AC-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbaLIUZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:25:17 -0500
Received: from hahler.de ([188.40.33.212]:35406 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbaLIUZP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:25:15 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Dec 2014 15:25:15 EST
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id 76C6E6212D
	for <git@vger.kernel.org>; Tue,  9 Dec 2014 21:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:subject:subject:mime-version
	:user-agent:from:from:date:date:message-id:received:received; s=
	postfix2; t=1418156313; bh=XrU1K9DoGzG6iitKqv29Gpc3DD1DL2Tr+pbiL
	KzcEnQ=; b=K/9JJhq6L9YrjlOL7xfhajZPriUh5VHxWmsiIA1OZlemFpOZjW7ph
	5lNRAVihFRZlVQBCvXxFCLJ6jfLzb279EY5hsk/WrcW2ri9/H47McHmzA408FUYO
	lb49SWXmtGa8eQXRCof1LSAvaFU2dU1B7QXhRSWhrRgXH+aj79Ljsk=
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id zjzkdSpRkXjv for <git@vger.kernel.org>;
	Tue,  9 Dec 2014 21:18:33 +0100 (CET)
Received: from lenny.thequod.de (ip5b403898.dynamic.kabel-deutschland.de [91.64.56.152])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Tue,  9 Dec 2014 21:18:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261159>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LvE9IcINm8Hpw4cG3CgDvFrGpJFSpMSfJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm wondering why the built-in patterns (defined in userdiff.c) are not
being applied by default, e.g. what you would normally do in
core.attributesfile via:

    *.py diff=3Dpython

Wouldn't it make sense to provide certain defaults for attributes, where
Git provides enhanced patterns?


Regards,
Daniel.

--=20
http://daniel.hahler.de/



--LvE9IcINm8Hpw4cG3CgDvFrGpJFSpMSfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iD8DBQFUh1kWfAK/hT/mPgARAuZYAKCWCnrZXNMPdompJHS6RSUXWkhQGQCgjfNK
TmwdxV7+skOy4ORiK6aENA0=
=GtX4
-----END PGP SIGNATURE-----

--LvE9IcINm8Hpw4cG3CgDvFrGpJFSpMSfJ--
