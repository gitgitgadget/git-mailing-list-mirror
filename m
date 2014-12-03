From: Debarshi Ray <rishi.is@lostca.se>
Subject: git config option for passing flags to diff
Date: Wed, 3 Dec 2014 14:27:51 +0000
Message-ID: <20141203142741.GA65669@arati.lostca.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 15:33:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwAzX-0003In-CL
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 15:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbaLCOdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 09:33:14 -0500
Received: from arati.lostca.se ([144.76.32.53]:11698 "EHLO arati.lostca.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbaLCOdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 09:33:13 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Dec 2014 09:33:13 EST
Received: from arati.lostca.se (localhost [127.0.0.1])
	by arati.lostca.se (Postfix) with ESMTP id 77070C08;
	Wed,  3 Dec 2014 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lostca.se; h=date:from:to
	:subject:message-id:mime-version:content-type; s=howrah; bh=n4eF
	G2CnZA0Wzbts8vJ5CMlqbIQ=; b=eQ6m/K8xIHyQSwbNiDjjVxnwanzJ7lFFJfPZ
	KzZ2rsSDoGbNKRUTKguaG5ob9TxC0oCgKoJjB2xnNWIc78ebL8F56oj5JZT2B4RO
	r7C5Z4uAJxCabQaxyNG4eG8jcx9U3+9FnqOs2KEwk0CnhJ5vq5ou2UlHwBgVGiFX
	sg+FcDc=
Received: from localhost (unknown [IPv6:2a01:4f8:191:2334::25])
	by arati.lostca.se (Postfix) with ESMTPSA id 44564C07;
	Wed,  3 Dec 2014 14:27:51 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260649>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have been looking for a git config option to turn on
--function-context, and after searching on the Internet and reading
the man pages, #git confirmed that it doesn't exist.

I am wondering if it would be sensible to introduce such a variable?
Or a variable to specify any additional flags to diff?

Thanks,
Debarshi
--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (FreeBSD)

iQIcBAEBAgAGBQJUfx3cAAoJEEMnBfrN1AMlur8P/j4OCpSihewYXsK9JF3CnBNX
6fd/TGix5fIoAaI5R8nAIzVQRBtPyaj5msSOBQez26gWRPPIKf0Xghvv/ehTje2c
Xzq6v6vKEFzQxAC4cMeUzMXBQsI4QXsxF/P2htTLx6kAK+CTsa4apSboiW9M4im9
ntOpb8nw1f8iGy2FePr163viEjvwFTeiceoxZ4k5waiimm/sSq2GUGFehTxf15R1
BxESzHVUNgnX3uCWpQivhzLbpOXPX+arzFLO6NhkzeCynF64Klso4gr0eDxb/E7y
71vlmZFUGFRFuhvi7+cXB2nCfP4bc0ikWYLco7uwGRgxxzNk6BtzmdQONV4CVYk0
mHLEc/mEZnGk3cRUTzp509KkVKCMTjTSz/J3C4WGoyZ8/F1ZfeztZaIUk5+rH94g
PVryqhSswLTmGdNGVQaZKiuJ8AJxmh9wjS75ySnO08sNjKEJRuaEQfDTUyWWWvIc
/dpWnDfI3XMzywRyOeYn53Rbg8h7n9vX28xcII7g8taVH3Y3Lqpt3gb88zdfpGOQ
RBWXEN0kfwBknWoKbE6xZoBdnNHt785IK/QCQMaQmf78PjbU1KA4xV8fSHZIWBZJ
Z77MjsfK5r11tD2Ib7yXUFR7O2bzLm3gRd5HA5VNYe2i73VubuaBeKw1Rj0N87VZ
YVAwD/KYc6r6QMb3htXN
=hd3l
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
