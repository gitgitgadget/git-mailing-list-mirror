From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 02/10] Define utility functions for object IDs.
Date: Sun, 8 Mar 2015 14:48:16 +0000
Message-ID: <20150308144816.GB4245@vauxhall.crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-3-git-send-email-sandals@crustytoothpaste.net>
 <CACsJy8DBpRPq34=JwJJEOp=DoCP_dkRQB60xPCyqoBFjui416A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 15:48:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUcVG-0004Lr-NN
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 15:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbbCHOsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 10:48:22 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49866 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752556AbbCHOsV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2015 10:48:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e0df:a888:a4a7:fd4e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 07AC62808F;
	Sun,  8 Mar 2015 14:48:20 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8DBpRPq34=JwJJEOp=DoCP_dkRQB60xPCyqoBFjui416A@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265089>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2015 at 04:57:36PM +0700, Duy Nguyen wrote:
>On Sun, Mar 8, 2015 at 6:23 AM, brian m. carlson
><sandals@crustytoothpaste.net> wrote:
>> I'm not very excited about having to put the #include in the middle of
>> cache.h.  The alternative, of course, is to move enum object_type up,
>> which I can do if necessary.  Another alternative is to simply move the
>> struct object_id definitions to cache.h instead of object.h, which might
>> be cleaner.
>>
>> I'm interested in hearing opinions about the best way to go forward.
>
>I think declaring struct object_id in cache.h would be simplest.
>Another alternative is do it in git-compat-util.h. This is not the
>first abuse of git-compat-util.h (because it's included everywhere).
>starts_with(), ends_with() and friends are already in
>git-compat-util.h

cache.h is so ubiquitous due to the hash* functions that I didn't need=20
to include it anywhere, so I don't see a reason to abuse=20
git-compat-util.h for that purpose.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/GEwAAoJEL9TXYEfUvaL0VkP/3LMJSCYctBydnddjvYL9gqk
tVxQLj7YEjnV3rPnulrIxagHnkNg650rexoXHvc+f+gMe5ssdvIdaW2/1xrurF8O
8cdLaOfj5AsXkEzIo/w9E2nK34w3jgBpLvhcOlQ+t9BsPJe4QXN1flntxkMg38jA
P77IXcJc47cg80JBedt7J88f9HuxwWh5y1ABGnqJ672p+ZVAS8JVzUAiqr1f3EVV
KXQcedsUdE3utb1/pme82+lMrmbv9BX9xJqsad/IQkX8FxA6L9kkdOj93EFnzIsA
moZRFX4WMEpZdrQ3p/AROPYAHpzav7og9QPiPHfjp9UxHc5sEL616bzOESc2C+56
G1n7DdEpAhiz7LyRLAn260U5URJsxyCtkKpVmIIIMX4TFH8f/UX6FOla1iDPHxxq
MrmeyJFqndGsH5pyFDYKtXNmIeN1ZoX0shx7xR3TMk50z0T7SP/qlqKXAgT1oNBq
QbSV7iyJn38EysEGBEx27vXvZV7zDzKXCamPm2BxOwbfW7Q9apzcpmiVZA1BrH+p
2Nzywoe1sR+HxuAGPRvQkZlBkqzSnR3B8EuSIinUo0yIvGsMJuoPtQvNT4VEnCiI
IBFCElq+rMPMja7FjCRaOOiiJU59Hl2+g6dCnnCNCK2WihoQ5TGNwyFANM/nHO5k
kRxfydLZM7A2dSZFzJPQ
=9xnR
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
