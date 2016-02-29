From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/22] remote-curl.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:50:29 -0800
Message-ID: <xmqqbn6zbbbe.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:50:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaStx-0000Om-TC
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcB2Sud convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:50:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751602AbcB2Sud convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:50:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 419D247874;
	Mon, 29 Feb 2016 13:50:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r70L2MH7R7tn
	rf6/R+T7wdRnY4c=; b=gPeNDdPARMn+sqeXasN8YqKG7lRAMdGVzEVXrJClzLZz
	3Sh/9+HnFN2Q0DLeh2M+nwpjur/RY6iX0duW1rPDinpdvGGp0r5AXsXirbX8lK5N
	N1oGvtsf0m0JZAxReATVXri80tNOuCzajBjpBEdZVpm2WKY/x9JASu9TNTsQaFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZI6HI6
	sKZ813rAx7YymM2p+99qiuIW8nrAWzvfCLNqFnTRD4kcL/iWUZ5O/4IgkBxz6Bu5
	1xz5wZq4hZ6OqLufwLY7Vw/WD00ujsWEUp5AiDKnnkhpF955JkbaF2EZP55nIpHr
	ARVVHN73K/db5RNQq/vWKaZWw9TyVqXnRREi8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A7F347873;
	Mon, 29 Feb 2016 13:50:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EED0147872;
	Mon, 29 Feb 2016 13:50:30 -0500 (EST)
In-Reply-To: <1456555333-5853-16-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E8E69EC-DF15-11E5-91B6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287867>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

All (or at least most) of these look old ones.  I'm inclined to say
we should do the whole thing post 2.8.0 release for this file.

