From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 02/21] path.c: rename vsnpath() to git_vsnpath()
Date: Sat, 14 Dec 2013 20:23:07 +0000
Message-ID: <52ACBE2B.3040909@ramsay1.demon.co.uk>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com> <1387018507-21999-1-git-send-email-pclouds@gmail.com> <1387018507-21999-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 21:23:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrvkB-000455-Me
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 21:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab3LNUXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 15:23:12 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:35988 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753870Ab3LNUXL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 15:23:11 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id B62CC18C761;
	Sat, 14 Dec 2013 20:23:09 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 8020F18C55B;
	Sat, 14 Dec 2013 20:23:09 +0000 (GMT)
Received: from [192.168.254.17] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Sat, 14 Dec 2013 20:23:09 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1387018507-21999-3-git-send-email-pclouds@gmail.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239316>

On 14/12/13 10:54, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> This is the underlying implementation of git_path(), git_pathdup() an=
d
> git_snpath() which will prefix $GIT_DIR in the result string. Put git=
_
> prefix in front of it to avoid the confusion that this is a generic
> path handling function.#
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  path.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/path.c b/path.c
> index 4c1c144..06863b7 100644
> --- a/path.c
> +++ b/path.c
> @@ -50,7 +50,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt=
, ...)
>  	return cleanup_path(buf);
>  }
> =20
> -static char *vsnpath(char *buf, size_t n, const char *fmt, va_list a=
rgs)
> +static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_li=
st args)

:-D I renamed this _from_ git_vsnpath() in commit 5b3b8fa2 ("path.c: Re=
move the
'git_' prefix from a file scope function", 04-09-2012), because ... wel=
l it's a
file scope function! (i.e. the git_ prefix implies greater than file sc=
ope).
I'm not very good at naming things, so ...

ATB,
Ramsay Jones
