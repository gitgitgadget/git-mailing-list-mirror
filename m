From: Beat Bolli <bbolli@ewanet.ch>
Subject: Re: [PATCH v2] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 23:02:36 +0200
Message-ID: <5400EA6C.3030504@ewanet.ch>
References: <1409331522-8457-1-git-send-email-bbolli@ewanet.ch> <xmqqwq9r5dhb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NmCmptegiWVI7VElF1SJucOfX3wNqXFcT"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 23:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNTQd-0002k1-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 23:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbaH2VJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 17:09:47 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:50489 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbaH2VJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 17:09:47 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Aug 2014 17:09:46 EDT
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 0B946C3444;
	Fri, 29 Aug 2014 23:02:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	NORMAL_HTTP_TO_IP autolearn=ham version=3.3.2
Received: from mcmini.bolli (84-243-153-5.dyn.cable.fcom.ch [5.153.243.84])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id D3AABC3442;
	Fri, 29 Aug 2014 23:02:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqwq9r5dhb.fsf@gitster.dls.corp.google.com>
OpenPGP: id=506A903A;
	url=http://drbeat.li/pubkey.asc
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256195>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NmCmptegiWVI7VElF1SJucOfX3wNqXFcT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 29.08.14 20:59, Junio C Hamano wrote:
>> +# ISO strict date format
>> +test_expect_success 'ISO and ISO-strict date formats display the same=
 values' '
>> +	git log --format=3D%ai%n%ci | sed -e "s/ /T/; s/ //; s/..\$/:&/" >ex=
pected &&
>> +	git log --format=3D%aI%n%cI >actual &&
>> +	test_cmp expected actual
>> +'
>=20
> This is saying that as long as --date=3Diso-strict format is
> bug-to-bug compatible with --date=3Diso format it is OK.
>=20
> Which is fine, especially knowing the implementation ;-)
>=20

Yeah, I wasn't sure how to test this, since the commit dates change with
each test run. Maybe it's the easy way out, but on the other hand it's
better than no test at all. Check the known parts with a regex?

Thanks,
Beat
--=20
mail: echo '<bNbolOli@ewaSPnetAM.ch>' | tr -d '[A-S]'
pgp: 0x506A903A; 49D5 794A EA77 F907 764F  D89E 304B 93CF 506A 903A
gsm: 4.7.7.6.0.7.7.9.7.1.4.e164.arpa
icbm: 47.0452 N, 7.2715 E

"It takes love over gold, and mind over matter" -- Dire Straits


--NmCmptegiWVI7VElF1SJucOfX3wNqXFcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQA6m8ACgkQMEuTz1BqkDq3uQCgwND7vE19x4V1rjBbyM7djo4K
dnUAnA9U63tCjGWAmtbWvjgQ3SPa6w+7
=MIem
-----END PGP SIGNATURE-----

--NmCmptegiWVI7VElF1SJucOfX3wNqXFcT--
