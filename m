From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/4] completion: prioritize ./git-completion.bash
Date: Fri, 3 Jan 2014 22:55:41 +0000
Message-ID: <20140103225541.GG3338@vauxhall.crustytoothpaste.net>
References: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
 <1388736031-6068-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 23:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzDej-0007xV-1G
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 23:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbaACWzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 17:55:49 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50852 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753362AbaACWzs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jan 2014 17:55:48 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d482:2f7d:c25:9548])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4AB2928074;
	Fri,  3 Jan 2014 22:55:45 +0000 (UTC)
Mail-Followup-To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1388736031-6068-2-git-send-email-artagnon@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239940>


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2014 at 01:30:28PM +0530, Ramkumar Ramachandra wrote:
> To ease development, prioritize ./git-completion.bash over other
> standard system paths.
>=20
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  contrib/completion/git-completion.zsh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/g=
it-completion.zsh
> index fac5e71..6fca145 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -30,10 +30,10 @@ if [ -z "$script" ]; then
>  	local -a locations
>  	local e
>  	locations=3D(
> +		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>  		'/etc/bash_completion.d/git' # fedora, old debian
>  		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
>  		'/usr/share/bash-completion/git' # gentoo
> -		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>  		)
>  	for e in $locations; do
>  		test -f $e && script=3D"$e" && break

I'm not clear on this change.  It looks like this loads
git-completion.bash from the same directory as git-completion.zsh.  Is
this correct?  Your commit message says "./", and if that's the case, it
has the same security problems as putting "." first in your PATH.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSxz/tAAoJEL9TXYEfUvaLtO0QAMX04m5vv5RzFSiuGYHEvBeQ
S6q6X8WkdhlViPDjXu07QFeDRybG70Jiy3p9xemLdRv2rYV9+6M7YwfyBtEU5fAT
h1ShWbndzSnVvctdkawAT0WvUrGnUfVY6gYvc8EsMRGh+RtnUv0Uh6YbcrgsIeFQ
OYOvB7IK3sHaVsKRIC76i6WRP4fQhXaQCStZsyYweOChvLWbQnCAPr8cFPUdU/iB
0Cpx4NGvHML9sBSOMT4+lF335k4YdUI7TI6HT3h1RbfeCJyIh/QEww0T00IKgYym
dlXk6HHnF8rDuxnZ3ohBofnzS7MCgXdxRxNAsOyhpv87Kdlvk0UycWJyfzqOiBnA
CS9wtdOUvUualKKCazHhnQOtWLStDj/uCLJgs5ASy6ZYVso9D9EqqAUbN8iV3Z0E
KChxB5XuHxy8HcK2iwy6ZOH3czrPURBTnzukKpnd0ROMbLJEba78oMf1RC4TOXF2
OYUrGwak0vIQxgeCMwIzIU0YjdnvDAhf2F3oiHO9TUBxkaUubWv2MEh8McDKsbIp
kGSj5ACZV1h1kmx+DQ2FD8XJupJCTpevTVzSfhN9WZSvFHsc2RSrsZd/ZH5MHtWz
ojja/z3sKff4DfgmDHVCn39UjVjCgkBK3Sg4WnaZNdOPV0wEBlD7cgYWKjbXS5Vk
QCcy4OdFEyPaefTQvTPv
=emtw
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
