From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] dir.c: coding style fix
Date: Mon, 14 Jul 2014 15:30:51 -0700
Message-ID: <xmqq4myjy3ms.fsf@gitster.dls.corp.google.com>
References: <53C3A71F.1020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 00:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6om0-0004Qc-P1
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 00:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149AbaGNWbB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 18:31:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64079 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756976AbaGNWa7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2014 18:30:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C620A27EE9;
	Mon, 14 Jul 2014 18:30:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/Cf8mBxBMcon
	F0kYicLe/+/gdZg=; b=CzzQ4f/C7c1xNgRuZla81AaW9bV2ALMJC3pNQhMmiopC
	ixvTrZEZRkr7/UKaEA3ykJPG4sDcNvLWRu7EnqAYtJf6iv07zOzSXj/9PlpE+pxx
	WeWkOr3SmuWew21zAFBGZr9u2GVQGkRQcwtVEhd3FRhy2iqrA4RNXYzFaQr7L0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u8+bmL
	F5LWU9ygLAIFSN53h4579CglfXWIoHJzJwZcK9zqpXRJkpr7p4Heo7uAdU0ilIm1
	01dgvkjmF1db54uecO9iRw3jPZr+P695fkFYm8yKWmPQYkDWzIp0N2+L7dYt/JYk
	+zbRxIwnjYZcQWpxq7+ln4xsyWEym4PxoPX0E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB2FF27EE8;
	Mon, 14 Jul 2014 18:30:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F3D0C27EE6;
	Mon, 14 Jul 2014 18:30:35 -0400 (EDT)
In-Reply-To: <53C3A71F.1020101@gmail.com> (Karsten Blees's message of "Mon, 14
	Jul 2014 11:47:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 79928F4A-0BA6-11E4-B0DF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253544>

Karsten Blees <karsten.blees@gmail.com> writes:

> From: =3D?UTF-8?q?Nguy=3DE1=3DBB=3D85n=3D20Th=3DC3=3DA1i=3D20Ng=3DE1=3D=
BB=3D8Dc=3D20Duy?=3D
>  <pclouds@gmail.com>
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---

Thanks for forwarding.   I'll fix-up the Yikes (see how these two
lines show the same name in a very different way), but how did you
produce the above?  Is there some fix we need in the toolchain that
produces patch e-mails?

>  dir.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index e65888d..3068ca8 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -557,8 +557,7 @@ int add_excludes_from_file_to_list(const char *fn=
ame,
>  			buf =3D xrealloc(buf, size+1);
>  			buf[size++] =3D '\n';
>  		}
> -	}
> -	else {
> +	} else {
>  		size =3D xsize_t(st.st_size);
>  		if (size =3D=3D 0) {
>  			close(fd);
> @@ -793,9 +792,11 @@ static void prep_exclude(struct dir_struct *dir,=
 const char *base, int baselen)
> =20
>  	group =3D &dir->exclude_list_group[EXC_DIRS];
> =20
> -	/* Pop the exclude lists from the EXCL_DIRS exclude_list_group
> +	/*
> +	 * Pop the exclude lists from the EXCL_DIRS exclude_list_group
>  	 * which originate from directories not in the prefix of the
> -	 * path being checked. */
> +	 * path being checked.
> +	 */
>  	while ((stk =3D dir->exclude_stack) !=3D NULL) {
>  		if (stk->baselen <=3D baselen &&
>  		    !strncmp(dir->basebuf, base, stk->baselen))
> @@ -822,8 +823,7 @@ static void prep_exclude(struct dir_struct *dir, =
const char *base, int baselen)
>  		if (current < 0) {
>  			cp =3D base;
>  			current =3D 0;
> -		}
> -		else {
> +		} else {
>  			cp =3D strchr(base + current + 1, '/');
>  			if (!cp)
>  				die("oops in prep_exclude");
