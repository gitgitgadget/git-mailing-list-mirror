Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4F51F404
	for <e@80x24.org>; Fri, 29 Dec 2017 17:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdL2R3S (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 12:29:18 -0500
Received: from mout.web.de ([212.227.17.11]:62718 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdL2R3R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 12:29:17 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAMli-1efNX433DG-00BdC9; Fri, 29
 Dec 2017 18:29:00 +0100
Date:   Fri, 29 Dec 2017 18:28:58 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 4/5] convert: add support for 'checkout-encoding'
 attribute
Message-ID: <20171229172858.GB23935@tor.lan>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
 <20171229152222.39680-5-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171229152222.39680-5-lars.schneider@autodesk.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:1LtJlYsw8hCaTboBFb7s/GVAL4jVkdlYs0KRpnLnfrMoCr3tKgx
 wuUhOQExzGL3UdlZe3EyFewAkgY7qDQV9sKP6DlnoQBTjvDK2/NAYDE+RtIPCBL4YA+mTQ6
 ZxLGoLpxYtxTrze1u5/Xwx2nhd0Pj0jzaSP6VU9zUk9q3dJo7kSf5moiPo/VnsIaZojIjot
 4E5EG1Bh8JOQtvsIOK2OQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TWCq1LZvAr4=:0flbdBjD4+FPQZwKu96nyF
 2RI0pJ1X91LjqyDvnMrgMpdu9xdts8nz2jNu+UOLhjIXWXmzdE0TyGDSG4REV5odM4leLsLCS
 cxSOhtF9QSnDTspIZNT6aD83Ub1M9p9VNhd3YjhXJeWwVtTrqHeOmW8Q42gYzVJ5u65gRd/1B
 cEUAJ77Ogt4i+IDsj0YGIjLZxFDGkxFN9X3UFKylYACrEdtORZxsqnpyMmB3akCCIsvMQfg5l
 AARFqzsTtHfdZKtKkVYMTXqz0g85WMmgnMP0hSyjnGJBvJiOKA0pABF8Rfo7tXuBGo1eK7ax8
 0t4ZZUfWt7r3YN49uqf2UiL78A4R7I8smWt+WdXkdVJj1JlwpE9ZRbSp8X3ouyMiBRdGCLic7
 dETwYZ5EKiqlsLlR4Kho9YoJDc1Vc9/rlaRD9IXLfe7eTfDCnbKJfQ6XKfTAXlvvZk2Ws74ud
 mf2aYGcPP6f0Ly5zkuo69xmgUKx6ociTlNQV+n5LGPDBViNpUm7FRCYVBONniiojnJ1LSPI14
 Vgk/q3gPn+joOVG7R+ZyQcKnZcioXdGGJBzIJ1AV5IMGnzsZrK4YhsJLyb4B8m8jFoNjDMOib
 fn2FXVS1M09F/cdUo93cQopcqxOdbjqxzWTF13RbLUdZL4Ydp6gWVB6WERZPlPNM32Uhtwbmh
 /okMhptIKe7Lxi8oHhiZpSrXFbey7mIWtkm+PdFT9IDskUb5yKmh4XC4b2ozBI4grB1dDh45o
 QqUBsEXQl/ooUFtBILDK9kTIUtCxqEyV2DL3uOx8ObH/oqgTqE+r4I7sJ9NuYlvwBv7UV2hn3
 NKSOX+gYBTYEgTPiaRcb0xHPgxYXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I probably need to look at convert.c more closer, some other comments inline.


On Fri, Dec 29, 2017 at 04:22:21PM +0100, lars.schneider@autodesk.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git and its tools (e.g. git diff) expect all text files in UTF-8
> encoding. Git will happily accept content in all other encodings, too,
> but it might not be able to process the text (e.g. viewing diffs or
> changing line endings).

UTF-8 is too strict, the text from below is more correct:
 +Git recognizes files encoded with ASCII or one of its supersets (e.g.
 +UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
 +interpreted as binary and consequently built-in Git text processing
 +tools (e.g. 'git diff') as well as most Git web front ends do not
 +visualize the content.


> 
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the
> content to a canonical UTF-8 representation. On checkout Git will

Minor question about "canonical":
Would this mean the same ?
 ...then Git converts the content into  UTF-8.


> reverse the conversion.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/gitattributes.txt |  59 ++++++++++++
>  apply.c                         |   2 +-
>  blame.c                         |   2 +-
>  combine-diff.c                  |   2 +-
>  convert.c                       | 196 ++++++++++++++++++++++++++++++++++++++-
>  convert.h                       |   8 +-
>  diff.c                          |   2 +-
>  sha1_file.c                     |   5 +-
>  t/t0028-checkout-encoding.sh    | 197 ++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 460 insertions(+), 13 deletions(-)
>  create mode 100755 t/t0028-checkout-encoding.sh
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 30687de81a..0039bd38c3 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -272,6 +272,65 @@ few exceptions.  Even though...
>    catch potential problems early, safety triggers.
>  
>  
> +`checkout-encoding`
> +^^^^^^^^^^^^^^^^^^^
> +
> +Git recognizes files encoded with ASCII or one of its supersets (e.g.
> +UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
> +interpreted as binary and consequently built-in Git text processing
> +tools (e.g. 'git diff') as well as most Git web front ends do not
> +visualize the content.
> +

> +In these cases you can teach Git the encoding of a file in the working
                          teach ? tell ? 
> +directory with the `checkout-encoding` attribute. If a file with this
> +attributes is added to Git, then Git reencodes the content from the
> +specified encoding to UTF-8 and stores the result in its internal data
> +structure.

Minor Q:
> its internal data structure.
Should we simply write "stores the result in the index" ?

> On checkout the content is encoded back to the specified
> +encoding.

> +
> +Please note that using the `checkout-encoding` attribute has a number
> +of drawbacks:
> +
> +- Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
> +  errors as the conversion might not be round trip safe.
> +
> +- Reencoding content requires resources that might slow down certain
> +  Git operations (e.g 'git checkout' or 'git add').
> +
> +- Git clients that do not support the `checkout-encoding` attribute or
> +  the used encoding will checkout the respective files as UTF-8 encoded.
> +  That means the content appears to be different which could cause
> +  trouble. Affected clients are older Git versions and alternative Git
> +  implementations such as JGit or libgit2 (as of January 2018).
> +
> +Use the `checkout-encoding` attribute only if you cannot store a file in
> +UTF-8 encoding and if you want Git to be able to process the content as
> +text.
> +

I would maybe rephrase a little bit (first things first):

Please note that using the `checkout-encoding` attribute may have a number
of pitfalls:

- Git clients that do not support the `checkout-encoding` attribute
  will checkout the respective files as UTF-8 encoded,  which typically
  causes trouble.
  Escpecialy when older Git versions are used or alternative Git
  implementations such as JGit or libgit2 (as of January 2018).

- Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
  errors as the conversion might not be round trip safe.

- Reencoding content requires resources that might slow down certain
  Git operations (e.g 'git checkout' or 'git add').

Use the `checkout-encoding` attribute only if you cannot store a file in
UTF-8 encoding and if you want Git to be able to process the content as
text.

-----
Side question: What happens if "the used encoding" is not supported by
the underlying iconv lib ?
Will Git fail, delete the file from the working tree ?
That may be worth to mention. (And I need to do the code-review)

> +Use the following attributes if your '*.txt' files are UTF-16 encoded
> +with byte order mark (BOM) and you want Git to perform automatic line
> +ending conversion based on your platform.
> +
> +------------------------
> +*.txt		text checkout-encoding=UTF-16
> +------------------------
> +
> +Use the following attributes if your '*.txt' files are UTF-16 little
> +endian encoded without BOM and you want Git to use Windows line endings
> +in the working directory.
> +
> +------------------------
> +*.txt 		checkout-encoding=UTF-16LE text eol=CRLF
> +------------------------
> +
> +You can get a list of all available encodings on your platform with the
> +following command:
> +
> +------------------------
> +iconv --list
> +------------------------
> +
> +
>  `ident`
>  ^^^^^^^
>  
> diff --git a/apply.c b/apply.c
> index 321a9fa68d..c4bd5cf1f2 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2281,7 +2281,7 @@ static int read_old_data(struct stat *st, struct patch *patch,
>  		 * should never look at the index when explicit crlf option
>  		 * is given.
>  		 */
> -		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
> +		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf, 0);

Hm. Do we really need another parameter here?
The only caller that needs it (and sets it to 1) is sha1_file.c.
When an invalid encoding/content is used, it should be safe to die() always?
Just loud thinking..

If really needed, it may need less changes in the code base, if a new function
convert_to_git_or_die() is defined, which is called by convert_to_git()

(and the other alternative would be to convert safe_crlf into a bitmap,
 see https://public-inbox.org/git/20171229132828.17594-1-tboegi@web.de/T/#u
 what do you think ?)


>  		return 0;
>  	default:
>  		return -1;
> diff --git a/blame.c b/blame.c
> index 2893f3c103..388b66897b 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -229,7 +229,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  		if (strbuf_read(&buf, 0, 0) < 0)
>  			die_errno("failed to read from stdin");
>  	}
> -	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
> +	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0, 0);
>  	origin->file.ptr = buf.buf;
>  	origin->file.size = buf.len;
>  	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
> diff --git a/combine-diff.c b/combine-diff.c
> index 2505de119a..4555e49b5f 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1053,7 +1053,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  			if (is_file) {
>  				struct strbuf buf = STRBUF_INIT;
>  
> -				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf)) {
> +				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf, 0)) {
>  					free(result);
>  					result = strbuf_detach(&buf, &len);
>  					result_size = len;
> diff --git a/convert.c b/convert.c
> index 20d7ab67bd..fc8c96b670 100644
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
> @@ -256,6 +257,147 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
>  
>  }
>  
> +static struct encoding {
> +	const char *name;
> +	struct encoding *next;
> +} *encoding, **encoding_tail;
> +static const char *default_encoding = "UTF-8";
> +
> +static int encode_to_git(const char *path, const char *src, size_t src_len,
> +			 struct strbuf *buf, struct encoding *enc, int write_obj)
> +{
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
> +	/*
> +	 * Looks like we got called from "would_convert_to_git()".
> +	 * This means Git wants to know if it would encode (= modify!)
> +	 * the content. Let's answer with "yes", since an encoding was
> +	 * specified.
> +	 */
> +	if (!buf && !src)
> +		return 1;
> +
> +	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
> +		const char *error_msg = _(
> +			"BOM is prohibited for '%s' if encoded as %s");
> +		const char *advise_msg = _(
> +			"You told Git to treat '%s' as %s. A byte order mark "
> +			"(BOM) is prohibited with this encoding. Either use "
> +			"%.6s as checkout encoding or remove the BOM from the "
> +			"file.");
> +
> +		advise(advise_msg, path, enc->name, enc->name, enc->name);
> +		if (write_obj)
> +			die(error_msg, path, enc->name);
> +		else
> +			error(error_msg, path, enc->name);

As said before, I would just die(). Or do I miss something ?
Being strict with BOMs seams like a good idea.

> +
> +
> +	} else if (has_missing_utf_bom(enc->name, src, src_len)) {
> +		const char *error_msg = _(
> +			"BOM is required for '%s' if encoded as %s");
> +		const char *advise_msg = _(
> +			"You told Git to treat '%s' as %s. A byte order mark "
> +			"(BOM) is required with this encoding. Either use "
> +			"%sBE/%sLE as checkout encoding or add a BOM to the "
> +			"file.");
> +		advise(advise_msg, path, enc->name, enc->name, enc->name);
> +		if (write_obj)
> +			die(error_msg, path, enc->name);
> +		else
> +			error(error_msg, path, enc->name);
> +	}
> +
> +	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
> +				  &dst_len);
> +	if (!dst) {
> +		/*
> +		 * We could add the blob "as-is" to Git. However, on checkout
> +		 * we would try to reencode to the original encoding. This
> +		 * would fail and we would leave the user with a messed-up
> +		 * working tree. Let's try to avoid this by screaming loud.
> +		 */
> +		const char* msg = _("failed to encode '%s' from %s to %s");
> +		if (write_obj)
> +			die(msg, path, enc->name, default_encoding);
> +		else
> +			error(msg, path, enc->name, default_encoding);
> +	}
> +
> +	/*
> +	 * UTF supports lossless round tripping [1]. UTF to other encoding are
> +	 * mostly round trip safe as Unicode aims to be a superset of all other
> +	 * character encodings. However, the SHIFT-JIS (Japanese character set)
> +	 * is an exception as some codes are not round trip safe [2].
> +	 *
> +	 * Reverse the transformation of 'dst' and check the result with 'src'
> +	 * if content is written to Git. This ensures no information is lost
> +	 * during conversion to/from UTF-8.
> +	 *
> +	 * Please note, the code below is not tested because I was not able to
> +	 * generate a faulty round trip without iconv error.
> +	 *
> +	 * [1] http://unicode.org/faq/utf_bom.html#gen2
> +	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
> +	 */
> +	if (write_obj && !strcmp(enc->name, "SHIFT-JIS")) {
> +		char *re_src;
> +		int re_src_len;
> +
> +		re_src = reencode_string_len(dst, dst_len,
> +					     enc->name, default_encoding,
> +					     &re_src_len);
> +
> +		if (!re_src || src_len != re_src_len ||
> +		    memcmp(src, re_src, src_len)) {
> +			const char* msg = _("encoding '%s' from %s to %s and "
> +					    "back is not the same");
> +			if (write_obj)
> +				die(msg, path, enc->name, default_encoding);
> +			else
> +				error(msg, path, enc->name, default_encoding);
> +		}
> +
> +		free(re_src);
> +	}
> +
> +	strbuf_attach(buf, dst, dst_len, dst_len + 1);
> +	return 1;
> +}
> +
> +static int encode_to_worktree(const char *path, const char *src, size_t src_len,
> +			      struct strbuf *buf, struct encoding *enc)
> +{
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
> +	dst = reencode_string_len(src, src_len, enc->name, default_encoding,
> +				  &dst_len);
> +	if (!dst) {
> +		error("failed to encode '%s' from %s to %s",
> +			path, enc->name, default_encoding);
> +		return 0;
> +	}
> +
> +	strbuf_attach(buf, dst, dst_len, dst_len + 1);
> +	return 1;
> +}
> +
>  static int crlf_to_git(const struct index_state *istate,
>  		       const char *path, const char *src, size_t len,
>  		       struct strbuf *buf,
> @@ -969,6 +1111,31 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
>  	return 1;
>  }
>  
> +static struct encoding *git_path_check_encoding(struct attr_check_item *check)
> +{
> +	const char *value = check->value;
> +	struct encoding *enc;
> +
> +	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
> +	    !strlen(value))
> +		return NULL;
> +
> +	for (enc = encoding; enc; enc = enc->next)
> +		if (!strcasecmp(value, enc->name))
> +			return enc;
> +
> +	/* Don't encode to the default encoding */
> +	if (!strcasecmp(value, default_encoding))
> +		return NULL;
> +
> +	enc = xcalloc(1, sizeof(struct convert_driver));
> +	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
> +	*encoding_tail = enc;
> +	encoding_tail = &(enc->next);
> +
> +	return enc;
> +}
> +
>  static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
>  {
>  	const char *value = check->value;
> @@ -1024,6 +1191,7 @@ struct conv_attrs {
>  	enum crlf_action attr_action; /* What attr says */
>  	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
>  	int ident;
> +	struct encoding *checkout_encoding; /* Supported encoding or default encoding if NULL */
>  };
>  
>  static void convert_attrs(struct conv_attrs *ca, const char *path)
> @@ -1032,8 +1200,10 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  
>  	if (!check) {
>  		check = attr_check_initl("crlf", "ident", "filter",
> -					 "eol", "text", NULL);
> +					 "eol", "text", "checkout-encoding",
> +					 NULL);
>  		user_convert_tail = &user_convert;
> +		encoding_tail = &encoding;
>  		git_config(read_convert_config, NULL);
>  	}
>  
> @@ -1055,6 +1225,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  			else if (eol_attr == EOL_CRLF)
>  				ca->crlf_action = CRLF_TEXT_CRLF;
>  		}
> +		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
>  	} else {
>  		ca->drv = NULL;
>  		ca->crlf_action = CRLF_UNDEFINED;
> @@ -1120,7 +1291,7 @@ const char *get_convert_attr_ascii(const char *path)
>  
>  int convert_to_git(const struct index_state *istate,
>  		   const char *path, const char *src, size_t len,
> -                   struct strbuf *dst, enum safe_crlf checksafe)
> +		   struct strbuf *dst, enum safe_crlf checksafe, int write_obj)
>  {
>  	int ret = 0;
>  	struct conv_attrs ca;
> @@ -1135,6 +1306,13 @@ int convert_to_git(const struct index_state *istate,
>  		src = dst->buf;
>  		len = dst->len;
>  	}
> +
> +	ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, write_obj);
> +	if (ret && dst) {
> +		src = dst->buf;
> +		len = dst->len;
> +	}
> +
>  	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
>  		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
>  		if (ret && dst) {
> @@ -1147,7 +1325,7 @@ int convert_to_git(const struct index_state *istate,
>  
>  void convert_to_git_filter_fd(const struct index_state *istate,
>  			      const char *path, int fd, struct strbuf *dst,
> -			      enum safe_crlf checksafe)
> +			      enum safe_crlf checksafe, int write_obj)
>  {
>  	struct conv_attrs ca;
>  	convert_attrs(&ca, path);
> @@ -1158,6 +1336,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
>  	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);
>  
> +	encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, write_obj);
>  	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
>  	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
>  }
> @@ -1189,6 +1368,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  		}
>  	}
>  
> +	ret |= encode_to_worktree(path, src, len, dst, ca.checkout_encoding);
> +	if (ret) {
> +		src = dst->buf;
> +		len = dst->len;
> +	}
> +
>  	ret_filter = apply_filter(
>  		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
>  	if (!ret_filter && ca.drv && ca.drv->required)
> @@ -1217,7 +1402,7 @@ int renormalize_buffer(const struct index_state *istate, const char *path,
>  		src = dst->buf;
>  		len = dst->len;
>  	}
> -	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
> +	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE, 0);
>  }
>  
>  /*****************************************************************
> @@ -1655,6 +1840,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
>  	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
>  		return NULL;
>  
> +	if (ca.checkout_encoding)
> +		return NULL;
> +
>  	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
>  		return NULL;
>  
> diff --git a/convert.h b/convert.h
> index 4f2da225a8..9e4e884ec1 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -66,7 +66,8 @@ extern const char *get_convert_attr_ascii(const char *path);
>  /* returns 1 if *dst was used */
>  extern int convert_to_git(const struct index_state *istate,
>  			  const char *path, const char *src, size_t len,
> -			  struct strbuf *dst, enum safe_crlf checksafe);
> +			  struct strbuf *dst, enum safe_crlf checksafe,
> +			  int write_obj);
>  extern int convert_to_working_tree(const char *path, const char *src,
>  				   size_t len, struct strbuf *dst);
>  extern int async_convert_to_working_tree(const char *path, const char *src,
> @@ -79,13 +80,14 @@ extern int renormalize_buffer(const struct index_state *istate,
>  static inline int would_convert_to_git(const struct index_state *istate,
>  				       const char *path)
>  {
> -	return convert_to_git(istate, path, NULL, 0, NULL, 0);
> +	return convert_to_git(istate, path, NULL, 0, NULL, 0, 0);
>  }
>  /* Precondition: would_convert_to_git_filter_fd(path) == true */
>  extern void convert_to_git_filter_fd(const struct index_state *istate,
>  				     const char *path, int fd,
>  				     struct strbuf *dst,
> -				     enum safe_crlf checksafe);
> +				     enum safe_crlf checksafe,
> +				     int write_obj);
>  extern int would_convert_to_git_filter_fd(const char *path);
>  
>  /*****************************************************************
> diff --git a/diff.c b/diff.c
> index 2ebe2227b4..16ca0bf0df 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3599,7 +3599,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  		/*
>  		 * Convert from working tree format to canonical git format
>  		 */
> -		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn)) {
> +		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn, 0)) {
>  			size_t size = 0;
>  			munmap(s->data, s->size);
>  			s->should_munmap = 0;
> diff --git a/sha1_file.c b/sha1_file.c
> index afe4b90f6e..75800248d2 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1694,7 +1694,8 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
>  	if ((type == OBJ_BLOB) && path) {
>  		struct strbuf nbuf = STRBUF_INIT;
>  		if (convert_to_git(&the_index, path, buf, size, &nbuf,
> -				   get_safe_crlf(flags))) {
> +				   get_safe_crlf(flags),
> +				   write_object)) {
>  			buf = strbuf_detach(&nbuf, &size);
>  			re_allocated = 1;
>  		}
> @@ -1728,7 +1729,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
>  	assert(would_convert_to_git_filter_fd(path));
>  
>  	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
> -				 get_safe_crlf(flags));
> +				 get_safe_crlf(flags), write_object);
>  
>  	if (write_object)
>  		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
> diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
> new file mode 100755
> index 0000000000..1a329ab933
> --- /dev/null
> +++ b/t/t0028-checkout-encoding.sh
> @@ -0,0 +1,197 @@
> +#!/bin/sh
> +
> +test_description='checkout-encoding conversion via gitattributes'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup test repo' '
> +
> +	text="hallo there!\ncan you read me?" &&

