From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] Remove deprecated OPTION_BOOLEAN
Date: Mon, 29 Jul 2013 20:18:51 +0200
Message-ID: <51F6B20B.1010709@googlemail.com>
References: <1375112281-3935-1-git-send-email-stefanbeller@googlemail.com> <1375112281-3935-2-git-send-email-stefanbeller@googlemail.com> <7v4nbd1bjj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD4552B56E0250D855F08BBC5"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 20:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3s1q-0000jq-44
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 20:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430Ab3G2SSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 14:18:38 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:38836 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3G2SSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 14:18:37 -0400
Received: by mail-we0-f169.google.com with SMTP id n5so3567395wev.0
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=Te7fW5qbgV+rq8PfFK43G6c8qyecaIblqTLaX1547bM=;
        b=qaceFzPUpgt2xQ18RZGaIBi1Wvwza4qbs/q8n65bmahMvo1oqF7NJDdWhBawCXe61H
         FEMo0fO6c6fs5Nl6vXYURFSPpUMxkAnZE4zFbIU5Vhkuv+iDemZe1pTt59dibGJwzf6W
         LcMPlkH/4/JcEO42DNxe1bYVdkIB2o/x+C0pT3lc00Pl0glXriSzkrQvF9D1lUFFB44h
         X9zfukbV0yYVXe+Z6NQ5uCxsN96K6glgTBcaClLvPmwMmE1r3PxaCTOhD2LZfmwKn5Kq
         ZjIcPJZv6XnPL0siUU3ymC7WqD2zWyJ5RFjitKHOkBqlfdVaT1HnXhoivdxtOQ2kTNYo
         VPNw==
X-Received: by 10.194.2.13 with SMTP id 13mr44800132wjq.74.1375121916728;
        Mon, 29 Jul 2013 11:18:36 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id w4sm24222536wia.9.2013.07.29.11.18.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 11:18:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7v4nbd1bjj.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231315>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4552B56E0250D855F08BBC5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/29/2013 08:11 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> As of b04ba2bb4 OPTION_BOOLEAN was deprecated.
>=20
> The primary purpose of b04ba2bb (parse-options: deprecate
> OPT_BOOLEAN, 2011-09-27) is to deprecate OPT_BOOLEAN(), which was
> hard to use correctly.
>=20
> OPT_BOOLEAN() is not touched at all with this patch, it seems.  Do
> they want count-up semantics?
>=20

I'm working on the OPT_BOOLEAN replacement as well, but the=20
OPTION_BOOLEAN seemed as an easier start (way less until completion)

> At first glance, it looked to me that OPT_HIDDEN_BOOL was a good
> addition, given how often we have PARSE_OPT_HIDDEN.  While I think
> some of the hidden ones are justified, I am not sure if the hiding
> of many options are.  If we stop hiding many of them, HIDDEN_BOOL
> may become not so useful.  I dunno.

There should be no change in semantics.
All those which now use the OPT_HIDDEN_BOOL have had=20
{OPTION_BOOLEAN,..., PARSE_OPT_HIDDEN}
before.

But your concern sounds more like you'd dislike the
appearance of OPT_HIDDEN_BOOL because you'd want to remove the
hidden options. The options being hidden there sound to me as if
those were hidden due to their historical nature and there is always
a non-hidden equivalent being better worded.

Stefan


--------------enigD4552B56E0250D855F08BBC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR9rILAAoJEJQCPTzLflhq18YQAMjx5pksKeBq9pkJxR/vPp9i
tc/1UQ27lzFCelcRwbRFFbGpmnnY8sdsBUpWckj1+JbqpZu7FrFvHd1FX3rjEJJB
UaYTCcg9lhZp/2wVaqUX9Mc6pe57/g1UV+Kb5hridWVcjw46QJvptMEfmiOsuDiE
w/CLDojpKTkA4/k7WedFPF/5NfN6wIC34//Ho9gcQTo0In4iO5NlhoTFPK3fYXGj
QxJvWF5HfDI3xg6z2mzf47p4bfvdh6O7xdn/Nk7df0DBMxkyIRV7OsLayCwQr7Km
CEaXhrty2JnrNmCH1lrW29w8iEPxmWl7It5nmIScy9HvtsYGqqgJ/TRlFSc+pYTx
Ag8RvsJoQWanpwkuVypE9BEteZiqllUiWCs42NyUk2cE7yLxLyOInzrn66TKMIfJ
HHIJqblsTo7eqZ6COVA1U9xML3yaAPSk4MF8X796CJ7cgw/+njlWbMoCnpzQml2c
S4HW6iAW5b/BJMwa4zLIF7ed9hOvwp99kZuEdQ/6nG8N8L5qa1p476ADj1rQhpSv
szxxvnrM11hk5JDcqCl4EeTfpd3AmtfC4ZYl4j5Ihl9zyXJ2zygWSq7K9LUPxxTJ
vhKdbXLTYgCPzyMwga+rldBsHSVozcGLx0HVsZzTelXGfiD+1yRQYkq/YlJcQZpH
EhWp0txjbDFmOALrejDK
=m25q
-----END PGP SIGNATURE-----

--------------enigD4552B56E0250D855F08BBC5--
