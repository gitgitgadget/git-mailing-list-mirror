From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/22] http.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:31:44 -0800
Message-ID: <xmqqwppnbc6n.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:31:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSbo-0006ty-Gv
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbcB2Sbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:31:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751353AbcB2Sbr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:31:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D6D94735B;
	Mon, 29 Feb 2016 13:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ItWqYOYQ1zDT
	jnD+DUfzsmIYfgY=; b=UYWVSvTlpYI56S05M3KeD78e6lqqGPows3DC5h+4aKVp
	VajK8fGmrtkSLIugNe8KqmlI3xcc0m4baEvfSCd/gYcg6hI15vWNFN0iCe4mQzw7
	X03TgvXRJ50373xBNAvQn6DM6BKfW81r7q6PXxvQKSBD+ANG4+Ph9pi55aDb+uU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G12Ivj
	16y2FlWpitIvDRStSXQUmyXlzKYCBEGjBM07N2lJ/qCE1RPEoatT/r4PcLeQXWeG
	dTtISCHPdXz1i6yfSpK4UaiEKcdpDkH1ZKS2uRjwHipkX+Jfc4ZnxBU6+dI/UW7r
	8V1iCd+jA8FiTNfx6Jzeth4oFQCuqhfUIGitk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 857074735A;
	Mon, 29 Feb 2016 13:31:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E391347359;
	Mon, 29 Feb 2016 13:31:45 -0500 (EST)
In-Reply-To: <1456555333-5853-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFF9D7A0-DF12-11E5-ADB7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287862>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

All (or at least most of) these look old ones.  I'm inclined to say
we should do the whole thing post 2.8.0 release for this file.

