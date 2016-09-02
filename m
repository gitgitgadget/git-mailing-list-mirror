Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068F31F859
	for <e@80x24.org>; Fri,  2 Sep 2016 09:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbcIBJB7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 05:01:59 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35100 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbcIBJB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 05:01:58 -0400
Received: by mail-wm0-f52.google.com with SMTP id w2so19476527wmd.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQfc5klwq5LQnu4MezON8ZeehzcjK/SE6Jaet9gU4Wk=;
        b=z1JnhqRtQMM+Wqqt151YEZFeALT6sJ3IT5yxPL8Qz3oI92qehiM6yherLfAH8AuCjC
         GPtZ0F9KzbH5Ii3bOgH3OdALWO3+MYD28jE2szg21z3IzN2nScPGgth4jiw5dBCqVl+c
         lZgU57WOpqnLRU7GkiFZYxv/QPBP0E9+u2IY3YTrfBsU2DKU94llE717PwwzsHGeY1Ec
         UwdGoB4vLU7Jx2MinMqZRqKFNr46WzR9cSC9W49NvAFWHXrON240k5Sd9g9C17xSZjiX
         TagFj1JCgbJxAlVORZELjmrlmpb7llKmer26ckmjMPd5E4YmmYcd/Ivuk5ZCItpz4N/+
         FNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQfc5klwq5LQnu4MezON8ZeehzcjK/SE6Jaet9gU4Wk=;
        b=d4x1G6S8RLUeDcCTw0u1NseBuWgRMWPx7jEppfl1jw0f2c9OH3GFFhzKY/gklv67tA
         gSid7mRzgyaRRdU/Gbc6t4OfIvf7D76CSv2r/KeHwkZatHRNKd0iKnUPJtuHNAv4bgrW
         vldlsvtBTzaHE4zJ1krPeCUG1scu7W/PbNX4e4uDxZy5/+5SRCiod1bF0XTrdnwWr1s+
         0mVs9bC8g1Lib+ogHwP9I+RQrpWLzlnyuF0vf50OWZf960ncVgROml5OVYoIO8VZ5ie7
         nKZR2+4sgBKSEDdZO7oqFVheKw58OIAv14S4rj4RJB6k4XKiW50iD0+ML/KF3BBT3lHk
         Nk1w==
X-Gm-Message-State: AE9vXwOXfueUXDCZAZ049R+nScOfJCrkEXqqbl6x8x6Tx8UZEPTzFC+f+jdiBkUqkLMQpA==
X-Received: by 10.194.175.38 with SMTP id bx6mr17335325wjc.47.1472806916237;
        Fri, 02 Sep 2016 02:01:56 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id hk4sm1848182wjb.16.2016.09.02.02.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 02:01:55 -0700 (PDT)
Message-ID: <1472806914.4680.50.camel@kaarsemaker.net>
Subject: Re: bug: 'core.logallrefupdates' is not set by default in non-bare
 repository
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jeff King <peff@peff.net>
Cc:     doak <doak@gmx.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Fri, 02 Sep 2016 11:01:54 +0200
In-Reply-To: <20160902080416.jmrctu3onfmylmeq@sigill.intra.peff.net>
References: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
         <1472634746.4265.47.camel@kaarsemaker.net>
         <20160831104825.quyqb54bo5k7fdxs@sigill.intra.peff.net>
         <1472657553.4265.63.camel@kaarsemaker.net>
         <20160902080416.jmrctu3onfmylmeq@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On vr, 2016-09-02 at 04:04 -0400, Jeff King wrote:
> On Wed, Aug 31, 2016 at 05:32:33PM +0200, Dennis Kaarsemaker wrote:
> 
> > 
> > > 
> > > We may need to do something like turn off the
> > > need_shared_repository_from_config in init-db, since I think it would
> > > not want to ever read from the default config sources in most of its
> > > code-paths (OTOH, it should in theory respect core.sharedRepository
> > > in ~/.gitconfig, so maybe there is another more elegant way of
> > > handling this).
> > I would go even further and say that git init should completely ignore
> > the config of a repository you happen to be in when creating a new
> > repository.
> Hmm. I'd think we would already be avoiding that, because we shouldn't
> be calling setup_git_directory(). But some of the lazy-loaded setup is a
> bit overzealous, and we blindly look at ".git/config". If we try the
> same operation from a subdir of an existing repo, we _don't_ end up
> confused. Eek.

Yikes. Didnt' dig that deep, but that sounds wrong :)