>  remote-curl.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 15e48e2..d5b33aa 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -177,7 +177,7 @@ static struct ref *parse_info_refs(struct discove=
ry *heads)
>  			mid =3D &data[i];
>  		if (data[i] =3D=3D '\n') {
>  			if (mid - start !=3D 40)
> -				die("%sinfo/refs not valid: is this a git repository?",
> +				die(_("%sinfo/refs not valid: is this a git repository?"),
>  				    url.buf);
>  			data[i] =3D 0;
>  			ref_name =3D mid + 1;
> @@ -285,13 +285,13 @@ static struct discovery *discover_refs(const ch=
ar *service, int for_push)
>  		break;
>  	case HTTP_MISSING_TARGET:
>  		show_http_message(&type, &charset, &buffer);
> -		die("repository '%s' not found", url.buf);
> +		die(_("repository '%s' not found"), url.buf);
>  	case HTTP_NOAUTH:
>  		show_http_message(&type, &charset, &buffer);
> -		die("Authentication failed for '%s'", url.buf);
> +		die(_("Authentication failed for '%s'"), url.buf);
>  	default:
>  		show_http_message(&type, &charset, &buffer);
> -		die("unable to access '%s': %s", url.buf, curl_errorstr);
> +		die(_("unable to access '%s': %s"), url.buf, curl_errorstr);
>  	}
> =20
>  	last=3D xcalloc(1, sizeof(*last_discovery));
> @@ -314,7 +314,7 @@ static struct discovery *discover_refs(const char=
 *service, int for_push)
>  		strbuf_reset(&exp);
>  		strbuf_addf(&exp, "# service=3D%s", service);
>  		if (strcmp(line, exp.buf))
> -			die("invalid server response; got '%s'", line);
> +			die(_("invalid server response; got '%s'"), line);
>  		strbuf_release(&exp);
> =20
>  		/* The header can include additional metadata lines, up
> @@ -422,7 +422,7 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd,=
 void *clientp)
>  			rpc->pos =3D 0;
>  			return CURLIOE_OK;
>  		}
> -		error("unable to rewind rpc post data - try increasing http.postBu=
ffer");
> +		error(_("unable to rewind rpc post data - try increasing http.post=
Buffer"));
>  		return CURLIOE_FAILRESTART;
> =20
>  	default:
> @@ -604,11 +604,11 @@ retry:
> =20
>  		ret =3D git_deflate(&stream, Z_FINISH);
>  		if (ret !=3D Z_STREAM_END)
> -			die("cannot deflate request; zlib deflate error %d", ret);
> +			die(_("cannot deflate request; zlib deflate error %d"), ret);
> =20
>  		ret =3D git_deflate_end_gently(&stream);
>  		if (ret !=3D Z_OK)
> -			die("cannot deflate request; zlib end error %d", ret);
> +			die(_("cannot deflate request; zlib end error %d"), ret);
> =20
>  		gzip_size =3D stream.total_out;
> =20
> @@ -726,7 +726,7 @@ static int fetch_dumb(int nr_heads, struct ref **=
to_fetch)
> =20
>  	ALLOC_ARRAY(targets, nr_heads);
>  	if (options.depth)
> -		die("dumb http transport does not support --depth");
> +		die(_("dumb http transport does not support --depth"));
>  	for (i =3D 0; i < nr_heads; i++)
>  		targets[i] =3D xstrdup(oid_to_hex(&to_fetch[i]->old_oid));
> =20
> @@ -743,7 +743,7 @@ static int fetch_dumb(int nr_heads, struct ref **=
to_fetch)
>  		free(targets[i]);
>  	free(targets);
> =20
> -	return ret ? error("fetch failed.") : 0;
> +	return ret ? error(_("fetch failed.")) : 0;
>  }
> =20
>  static int fetch_git(struct discovery *heads,
> @@ -787,7 +787,7 @@ static int fetch_git(struct discovery *heads,
>  	for (i =3D 0; i < nr_heads; i++) {
>  		struct ref *ref =3D to_fetch[i];
>  		if (!*ref->name)
> -			die("cannot fetch by sha1 over smart http");
> +			die(_("cannot fetch by sha1 over smart http"));
>  		packet_buf_write(&preamble, "%s %s\n",
>  				 oid_to_hex(&ref->old_oid), ref->name);
>  	}
> @@ -832,13 +832,13 @@ static void parse_fetch(struct strbuf *buf)
>  			struct object_id old_oid;
> =20
>  			if (get_oid_hex(p, &old_oid))
> -				die("protocol error: expected sha/ref, got %s'", p);
> +				die(_("protocol error: expected sha/ref, got %s'"), p);
>  			if (p[GIT_SHA1_HEXSZ] =3D=3D ' ')
>  				name =3D p + GIT_SHA1_HEXSZ + 1;
>  			else if (!p[GIT_SHA1_HEXSZ])
>  				name =3D "";
>  			else
> -				die("protocol error: expected sha/ref, got %s'", p);
> +				die(_("protocol error: expected sha/ref, got %s'"), p);
> =20
>  			ref =3D alloc_ref(name);
>  			oidcpy(&ref->old_oid, &old_oid);
> @@ -850,7 +850,7 @@ static void parse_fetch(struct strbuf *buf)
>  			to_fetch[nr_heads++] =3D ref;
>  		}
>  		else
> -			die("http transport does not support %s", buf->buf);
> +			die(_("http transport does not support %s"), buf->buf);
> =20
>  		strbuf_reset(buf);
>  		if (strbuf_getline_lf(buf, stdin) =3D=3D EOF)
> @@ -886,7 +886,7 @@ static int push_dav(int nr_spec, char **specs)
>  		argv_array_push(&child.args, specs[i]);
> =20
>  	if (run_command(&child))
> -		die("git-http-push failed");
> +		die(_("git-http-push failed"));
>  	return 0;
>  }
> =20
> @@ -962,7 +962,7 @@ static void parse_push(struct strbuf *buf)
>  			specs[nr_spec++] =3D xstrdup(buf->buf + 5);
>  		}
>  		else
> -			die("http transport does not support %s", buf->buf);
> +			die(_("http transport does not support %s"), buf->buf);
> =20
>  		strbuf_reset(buf);
>  		if (strbuf_getline_lf(buf, stdin) =3D=3D EOF)
> @@ -994,7 +994,7 @@ int main(int argc, const char **argv)
>  	git_extract_argv0_path(argv[0]);
>  	setup_git_directory_gently(&nongit);
>  	if (argc < 2) {
> -		error("remote-curl: usage: git remote-curl <remote> [<url>]");
> +		error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
>  		return 1;
>  	}
> =20
> @@ -1017,14 +1017,14 @@ int main(int argc, const char **argv)
> =20
>  		if (strbuf_getline_lf(&buf, stdin) =3D=3D EOF) {
>  			if (ferror(stdin))
> -				error("remote-curl: error reading command stream from git");
> +				error(_("remote-curl: error reading command stream from git"));
>  			return 1;
>  		}
>  		if (buf.len =3D=3D 0)
>  			break;
>  		if (starts_with(buf.buf, "fetch ")) {
>  			if (nongit)
> -				die("remote-curl: fetch attempted without a local repo");
> +				die(_("remote-curl: fetch attempted without a local repo"));
>  			parse_fetch(&buf);
> =20
>  		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list =
")) {
> @@ -1060,7 +1060,7 @@ int main(int argc, const char **argv)
>  			printf("\n");
>  			fflush(stdout);
>  		} else {
> -			error("remote-curl: unknown command '%s' from git", buf.buf);
> +			error(_("remote-curl: unknown command '%s' from git"), buf.buf);
>  			return 1;
>  		}
>  		strbuf_reset(&buf);