>  http.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/http.c b/http.c
> index 1d5e3bb..d56cb52 100644
> --- a/http.c
> +++ b/http.c
> @@ -404,7 +404,7 @@ static void init_curl_proxy_auth(CURL *result)
>  			}
>  		}
>  		if (i =3D=3D ARRAY_SIZE(proxy_authmethods)) {
> -			warning("unsupported proxy authentication method %s: using anyaut=
h",
> +			warning(_("unsupported proxy authentication method %s: using anya=
uth"),
>  					http_proxy_authmethod);
>  			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>  		}
> @@ -445,7 +445,7 @@ static int sockopt_callback(void *client, curl_so=
cket_t fd, curlsocktype type)
> =20
>  	rc =3D setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
>  	if (rc < 0)
> -		warning("unable to set SO_KEEPALIVE on socket %s",
> +		warning(_("unable to set SO_KEEPALIVE on socket %s"),
>  			strerror(errno));
> =20
>  	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
> @@ -469,7 +469,7 @@ static CURL *get_curl_handle(void)
>  	long allowed_protocols =3D 0;
> =20
>  	if (!result)
> -		die("curl_easy_init failed");
> +		die(_("curl_easy_init failed"));
> =20
>  	if (!curl_ssl_verify) {
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
> @@ -503,7 +503,7 @@ static CURL *get_curl_handle(void)
>  			}
>  		}
>  		if (i =3D=3D ARRAY_SIZE(sslversions))
> -			warning("unsupported ssl version %s: using default",
> +			warning(_("unsupported ssl version %s: using default"),
>  				ssl_version);
>  	}
> =20
> @@ -558,8 +558,8 @@ static CURL *get_curl_handle(void)
>  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols=
);
>  #else
>  	if (transport_restrict_protocols())
> -		warning("protocol restrictions not applied to curl redirects becau=
se\n"
> -			"your curl version is too old (>=3D 7.19.4)");
> +		warning(_("protocol restrictions not applied to curl redirects bec=
ause\n"
> +			  "your curl version is too old (>=3D 7.19.4)"));
>  #endif
> =20
>  	if (getenv("GIT_CURL_VERBOSE"))
> @@ -659,7 +659,7 @@ void http_init(struct remote *remote, const char =
*url, int proactive_auth)
>  	free(normalized_url);
> =20
>  	if (curl_global_init(CURL_GLOBAL_ALL) !=3D CURLE_OK)
> -		die("curl_global_init failed");
> +		die(_("curl_global_init failed"));
> =20
>  	http_proactive_auth =3D proactive_auth;
> =20
> @@ -681,7 +681,7 @@ void http_init(struct remote *remote, const char =
*url, int proactive_auth)
> =20
>  	curlm =3D curl_multi_init();
>  	if (!curlm)
> -		die("curl_multi_init failed");
> +		die(_("curl_multi_init failed"));
>  #endif
> =20
>  	if (getenv("GIT_SSL_NO_VERIFY"))
> @@ -1544,7 +1544,7 @@ static int http_get_file(const char *url, const=
 char *filename,
>  	strbuf_addf(&tmpfile, "%s.temp", filename);
>  	result =3D fopen(tmpfile.buf, "a");
>  	if (!result) {
> -		error("Unable to open local file %s", tmpfile.buf);
> +		error(_("Unable to open local file %s"), tmpfile.buf);
>  		ret =3D HTTP_ERROR;
>  		goto cleanup;
>  	}
> @@ -1601,7 +1601,7 @@ static char *fetch_pack_index(unsigned char *sh=
a1, const char *base_url)
>  	tmp =3D strbuf_detach(&buf, NULL);
> =20
>  	if (http_get_file(url, tmp, NULL) !=3D HTTP_OK) {
> -		error("Unable to get pack index %s", url);
> +		error(_("Unable to get pack index %s"), url);
>  		free(tmp);
>  		tmp =3D NULL;
>  	}
> @@ -1778,7 +1778,7 @@ struct http_pack_request *new_http_pack_request=
(
>  		sha1_pack_name(target->sha1));
>  	preq->packfile =3D fopen(preq->tmpfile, "a");
>  	if (!preq->packfile) {
> -		error("Unable to open local file %s for pack",
> +		error(_("Unable to open local file %s for pack"),
>  		      preq->tmpfile);
>  		goto abort;
>  	}
> @@ -1866,7 +1866,7 @@ struct http_object_request *new_http_object_req=
uest(const char *base_url,
>  	unlink_or_warn(freq->tmpfile);
> =20
>  	if (freq->localfile !=3D -1)
> -		error("fd leakage in start: %d", freq->localfile);
> +		error(_("fd leakage in start: %d"), freq->localfile);
>  	freq->localfile =3D open(freq->tmpfile,
>  			       O_WRONLY | O_CREAT | O_EXCL, 0666);
>  	/*
> @@ -1885,7 +1885,7 @@ struct http_object_request *new_http_object_req=
uest(const char *base_url,
>  	}
> =20
>  	if (freq->localfile < 0) {
> -		error("Couldn't create temporary file %s: %s",
> +		error(_("Couldn't create temporary file %s: %s"),
>  		      freq->tmpfile, strerror(errno));
>  		goto abort;
>  	}
> @@ -1931,7 +1931,7 @@ struct http_object_request *new_http_object_req=
uest(const char *base_url,
>  			prev_posn =3D 0;
>  			lseek(freq->localfile, 0, SEEK_SET);
>  			if (ftruncate(freq->localfile, 0) < 0) {
> -				error("Couldn't truncate temporary file %s: %s",
> +				error(_("Couldn't truncate temporary file %s: %s"),
>  					  freq->tmpfile, strerror(errno));
>  				goto abort;
>  			}
> @@ -1985,7 +1985,7 @@ int finish_http_object_request(struct http_obje=
ct_request *freq)
>  	process_http_object_request(freq);
> =20
>  	if (freq->http_code =3D=3D 416) {
> -		warning("requested range invalid; we may already have all the data=
=2E");
> +		warning(_("requested range invalid; we may already have all the da=
ta."));
>  	} else if (freq->curl_result !=3D CURLE_OK) {
>  		if (stat(freq->tmpfile, &st) =3D=3D 0)
>  			if (st.st_size =3D=3D 0)
