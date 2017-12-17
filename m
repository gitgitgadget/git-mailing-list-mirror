Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151CC1F404
	for <e@80x24.org>; Sun, 17 Dec 2017 17:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757352AbdLQROY (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 12:14:24 -0500
Received: from mout.web.de ([212.227.17.11]:60879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752395AbdLQROW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 12:14:22 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lm4lR-1ezxCJ1sNV-00ZcGu; Sun, 17
 Dec 2017 18:14:06 +0100
Date:   Sun, 17 Dec 2017 18:14:04 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        patrick@luehne.de, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
Message-ID: <20171217171404.GA18175@tor.lan>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171211155023.1405-1-lars.schneider@autodesk.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:yzRIOPbX5TtOuRpxUCVu8+nErALln6Ki+MkkpadYmuD03cGrWwB
 UUcqCw3SgoO3fs1z6WsJE2d2N+vUoZZiZQcbTZxO9QAn4lAdvvfqpOO3dKydOs8PcfPi8Aj
 2tcTpl2jxmMLtmtsKHc6cbet6qetVRQ2CRh6dnlU+IJX0M5jDL4vELr79Q14VQG8rqukYp7
 fmHj5Uqp47/DkRnpGxELA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BvX5WYG0DMU=:Uc6X+ElHpTnBbxD3gDl5Rf
 VD9u6nlSDIXsokbdpbdOd1c745IcmIev7JhZC1DI37FxZwlCnINzaV8+1iAP90prMbvAJDQlh
 p2aj2ojC3WWEOC4yoUXODDvtB+wWZgnreeuZUPZPNwyKiiMAduJy1NscVWNxkSowk6Q5KZePy
 IbL3Fb7R3zrZCVc1JdD8IHP0E6J3AGYMldqjLC+dnUSfGbo5MyGJlKyLiJZiyAtuEK0RNsq5Q
 mzjYVetaP9AZHy0Td3XMQ1Eo93nVNmP1HqyzJFHxD8LduMTlqGTMhGjxIwa0kJvIZyu1FzRPu
 QzTaCpHK4wyCricrjiE6+DPZpUV4KtQbnPKhxJ3LN/C2PdD2YKRZWt3FVG52TpDpjb91FVQXm
 6K5RmNZ3mhdy2YR5Zel9NiFPsLE5CSu38VrUlZYoyMV+wjWlsFpF0KQA2CzDvY9T5bboJFUty
 8aCA08Nomk/Z3iur+CcgNIV/zDzEVlTza7+5w/51OSXLXvVND5fJNzZfX6sH43KXtK0cNic7G
 /aFUeIfzKPPaR72wDCdPHp/lcyt0yBPHfW+ovQw+uY0Dyy1T0H0u9IJIpZp9JR3VriFIoOCWh
 nKEJxK4eN8shl17+PK4WJbaZMvVeKu1VHm9Wi1rZUpP/t+vG7y5t4asF8YLGOlczIVyn0L0sz
 GT/vJVTPqt2s5ObtljxsAM5I8HLgm+VufPCjfBAyHkZuow0qNsNBm4lEi3cx0FcTagBew6IEF
 S6P39i/yyIEV1TGQjg1Jmzh134lsJlGkI4OOVfzdSU0obtRqvdiTHuH6R9DhtpTYoKYpYb/AB
 3OQ63lQpNh1NUbmw1/1AUFhothfDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 04:50:23PM +0100, lars.schneider@autodesk.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git and its tools (e.g. git diff) expect all text files in UTF-8
> encoding. Git will happily accept content in all other encodings, too,
> but it might not be able to process the text (e.g. viewing diffs or
> changing line endings).
> 
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the
> content to a canonical UTF-8 representation. On checkout Git will
> reverse the conversion.
> 
> Reviewed-by: Patrick Lühne <patrick@luehne.de>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> 
> Hi,
> 
> here is a WIP patch to add text encoding support for files encoded with
> something other than UTF-8 [RFC].
> 
> The 'encoding' attribute is already used to view blobs in gitk. That
> could be a problem as the content is stored in Git with the defined
> encoding. This patch would interpret the content as UTF-8 encoded and
> it would try to reencode it to the defined encoding on checkout.
> Plus, many repos define the attribute very broad (e.g. "* encoding=cp1251").
> These folks would see errors like these with my patch:
>     error: failed to encode 'foo.bar' from utf-8 to cp1251
> 
> A quick search on GitHub reveals 2,722 repositories that use the
> 'encoding' attribute [1]. Using the GitHub API [2], I identified the
> following encodings in all publicly accessible repositories:
> 
>     ANSI        <-- garbage (ignore by my implementation)
>     cp1251
>     cp866
>     cp950
>     iso8859-1
>     koi8-r
>     shiftjis    <-- garbage (ignore by my implementation)
>     UTF-8       <-- unnecessary (ignore by my implementation)
>     utf8        <-- garbage (ignore by my implementation)
> 
> TODOs:
>     - The iconv docs mention that "errno == EINVAL" is harmless but
>       we don't handle that case in utf8.c:reencode_string_iconv()
>     - Git does not compile with NO_ICONV=1 right now because of
>       compat/precompose_utf8.c. I will send a patch to fix that.

Minor: Does Git not compile under MacOS when setting NO_ICONV=1 ?
This is possible not introduced by the patch. 

> 
> Questions:
>     - Should I use warning() or error() in the patch?
>       (currently I use the warning)

Errors, see below.

>     - Do you agree with the approach in general?

Yes, some comments inline.

> 
> Thanks,
> Lars
> 
> 
> [RFC] http://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com
>   [1] https://github.com/search?p=1&q=encoding+filename%3Agitattributes&type=Code&utf8=%E2%9C%93
>   [2] curl --user larsxschneider:secret -H 'Accept: application/vnd.github.v3.text-match+json' 'https://api.github.com/search/code?q=encoding+in:file+filename:gitattributes' | jq -r '.items[].text_matches[].fragment' | sed 's/.*encoding=//' | sort | uniq
>   [3] https://www.gnu.org/software/libc/manual/html_node/iconv-Examples.html#iconv-Examples
> 
> 
> 
> 
> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/larsxschneider/git/commit/afc9e88a4d
>     Checkout: git fetch https://github.com/larsxschneider/git encoding-v1 && git checkout afc9e88a4d
> 
>  Documentation/gitattributes.txt |  27 ++++++
>  convert.c                       | 192 +++++++++++++++++++++++++++++++++++++++-
>  t/t0028-encoding.sh             |  60 +++++++++++++
>  3 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100755 t/t0028-encoding.sh
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 30687de81a..84de2fa49c 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -146,6 +146,33 @@ Unspecified::
>  Any other value causes Git to act as if `text` has been left
>  unspecified.
> 
> +`encoding`
> +^^^^^^^^^^
> +
> +By default Git assumes UTF-8 encoding for text files.  The `encoding`

This is probably "ASCII" and it's supersets like ISO-8859-1 or UTF-8.

> +attribute sets the encoding to be used in the working directory.
> +If the path is added to the index, then Git encodes the content to
> +UTF-8.  On checkout the content is encoded back to the original
> +encoding.  Consequently, you can use all built-in Git text processing
> +tools (e.g. git diff, line ending conversions, etc.) with your
> +non-UTF-8 encoded file.
> +
> +Please note that re-encoding content can cause errors and requires
> +resources. Use the `encoding` attribute only if you cannot store
> +a file in UTF-8 encoding and if you want Git to be able to process
> +the text.
> +
> +------------------------
> +*.txt		text encoding=UTF-16
> +------------------------

I think that encoding (or worktree-encoding as said elsewhere) must imply text.
(That is not done in convert.c, but assuming binary or even auto
does not make much sense to me)


> +
> +All `iconv` encodings with a stable round-trip conversion to and from
> +UTF-8 are supported.  You can see a full list with the following command:
> +
> +------------------------
> +iconv --list
> +------------------------
> +
>  `eol`
>  ^^^^^
> 
> diff --git a/convert.c b/convert.c
> index 20d7ab67bd..ee19c17104 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -7,6 +7,7 @@
>  #include "sigchain.h"
>  #include "pkt-line.h"
>  #include "sub-process.h"
> +#include "utf8.h"
> 
>  /*
>   * convert.c - convert a file when checking it out and checking it in.
> @@ -256,6 +257,149 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
> 
>  }

I would avoid to use these #ifdefs here.
All functions can be in strbuf.c (and may have #ifdefs there), but not here.

> 
> +#ifdef NO_ICONV
> +#ifndef _ICONV_T
> +/* The type is just a placeholder and not actually used. */
> +typedef void* iconv_t;
> +#endif
> +#endif
> +
> +static struct encoding {
> +	const char *name;
> +	iconv_t to_git;       /* conversion to Git's canonical encoding (UTF-8) */
> +	iconv_t to_worktree;  /* conversion to user-defined encoding */
> +	struct encoding *next;
> +} *encoding, **encoding_tail;

This seems like an optimazation, assuning that iconv_open() eats a lot of ressources.
I don't think this is the case. (Undere MacOS we run iconv_open() together with
every opendir(), and optimizing this out did not show any measurable improvements)

> +static const char *default_encoding = "utf-8";

The most portable form is "UTF-8" (correct me if that is wrong)

> +static iconv_t invalid_conversion = (iconv_t)-1;
> +
> +static int encode_to_git(const char *path, const char *src, size_t src_len,
> +			 struct strbuf *buf, struct encoding *enc)
> +{
> +#ifndef NO_ICONV
> +	char *dst, *re_src;
> +	int dst_len, re_src_len;
> +
> +	/*
> +	 * No encoding is specified or there is nothing to encode.
> +	 * Tell the caller that the content was not modified.
> +	 */
> +	if (!enc || (src && !src_len))
> +		return 0;
> +
> +	/*
> +	 * Looks like we got called from "would_convert_to_git()".
> +	 * This means Git wants to know if it would encode (= modify!)
> +	 * the content. Let's answer with "yes", since an encoding was
> +	 * specified.
> +	 */
> +	if (!buf && !src)
> +		return 1;
> +
> +	if (enc->to_git == invalid_conversion) {
> +		enc->to_git = iconv_open(default_encoding, encoding->name);
> +		if (enc->to_git == invalid_conversion)
> +			warning(_("unsupported encoding %s"), encoding->name);
> +	}

 	/* There are 2 different types of reaction:
	      Either users  know what that a warning means: You asked for problems,
	      	        and do the right thing. Other may may ignore the warning
			       - in both cases an error is useful */

> +
> +	if (enc->to_worktree == invalid_conversion)
> +		enc->to_worktree = iconv_open(encoding->name, default_encoding);
> +
> +	/*
> +	 * Do nothing if the encoding is not supported. This could happen in
> +	 * two cases:
> +	 *   (1) The encoding is garbage. That is no problem as we would not
> +	 *       encode the content to UTF-8 on "add" and we would not encode
> +	 *       it back on "checkout".
> +	 *   (2) Git users use different iconv versions that support different
> +	 *       encodings. This could lead to problems, as the content might
> +	 *       not be encoded on "add" but encoded back on "checkout" (or
> +	 *       the other way around).
> +	 * We print a one-time warning to the user in both cases above.
> +	 */

Isn't an error better than "garbage in -> garbage out" ?

> +	if (enc->to_git == invalid_conversion || enc->to_worktree == invalid_conversion)
> +		return 0;
> +
> +	dst = reencode_string_iconv(src, src_len, enc->to_git, &dst_len);

I would suggest to write a function in strbuf and use it here:

int strbuf_add_reencode((struct strbuf *sb, const void *data, size_t len,
                         const char *from, const char *to)

> +	if (!dst)
> +		/*
> +		 * We could add the blob "as-is" to Git. However, on checkout
> +		 * we would try to reencode to the original encoding. This
> +		 * would fail and we would leave the user with a messed-up
> +		 * working tree. Let's try to avoid this by screaming loud.
> +		 */
> +		die(_("failed to encode '%s' from %s to %s"),
> +			path, enc->name, default_encoding);
> +
> +	/*
> +	 * Encode dst back to ensure no information is lost. This wastes

"wastes" ? "uses" i would say.

> +	 * a few cycles as most conversions are round trip conversion
> +	 * safe. However, content that has an invalid encoding might not
> +	 * match its original byte sequence after the UTF-8 conversion
> +	 * round trip. Let's play safe here and check the round trip
> +	 * conversion.
> +	 */
> +	re_src = reencode_string_iconv(dst, dst_len, enc->to_worktree, &re_src_len);
> +	if (!re_src || strcmp(src, re_src)) {
> +		die(_("encoding '%s' from %s to %s and back is not the same"),
> +			path, enc->name, default_encoding);
> +	}
> +	free(re_src);
> +
> +	strbuf_attach(buf, dst, dst_len, dst_len + 1);
> +	return 1;
> +#else
> +	warning(_("cannot encode '%s' from %s to %s because "
> +		"your Git was not compiled with encoding support"),
> +		path, enc->name, default_encoding);
> +	return 0;
> +#endif
> +}
> +
> +static int encode_to_worktree(const char *path, const char *src, size_t src_len,
> +			      struct strbuf *buf, struct encoding *enc)


Similar here: Better to use a (new) function from strbuf.

> +{
> +#ifndef NO_ICONV
> +	char *dst;
> +	int dst_len;
> +
> +	/*
> +	 * No encoding is specified or there is nothing to encode.
> +	 * Tell the caller that the content was not modified.
> +	 */
> +	if (!enc || (src && !src_len))
> +		return 0;
> +
> +	if (enc->to_worktree == invalid_conversion) {
> +		enc->to_worktree = iconv_open(encoding->name, default_encoding);
> +		if (enc->to_worktree == invalid_conversion)
> +			warning("unsupported encoding %s", encoding->name);
> +	}
> +
> +	/*
> +	 * Do nothing if the encoding is not supported.
> +	 * See detailed explanation in encode_to_git().
> +	 */
> +	if (enc->to_worktree == invalid_conversion)
> +		return 0;
> +
> +	dst = reencode_string_iconv(src, src_len, enc->to_worktree, &dst_len);
> +	if (!dst) {
> +		warning("failed to encode '%s' from %s to %s",
> +			path, default_encoding, encoding->name);
> +		return 0;
> +	}
> +
> +	strbuf_attach(buf, dst, dst_len, dst_len + 1);
> +	return 1;
> +#else
> +	warning(_("cannot encode '%s' from %s to %s because "
> +		"your Git was not compiled with encoding support"),
> +		path, default_encoding, encoding->name);
> +	return 0;
> +#endif
> +}
> +
>  static int crlf_to_git(const struct index_state *istate,
>  		       const char *path, const char *src, size_t len,
>  		       struct strbuf *buf,
> @@ -969,6 +1113,32 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
>  	return 1;
>  }
> 
> +static struct encoding *git_path_check_encoding(struct attr_check_item *check)
> +{
> +	const char *value = check->value;
> +	struct encoding *enc;
> +
> +	if (ATTR_UNSET(value))
> +		return NULL;
> +
> +	for (enc = encoding; enc; enc = enc->next)
> +		if (!strcmp(value, enc->name))
> +			return enc;
> +
> +	/* Don't encode to the default encoding */
> +	if (!strcasecmp(value, default_encoding))
> +		return NULL;
> +
> +	enc = xcalloc(1, sizeof(struct convert_driver));
> +	enc->name = xstrdup(value);
> +	enc->to_git = invalid_conversion;
> +	enc->to_worktree = invalid_conversion;
> +	*encoding_tail = enc;
> +	encoding_tail = &(enc->next);
> +
> +	return enc;
> +}
> +
>  static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
>  {
>  	const char *value = check->value;
> @@ -1024,6 +1194,7 @@ struct conv_attrs {
>  	enum crlf_action attr_action; /* What attr says */
>  	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
>  	int ident;
> +	struct encoding *encoding; /* Supported encoding or default encoding if NULL */
>  };
> 
>  static void convert_attrs(struct conv_attrs *ca, const char *path)
> @@ -1032,8 +1203,9 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
> 
>  	if (!check) {
>  		check = attr_check_initl("crlf", "ident", "filter",
> -					 "eol", "text", NULL);
> +					 "eol", "text", "encoding", NULL);
>  		user_convert_tail = &user_convert;
> +		encoding_tail = &encoding;
>  		git_config(read_convert_config, NULL);
>  	}

As written before, "worktree-encoding" should imply text.

> 
> @@ -1055,6 +1227,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  			else if (eol_attr == EOL_CRLF)
>  				ca->crlf_action = CRLF_TEXT_CRLF;
>  		}
> +		ca->encoding = git_path_check_encoding(ccheck + 5);
>  	} else {
>  		ca->drv = NULL;
>  		ca->crlf_action = CRLF_UNDEFINED;
> @@ -1135,6 +1308,13 @@ int convert_to_git(const struct index_state *istate,
>  		src = dst->buf;
>  		len = dst->len;
>  	}
> +
> +	ret |= encode_to_git(path, src, len, dst, ca.encoding);
> +	if (ret && dst) {
> +		src = dst->buf;
> +		len = dst->len;
> +	}
> +
>  	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
>  		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
>  		if (ret && dst) {
> @@ -1158,6 +1338,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
>  	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);
> 
> +	encode_to_git(path, dst->buf, dst->len, dst, ca.encoding);
>  	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
>  	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
>  }
> @@ -1189,6 +1370,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  		}
>  	}
> 
> +	ret |= encode_to_worktree(path, src, len, dst, ca.encoding);
> +	if (ret) {
> +		src = dst->buf;
> +		len = dst->len;
> +	}
> +
>  	ret_filter = apply_filter(
>  		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
>  	if (!ret_filter && ca.drv && ca.drv->required)
> @@ -1655,6 +1842,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
>  	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
>  		return NULL;
> 
> +	if (ca.encoding)
> +		return NULL;
> +
>  	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
>  		return NULL;
> 

> diff --git a/t/t0028-encoding.sh b/t/t0028-encoding.sh

(I didn't review the test yet)

Another comment for a possible improvement:
"git diff"  could be told to write the worktree-encoding into the diff,
and "git apply" can pick that up. 
