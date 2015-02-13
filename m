From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/2] Getopt::Long workaround in send-email
Date: Fri, 13 Feb 2015 22:21:20 +0000
Message-ID: <20150213222120.GB4738@vauxhall.crustytoothpaste.net>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
 <1423858769-1565-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 23:21:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMOc6-0008Jo-51
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 23:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbbBMWV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 17:21:26 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48660 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753132AbbBMWVZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2015 17:21:25 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:9041:14ab:d6b:d429])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 21EED2808F;
	Fri, 13 Feb 2015 22:21:24 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	"Kyle J. McKay" <mackyle@gmail.com>
Content-Disposition: inline
In-Reply-To: <1423858769-1565-1-git-send-email-gitster@pobox.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263845>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2015 at 12:19:27PM -0800, Junio C Hamano wrote:
>The first one is a replay of Kyle's workaround for older versions of
>Getopt::Long that did not take "--no-option" to negate a boolean
>option "--option".  The second one revert the workarounds made to
>the test script over time, and should break if the first one does
>not work well for older Getopt::Long (I have no reason to suspect it
>would break, though).
>
>I am inclined to squash these into one commit before starting to
>merge them down to 'next' and then to 'master', after getting
>Tested-by: from those with older Getopt::Long (prior to 2.32).
>
>Obviously, tc/t9001-noxmailer topic will become unnecessary and be
>dropped when that happens.

I think this is a good fix.  It preserves the documented behavior even=20
on less capable systems.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU3njgAAoJEL9TXYEfUvaLgQoP/2Im4tmkoX3erzaypc3czSg3
jnH3jrvzDNpusoYJKkx1BqbpcqJkpAp012SDNTM6RtCy6w7ZipUZiHt+4Xex/PqF
KWm/McGJyy2RSwf7yvrxeTgUyMCgATw26PvmYjIQnEUoSY/rZSwrsBu7RFbCE3+J
hd9dAhDVCd4FVDtOyyTG8jpqoMmtoHhbQRtDd1NbZLBO2GP9fX/NEc/XDnBEHTGG
p8WxTXalN8gJl3mWHwlqRqXOYsQnnAyIXZ/sHC4tTLUf2NI8El62zUeGxGVTMXpu
oZ2dzGMjMyDTDgAp/Ek2rIkgJWLhlge4RvTG5jgJ6HFykf2Q0QmRk8631EG9Sn9w
CekmZ/GMQ6gjRX5F3lvpfoZuNp9WeVegFrCz2pfawwgMQpdkyJdMXSbMtzQxVHaY
on6I9QafNtmwMKkpLqgH467906pI0UI0d1xVXkClGsdrojB6NvPD9HeUEsAphxKh
gbzNYmccJkiyZfW97eInJT084cv28n0bdi+BkxCkMcd0bgiQmp0lN+oRg6ThdftK
T1XMNfg0yRvBzZ9U9vqTu4Mv5K4zpXxEiLZr+7iKPJE3U+FEW90RTf6oTVfFdKBw
FT+QB2u/qbLd6/KEttuiFrsydWlhP2Rv1VWvLf/Uy2Uj5Ekgg0yNS367orfm05Ed
6ZxZ0PwNSPlMIV2G4Ni8
=XL3e
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
