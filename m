From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Fri, 29 Aug 2014 00:05:02 +0000
Message-ID: <20140829000502.GC53982@vauxhall.crustytoothpaste.net>
References: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
 <20140827192848.GC7561@peff.net>
 <805178325.32077.1409168920760.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
 <20140827200612.GA10469@peff.net>
 <597210348.36175.1409173228026.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
 <20140827222803.GZ20185@google.com>
 <1506847499.57192.1409201670955.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: dev <dev@cor0.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:05:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN9gt-0005sk-Pd
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 02:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbaH2AFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 20:05:12 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49830 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752565AbaH2AFL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 20:05:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4A0602808F;
	Fri, 29 Aug 2014 00:05:08 +0000 (UTC)
Mail-Followup-To: dev <dev@cor0.com>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <1506847499.57192.1409201670955.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256135>


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2014 at 12:54:30AM -0400, dev wrote:
> Funny I don't see libcurl anywhere. Thought that was needed? Also the
> RUNPATH
> and RPATH look duplicated and slightly borked but the initial data there
> is correct enough to locate all the libs except for some strange libz
> issue.

The main git binary is not linked with libcurl, only the HTTP and FTP
programs.  You'd want to check git-remote-http, for instance.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT/8OuAAoJEL9TXYEfUvaLZaQP/j8rLISJKoXdbYwjw3VEvb8C
steRoiDe6sJhk/cXJK6UK5JWc7yz2t5rffu+yILDRP6oNNL1MuIn4wJsbXq2HCmP
uyYnxzey6TwYAKgM5ez+K4Jaa1o8ixHjYm1oaVV0OQl09zYhga+5YmF0w8x0zmvf
Kct0zQKFLPQ0iqM45AmQFAZqpxw3fLL6K3wKIRxS6QQcInvCO5JG4ZMedAfQOlng
YE4SOzA2MxA6Q5pFpFSUPbp4fuHfAEU6FlqtxPDCaXWQIeSX1ZtUrlrS9ES/sqsP
xhrsqvQmB/ws70fyQrtQdcNuLomR+vR/JlNZpM3QH1Gg/v+Vo4xG5hcH0DpsQqWa
JyaCHNCWzxFU2YudZzl3hNwUov16zomUjH13hC6E2ZgEY1dbzIcY8SmRdRXeiLwT
XHZNfC0E9zWuzi570T4iQ042UZ+fFXLOgPKCw51P3dvhaMz84pUE13GCHBZLnkRa
Sw/4uei76MCr6vY9eqwUOUJ3BpxKOq/WHf3iOy/00BpNgHwvgZAt469kERONwnAF
ZdTG+Ipa4CsO1PuDcay+FwuTtKhjcMOhYnVkuLlLDmsE8njkMIQ/L0qFth0Dt0Qt
/YQT76P8qP6wx/jk+NjRX5o3SFQs0Zdi+K3UxlFEbuXjI0uf9CO0N/NxhoYbKAsr
EMAqT4C0xUmXdmD7FXfq
=aP+f
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
