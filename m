From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 09:47:42 +0200
Message-ID: <520C879E.6090101@googlemail.com>
References: <520BAF9F.70105@googlemail.com> <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com> <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com> <201308141125.59991.mfick@codeaurora.org> <520C01C3.2060804@googlemail.com> <7vhaersx74.fsf@alter.siamese.dyndns.org> <vpqy583hoax.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF169D61F3713BB9C74A2C4F0"
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, iveqy@iveqy.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 15 09:47:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9sHW-00044U-Dm
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 09:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760457Ab3HOHri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 03:47:38 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:60440 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760427Ab3HOHrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 03:47:37 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so320418wes.10
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=s5z5mo58eN6WIAHGljOhxDg5rgCx/TLKrtWK5vTGZD4=;
        b=Lm51nUeXu+CeY+os7QjZRsqWrbZ071F4m05orVHJWYC+KDs5maA/EbnAKnz+Q5JyVU
         5S5jzwGE4h2bRItkkzzuMEIkBMLUzzDtmT16GPjXE7ESSwfXZbFqdPAkyMr3xp+gW83C
         vfuhz8dKkjz0f3q8R31nGVXRG7nKmxuod3o/8AUD78iDzDVaFWfenleox4tsWMaQccXS
         XT7LBRDBNmvqfMm4siJ7p/RA5SqRQ+oZiH5DxakhippONjZcASIm9f1PTDeGLm3JSjY5
         I8u5bYbHt0jTA3ICIFBT6YnqreYdBuPuoiMEwGiMQIQlSIiFydnOKzbRNoKYx8FCx7et
         DkQg==
X-Received: by 10.180.189.132 with SMTP id gi4mr1069578wic.19.1376552856537;
        Thu, 15 Aug 2013 00:47:36 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id l7sm1318739wiw.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 00:47:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <vpqy583hoax.fsf@anie.imag.fr>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232335>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF169D61F3713BB9C74A2C4F0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2013 12:59 AM, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>
>>> I asked for a todo wish list a few weeks ago, but got no real answer,=

>>> but rather: "Pick your choice and try to come up with good patches".
>>
>> Hmph, I hope that wasn't me.
>>
>> There are some good ones here;
>>
>>   http://git-blame.blogspot.com/search?q=3Dleftover
>=20
> See also:
>=20
>   https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
>=20

Thanks, I bookmarked both of those pages.
The wiki already lists Rewrite "git repack" in C at the
very end, so my sense where to start wasn't way off. ;)




--------------enigF169D61F3713BB9C74A2C4F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDIeeAAoJEJQCPTzLflhqmZsQAKuvPS3JbiPA91J62gcLKqVP
k1y3vlLD1roWx+NlukGbn4ksf+VfiPoF8fDz/DZ0l28rLFhjOyFw48Hqu0jHH5Fg
fdeX9JEzflGPbRD/QfbptpXoRKVijnHNxpAoVEn9wB7qHIP3IxMVt8J6NXVRQ3UE
pgmD2ZVFVwU2bWpnwABpAss4kFS3LCgMUzlNh3M0zp3rR1dYGX/zgKobjCgfWzVD
K6ddabRX/gPF24uau04OsC6AHfChKhKuWw9vZS8nI0RlhMkiRyzXBeHV5+r50zB6
S+9UgGmdGCfAjPCPLI6jgIerHEkVRD25EM4n7hKUjBPU86Z+1GGdA0/aCGo47q4f
PW71KaHdrZ/7Tekan8FItjj4MX52AjVXfoNgvbzvbhtE/GfzR5D/yGTLipKN2L6t
WRZ7dPQ61OvWDq91k7MFSrN//x36HmjKMl50k+KXmRSOcE63t9DJS8JSSPZWrKC/
ha6PwQ5M2PJQpywDRR2ZTl7Ptb3ywDFAIxK9hIGI2rDh5HAnOM0LX1VWzHcRzX7q
bBXy1Ke90z5i4IMvr0z0IziwluNmCSmBoc0bz0Na5PgAT7c41HPgHrvc73vLpfql
O+DMxXX7fHfjxuYnOHZRAanwuCWbYbRn0m0a8uH1QWwLU1CWZFYxHlqiC2GXQ6kV
JCKt79OaDEIVkQAwYZij
=oCJG
-----END PGP SIGNATURE-----

--------------enigF169D61F3713BB9C74A2C4F0--
