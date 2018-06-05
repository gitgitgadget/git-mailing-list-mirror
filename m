Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2312B1F517
	for <e@80x24.org>; Tue,  5 Jun 2018 16:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeFEQ3n (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 12:29:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35961 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeFEQ3m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 12:29:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id a12-v6so1575013pfi.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n829QvKzu6qZSnoxDiwUL1jssdZPor4A2L0baseiF5U=;
        b=RHtVXR61qE9D0LAklAexykYmtd5rZ9lXQ52JQ3jTQ3Z+Rf7lKay3Yh0AizrcrDTp2t
         3PtgoHvSn1XSOPdHW1ZJYHOONd8oK3u39dr6mEgZvo8uuxjxT7vsaMUMoQbJnUPk554k
         8VUTut9vZ2lMo6Pxj+ciW1Q5h2UohUT89XWQbJt4GLBGH6LK+JWkEmcwREdmdw9wcknc
         Tv78YneGRAyZRDWOhCmvO7Bq42w1lL5VqMNSwEiTgHsY9+27w6EDYfgIJjiS3bv1/rgp
         KOeQ61JZ4iUlAvL36R/v0Uzszoc2W8O1R0jhbtoewce9aLAoiCOrLyu8RzoiUEoEVnhs
         21zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n829QvKzu6qZSnoxDiwUL1jssdZPor4A2L0baseiF5U=;
        b=XH6RI8s4A/ISemq7I9UQWcCdGrpgomG4cwkBfNdkXVMRZotxHFLykkSWEF++j9TOMs
         1LEB2zWYgfe2svM6fVC9pq4XNOrypFHXTJe3lW46SGPchdHFd0vHzhAizdHtfHx4bHXy
         tY7UGyfKdAVFmPc2AH7xJ71CY1aCTtJrBF8DdZsjFzaAPYvLMC9lzs03iMckM3D6Ke1l
         C/ej9WFujBD5FGUqFhCK0gT4n8l6I30fJYSMVpvpbronImkh6pXakFIh2A3i7nJ29kQj
         5tz68Cd9Ls4+gOhm7enjesoYPncUM1zCliaJ7N7sqB8vYyEL2KD0EnoPIzCs00EbflK6
         VxRw==
X-Gm-Message-State: ALKqPweMRp3X9hM0rIZXazV4RiYi6DKh/xZhBdznTb+O5MSTuM/acoxm
        0h9Hl3r1W3EWzvf8QpDaCDdQaw==
X-Google-Smtp-Source: ADUXVKIBBUPa97+Fks8bGrv/RJBWOxD58qobkGSkUX6SStUDSBTgBESiMzB4STtwAeO39CpoTDOXqg==
X-Received: by 2002:a63:a74c:: with SMTP id w12-v6mr21725998pgo.374.1528216181324;
        Tue, 05 Jun 2018 09:29:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r8-v6sm88848527pfk.179.2018.06.05.09.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 09:29:40 -0700 (PDT)
Date:   Tue, 5 Jun 2018 09:29:39 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refspec: initalize `refspec_item` in
 `valid_fetch_refspec()`
Message-ID: <20180605162939.GA158365@google.com>
References: <CAN0heSr6dPa+--Mut0+3Zgy-mWF0d2762vKU=d08CKhR8BnKmA@mail.gmail.com>
 <20180604144305.29909-1-martin.agren@gmail.com>
 <87tvqiz06t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvqiz06t.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jun 04 2018, Martin Ågren wrote:
> 
> > We allocate a `struct refspec_item` on the stack without initializing
> > it. In particular, its `dst` and `src` members will contain some random
> > data from the stack. When we later call `refspec_item_clear()`, it will
> > call `free()` on those pointers. So if the call to `parse_refspec()` did
> > not assign to them, we will be freeing some random "pointers". This is
> > undefined behavior.
> >
> > To the best of my understanding, this cannot currently be triggered by
> > user-provided data. And for what it's worth, the test-suite does not
> > trigger this with SANITIZE=address. It can be provoked by calling
> > `valid_fetch_refspec(":*")`.
> >
> > Zero the struct, as is done in other users of `struct refspec_item`.
> >
> > Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> > ---
> > I found some time to look into this. It does not seem to be a
> > user-visible bug, so not particularly critical.
> >
> >  refspec.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/refspec.c b/refspec.c
> > index ada7854f7a..7dd7e361e5 100644
> > --- a/refspec.c
> > +++ b/refspec.c
> > @@ -189,7 +189,10 @@ void refspec_clear(struct refspec *rs)
> >  int valid_fetch_refspec(const char *fetch_refspec_str)
> >  {
> >  	struct refspec_item refspec;
> > -	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
> > +	int ret;
> > +
> > +	memset(&refspec, 0, sizeof(refspec));
> > +	ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
> >  	refspec_item_clear(&refspec);
> >  	return ret;
> >  }
> 
> I think this makes more sense instead of this fix:

I like this diff.  The only nit I have is the same as what Martin
pointed out.  At least this way all memory will be initialized by the
time a call to parse_refspec is made.

> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 99e73dae85..74a804f2e8 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1077,7 +1077,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (option_required_reference.nr || option_optional_reference.nr)
>  		setup_reference();
> 
> -	refspec_item_init(&refspec, value.buf, REFSPEC_FETCH);
> +	refspec_item_init_or_die(&refspec, value.buf, REFSPEC_FETCH);
> 
>  	strbuf_reset(&value);
> 
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1f2ecf3a88..bb64631d98 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -684,7 +684,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
>  	const char *spec_src;
>  	const char *merge_branch;
> 
> -	refspec_item_init(&spec, refspec, REFSPEC_FETCH);
> +	refspec_item_init_or_die(&spec, refspec, REFSPEC_FETCH);
>  	spec_src = spec.src;
>  	if (!*spec_src || !strcmp(spec_src, "HEAD"))
>  		spec_src = "HEAD";
> diff --git a/refspec.c b/refspec.c
> index 78edc48ae8..8806df0fd2 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -124,11 +124,16 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>  	return 1;
>  }
> 
> -void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
> +int refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
>  {
>  	memset(item, 0, sizeof(*item));
> +	int ret = parse_refspec(item, refspec, fetch);
> +	return ret;
> +}
> 
> -	if (!parse_refspec(item, refspec, fetch))
> +void refspec_item_init_or_die(struct refspec_item *item, const char *refspec, int fetch)
> +{
> +	if (!refspec_item_init(item, refspec, fetch))
>  		die("Invalid refspec '%s'", refspec);
>  }
> 
> @@ -152,7 +157,7 @@ void refspec_append(struct refspec *rs, const char *refspec)
>  {
>  	struct refspec_item item;
> 
> -	refspec_item_init(&item, refspec, rs->fetch);
> +	refspec_item_init_or_die(&item, refspec, rs->fetch);
> 
>  	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
>  	rs->items[rs->nr++] = item;
> @@ -191,7 +196,7 @@ void refspec_clear(struct refspec *rs)
>  int valid_fetch_refspec(const char *fetch_refspec_str)
>  {
>  	struct refspec_item refspec;
> -	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
> +	int ret = refspec_item_init(&refspec, fetch_refspec_str, REFSPEC_FETCH);
>  	refspec_item_clear(&refspec);
>  	return ret;
>  }
> diff --git a/refspec.h b/refspec.h
> index 3a9363887c..ed5d997f7f 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -32,7 +32,8 @@ struct refspec {
>  	int fetch;
>  };
> 
> -void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
> +int refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
> +void refspec_item_init_or_die(struct refspec_item *item, const char *refspec, int fetch);
>  void refspec_item_clear(struct refspec_item *item);
>  void refspec_init(struct refspec *rs, int fetch);
>  void refspec_append(struct refspec *rs, const char *refspec);
> 
> I.e. let's fix the bug, but with this admittedly more verbose fix we're
> left with exactly two memset() in refspec.c, one for each type of struct
> that's initialized by the API.
> 
> The reason this is difficult now is because the current API conflates
> the init function with an init_or_die, which is what most callers want,
> so let's just split those concerns up. Then we're left with one init
> function that does the memset.

-- 
Brandon Williams
