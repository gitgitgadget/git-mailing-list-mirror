Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9A91F829
	for <e@80x24.org>; Mon,  1 May 2017 01:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951692AbdEABpJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:45:09 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33569 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1951658AbdEABpH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:45:07 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so2550456pgc.0
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=djPVbsOLKF1QaVWap7dygb0pfgEVlji3jCHL7qj7pB0=;
        b=dmKBBisyh/OOOWOXS3GKPPIyoNX7rxGHg0UsX4OEGd2N1pzkAi6OFB5XJexkG8PJle
         mxoQcWFyevRLbKYMO16XinZvFS/fd5D1mzxWyMTjbZkz1GZyOtUbzQsz+HWVUu1ix4ii
         oK83CtNOhfPhNrYCxe3cznHLJZf/UyI8NnKq97zEb2qE8IFl1LQj3Yzi8SyEkOLfEraL
         XtW3fcx6GbQeCo+nSFSh33wko99C/Bzy9CnDDFQZ+Mh8s+JMXTAlcQfARfBUsDmSTmO7
         dHU8TmUvI2lUYb8N1oI/8z6i+JA0ix6UPWIt9uMT3N+9Jqy1rv09z+5NKYMLrBHhg+qL
         a9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=djPVbsOLKF1QaVWap7dygb0pfgEVlji3jCHL7qj7pB0=;
        b=hPvCXVM0qYj5jwDGaS4Wdc3GRhKOmVnLzokGf2GyXgMI9nqccnRRfI/CGkjp+dG9WX
         Jlg6VYB5WGaG6oYsuKS0qoyfQtnShtT4aIAv7662o7TOMrXS/zRSaJWtRtQ0EwwI65sy
         ntRh7UyaD6gY4ylJLg3UMPGrRYzZuGOU4dKKZUVaoA0WHPFw9Vrxcu3nYOrlA6Qn37Vm
         eKYwrxCo38ULcO5P2zA0XbGlM3Np3C+SiU/JIvFhajzuUlfvYaBVAx6aZ6ZFQ+2QnFzS
         9gtgqKuxBKclOVGisMLrwqBEDSeszSgbk21Q1pyRRufbdBAFqEwF4Z+t1909BCWVZ59x
         Dzew==
X-Gm-Message-State: AN3rC/4aUVTZxkwadg7Xpv+0gYmJ3x4cGg/lmkK6PsHlA1JxX2t8OLyT
        9LoC7kZieJ4jT+1ZASY=
X-Received: by 10.84.231.143 with SMTP id g15mr30965786plk.187.1493603106838;
        Sun, 30 Apr 2017 18:45:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id 63sm16420894pfg.35.2017.04.30.18.45.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:45:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, worldhello.net@gmail.com
Subject: Re: [PATCH] i18n: remove i18n from tag reflog message
References: <20170429100253.4710-1-jn.avila@free.fr>
Date:   Sun, 30 Apr 2017 18:45:05 -0700
In-Reply-To: <20170429100253.4710-1-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Sat, 29 Apr 2017 12:02:53 +0200")
Message-ID: <xmqqwpa1ic4e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> The building of the reflog message is using strbuf, which is not
> friendly with internationalization frameworks. No other reflog
> messages are translated right now and switching all the messages to
> i18n would require a major rework of the way the messages are built.

Thanks for spotting.  Before we declare that reflog messages are for
i18n, we'd need to either drop (or redesign the implementation of)
the "checkout -" feature, which relies on the exact phrasing of how
reflog entries from "git checkout" looks like.

Will queue and merge down to 'master' quickly.

>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  builtin/tag.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 222404522..bdf1e88e9 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -309,7 +309,7 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
>  	if (rla) {
>  		strbuf_addstr(sb, rla);
>  	} else {
> -		strbuf_addstr(sb, _("tag: tagging "));
> +		strbuf_addstr(sb, "tag: tagging ");
>  		strbuf_add_unique_abbrev(sb, sha1, DEFAULT_ABBREV);
>  	}
>  
> @@ -317,14 +317,14 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
>  	type = sha1_object_info(sha1, NULL);
>  	switch (type) {
>  	default:
> -		strbuf_addstr(sb, _("object of unknown type"));
> +		strbuf_addstr(sb, "object of unknown type");
>  		break;
>  	case OBJ_COMMIT:
>  		if ((buf = read_sha1_file(sha1, &type, &size)) != NULL) {
>  			subject_len = find_commit_subject(buf, &subject_start);
>  			strbuf_insert(sb, sb->len, subject_start, subject_len);
>  		} else {
> -			strbuf_addstr(sb, _("commit object"));
> +			strbuf_addstr(sb, "commit object");
>  		}
>  		free(buf);
>  
> @@ -332,13 +332,13 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
>  			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
>  		break;
>  	case OBJ_TREE:
> -		strbuf_addstr(sb, _("tree object"));
> +		strbuf_addstr(sb, "tree object");
>  		break;
>  	case OBJ_BLOB:
> -		strbuf_addstr(sb, _("blob object"));
> +		strbuf_addstr(sb, "blob object");
>  		break;
>  	case OBJ_TAG:
> -		strbuf_addstr(sb, _("other tag object"));
> +		strbuf_addstr(sb, "other tag object");
>  		break;
>  	}
>  	strbuf_addch(sb, ')');
