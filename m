Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787DD1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 21:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdJEVmz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:42:55 -0400
Received: from mout.web.de ([212.227.17.12]:56651 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbdJEVmy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 17:42:54 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MduIT-1dfgkm1WvN-00Pdk4; Thu, 05
 Oct 2017 23:42:49 +0200
Date:   Thu, 5 Oct 2017 23:42:48 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
Message-ID: <20171005214248.GA31593@tor.lan>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
 <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
 <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
 <20171004211734.GA25379@tor.lan>
 <xmqq7ewa9xw6.fsf@gitster.mtv.corp.google.com>
 <xmqqo9pm8e4l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9pm8e4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:77aTiTWz7rVzKpS+dfRPyzHnnHa+5bWLeL3h6rKciMl7AbR+7kr
 F3bAGL5GrQsPN+qB4J0BtfQjCHcdDntm9ipzOepy6x/k3+e8AKAMfKoLPAn3I00lEmDe+cT
 Vtbw9qwM50/0qEM+UKgGIN5fIvxEEm90+0iAiEJmXBv3SvydN1IYMwNnP4ryzs2WS8jXP94
 grn2tulVSFpTiX64+1afQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hatLtxftJ8g=:I5Zd3zj1w+ivB13kRSHyJB
 jKU1910fnePw976giBMP0T/BYBnk+bUeKR/WkbQzL1jZDcjOeHXtHq5RdUvACqeN+4BKB6r/S
 ojGF6Gb05wJOMqsYfEjqj5Z2QQM+6eje6EBahfSohD46WwEu/4GmYklcrmQaiQLBGNlHIGtCB
 5B3KUmD2fbt2Vu9nBmqbyh/LptoNeLKyNRfstU1ej7worHOV57nnHX3VLT51zxCmsVZdCObZb
 EeQEpFFWrheKJNhLfEYjOT44M0RF8MFeE09q7RQIWoTh8wauw69EmzXaKeaNis43L746SCYnH
 TgzKeNBmFy/WsQ69ghV0W0nk4jGROT4QT72gQttaFksG6+AVHTfzpt6XKKMbJE45eEJz/URMS
 dXsn7Do79hb/QtePlG/2pt/fMpt7oC5ADOR/Qe8TBDjQdG68BJVnQDKvCOknhH8io7FV33Nw/
 83uLP0Hub7Uj82V+0c+Ak/PxQA2mqiaWOot/5H6eCZo59b/LMO+RbwoSdMh+FtK2hD72jkE15
 Gq51ATRZEKiAdpkTlHEx5jDwJ9LuKHmiXorg69aNp/xne2M2c2QtXvwYr71LQh5XqwWPArRCU
 3k4X6bFPT/WKj5pdBxu3DojrLixVTaXiRqbGXGqN2aiPckj5/N1HuVhKLULNKZt4hnnj4xfzK
 PuMVQIhtaVGa5+Y4zOjcp2MvOMU447MeMhw5CFqPi9Q/SV+eLqzJVskWb/SepeqnLwtHeuac7
 MAcFXwgT9tOnyiaI7cR2Fy9ufbw5oROsabO7da4kSJ1qqdEM2e5aX49Ih8CBCwcivmDkA2yl+
 Rski3OHSrIHuedeOxDO+Wtq2nfJag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 
>  builtin/add.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 5d5773d5cd..264f84dbe7 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -26,6 +26,7 @@ static const char * const builtin_add_usage[] = {
>  };
>  static int patch_interactive, add_interactive, edit_interactive;
>  static int take_worktree_changes;
> +static int rehash;
>  
>  struct update_callback_data {
>  	int flags;
> @@ -121,6 +122,41 @@ int add_files_to_cache(const char *prefix,
>  	return !!data.add_errors;
>  }
>  
> +static int rehash_tracked_files(const char *prefix, const struct pathspec *pathspec,
> +				int flags)
> +{
> +	struct string_list paths = STRING_LIST_INIT_DUP;
> +	struct string_list_item *path;
> +	int i, retval = 0;
> +
> +	for (i = 0; i < active_nr; i++) {
> +		struct cache_entry *ce = active_cache[i];
> +
> +		if (ce_stage(ce))
> +			continue; /* do not touch unmerged paths */
> +		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
> +			continue; /* do not touch non blobs */
> +		if (pathspec && !ce_path_match(ce, pathspec, NULL))
> +			continue;
> +		string_list_append(&paths, ce->name);
> +	}
> +
> +	for_each_string_list_item(path, &paths) {
> +		/*
> +		 * Having a blob contaminated with CR will trigger the
> +		 * safe-crlf kludge, avoidance of which is the primary
> +		 * thing this helper function exists.  Remove it and
> +		 * then re-add it.  Note that this may lose executable
> +		 * bit on a filesystem that lacks it.
> +		 */
> +		remove_file_from_cache(path->string);
> +		add_file_to_cache(path->string, flags);
> +	}
> +
> +	string_list_clear(&paths, 0);
> +	return retval;
> +}
> +
>  static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec, int prefix)
>  {
>  	char *seen;
> @@ -274,6 +310,7 @@ static struct option builtin_add_options[] = {
>  	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
>  	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
>  	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
> +	OPT_BOOL(0, "rehash", &rehash, N_("really update tracked files")),
>  	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
>  	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
>  	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
> @@ -498,7 +535,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	plug_bulk_checkin();
>  
> -	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
> +	if (rehash)
> +		exit_status |= rehash_tracked_files(prefix, &pathspec, flags);
> +	else
> +		exit_status |= add_files_to_cache(prefix, &pathspec, flags);
>  
>  	if (add_new_files)
>  		exit_status |= add_files(&dir, flags);

That looks like a nice one.
Before we put this into stone:
Does it make sense to say "renormalize" instead of "rehash" ?
(That term does exist already for merge.
 And rehash is more a technical term,  rather then a user-point-of-view explanation)
 
