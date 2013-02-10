From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 08/15] user-manual: Standardize backtick quoting
Date: Sun, 10 Feb 2013 10:22:13 -0500
Message-ID: <20130210152213.GA5462@odin.tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
 <d520dd4ff6774ef8d858a2438008c686d58db9b7.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=dDRMvlgZJXvWKvBx
Cc: Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:22:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Yk4-0007Sh-VW
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758775Ab3BJPW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:22:27 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:41962 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689Ab3BJPW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:22:26 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000G3AG11JOA0@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:22:14 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id A75C987934F; Sun,
 10 Feb 2013 10:22:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509733; bh=aS/XvJmHQc+qqmYAr8hsSsqDPOju02fUfCjgMMXhxFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fOfnia7fhJ8WqJMct9AmrBbebvxNsfI3Q6OpfwsCeB8C3QBABo+iC1zY/Q6lWAWib
 2psfAq/A1d+kw6rEdcySesjvXnX7IwpodIavc9nuvteTP1layqD9G/fomNZkEcevn6
 HS37X5Q/9aZunK1qCWY1M3Zy0N33VFvg15Fe40Y4=
Content-disposition: inline
In-reply-to: <d520dd4ff6774ef8d858a2438008c686d58db9b7.1360508415.git.wking@tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215921>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 10:10:34AM -0500, W. Trevor King wrote:
> @@ -4155,8 +4156,9 @@ As a result, the general consistency of an object c=
an always be tested
>  independently of the contents or the type of the object: all objects can
>  be validated by verifying that (a) their hashes match the content of the
>  file and (b) the object successfully inflates to a stream of bytes that
> -forms a sequence of <ascii type without space> {plus} <space> {plus} <as=
cii decimal
> -size> {plus} <byte\0> {plus} <binary object data>.
> +forms a sequence of
> +`<ascii type without space> {plus} <space> {plus} <ascii decimal size>
> +{plus} <byte\0> {plus} <binary object data>`.
> =20
>  The structured objects can further have their structure and
>  connectivity to other objects verified. This is generally done with

Reading through the user-manual history, it looks like I goofed here.
6cf378f0 (docs: stop using asciidoc no-inline-literal, 2012-04-26)
points out that `{plus}` is no longer interpreted inside backticks.
In v3, I'll use `+` instead of `{plus}`.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRF7skAAoJEEUbTsx0l5OMgaAQAJyCVvzN5eGb/t1FRSmo9PbY
rQ5MfqyIE3f4cwU8OROFghx1JTEQeKJEETHP8Cf1Oo6mCDfLKvEX9Jqsfqy/EMqk
4hIQkkkcZNwhhCfe6JHAJcvag4p8vLfbLWTdgjQEWMXlLhaVa+P6Zn/34SRJ5ByQ
GWB02Cg9twJaP/yFbQ2mIPLyXt+qGSS2PFqbvfVpdm0Nq4UnTJVXDmEmfbqA4DzK
gUEEV/vR6NHW/Y4+gcWKKv0aZZC8Qy5PCWIRvROo4Tf+sHO4by3xi5HzoK8nK4p0
HbTDaDpCIZUI5hqcu7TIKzj3H12TQAZVndIpgYoh1oEuW0ShXQZNf6Uiusl2qgR+
jBxVF+Li1xufdmgFjs9zGEOzJDeRJ+RfDGztCRHNn96PXaqJ9lEysd+L8e6LWPKX
qpwbzavxIA+gsaNHR/4nzYqcdjoy/Q6iEZ7O3GuN/UcOerEGwaASASBUFQ0bS8or
EiRH8QPKmIOx2mY/FoMX1wHtbguSP3Hcyo6e5wCG5BJbh0m3hU8GPZhFpLQUx8V8
mAlMVnhINvVLcfK3VQZHaOHVpECIuZyW7g3BOL7floGwZQwSvljG6nBdaS0oU80d
0rUIyzfEY+weNMtdNiu/4L5cfsP/D4eL81g0SB84ab8NcndHteYXnglPvNtXoel2
cFchwtXS88A8gE22nT4G
=Gtxg
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
