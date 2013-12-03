From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re* [PATCH] Improvements to git-archive tests and
 add_submodule_odb()
Date: Tue, 3 Dec 2013 21:42:08 +0100
Message-ID: <20131203204208.GC4629@sandbox-ub>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
 <6D370472-81BB-4249-9ADA-1C906C26D88F@mac.com>
 <20131203181807.GA4629@sandbox-ub>
 <xmqqpppdok2f.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Townsend <nick.townsend@mac.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 21:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnwnW-0000Ed-08
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab3LCUmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 15:42:18 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:45187 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972Ab3LCUmR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:42:17 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VnwnK-0007nB-NB; Tue, 03 Dec 2013 21:42:10 +0100
Content-Disposition: inline
In-Reply-To: <xmqqpppdok2f.fsf_-_@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238736>

Hi,

On Tue, Dec 03, 2013 at 10:39:36AM -0800, Junio C Hamano wrote:
> OK, thanks, then let's do this.

Yes, sounds good.

Cheers Heiko

> -- >8 --
> From: Nick Townsend <nick.townsend@mac.com>
> Date: Mon, 25 Nov 2013 15:31:09 -0800
> Subject: [PATCH] ref-iteration doc: add_submodule_odb() returns 0 for=
 success
>=20
> The usage sample of add_submodule_odb() function in the Submodules
> section expects non-zero return value for success, but the function
> actually reports success with zero.
>=20
> Helped-by: Ren=E9 Scharfe <l.s.r@web.de>
> Reviewed-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Nick Townsend <nick.townsend@mac.com>
> ---
>  Documentation/technical/api-ref-iteration.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/technical/api-ref-iteration.txt b/Document=
ation/technical/api-ref-iteration.txt
> index aa1c50f..02adfd4 100644
> --- a/Documentation/technical/api-ref-iteration.txt
> +++ b/Documentation/technical/api-ref-iteration.txt
> @@ -50,10 +50,10 @@ submodules object database. You can do this by a =
code-snippet like
>  this:
> =20
>  	const char *path =3D "path/to/submodule"
> -	if (!add_submodule_odb(path))
> +	if (add_submodule_odb(path))
>  		die("Error submodule '%s' not populated.", path);
> =20
> -`add_submodule_odb()` will return an non-zero value on success. If y=
ou
> +`add_submodule_odb()` will return zero on success. If you
>  do not do this you will get an error for each ref that it does not p=
oint
>  to a valid object.
> =20
> --=20
> 1.8.5-262-g1a2486c
>=20
