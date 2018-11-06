Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4201D1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 03:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbeKFNEi (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 08:04:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33435 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbeKFNEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 08:04:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so1470758wrr.0
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 19:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZJWes0v84soQHT1dG4kzDKi1yRyetA5hUDaByfKNc2A=;
        b=RYWACkIrIGFE9Gx094zpWKv/5BSwTU8Rhe/rHIq4ZmoAZbDNu5A1SKvLWAr9V3uxcQ
         l3Xls6SAgLCwHmMDzb8jgeKHbSh7fWAXNWsHv7u7TVQ+yKn2ayEqqZtX4Z69Cvld7DAl
         sYuJX3hVAbT9HGZv86eyTFueFt2xojC67sUtjRk49DPQpdKBTvW7hbjNHXpgziLrQ/GD
         ht2jJqDrnX0NClNfNxa23lxsLD6w5fsqHfOPjDuhdeknOo5rg+GkNnt9KlbeMAuIHeSQ
         bialSq+ALFwbaJYKdIjyCJlmqyJijVF7XUwngCZrRg65WTxyDtfA5c0KvhpnoBukeCHB
         2How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZJWes0v84soQHT1dG4kzDKi1yRyetA5hUDaByfKNc2A=;
        b=fe+9iCW4DxjCtP+j17mF7mlsMuCKXJSBp4tseXVwNDzKxHHrSQ8neFKdAIZuhHDzmb
         RGpX42elSZU4ybCa8QI/W1xAsRbuf9vSI0obgsGfQd5GxEF+rjHR27MN0w9wtMpWWfvC
         b1r8mw4aDq95Y5gAY3Mhe19wSC38UeT23H6BmYQEuOZgJnMPEy/h7TfigiYoL/96JZ5q
         jn3jfsyGCcd2Pw2w4eadHYFDjsodGX47b31293Mi/72BGM7KriYjEVth71vIP4G5rKcM
         KwSBBBg2B7w1x3y7iFpyygr7Hemg1akmjS6HNsH/1wjP7ucdw/7S3oPnp1PvhmYZUHDz
         Ikgg==
X-Gm-Message-State: AGRZ1gLQ90mGqeOuXoVljMnkdqaT+xV78U3u2fpV7zYVr/792hnSCzoX
        OHKQav9R+XmI6VQGgif/MT1E8A16zGI=
X-Google-Smtp-Source: AJdET5fQKIYL2rV+2Ckz3HhHZCXjJzn2JZEaAD8G6Nw6j6qiWgN+3my2iIhfYUu0hPc18tSEjDAsrw==
X-Received: by 2002:a5d:4682:: with SMTP id u2-v6mr16653409wrq.39.1541475690595;
        Mon, 05 Nov 2018 19:41:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l140-v6sm613796wmb.24.2018.11.05.19.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 19:41:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 15/16] fsck: reduce word legos to help i18n
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181105192059.20303-1-pclouds@gmail.com>
        <20181105192059.20303-16-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 12:41:29 +0900
In-Reply-To: <20181105192059.20303-16-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 5 Nov 2018 20:20:58 +0100")
Message-ID: <xmqqbm72g9ee.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  static const char *describe_object(struct object *obj)
>  {
> -	static struct strbuf buf = STRBUF_INIT;
> -	char *name = name_objects ?
> -		lookup_decoration(fsck_walk_options.object_names, obj) : NULL;
> +	static struct strbuf bufs[4] = {
> +		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
> +	};

If you need to repeat _INIT anyway, perhaps you want to actively
omit the 4 from above, no?  If you typed 6 by mistake instead, you'd
be in trouble when using the last two elements.

>  static int objerror(struct object *obj, const char *err)
>  {
>  	errors_found |= ERROR_OBJECT;
> -	objreport(obj, "error", err);
> +	fprintf_ln(stderr, "error in %s %s: %s",
> +		   printable_type(obj), describe_object(obj), err);
>  	return -1;
>  }

Makes sense.

>  static int fsck_error_func(struct fsck_options *o,
>  	struct object *obj, int type, const char *message)
>  {
> -	objreport(obj, (type == FSCK_WARN) ? "warning" : "error", message);
> -	return (type == FSCK_WARN) ? 0 : 1;
> +	if (type == FSCK_WARN) {
> +		fprintf_ln(stderr, "warning in %s %s: %s",
> +			   printable_type(obj), describe_object(obj), message);
> +		return 0;
> +	}
> +
> +	fprintf_ln(stderr, "error in %s %s: %s",
> +		   printable_type(obj), describe_object(obj), message);
> +	return 1;

Make it look more symmetrical like the original, perhaps by

	if (type == FSCK_WARN) {
		...
		return 0;
	} else { /* FSCK_ERROR */
		...
		return 1;
	}

Actually, wouldn't it be clearer to see what is going on, if we did
it like this instead?

	const char *fmt = (type == FSCK_WARN) 
		? N_("warning in %s %s: %s")
		: N_("error in %s %s: %s");
	fprintf_ln(stderr, _(fmt),
		   printable_type(obj), describe_object(obj), message);
	return (type == FSCK_WARN) ? 0 : 1;

It would show that in either case we show these three things in the
message.  I dunno.
