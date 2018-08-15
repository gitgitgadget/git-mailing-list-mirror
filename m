Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A841F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHOWCG (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:02:06 -0400
Received: from mout.web.de ([212.227.15.4]:51151 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbeHOWCG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:02:06 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK2JZ-1fpCL80bUj-001SAF; Wed, 15
 Aug 2018 21:08:19 +0200
Date:   Wed, 15 Aug 2018 21:08:16 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180815190816.GA26521@tor.lan>
References: <20180810153608.30051-1-pclouds@gmail.com>
 <20180812090714.19060-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180812090714.19060-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:Peeho/HHtrS502ZZQYvi9y4B/lcpM6vTagpSuRIHh4Lrr3jtg8l
 8I8kgoT9Q3/AFOjp9o6W+pW24koqJNgG42/EiB5NJBa+QrAk3zPlfVJ+CEsMgP5lkK+XffB
 8iszvmUn/FtUYSPANZRb7MZRK0sHx1l/3DW8gOeaoITilGxqPIGoJQCIyyHR4ZIDXve/he3
 EbzuOEkZdo79R5luhTrJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6QJmy0VVEQw=:f9Oattr1UL8Vy8rYwThkVm
 9m3acILVP2p8rLdjFc2vdcpB65dUB4nYMaWpkf9vqfrQm0wwwpGPtiwqR6QtHwsR5uiG8J/KC
 XS2gCNlml4iLhM8PkS/yjut8Q5iyADPglOjNqFUB8dAnT/KFiVda5rUZ6IXNAnkqJjPOuDG+i
 JwZgiNszdXF4Zxwv0fel8MM2LvKY6g0VzEPC5rbp2/G7LGDAxj1zXSk8DXB7W8rhyR4RGnMTt
 RCQMXUPa4pt7KbpKvv9UZ8f4sphoOFzThfdXmdo3bgdptJd2d11gKjcGrmAkWQhxlVe1bg0sT
 xCBOgQOVzOhJjeqGYCH9Dlge0YX2MwdabJ1HqU70kLVo9NJ9Nh1PdkVETlXoT1TnIltYJYWpH
 Xf5eRNNugPJTwNgDxjSf8R1mYQNlrmBBCP5h4ELocNpAnaC8tx2nryubrpti943E33O2Nb6Je
 ebsJ3p2RF/OGJh7ST9l8YTpbW6fIpNl8DCHwA1+EvxQzxZ+s1b9shff8u3f5I29o9KPbWXD5a
 0ZGlemUm+hY/J3leo/96uq0KFViuUVDVUtcnvZiNbaYrePP75d71h9Egx5EolaUXNqUquDEgH
 /At7BUEAcaGwIaQs+o7CDnwsMs1mEWYIC63AP1vMc7KSCTNmwYKByXcc4AWvEj1AoNoGCVCWx
 BczijqttBUcYSCmhySS0d6DZx4xtZHWBg4gYPjKU5TgglcjdcgOnaS6rhu8utg1ICGS5VrbEo
 gVja80L+VTGQLxWXgBbEtdZWx7SzeqtM8jAwPkgXwSzWSJmWClpjG/5qAHw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 12, 2018 at 11:07:14AM +0200, Nguyễn Thái Ngọc Duy wrote:
> Paths that only differ in case work fine in a case-sensitive
> filesystems, but if those repos are cloned in a case-insensitive one,
> you'll get problems. The first thing to notice is "git status" will
> never be clean with no indication what exactly is "dirty".
> 
> This patch helps the situation a bit by pointing out the problem at
> clone time. Even though this patch talks about case sensitivity, the
> patch makes no assumption about folding rules by the filesystem. It
> simply observes that if an entry has been already checked out at clone
> time when we're about to write a new path, some folding rules are
> behind this.
> 
> This patch is tested with vim-colorschemes repository on a JFS partition
> with case insensitive support on Linux. This repository has two files
> darkBlue.vim and darkblue.vim.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  v4 removes nr_duplicates (and fixes that false warning Szeder
>  reported). It also hints about case insensitivity as a cause of
>  problem because it's most likely the case when this warning shows up.
> 
>  builtin/clone.c  |  1 +
>  cache.h          |  1 +
>  entry.c          | 28 ++++++++++++++++++++++++++++
>  t/t5601-clone.sh |  8 +++++++-
>  unpack-trees.c   | 28 ++++++++++++++++++++++++++++
>  unpack-trees.h   |  1 +
>  6 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5c439f1394..0702b0e9d0 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -747,6 +747,7 @@ static int checkout(int submodule_progress)
>  	memset(&opts, 0, sizeof opts);
>  	opts.update = 1;
>  	opts.merge = 1;
> +	opts.clone = 1;
>  	opts.fn = oneway_merge;
>  	opts.verbose_update = (option_verbosity >= 0);
>  	opts.src_index = &the_index;
> diff --git a/cache.h b/cache.h
> index 8b447652a7..6d6138f4f1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1455,6 +1455,7 @@ struct checkout {
>  	unsigned force:1,
>  		 quiet:1,
>  		 not_new:1,
> +		 clone:1,
>  		 refresh_cache:1;
>  };
>  #define CHECKOUT_INIT { NULL, "" }
> diff --git a/entry.c b/entry.c
> index b5d1d3cf23..c70340df8e 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -399,6 +399,31 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
>  	return lstat(path, st);
>  }
>  
> +static void mark_colliding_entries(const struct checkout *state,
> +				   struct cache_entry *ce, struct stat *st)
> +{
> +	int i;
> +
> +	ce->ce_flags |= CE_MATCHED;
> +
> +#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
> +	for (i = 0; i < state->istate->cache_nr; i++) {
> +		struct cache_entry *dup = state->istate->cache[i];
> +
> +		if (dup == ce)
> +			break;
> +
> +		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
> +			continue;
> +

Should the following be protected by core.checkstat ? 
	if (check_stat) {


> +		if (dup->ce_stat_data.sd_ino == st->st_ino) {
> +			dup->ce_flags |= CE_MATCHED;
> +			break;
> +		}
> +	}
> +#endif

Another thing is that we switch of the ASCII case-folding-detection-logic
off for Windows users, even if we otherwise rely on icase.
I think we can use fspathcmp() as a fallback. when inodes fail,
because we may be on a network file system.
(I don't have a test setup at the moment, but what happens with inodes
when a Windows machine exports a share to Linux or Mac ?)

Is there a chance to get the fspathcmp() back, like this ?

static void mark_colliding_entries(const struct checkout *state,
				   struct cache_entry *ce, struct stat *st)
{
	int i;
	ce->ce_flags |= CE_MATCHED;

	for (i = 0; i < state->istate->cache_nr; i++) {
		struct cache_entry *dup = state->istate->cache[i];
		int folded = 0;

		if (dup == ce)
			break;

		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
			continue;

		if (!fspathcmp(dup->name, ce->name))
			folded = 1;

#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
		if (check_stat && (dup->ce_stat_data.sd_ino == st->st_ino))
			folded = 1;
#endif
		if (folded) {
			dup->ce_flags |= CE_MATCHED;
			break;
		}
	}
}

