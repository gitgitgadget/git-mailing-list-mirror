From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [msysGit] [PATCH] mingw-multibyte: fix memory acces violation
 and path length limits.
Date: Sun, 29 Sep 2013 13:01:35 +0200
Message-ID: <5248088F.2060902@googlemail.com>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com> <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info> <524796DC.5020302@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="h8mSG6fUkMeGRcG2bwaauFxTF1bubx9ie"
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 29 13:01:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQEl6-0002fp-AB
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 13:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab3I2LBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 07:01:37 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:57330 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3I2LBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 07:01:35 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so2084079eek.36
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=ad/tx4Plv37mJ1KzI2wZlgCIxnYVGhls8w/C4o8TpP0=;
        b=sjHBlYbIhRMhAoHaiUZJUCV/boAsMFYWftSsdiTYqmGggj5j6KynJ9YtaY10gw0V33
         RlJ7MnYXgt9xs5DmrJDVETVKMZubSiGyaG3ACcDbUBOyTQ1mUBpg3zGB4LAkGVxRVORE
         OfCckiE9tKtzj7AcyNcIhkWFYymufR8g5Z6HzO7SxhOOn10/quh7iQHGUHRdBrTthj8u
         Mt71lstRC00FUyyBNxQXlVAb7rt/3eX36uVb8OG3OXoY6sVvmPPuLQaFKpWbB3s7/Hmt
         UYhK93VCJ++ewUe0hg2rCacPFcayDLJRYJvU+viYiYdbKP+RSHIZpfwq8BdNT3e1QynZ
         DOCA==
X-Received: by 10.14.213.68 with SMTP id z44mr11344eeo.70.1380452493871;
        Sun, 29 Sep 2013 04:01:33 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id h45sm38236495eeg.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 04:01:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <524796DC.5020302@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235596>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h8mSG6fUkMeGRcG2bwaauFxTF1bubx9ie
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2013 04:56 AM, Wataru Noguchi wrote:
>=20
> - gcc optimization level is O2.(fail)
> - gcc O0, O1 works fine.

Maybe you could try to compile with
STACK found at http://css.csail.mit.edu/stack/
That tool is designed to find
Optimization-unstable code.




--h8mSG6fUkMeGRcG2bwaauFxTF1bubx9ie
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSSAiPAAoJEJQCPTzLflhqvFQQAIFN3tMPZh10T4+G/VgaBoq3
M/BZ2UV8Ooc4gnZ5ycDp5lrG7j6ewncQK7JWYdVYjmYdG9MYH8rMmMeexKtvoqyl
RtdQeWcmZGOTq0DGiBtF5mbh4EcyTxaB01MnRpFcOIlH+R4pas3JtmwKi0kUz/dT
F2ZlYDjRRcb0lIiKT9PxUM5sW0KQx4Dmxrfi+UfoyB0FBOaJj/JdTSuUvcHIAtHg
v4RuCEm0SgKhDvYGA0gvIapfByPQAD4wuamp+y0dGILPsuXb0AVwIOoV5Q0ICmCd
Y0WdJiReuFEyWtxVLVhai/M4RFm5yAHG0xqPDxnUXvqAQyjSxXV+0yIjP+4ZeTXR
FrlFwiv8HQ9RQRXZ3oFv78cljnwq7XkQPlbl8qz7Hw5/juYatMaLN7wm0srxLQ8L
BdAyaDohxvA0JV9vslzg/VvkX0QPEr1Cblsjgi0PNHohWTBKaBq47K4YDGEPqGuj
mJ0YoH7tSNO37DD87IqPN5ODBaALJLbKoQ6Ao0cyAPGDdKufTIIaFYR8RnrKXpH/
zBCmWut4zglZMlMTx+sWa5ufWV7C8zNSVrAOj3sF/ccxLXpy7to9/uf6vzqMOtAM
JiggDeFlgvhgInQtwnjOdzZMaMIqIrq+IW+QO7qUXP5pI33fhshDhvlllRNVpp/a
BfuQUMUWIxN+phukv5LT
=BR38
-----END PGP SIGNATURE-----

--h8mSG6fUkMeGRcG2bwaauFxTF1bubx9ie--
