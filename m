From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Sat, 13 Jun 2015 00:32:23 +0200
Message-ID: <20150612223223.GA22677@leeloo.kyriasis.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
 <1434147436-21272-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 00:32:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XV3-0006uT-5U
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbbFLWc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 18:32:28 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:50708 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbbFLWc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:32:27 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 15641222;
	for <git@vger.kernel.org>;
	Fri, 12 Jun 2015 22:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=mfnm6uA0ytXHYtGTVRD5dSunOOU=; b=arAXpl
	Syo1/yOpKAxaj7ipZr1PazbZWdhuMHyRn0SRcseoCt/BWtkM5Vs++dCU4wIxp8q2
	vMP7hW6OOlX1bgoaXCcmtBBLJu8LQ5Z0x+UmjN+EV49SjbR9R7//3dGvauUSm9q/
	mX50slJXpglH860/nRqihExkHiET3ABCwOcik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=Xzjjh/XUqBmXDyFYrjR8nB2Wo8aDEQJ2
	zd/bXVd9DQW8hFSY2EkwthoC5WE8JmeSOxnp4SvJ6wzxkYSU3vFLop+RHXUXtUhR
	jLN+AdTGpEqctAts1trqkuPBt+Tv3702sjkF2CDy6a6jYuC+OMwN/jsKumvKSBdb
	Bk4akmWIeOE=
Received: from leeloo.kyriasis.com (m77-218-249-155.cust.tele2.se [77.218.249.155]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id a8c4d3d4;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Fri, 12 Jun 2015 22:32:26 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1434147436-21272-1-git-send-email-johannes@kyriasis.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271540>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13/06, Johannes L=C3=B6thberg wrote:
>Git should fail to clone if trying to clone from an non-existing
>ref namespace, since it's the same as a non-existing repository
>
>Signed-off-by: Johannes L=C3=B6thberg <johannes@kyriasis.com>
>---
>
>Changes since v1:
>
>* Fixed the namespace check, since I apparently forgot to check with a
>  bare repo in my last test. D'oh.
>
>Two other options for this would be to either add a
>get_git_namespace_len() function and use that, or a is_namespaced()
>functon. But since it's only used here for now at least it feels simpler
>to not bloat the codabase with another function which has no other use.
>

I should note that I have a small test script written now, ready to be=20
converted into a git test, though I want some opinions on whether the=20
patch would be merged before bothering to convert it.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVe130AAoJEJAcHDIOsNRdK3wgAJvHBI8IEAFXG8M4DP5JVnkT
FYpmBcU0ooaoBH01skbK7mMnraAD2KjwUFKEuGdHFsYnaFbIMd21981ytMMf5Ofe
veD74FiyzfHQnCa74qnFUE6yOtMang6fclzLDm+tYibtZe4XDuBU0cLM5iLIJypn
dgyoAjAN7rHPKB8HELKgM5+cLTxzY5jnqebpV5mjqi0zp/ruJwKtuMDvWgFD4uyn
6ody40ZJWEhc/uRmz0aUvO7HecWcJgRakXFREgJANZ02zZ4/wf2k6fI1gke34GlU
O0DFHTIvFRUpb8PGZEhaJFDQVavX/g8Wq4IXN9IpIAMZNOG/HtioNMHmrac4KyiF
TVFo7Diop2ZI91c509nLdQDuxg0kmJD1MOWl4oeWIYJpIHt2rvNcDuaguLPF/hAJ
Dk+cS7ePs97yuksXOhKX577h/IsuN3VIElNqx3nUS0ImjbIAaY9eroTsxhP4XJip
OtuXpTVLyWvWfqcbztlpRXl3sc0tXCP99EbS7VXBJfAGS6apEZ07mquhNUTc9s/F
xh1K6R30dSWFQNbSL/9KOahHVmDgYuE0bB3neiwU3cheanzsscX6kOA9Gy1UX33+
wdg9C4OQNfaPmfUQtpYCpgxBuEkCvPRm2V0c1EQx4WYBjVpnstbXCIVFRYvZLhJz
RwHUMx/yce+g/PRAfmkz31YLF+FLa+mqedj5qSf/UQyow6l58PW3tTCqx6fmcLiu
gxviu9O0xH7EHDFsQZe9KuG8s/SDnH2t3ioDIKMTbTMDd162mHl3WV7Iu4eCbcbW
ckBIr7m3zxIMOp9KoWkOpdbTNO/ETtpP3RQGOVcUMYIwoxRkC+6QdOGLDWD3h8dG
2UuqtiqcU/mTjHkrb8ks925KuGR4twwPkU0uI4hbpHCVNqsYc10to+XpuwgUw+Ew
BQpiWjR4ZxK1yBXBS0nW2eN0Jm3QEP2xGaRvo4CQS60MrBrG+7FFq8Ak2BFGsi1c
09etLpwI5WsmMkMwcTT+k+u0j8Ysg7954zlRwUt15AfNfXQQv9BbGrJrMSw4tAnC
YW+6BDcK/3oBtLc8g6tCVirCQiiOLJ7tPCUE8MIBW0EFTbobyeM+J40yGo00odiT
3O0NDBkb3urATkIN5k8/8ZDK1XiRKmAuMZZA+LanXOR69KI/AQRKRQ3hCxvqVrd5
ne+UTkqOREyMeMV79KnP9kBNJipJUa1kysnrIuiPmiLvrEKqI08uYR2hFOpHfizQ
ksEKpz2rN8qBDUdOxGNZ5888M4pnYpZfAo+V0PZRDUlAAYhxgj6BXJgnIz3qZcGu
uCUjghaKRlW8LSQhdH5Ef7CV08alDGVAhsP4bF1G2duxHvgiBhIr4iQaKGJxs54=
=4c/I
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
