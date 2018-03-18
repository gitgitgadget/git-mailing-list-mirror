Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80241F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 07:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeCRHY7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 03:24:59 -0400
Received: from mout.web.de ([212.227.15.3]:42265 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCRHY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 03:24:58 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkyTl-1eNZdD3uiL-00amau; Sun, 18
 Mar 2018 08:24:39 +0100
Date:   Sun, 18 Mar 2018 08:24:35 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v11 06/10] convert: add 'working-tree-encoding' attribute
Message-ID: <20180318072435.GA24190@tor.lan>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
 <20180309173536.62012-7-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309173536.62012-7-lars.schneider@autodesk.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:5zSRQeCzclnB5zhSfdHJRm5DTICM7M2j+1uXcgoej5htYYqjVGv
 hOgF0glVRi+srEPN6Iuu2NFvQiJlnL+l87na4VJixStpyLG89dsZ5HhugbD4WtkHf/Q4KUk
 llKckIS1Zd8FVaVJTX0aERvmG8b/Pq6R2fkcIKgchb7nKLT89da/ksJCk7MT1fBjQwdm6RR
 moBVMnMd8XpU97rC1nx7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DFMjyzUUNkw=:8z4HxGZedodIsAQlvswaJt
 T5OO5M5K2+fSTNNcfIKdlCFdbWGLYUfYMW3splUb2A4OwSCJyQ0XeBPXpFeA82Q8gl4rtSQRa
 vO5j6N5PEHHflIIIskQ/1q7uwwDAWyjfkZAg/vahjzV75+/QGwz6YmgbOic3HRvMgGPoA9LHJ
 jwoWcg/U5abClzepjBJgpLGQryV6hqCtcvlLs5Ub8LCZGZkUROzxb48j4HANbR7vIsfriztJF
 R/etXZEKk+IB/+WdMM/5QqHffqRyDHpkhtGlD1LPECwSUH0RXRMcNegMykn1PgVsV4hdxYcvR
 GEY3gTLxzrDA/LtfUdWJH0YuTah3BRZb2ua+xjMDL7EL2tE73x6SqQdgBfeLVFAvE8JP3qKWe
 Lr41hFOjg5+qLpnqnX6F17fXcX4w5GAnwzG3LUhOw+XZjr2+BSm6ofEAmedwBTv3x6ehAQJID
 P/loLC4Z8Qa2mlZzkcxBWqE0L57XighGjozhxxFWyhegHje74lgqhZBKJSezmm5U92+QQJ057
 i0aG0IAEvGIhjEhrXNwMKtcQAQByyoQ/HtwUI0E7WIoJqNUovj6KTwQGFOAS0gwjxzPTH1J8v
 KQELNTakUrPwuL4eI0NswyQCrffoaYncVgnEJlHzhgIMM+c6d/+Z/cgzDO1VOPOJW6DIT4zzM
 V49G2Apw6Pm1/XcDwpYwlhh2Lp6jMnpbFdxufVuMAlP08WW7hGmWsQtTpa6ky1tKkK1NprKtK
 L0/hegapwN8F8VOW/vTfONb0Lw5oGGvc/LWeKA+umcl+91VI+1Qd1Aa5ZGddPhQ0vCdKxHjPP
 1wz77jR/Qam+E9T8tLwTP2wNbyf+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some comments inline

On Fri, Mar 09, 2018 at 06:35:32PM +0100, lars.schneider@autodesk.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git recognizes files encoded with ASCII or one of its supersets (e.g.
> UTF-8 or ISO-8859-1) as text files. All other encodings are usually
> interpreted as binary and consequently built-in Git text processing
> tools (e.g. 'git diff') as well as most Git web front ends do not
> visualize the content.
> 
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the

Minor comment:
"Git converts the content"
Everywhere else (?) "encodes or reencodes" is used.
"Git reencodes the content" may be more consistent.


[No comments on the .gitattributes]

>  
> diff --git a/convert.c b/convert.c
> index b976eb968c..aa59ecfe49 100644
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
> @@ -265,6 +266,78 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
>  
>  }
>  
> +static const char *default_encoding = "UTF-8";
> +
> +static int encode_to_git(const char *path, const char *src, size_t src_len,
> +			 struct strbuf *buf, const char *enc, int conv_flags)
> +{
> +	char *dst;
> +	int dst_len;
> +	int die_on_error = conv_flags & CONV_WRITE_OBJECT;
> +
> +	/*
> +	 * No encoding is specified or there is nothing to encode.
> +	 * Tell the caller that the content was not modified.
> +	 */
> +	if (!enc || (src && !src_len))
> +		return 0;

(This may have been discussed before.
 As we checked (enc != NULL) I think we can add here:)
	if (is_encoding_utf8(enc))
		return 0;

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
> +	dst = reencode_string_len(src, src_len, default_encoding, enc,
> +				  &dst_len);
> +	if (!dst) {
> +		/*
> +		 * We could add the blob "as-is" to Git. However, on checkout
> +		 * we would try to reencode to the original encoding. This
> +		 * would fail and we would leave the user with a messed-up
> +		 * working tree. Let's try to avoid this by screaming loud.
> +		 */
> +		const char* msg = _("failed to encode '%s' from %s to %s");
> +		if (die_on_error)
> +			die(msg, path, enc, default_encoding);
> +		else {
> +			error(msg, path, enc, default_encoding);
> +			return 0;
> +		}
> +	}
> +
> +	strbuf_attach(buf, dst, dst_len, dst_len + 1);
> +	return 1;
> +}
> +
> +static int encode_to_worktree(const char *path, const char *src, size_t src_len,
> +			      struct strbuf *buf, const char *enc)
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

 Same as above:
	if (is_encoding_utf8(enc))
		return 0;

> +
> +	dst = reencode_string_len(src, src_len, enc, default_encoding,
> +				  &dst_len);
> +	if (!dst) {
> +		error("failed to encode '%s' from %s to %s",
> +			path, default_encoding, enc);
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
> @@ -978,6 +1051,25 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
>  	return 1;
>  }
>  
> +static const char *git_path_check_encoding(struct attr_check_item *check)
> +{
> +	const char *value = check->value;
> +
> +	if (ATTR_UNSET(value) || !strlen(value))
> +		return NULL;
> +


> +	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
> +		error(_("working-tree-encoding attribute requires a value"));
> +		return NULL;
> +	}

TRUE or false are values, but just wrong ones.
If this test is removed, the user will see "failed to encode "TRUE" to "UTF-8",
which should give enough information to fix it.

> +
> +	/* Don't encode to the default encoding */
> +	if (!strcasecmp(value, default_encoding))
> +		return NULL;
 Same as above ?:
	if (is_encoding_utf8(value))
		return 0;

