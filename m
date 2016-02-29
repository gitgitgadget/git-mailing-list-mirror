From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/22] credential-cache--daemon.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:30:31 -0800
Message-ID: <xmqq1t7vcqt4.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:30:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSad-0006Gb-5f
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbcB2Saf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:30:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbcB2Sae convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:30:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62AF0472C8;
	Mon, 29 Feb 2016 13:30:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=deBHkigRX+e+
	C6qRZbpTvvTih9s=; b=G2EC5LVOUuUQzCXhfmCUL/N/gN6xZNcMM2G76cb+bH7+
	UrUfWM4OarABtQdeh3ScUXrkm2ZLWxPn1Kq4jvmCJOXx53IgemD6wlWsUSy3Hu2v
	cN3lhC1osd2tbf9Z5I7iRUJ2JwyhJqRqNg2OXgWOOEsL2W+CO0rAGCvjjfdQudo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d0H/WS
	AQazbM1n8nSEIBsExEu7Wv25lj6EuYTBy+f/iqOvchszZ1WQcQPMFO9uV12u+eOI
	O8ilRP9SVzxwBKZF5r1Rr9Yv799UwofloKF6353Tp7FaIq5DOBqIU/gg4ZEZot2+
	zZyNGUn8IexXgNidE2539iDnUt432vogRl7io=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A219472C6;
	Mon, 29 Feb 2016 13:30:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8F977472C3;
	Mon, 29 Feb 2016 13:30:32 -0500 (EST)
In-Reply-To: <1456555333-5853-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84429FD4-DF12-11E5-A876-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287861>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

All (or at least most of) these look old ones.  I'm inclined to say
we should do the whole thing post 2.8.0 release for this file.


>  credential-cache--daemon.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
> index 63ca7c8..ab33355 100644
> --- a/credential-cache--daemon.c
> +++ b/credential-cache--daemon.c
> @@ -98,12 +98,12 @@ static int read_request(FILE *fh, struct credenti=
al *c,
> =20
>  	strbuf_getline_lf(&item, fh);
>  	if (!skip_prefix(item.buf, "action=3D", &p))
> -		return error("client sent bogus action line: %s", item.buf);
> +		return error(_("client sent bogus action line: %s"), item.buf);
>  	strbuf_addstr(action, p);
> =20
>  	strbuf_getline_lf(&item, fh);
>  	if (!skip_prefix(item.buf, "timeout=3D", &p))
> -		return error("client sent bogus timeout line: %s", item.buf);
> +		return error(_("client sent bogus timeout line: %s"), item.buf);
>  	*timeout =3D atoi(p);
> =20
>  	if (credential_read(c, fh) < 0)
> @@ -132,16 +132,16 @@ static void serve_one_client(FILE *in, FILE *ou=
t)
>  		remove_credential(&c);
>  	else if (!strcmp(action.buf, "store")) {
>  		if (timeout < 0)
> -			warning("cache client didn't specify a timeout");
> +			warning(_("cache client didn't specify a timeout"));
>  		else if (!c.username || !c.password)
> -			warning("cache client gave us a partial credential");
> +			warning(_("cache client gave us a partial credential"));
>  		else {
>  			remove_credential(&c);
>  			cache_credential(&c, timeout);
>  		}
>  	}
>  	else
> -		warning("cache client sent unknown action: %s", action.buf);
> +		warning(_("cache client sent unknown action: %s"), action.buf);
> =20
>  	credential_clear(&c);
>  	strbuf_release(&action);
> @@ -160,7 +160,7 @@ static int serve_cache_loop(int fd)
>  	pfd.events =3D POLLIN;
>  	if (poll(&pfd, 1, 1000 * wakeup) < 0) {
>  		if (errno !=3D EINTR)
> -			die_errno("poll failed");
> +			die_errno(_("poll failed"));
>  		return 1;
>  	}
> =20
> @@ -170,12 +170,12 @@ static int serve_cache_loop(int fd)
> =20
>  		client =3D accept(fd, NULL, NULL);
>  		if (client < 0) {
> -			warning("accept failed: %s", strerror(errno));
> +			warning(_("accept failed: %s"), strerror(errno));
>  			return 1;
>  		}
>  		client2 =3D dup(client);
>  		if (client2 < 0) {
> -			warning("dup failed: %s", strerror(errno));
> +			warning(_("dup failed: %s"), strerror(errno));
>  			close(client);
>  			return 1;
>  		}
> @@ -195,13 +195,13 @@ static void serve_cache(const char *socket_path=
, int debug)
> =20
>  	fd =3D unix_stream_listen(socket_path);
>  	if (fd < 0)
> -		die_errno("unable to bind to '%s'", socket_path);
> +		die_errno(_("unable to bind to '%s'"), socket_path);
> =20
>  	printf("ok\n");
>  	fclose(stdout);
>  	if (!debug) {
>  		if (!freopen("/dev/null", "w", stderr))
> -			die_errno("unable to point stderr to /dev/null");
> +			die_errno(_("unable to point stderr to /dev/null"));
>  	}
> =20
>  	while (serve_cache_loop(fd))
> @@ -211,10 +211,10 @@ static void serve_cache(const char *socket_path=
, int debug)
>  }
> =20
>  static const char permissions_advice[] =3D
> -"The permissions on your socket directory are too loose; other\n"
> +N_("The permissions on your socket directory are too loose; other\n"
>  "users may be able to read your cached credentials. Consider running=
:\n"
>  "\n"
> -"	chmod 0700 %s";
> +"	chmod 0700 %s");
>  static void init_socket_directory(const char *path)
>  {
>  	struct stat st;
> @@ -223,7 +223,7 @@ static void init_socket_directory(const char *pat=
h)
> =20
>  	if (!stat(dir, &st)) {
>  		if (st.st_mode & 077)
> -			die(permissions_advice, dir);
> +			die(_(permissions_advice), dir);
>  	} else {
>  		/*
>  		 * We must be sure to create the directory with the correct mode,
> @@ -232,9 +232,9 @@ static void init_socket_directory(const char *pat=
h)
>  		 * our protected socket.
>  		 */
>  		if (safe_create_leading_directories_const(dir) < 0)
> -			die_errno("unable to create directories for '%s'", dir);
> +			die_errno(_("unable to create directories for '%s'"), dir);
>  		if (mkdir(dir, 0700) < 0)
> -			die_errno("unable to mkdir '%s'", dir);
> +			die_errno(_("unable to mkdir '%s'"), dir);
>  	}
> =20
>  	if (chdir(dir))
> @@ -253,7 +253,7 @@ int main(int argc, const char **argv)
>  	const char *socket_path;
>  	int ignore_sighup =3D 0;
>  	static const char *usage[] =3D {
> -		"git-credential-cache--daemon [opts] <socket_path>",
> +		N_("git-credential-cache--daemon [opts] <socket_path>"),
>  		NULL
>  	};
>  	int debug =3D 0;
> @@ -274,7 +274,7 @@ int main(int argc, const char **argv)
>  		usage_with_options(usage, options);
> =20
>  	if (!is_absolute_path(socket_path))
> -		die("socket directory must be an absolute path");
> +		die(_("socket directory must be an absolute path"));
> =20
>  	init_socket_directory(socket_path);
>  	register_tempfile(&socket_file, socket_path);