Is this portable ? (the "\n")


> +
> +	echo "*.utf16 text checkout-encoding=utf-16" >.gitattributes &&
> +
> +	printf "$text" >test.utf8.raw &&
> +	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
> +	cp test.utf16.raw test.utf16 &&
> +
> +	git add .gitattributes test.utf16 &&
> +	git commit -m initial
> +'
> +
> +test_expect_success 'ensure UTF-8 is stored in Git' '
> +	git cat-file -p :test.utf16 >test.utf16.git &&
> +	test_cmp_bin test.utf8.raw test.utf16.git &&
> +	rm test.utf8.raw test.utf16.git
> +'
> +
> +test_expect_success 're-encode to UTF-16 on checkout' '
> +	rm test.utf16 &&
> +	git checkout test.utf16 &&
> +	test_cmp_bin test.utf16.raw test.utf16 &&
> +
> +	# cleanup
> +	rm test.utf16.raw
> +'
> +
> +test_expect_success 'check prohibited UTF BOM' '
> +	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
> +	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
> +	printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
> +	printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
> +
> +	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
> +	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
> +	printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
> +	printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&
> +
> +	echo "*.utf16be text checkout-encoding=utf-16be" >>.gitattributes &&
> +	echo "*.utf16le text checkout-encoding=utf-16le" >>.gitattributes &&
> +	echo "*.utf32be text checkout-encoding=utf-32be" >>.gitattributes &&
> +	echo "*.utf32le text checkout-encoding=utf-32le" >>.gitattributes &&
> +
> +	# Here we add a UTF-16 files with BOM (big-endian and little-endian)
> +	# but we tell Git to treat it as UTF-16BE/UTF-16LE. In these cases
> +	# the BOM is prohibited.
> +	cp bebom.utf16be.raw bebom.utf16be &&
> +	test_must_fail git add bebom.utf16be 2>err.out &&
> +	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
> +
> +	cp lebom.utf16le.raw lebom.utf16be &&
> +	test_must_fail git add lebom.utf16be 2>err.out &&
> +	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
> +
> +	cp bebom.utf16be.raw bebom.utf16le &&
> +	test_must_fail git add bebom.utf16le 2>err.out &&
> +	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
> +
> +	cp lebom.utf16le.raw lebom.utf16le &&
> +	test_must_fail git add lebom.utf16le 2>err.out &&
> +	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
> +
> +	# ... and the same for UTF-32
> +	cp bebom.utf32be.raw bebom.utf32be &&
> +	test_must_fail git add bebom.utf32be 2>err.out &&
> +	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
> +
> +	cp lebom.utf32le.raw lebom.utf32be &&
> +	test_must_fail git add lebom.utf32be 2>err.out &&
> +	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
> +
> +	cp bebom.utf32be.raw bebom.utf32le &&
> +	test_must_fail git add bebom.utf32le 2>err.out &&
> +	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
> +
> +	cp lebom.utf32le.raw lebom.utf32le &&
> +	test_must_fail git add lebom.utf32le 2>err.out &&
> +	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
> +
> +	# cleanup
> +	git reset --hard HEAD
> +'
> +
> +test_expect_success 'check required UTF BOM' '
> +	echo "*.utf32 text checkout-encoding=utf-32" >>.gitattributes &&
> +
> +	cp nobom.utf16be.raw nobom.utf16 &&
> +	test_must_fail git add nobom.utf16 2>err.out &&
> +	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
> +
> +	cp nobom.utf16le.raw nobom.utf16 &&
> +	test_must_fail git add nobom.utf16 2>err.out &&
> +	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
> +
> +	cp nobom.utf32be.raw nobom.utf32 &&
> +	test_must_fail git add nobom.utf32 2>err.out &&
> +	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
> +
> +	cp nobom.utf32le.raw nobom.utf32 &&
> +	test_must_fail git add nobom.utf32 2>err.out &&
> +	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
> +
> +	# cleanup
> +	rm nobom.utf16 nobom.utf32 &&
> +	git reset --hard HEAD
> +'
> +
> +test_expect_success 'eol conversion for UTF-16 encoded files on checkout' '
> +	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
> +	printf "one\r\ntwo\r\nthree\r\n" >crlf.utf8.raw &&
> +
> +	cat lf.utf8.raw | iconv -f UTF-8 -t UTF-16 >lf.utf16.raw &&
> +	cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-16 >crlf.utf16.raw &&
> +	cp crlf.utf16.raw eol.utf16 &&
> +
> +	git add eol.utf16 &&
> +	git commit -m eol &&
> +
> +	# UTF-16 with CRLF (Windows line endings)
> +	rm eol.utf16 &&
> +	git -c core.eol=crlf checkout eol.utf16 &&
> +	test_cmp_bin crlf.utf16.raw eol.utf16 &&
> +
> +	# UTF-16 with LF (Unix line endings)
> +	rm eol.utf16 &&
> +	git -c core.eol=lf checkout eol.utf16 &&
> +	test_cmp_bin lf.utf16.raw eol.utf16 &&
> +
> +	rm crlf.utf16.raw crlf.utf8.raw lf.utf16.raw lf.utf8.raw &&
> +
> +	# cleanup
> +	git reset --hard HEAD^
> +'
> +
> +test_expect_success 'check unsupported encodings' '
> +
> +	echo "*.nothing text checkout-encoding=" >>.gitattributes &&
> +	printf "nothing" >t.nothing &&
> +	git add t.nothing &&
> +
> +	echo "*.garbage text checkout-encoding=garbage" >>.gitattributes &&
> +	printf "garbage" >t.garbage &&
> +	test_must_fail git add t.garbage 2>err.out &&
> +	test_i18ngrep "fatal: failed to encode" err.out &&
> +
> +	# cleanup
> +	rm err.out &&
> +	git reset --hard HEAD
> +'
> +
> +test_expect_success 'error if encoding round trip is not the same during refresh' '
> +	BEFORE_STATE=$(git rev-parse HEAD) &&
> +
> +	# Skip the UTF-16 filter for the added file
> +	# This simulates a Git version that has no checkoutEncoding support
> +	echo "hallo" >nonsense.utf16 &&
> +	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
> +	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
> +	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
> +	git update-ref refs/heads/master $COMMIT &&
> +
> +	test_must_fail git checkout HEAD^ 2>err.out &&
> +	test_i18ngrep "error: .* overwritten by checkout:" err.out &&
> +
> +	# cleanup
> +	rm err.out &&
> +	git reset --hard $BEFORE_STATE
> +'
> +
> +test_expect_success 'error if encoding garbage is already in Git' '
> +	BEFORE_STATE=$(git rev-parse HEAD) &&
> +
> +	# Skip the UTF-16 filter for the added file
> +	# This simulates a Git version that has no checkoutEncoding support
> +	cp nobom.utf16be.raw nonsense.utf16 &&
> +	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
> +	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
> +	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
> +	git update-ref refs/heads/master $COMMIT &&
> +
> +	git diff 2>err.out &&
> +	test_i18ngrep "error: BOM is required" err.out &&
> +
> +	# cleanup
> +	rm err.out &&
> +	git reset --hard $BEFORE_STATE
> +'
> +
> +test_done
> -- 
> 2.15.1
> 
