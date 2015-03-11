From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Wed, 11 Mar 2015 21:59:20 +0000
Message-ID: <20150311215919.GA46326@vauxhall.crustytoothpaste.net>
References: <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
 <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
 <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
 <ABA76895-9BD2-4EA8-B765-0F9DE71A2CEC@cisco.com>
 <3E5DD2BE-1E44-4D0A-89A1-627A1239C72A@cisco.com>
 <E53D99DB-E894-4FA8-9351-39E23FFD677E@cisco.com>
 <20150310222907.GA36141@vauxhall.crustytoothpaste.net>
 <68DFACB3-5EA7-4414-9B74-B4E6F6A417B9@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "Dan Langille (dalangil)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 22:59:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVof6-0005yH-J1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 22:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbbCKV72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 17:59:28 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50024 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501AbbCKV71 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 17:59:27 -0400
Received: from vauxhall.crustytoothpaste.net (ng1.cptxoffice.net [208.74.121.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 670F42808F;
	Wed, 11 Mar 2015 21:59:26 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <68DFACB3-5EA7-4414-9B74-B4E6F6A417B9@cisco.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265342>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 07:33:05PM +0000, Dan Langille (dalangil) wrote:
>> On Mar 10, 2015, at 6:29 PM, brian m. carlson <sandals@crustytoothpaste.=
net> wrote:
>> Does it work with a ticket if you specify a username, as in the
>> following URL?
>> https://bmc@git.crustytoothpaste.net/git/bmc/homedir.git
>
>Yes, that does work.  Our project is 98% of the way there now.
>
>I looked at both libcurl and git environment variables to see if there
>was a way to specify the user without putting it in the URL.  I didn=E2=80=
=99t see one.
>
>My next step is the git configuration, either server or client.  Do you kn=
ow
>if I should stop looking now because it=E2=80=99s not there?

You might try looking at git config --help.  It looks like there's a
credential.username option that might do what you want.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVALq3AAoJEL9TXYEfUvaLkdoP/iZ3E8sXyhmi7CWe+poaxo3O
8+VenypkWKJff9470AFwPGcw9EXpUmdbJLagrAHZTnKuYXIrTkYZc0Ero8WWTAUc
GcyY3SVQjvcnQkIRYqsTlCPVXJha7A5BM0hDCQo5IjROylJgJzcqXjAokCjoEm+r
FEq4P+05OavDUO/sEFGoyuOIUICoH5p8zDkTvzH/fgkw6K93+QT4Wj2dOuexc9F+
Od+Ni1+Qex/5lx0zkCwMx+PWvLK9EL35phphcA0qmQlXUaCQkPyfytuPl5rJS1nt
uPh/nK6akCNNt/H+Y2UVsCvmGNL5d8dYdQJg43qHiqnOfS3yE22c6MQ66B1FgRq/
npZm4pp/VQokBk9nQZVj3FPB2zpgv3kAKn48IiNDIXPFfCUAYcth7fb/yDT+NxE3
S3dHTTLOkWmAczL2GdHgNnhD0UaZFqVO9IGFnY2KC+/0VdsSmv1g5X79dpb73jce
rr4cdow1cBnudYO2Lz7wO6vFauhOI8gNor7MGOAhBEyNKNLqgVGo760A4Pxh0qW3
EEOuVFFjw4Ng3/2kK23pCuq4nRCFWAcmwjRfDs3aXcA9kgXZSpiOZySFZ7+mnMi0
m/mhfUmA9ZZuZDNpRrzTrNJotJeldg45NMym6+ia0ghP9ChMfvcCMEfifA69f1AE
4Zfc6joCiwZDQjnGQbcO
=/Dif
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
