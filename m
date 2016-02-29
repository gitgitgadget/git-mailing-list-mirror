From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/22] convert.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:29:33 -0800
Message-ID: <xmqq60x7cquq.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:29:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSZl-0005oQ-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbcB2S3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:29:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753170AbcB2S3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:29:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 212F347262;
	Mon, 29 Feb 2016 13:29:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jduRjjcWwqeR
	wzH3sEM/nG5FJ4U=; b=VoY9uCWXx//Ddu0/oAzf0QAaZXPWB9LM36khi9dmL6my
	AJprVSnbXZIgm2djnIRiwWAs1tDi9bLtB0HMMuGSmJuPaO1kvquftoixNmc69naK
	yEYd2dsKpR/KbBTmqjlagHzhGW0goMs58x9/xGW5oWksKge2mJTE6LDd0DleF5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ILmn6e
	DgnRi9HYhcnKW7lSsdHhDB+mzoiLVjk+Ob7WBceC5ozUOM4zsEHQDV4EYVyHOCUG
	DZ7Y9IOb7k9ka4BxoV8iel9JUoLX+WLA+35nfXd8pqoOkiNzGmJD8uz7dM0iTUVW
	8MAzyGHTiudLxpKBugOJRK8KMpAeXRwpwW9QA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 175FF47261;
	Mon, 29 Feb 2016 13:29:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 889A347260;
	Mon, 29 Feb 2016 13:29:34 -0500 (EST)
In-Reply-To: <1456555333-5853-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:41:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61ABE16A-DF12-11E5-BA50-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287860>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

All (or at least most of) these look old ones.  I'm inclined to say
we should do the whole thing post 2.8.0 release for this file.

>  convert.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index f524b8d..59d03b0 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -199,9 +199,11 @@ static void check_safe_crlf(const char *path, en=
um crlf_action crlf_action,
>  		 */
>  		if (stats->crlf) {
>  			if (checksafe =3D=3D SAFE_CRLF_WARN)
> -				warning("CRLF will be replaced by LF in %s.\nThe file will have =
its original line endings in your working directory.", path);
> +				warning(_("CRLF will be replaced by LF in %s.\n"
> +					  "The file will have its original line "
> +					  "endings in your working directory."), path);
>  			else /* i.e. SAFE_CRLF_FAIL */
> -				die("CRLF would be replaced by LF in %s.", path);
> +				die(_("CRLF would be replaced by LF in %s."), path);
>  		}
>  	} else if (output_eol(crlf_action) =3D=3D EOL_CRLF) {
>  		/*
> @@ -210,9 +212,11 @@ static void check_safe_crlf(const char *path, en=
um crlf_action crlf_action,
>  		 */
>  		if (stats->lonelf) {
>  			if (checksafe =3D=3D SAFE_CRLF_WARN)
> -				warning("LF will be replaced by CRLF in %s.\nThe file will have =
its original line endings in your working directory.", path);
> +				warning(_("LF will be replaced by CRLF in %s.\n"
> +					  "The file will have its original line "
> +					  "endings in your working directory."), path);
>  			else /* i.e. SAFE_CRLF_FAIL */
> -				die("LF would be replaced by CRLF in %s", path);
> +				die(_("LF would be replaced by CRLF in %s"), path);
>  		}
>  	}
>  }
> @@ -397,7 +401,7 @@ static int filter_buffer_or_fd(int in, int out, v=
oid *data)
>  	child_process.out =3D out;
> =20
>  	if (start_command(&child_process))
> -		return error("cannot fork to run external filter %s", params->cmd)=
;
> +		return error(_("cannot fork to run external filter %s"), params->c=
md);
> =20
>  	sigchain_push(SIGPIPE, SIG_IGN);
> =20
> @@ -415,13 +419,13 @@ static int filter_buffer_or_fd(int in, int out,=
 void *data)
>  	if (close(child_process.in))
>  		write_err =3D 1;
>  	if (write_err)
> -		error("cannot feed the input to external filter %s", params->cmd);
> +		error(_("cannot feed the input to external filter %s"), params->cm=
d);
> =20
>  	sigchain_pop(SIGPIPE);
> =20
>  	status =3D finish_command(&child_process);
>  	if (status)
> -		error("external filter %s failed %d", params->cmd, status);
> +		error(_("external filter %s failed %d"), params->cmd, status);
> =20
>  	strbuf_release(&cmd);
>  	return (write_err || status);
> @@ -462,15 +466,15 @@ static int apply_filter(const char *path, const=
 char *src, size_t len, int fd,
>  		return 0;	/* error was already reported */
> =20
>  	if (strbuf_read(&nbuf, async.out, len) < 0) {
> -		error("read from external filter %s failed", cmd);
> +		error(_("read from external filter %s failed"), cmd);
>  		ret =3D 0;
>  	}
>  	if (close(async.out)) {
> -		error("read from external filter %s failed", cmd);
> +		error(_("read from external filter %s failed"), cmd);
>  		ret =3D 0;
>  	}
>  	if (finish_async(&async)) {
> -		error("external filter %s failed", cmd);
> +		error(_("external filter %s failed"), cmd);
>  		ret =3D 0;
>  	}
> =20
> @@ -868,7 +872,7 @@ int convert_to_git(const char *path, const char *=
src, size_t len,
> =20
>  	ret |=3D apply_filter(path, src, len, -1, dst, filter);
>  	if (!ret && required)
> -		die("%s: clean filter '%s' failed", path, ca.drv->name);
> +		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
> =20
>  	if (ret && dst) {
>  		src =3D dst->buf;
> @@ -892,7 +896,7 @@ void convert_to_git_filter_fd(const char *path, i=
nt fd, struct strbuf *dst,
>  	assert(ca.drv->clean);
> =20
>  	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
> -		die("%s: clean filter '%s' failed", path, ca.drv->name);
> +		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
> =20
>  	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksaf=
e);
>  	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
> @@ -932,7 +936,7 @@ static int convert_to_working_tree_internal(const=
 char *path, const char *src,
> =20
>  	ret_filter =3D apply_filter(path, src, len, -1, dst, filter);
>  	if (!ret_filter && required)
> -		die("%s: smudge filter %s failed", path, ca.drv->name);
> +		die(_("%s: smudge filter %s failed"), path, ca.drv->name);
> =20
>  	return ret | ret_filter;
>  }
