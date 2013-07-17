From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Thu, 18 Jul 2013 00:16:36 +0200
Message-ID: <51E717C4.6010606@googlemail.com>
References: <51E431F1.6050002@ramsay1.demon.co.uk> <51E4E0C0.3060604@viscovery.net> <20130716062122.GA4964@sigill.intra.peff.net> <6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley> <51E715D8.9040307@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5A550DC214B87E42B54B6470"
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 00:16:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uza1o-0007Wo-53
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 00:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab3GQWQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 18:16:39 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51916 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab3GQWQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 18:16:38 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so1310940eek.19
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 15:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=wuhq8UGs34hMFJ/EmvCPFUxB3s347S2l6hOuxCEpYoo=;
        b=VS2Ntvj6S8bADTi0sBTVzO0lOEL5/JePUn9NX7QKvdIeXjUCf+1ee+034VNcOTGwoy
         nBvWg+GS1hVZ5Q3j/bAuYlmSe6XJz6Cci91R5T2S+zPzZ/wNVgqUubXUUzAtjyYNl/98
         nC2Dls4eJEhNFoN/7u70aZwPVPeHH/QTUTqbpu0On4Ew290bAwPMjavKEZlmMqjDJQur
         LWMKo25OM26X2ajA3dOzMlFQaHLIzS+ojU75K/bUPJeiLUFwmwxmOuhGvBF63RdIMGKl
         Qc3SIxB7hPjjayCMraxqqXg5u5p5afIV94lr8pFjF7je6+n5AlN4VBS5u/9kGJlAuDUd
         VSuA==
X-Received: by 10.15.35.65 with SMTP id f41mr8323814eev.61.1374099397327;
        Wed, 17 Jul 2013 15:16:37 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id l42sm14150997eeo.14.2013.07.17.15.16.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 15:16:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <51E715D8.9040307@googlemail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230661>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A550DC214B87E42B54B6470
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2013 12:08 AM, Stefan Beller wrote:
>=20
> So I started using the clang code analyzer on git. One of the=20
> first warnings actually is this:
>=20

So in case somebody else would also like to play around with the
clang static code analyzer:

# get clang:
cd <good location>
git clone http://llvm.org/git/llvm.git
cd llvm/tools
git clone http://llvm.org/git/clang
cd <good location>
mkdir build && cd build
cmake ..
# if desired make install

# in the Makefile of git change
CC =3D <good location>/llvm/tools/clang/tools/scan-build/ccc-analyzer
# then obviously:
make clean
make


--------------enig5A550DC214B87E42B54B6470
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR5xfEAAoJEJQCPTzLflhqczIP/2wnDXITslrSyDtzBWzJjNT5
JLXAoIrz45rMLEjLGtNa7xpY40u0nJMA6OUKgiV14O4qcB065yFjhkct0+2cnUGP
+C3e7yvDrlcB5Lx+2YPbduIabKN4ZPRzRdgufjviMKCWgFWxfdPCfOGBlWgfdD19
Jrev6oRaxXVX8I+bNIxnGGLf+njNL+uE1SDaV6qa512VpO14t+13DT4KySEomQ1J
wkukPP9ePrhBo4Kn3231jM0DIsxpJPbu5/C5GwjWkzfnGi1BORv7BS34ECjS+Thy
AZr8kkV9CPLIUES3XpLedquoHHJqsWRNKJ28Gw2AoJUMU9CYKeHQ5uONILVEggi1
F522ZCzbfQDo5ThxTRKisJgLPURwu7TXzSjTj53dK9+DKDwFA8yPnMyTuNJTyXTU
+XnOZSK0cKM8FH7Hc+SG18oUsmMlLfOfSCBx36VH5uH67FRYJoWtIAmabFdB8yfs
kzcmvzlHUvKIR0Ba1R2Ss6u78hEJj/CEBW0Eflqqzz70eiE0yCZydt4YiwAbm4jW
UP24sZRHByLfOiXjUrh3Oe0b8vtkQP2AUuq2rznohcqnjAzevc5Rh5YCAluEX2Ws
435y2ZYl1V0fUcVDsz8Qr2aMKDg3pHM8ozrWkrGRSyG4N+IEAuAGTzFass9DeIoh
n9PMZrk2BCs31kM4+7wf
=sd6H
-----END PGP SIGNATURE-----

--------------enig5A550DC214B87E42B54B6470--
