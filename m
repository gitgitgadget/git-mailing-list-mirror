From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] am: terminate state files with a newline
Date: Mon, 24 Aug 2015 23:36:12 +0000
Message-ID: <20150824233612.GE232027@vauxhall.crustytoothpaste.net>
References: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
 <xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
 <20150823055053.GA15849@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 01:36:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU1I5-0007gi-Go
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 01:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbbHXXgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 19:36:33 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45979 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753810AbbHXXgS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 19:36:18 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 175D628094;
	Mon, 24 Aug 2015 23:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1440459377;
	bh=6vJzDa9xdmXqYLhytGBVhZYcYNipzmVNd6M0Lc0bMyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1stV4ptq8xfqjOGgCl9rPNBGVoO14N49kzZ2FgaqTwFRj6VxgCuyLW0azYgOkJlU
	 OZnz0QfRlHa1h/KLz6U53rQYXCWJ0u6qqvpfVywDtIupRn1rUCekFFBFDoYZKEb2ia
	 Y7kS/DhRM2DnS9PS5N5yXRA8sl11oPpHY/vb2rn3wq01cyoI0Gseo+B2314ATDhEdm
	 c5868HcvWUuz+LvQJ+KSRhtLAQr7XvPJR/hgcemRdqiOx33g1fIKm3oN/0aOJJAbUv
	 oJTTrpmby9wPgXNB+GozvtJK0UzMf1/pT0ja6tKDNv5NGjmTOx4mWk08z06XVIsSSE
	 sk5pbiGcvnWJudUGmk/4PhyvxlaF2a+Ba62t6xJxcEnl2S7JUdoqmtH8BxF7jhbPEj
	 btqbNCGFYE9oARfB25VEyAB6pM0kUT7W9WC7Fqtco7T1ZT2whJu1fsaNgKDZ0l3/FT
	 vOKwdu2Jdm5nIDnitBwtnx8KsDouOBxukFMHCFVBqhiHuehn82I
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150823055053.GA15849@yoshi.chippynet.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.1.0-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276497>


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2015 at 01:50:53PM +0800, Paul Tan wrote:
> Did we ever explictly allow external programs to poke around the
> contents of the .git/rebase-apply directory? I think it may not be so
> good, as it means that it may not be possible to switch the storage
> format in the future (e.g. to allow atomic modifications, maybe?) :-/ .

zsh's vcs_info does read files in those directories in order to
determine which patches have been applied.  I just submitted a patch to
zsh that fixed warnings when a conflict occurred with git rebase -m.

I expect that unless we provide a programmatic way to discover all of
that information trivially (and maybe even then, due to compatibility
with older versions of git), people are going to poke around those
directories.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.7 (GNU/Linux)

iQIcBAEBCgAGBQJV26psAAoJEL9TXYEfUvaLQy4QAK5OFpAhHYyRRxGiPxMqNTrL
kPViJsgfBQxLuSxklEQ+yFMSPI1vCqnV849aIqVUZc51fEeG6dYAqlKHS1X35U/s
mx/H/JjaENhOMUMsTTe2Ff2dcJtD9zIZTTw1qxUZGjwFWtjr5EVyL9OpzfvWwVtn
bJ/QbHO2mhpqgqSCOoekuvN4RhRlUp3TNayG7LPcg674PwYIVXXDHpCz9MLX8xLM
R8EIYw4XuAK0oRkkOKF4oOXwdeJ6K5OuXsXfUcHm8l9HJ/8RpA2wyzLs9HpLVj5/
qM36QGlit0IcLdn6Oap85Ej+nb7WZYexp3KDw9qtK3ijl1v4u8ubk6Hrcx8MzULW
ejdI2ttL3I6Lm2li6eOBQw5SQZG1JIbuDkESskyeJnLrG5mEUSNFd1ok6Oxpx2Ye
o3UNeJ1/PpAx9jwrXABv/XtK58dSdaSFtAO9ZFk6R+zoWNJagm8Xkz+db+Ppb6nO
CuthO55RvkgvR1x01pDorrw2HsKq79YRLzQVF4Mi+DniHC17GLzSx8w5IdQikui7
vuiP+OmikiAFO0R3zJcW9CTmpt3xXyr9++JJC9vcr1Kjp6qjvrkknR1fe/EbMH/O
XRuhfyRcrGGQNOXxyFjFZPqgvSWI6Ulx+MtbuH/gtHJQQjGiy9EIRz1UDRJQDW1X
icUF+T+4aSB/H2b9+EO5
=/cL6
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--
