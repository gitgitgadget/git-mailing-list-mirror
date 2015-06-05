From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH] receive-pack: Create a HEAD ref for ref namespace
Date: Fri, 5 Jun 2015 16:10:40 +0200
Message-ID: <20150605141040.GB1165@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <ef4dae3e-3ae8-4727-9448-80f801e1dbdf@email.android.com>
 <55719C47.6030600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 16:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0sKk-00048a-3k
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 16:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbbFEOKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 10:10:44 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52525 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942AbbFEOKm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 10:10:42 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 5cb89d23;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=QXGGjbfDNWiJh5obOj0UoUTpeyM=; b=HNEM5r
	XKZo+aSpF6BJeUTUvd4XUiMtoAL7dnbtpYHQNekqoaOn+mzAYok8r6WY2ckqcFFt
	TTFgFHz552NY8f6z9P/AjB8sN7MbjqjzVOqNOGSZJvXrwDZvnvYp0h7ssskjFk+H
	gLwoTzmXwlF7tgFbmXsQq8AvD5qPjR/rAo40k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=YASXFEr5oLy6q1xEGrs2HqMlFP7blX7p
	KyOMkbRgxk06SB71zKGJdipc90u45f/h20UOdUnW1mFD/YF8RVg2MT8vf8Q5lbDf
	oFyBGx8JBna2gfE2QMaFiTJqTVqrjOH2jTjWNwSiKJMGcf+rPhP0l4YwDXr+0ADc
	cufM7CCpdQQ=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id d847591d;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 14:10:40 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <55719C47.6030600@drmicha.warpmail.net>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270834>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/06, Michael J Gruber wrote:
>(Also, your patch duplicates the line "struct strbuf namespaced_head_buf
>=3D STRBUF_INIT;")
>

I replied too soon, it doesn't duplicate it, it's a different variable=20
named similarly.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVca3cAAoJEJAcHDIOsNRdcMMgAJeshSgrz3dyMdlH4F7YO9eB
Z5nSRDN3SdeDgl4nGbHpI88pq7/EM8AYJ7A7HqeWCZ7+sYvs1+4cSKsqOSR1/725
ZH1dvjH+nGClh179BBvWGNiHmDGo2SMNc/zpEwFhCnEnWk/L6YQBmUJ2fWqNH4jT
F4dGATosvxhQpmNYurLXUsuaDAkQvhdPJzTq9fLn9ra7PJTkRQqzGL8Dgg3X0qeK
aepPNEmPQB9tJ0SEVnABLfrJ1pSU1ndKD5+8scVnd17215gM1jZvE7ZOVV/IwkPy
pi8dO4ZR0kIYVqkEgsnSJMcjaCS1Qx1B+ELlEfHZroLuB436CXOyiJrx7ZEbiAk3
mCqhqwY5vuAbGnMmmZ3LbdhQTQa1GiMndKDAZFYF+O/2CaKF4S4cCX8qCgz3uIpF
Pv3dI7fgTq2gdsXtGflTJG45iTkRQb1/t5ko2K4X2O7BAnZUx+uriNZ8sHnSQoFs
SGGo+omkPe5OvHrEI1+2mB3JeLGCGrFp7cU3VRa5yQa7bisWBZvqDNUJ+rXUs8Fq
538KWeD1c6bmZbgvegijqDP7LO+6jMjpWgDmuoYoUdmrxmNCLeFGn5v1Wpr0KleI
6uMGpmvXc73r4pGS9HcENwilFe+JiDh2CudoOP9NEvF7V07ac6SaHvuL4bJVeN98
4yRNUbs5cn4lC4D5uN8IdRga2YWzub2+hr6xjHkaNb8uk3t2aJv6ebQETL/2ulaP
4htrK8rRAOAJq4pekm901hCN20e6B/CYmHgQFDD1g65CFkqibJnhRjvgTA6Y/vmq
bz5Np+IRFCnmPXPttQEbleFB6OdNFGf0wVpxFVBVsGJ/QdpYvdOQQ9D8T3pieJmB
jxYB2Z1e1DWcHG2DAiaH0fyIR0mlbaH8NsmiEyBfgqak4NRKDxRoCiJn7NAgS5n6
jY7fb4uR7rgkjsRogZUa9Lr05hOXuii0lFGd/k7g0yXAUNYWMtiUgruJfkoVUyeh
5ViMn/wcVyAT6bpvAoDEUJ+as2Sm/wTWFgKvSqck/KbT7Xfli0rvxfXX3+IBdQVB
0B3nrmZjL/mTsrplW0j6SfP4JsqH4w4QhY4irOvttoYwJ0qlW/Gyh0wzs7aaa+F0
PBcM7V+lp/l/HNhZPlrs2BaUbdUc8+1IQIHZGZOkY5WaKBtjJIjceaaoFpeyZiGx
bJmixabl51WtohLq6u9dq+9de+v2Ee+KjqupF1FFk3DE2TGa6UWdI3A417BEHgSr
ICPfF/21PACNMkFYlPteWJvXm9Kv5bJALoRBxCXeXki15waJKTfkl/bCPU1XR9jK
foZV9RTGDOsKxFne1NlCYuTBXuhMocpEodPVELggrG/kdzFwi2FJ8de9DPR9eKE=
=1q8/
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