> So I actually wonder if that is the root of the bug. In your patch, you
> disable config reading when we chdir to the new repo:
> 
> > 
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 3a45f0b..d0fd3dc 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -493,6 +493,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
> >  		int mkdir_tried = 0;
> >  	retry:
> >  		if (chdir(argv[0]) < 0) {
> > +			/*
> > +			 * We're creating a new repository. If we're already in another
> > +			 * repository, ignore its config
> > +			 */
> > +			ignore_repo_config = 1;
> > +			git_config_clear();
> But I think we should go further and avoid ever looking at the original
> repository in the first place. I.e., I would say that "git init" should
> never ever behave differently if run in an existing repo versus outside
> of one.

Well, 'git init' is a valid operation to run inside an existing repo to
reinitialize some bits, so we definitely need to not ignore the config
once we're sure we're not creating a new repo.

> So really we ought to be setting ignore_repo_config from the very start
> of cmd_init(), and then re-enabling it once we are "inside" the new
> repo.  The git_config_clear() should in theory come once we are
> "inside", as well; we may have cached system/global config, and
> need to flush so we read them anew along with the new local config.

That's why I git_config_clear() twice.

> OTOH, since there shouldn't be anything interesting in the new
> repo-level config, I'm not sure that's really necessary. The rest of
> "init" can probably proceed without caring.

Except when running 'git init' to re-init existing repo.

> I also wonder if there are other things besides config which might
> accidentally read from .git (because they call git_pathdup(), and it
> just blindly looks in ".git" if nobody called setup_git_directory()). So
> it would be nice to have some flag for "do not ever lazy-call
> setup_git_env; we do not care about any repository".  But I think that's
> ahrd; functions like git_pathdup() are always expected to return _some_
> value, so what would they say? The best we could do is return
> "/does-not-exist/" or something, but that is awfully hacky.
> 
> > 
> > @@ -500,7 +506,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
> >  				 * and we know shared_repository should always be 0;
> >  				 * but just in case we play safe.
> >  				 */
> > -				saved = get_shared_repository();
> >  				set_shared_repository(0);
> >  				switch (safe_create_leading_directories_const(argv[0])) {
> >  				case SCLD_OK:
> I don't know if anybody cares about being able to set core.sharedRepository
> from ~/.gitconfig. It didn't work until v2.9.0 anyway (when I moved it
> out of the repository-format check), but it seems like you _should_ be
> able to set it and have it Just Work.
> 
> And in that case, this "we know shared_repository should always be 0" is
> not true, and we would want to keep doing the save/set-to-0/restore
> dance here.

We don't need to save if we throw away the cache below.

> > @@ -524,6 +528,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
> >  	} else if (0 < argc) {
> >  		usage(init_db_usage[0]);
> >  	}
> > +
> > +	need_shared_repository_from_config = 1;
> > +	ignore_repo_config = 0;
> > +	git_config_clear();
> This is the part I think we could actually skip. The only thing we might
> not have loaded is the "config" we just wrote to the new repository. But
> I don't think we have to care about what is in it.

We do, because this is also called for existing repos.

> > diff --git a/config.c b/config.c
> > index 0dfed68..2df0189 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1304,7 +1304,7 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
> >  		ret += git_config_from_file(fn, user_config, data);
> >  
> >  	current_parsing_scope = CONFIG_SCOPE_REPO;
> > -	if (repo_config && !access_or_die(repo_config, R_OK, 0))
> > +	if (repo_config && !ignore_repo_config && !access_or_die(repo_config, R_OK, 0))
> >  		ret += git_config_from_file(fn, repo_config, data);
> We probably want to intercept the call to git_pathdup() earlier than
> this, if the point is not to touch any of the lazy-load setup_git_dir()
> stuff at all. The effect is the same for config, but I think it makes
> sense to have as little effect as possible.

Thought about doing that, but didn't know what side-effects that would
have.

> So here's the minimal fix that seems to work for me:
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 3a45f0b..56e7b9a 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -484,6 +484,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> +	ignore_repo_config = 1;
> +
>  	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
>  
>  	if (real_git_dir && !is_absolute_path(real_git_dir))
> diff --git a/cache.h b/cache.h
> index b780a91..13b78e4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1582,6 +1582,13 @@ enum config_origin_type {
>  	CONFIG_ORIGIN_CMDLINE
>  };
>  
> +/*
> + * If non-zero, git_config() will avoid any attempt to find the repo config;
> + * this is useful for programs like git-init that might look at config before
> + * actually setting up the new repository.
> + */
> +extern int ignore_repo_config;
> +
>  typedef int (*config_fn_t)(const char *, const char *, void *);
>  extern int git_default_config(const char *, const char *, void *);
>  extern int git_config_from_file(config_fn_t fn, const char *, void *);
> diff --git a/config.c b/config.c
> index 0dfed68..c9fc62e 100644
> --- a/config.c
> +++ b/config.c
> @@ -14,6 +14,8 @@
>  #include "string-list.h"
>  #include "utf8.h"
>  
> +int ignore_repo_config;
> +
>  struct config_source {
>  	struct config_source *prev;
>  	union {
> @@ -1289,7 +1291,7 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
>  	int ret = 0;
>  	char *xdg_config = xdg_config_home("config");
>  	char *user_config = expand_user_path("~/.gitconfig");
> -	char *repo_config = git_pathdup("config");
> +	char *repo_config = ignore_repo_config ? NULL : git_pathdup("config");;
>  
>  	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
>  	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index a6fdd5e..8efddaa 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -384,4 +384,13 @@ test_expect_success MINGW 'bare git dir not hidden' '
>  	! is_hidden newdir
>  '
>  
> +test_expect_success 'init from existing directory does not confuse config' '
> +	rm -rf newdir &&
> +	test_config core.logallrefupdates true &&
> +	git init newdir &&
> +	echo true >expect &&
> +	git -C newdir config --bool core.logallrefupdates >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> 
> 
