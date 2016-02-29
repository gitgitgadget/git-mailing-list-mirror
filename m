From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/22] ident.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:34:59 -0800
Message-ID: <xmqqsi0bbc18.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:35:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSez-0000F8-TD
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbcB2SfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:35:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbcB2SfE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:35:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B01CC47434;
	Mon, 29 Feb 2016 13:35:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=quObxnFv1XoV
	8Uro9xS0/EHlKbM=; b=LbHKZsENMLolUnDSQYJ3oAk4+5E4X4rRDwIY8SgDqVUk
	eta1SvTzA+p78YNcggw57e8sgehWpKA6EdoP97jtySZqd1urSf4GgXJYI3ttW0wS
	grNZq0d3Oq0EYVT1rDzL57kgHsZY3/yTwuxbidROOScWtcMgN3aWTXtJxQfws6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aip5PO
	Tyy8k8booTiB9Or1eB3Z0CEPQiYan63Z+JSbcOBgp3tIRT7rB+bVJcp98HvmPsWx
	pQr14LdJ6PEpsnWOi9dOYxaLLXFO05UqfqvccBKymiXULtMF9/AGfEkXZ/kgPx9i
	Mhitzs8TIvxDDa1iUAtevzfwd/WffdXq6qmWg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5CCEF47432;
	Mon, 29 Feb 2016 13:35:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 061F747431;
	Mon, 29 Feb 2016 13:35:00 -0500 (EST)
In-Reply-To: <1456555333-5853-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24432314-DF13-11E5-B0B4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287863>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

All (or at least most of) these look old ones; even the ones blamed
to 59f92959 (fmt_ident: refactor strictness checks, 2016-02-04) had
original in the same file without _().

I'm inclined to say we should do the whole thing post 2.8.0 release
for this file.

>  ident.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 6e12582..367a5dc 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -75,13 +75,13 @@ static int add_mailname_host(struct strbuf *buf)
>  	mailname =3D fopen("/etc/mailname", "r");
>  	if (!mailname) {
>  		if (errno !=3D ENOENT)
> -			warning("cannot open /etc/mailname: %s",
> +			warning(_("cannot open /etc/mailname: %s"),
>  				strerror(errno));
>  		return -1;
>  	}
>  	if (strbuf_getline(&mailnamebuf, mailname) =3D=3D EOF) {
>  		if (ferror(mailname))
> -			warning("cannot read /etc/mailname: %s",
> +			warning(_("cannot read /etc/mailname: %s"),
>  				strerror(errno));
>  		strbuf_release(&mailnamebuf);
>  		fclose(mailname);
> @@ -125,7 +125,7 @@ static void add_domainname(struct strbuf *out, in=
t *is_bogus)
>  	char buf[1024];
> =20
>  	if (gethostname(buf, sizeof(buf))) {
> -		warning("cannot get host name: %s", strerror(errno));
> +		warning(_("cannot get host name: %s"), strerror(errno));
>  		strbuf_addstr(out, "(none)");
>  		*is_bogus =3D 1;
>  		return;
> @@ -355,18 +355,18 @@ const char *fmt_ident(const char *name, const c=
har *email,
>  			using_default =3D 1;
>  			if (strict && default_name_is_bogus) {
>  				fputs(env_hint, stderr);
> -				die("unable to auto-detect name (got '%s')", name);
> +				die(_("unable to auto-detect name (got '%s')"), name);
>  			}
>  			if (strict && ident_use_config_only
>  			    && !(ident_config_given & IDENT_NAME_GIVEN))
> -				die("user.useConfigOnly set but no name given");
> +				die(_("user.useConfigOnly set but no name given"));
>  		}
>  		if (!*name) {
>  			struct passwd *pw;
>  			if (strict) {
>  				if (using_default)
>  					fputs(env_hint, stderr);
> -				die("empty ident name (for <%s>) not allowed", email);
> +				die(_("empty ident name (for <%s>) not allowed"), email);
>  			}
>  			pw =3D xgetpwuid_self(NULL);
>  			name =3D pw->pw_name;
> @@ -377,11 +377,11 @@ const char *fmt_ident(const char *name, const c=
har *email,
>  		email =3D ident_default_email();
>  		if (strict && default_email_is_bogus) {
>  			fputs(env_hint, stderr);
> -			die("unable to auto-detect email address (got '%s')", email);
> +			die(_("unable to auto-detect email address (got '%s')"), email);
>  		}
>  		if (strict && ident_use_config_only
>  		    && !(ident_config_given & IDENT_MAIL_GIVEN))
> -			die("user.useConfigOnly set but no mail given");
> +			die(_("user.useConfigOnly set but no mail given"));
>  	}
> =20
>  	strbuf_reset(&ident);
> @@ -396,7 +396,7 @@ const char *fmt_ident(const char *name, const cha=
r *email,
>  		strbuf_addch(&ident, ' ');
>  		if (date_str && date_str[0]) {
>  			if (parse_date(date_str, &ident) < 0)
> -				die("invalid date format: %s", date_str);
> +				die(_("invalid date format: %s"), date_str);
>  		}
>  		else
>  			strbuf_addstr(&ident, ident_default_date());
