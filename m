Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438191F453
	for <e@80x24.org>; Mon,  4 Feb 2019 10:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfBDKiF (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 05:38:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:35647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbfBDKiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:03 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfCX2-1hSASG3JMm-00or6w; Mon, 04
 Feb 2019 11:38:00 +0100
Date:   Mon, 4 Feb 2019 11:38:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
In-Reply-To: <5d521649-0b21-04e3-3182-e8714fcbfeac@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1902041135320.41@tvgsbejvaqbjf.bet>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org> <5d521649-0b21-04e3-3182-e8714fcbfeac@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6TNtIu20Kh8STzEQkNejNGG9c0unnB7lW+neLXUcpQWU7T6dLFD
 mTfdOMI9ijnOIqUFlWIcE5lUiypf/cUX4KZCLV2CX/dJZxN257qwTLWj2SDIoyxswwsO1Po
 yDDacz+dNji4TiGJ2OTaZYXu5RB4Pk3GAZ2hsIQbN0fD9/O+116oUlz+XvRkmwZbOJjs7tu
 13RrTnOAp23ISx4x3EvlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ca/7q63ryQ=:7FYMudQZ1rKX2kpdtMy7Ox
 3+8WvnlsthOa7q48D233Kk/aQbbYgBPoiU93+CyD6asIhca0xMhKKywyTNmPttVLjpJyTk1UF
 ZbgyxMjJVAkDAg+NxQAabAmAk1OxNEPrFe5sAdswtmztXP+4CTwUYhK05ubBQfD7k1myU4zhi
 vOcdkcqO7Y0MD3nbyroHyR08mdUwNdvmWjizsedtfbzUWJIECFuDLO5z6ijmUTn9CHwDgWvdo
 q4rn8CFN06ab9fy8+TogM85V3RkGBQ1pjRsXTtznH60jernqIcIgrBxeadcSKo4efpoTBsawE
 Z6ko/Ngkw3AaTb99j+ODdlmi4v8u0anpHZkq1aiBFI4sFw1AHm//KvVFcEzkFV9+C2XZ2Yz5d
 Mttkg3v3UZueNaI5mkR9nkda7/KpP90g3cpJF0RT27GnMsv/vqrMx/2lmSoA0V1bOh831Cv6a
 zgC2uFaOycVunG/YUhNau/4Gs1y7iQky5veOkTnTHmRYoCN+TeftABAlEv9UIAjknpXmIdrYR
 Ds3KmqxAG26LRpuLH0e/zx5Yj5iU/3Jff+m4bvKlKHjFZkBvZ9sqNLng1W/3F2kFISCQkAiIA
 HXoN0UFngw2fW1yO4ox2UMv5LQYYM7xzbV4AKWNizut7TT5ZMXd3w5nCGkiucrtBec567gKwG
 VJISO7K1QC33OhnZzF8nOEQiBJFW3eX9BC6YEd6yNDmUpAK4HLK/+yv4RxEZZSkr3APX4nkEM
 P0qGKoVb2wJVEz6977wVFTPS+wZb9Prn3Be92xNbnzQ98LPJoosGv5cbVqMN4URzggeSyr22p
 sxBPIWsZXTULgx3gHZo+joexckzpXLS0dwokTdswiYexDkGv18Qs+/7ziuE57aAyJZFcyIXLV
 N0SWWoLqg8JJNEaQM6SFl88DGzsD2yxH3qaXwidTZwOHpLktjLVUCjf/f/4xDe37ACSE7TrZo
 6cQXvrZ3mrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 4 Feb 2019, Johannes Sixt wrote:

> Am 03.02.19 um 17:51 schrieb Johannes Sixt:
> > strbuf_vinsertf inserts a formatted string in the middle of an existing
> > strbuf value.
> 
> Quite frankly, this is a really unusual operation, and I'd prefer to get
> rid of it. There is only one call, and it looks like it only wants to be
> lazy and save one strbuf variable.

The only reason why there are not more callers is that I did not convert
any of the appropriate places. We have quite a few places where we
allocate a new strbuf for the sole purpose of formatting something that is
then inserted into an already existing strbuf (possibly extending the
buffer, which might require a move of the buffer just because that
temporary strbuf is in the way).

It does not sound like good practice to me to allocate things left and
right, only to reallocate something that was just allocated anyway and to
copy things into that and then release things left and right.

Ciao,
Dscho

> This helper adds way more code than a non-lazy caller would need. There
> wouldn't even be a mental burden. Like this (except that strbuf_addstr
> doesn't do what I thought it would do...).
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 74e6ff62b5..95d202aea3 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1101,7 +1101,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
>  	return ret;
>  }
>  
> -static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
> +static int do_create_stash(struct pathspec ps, const char *stash_msg,
>  			   int include_untracked, int patch_mode,
>  			   struct stash_info *info, struct strbuf *patch,
>  			   int quiet)
> @@ -1117,6 +1117,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  	struct strbuf msg = STRBUF_INIT;
>  	struct strbuf commit_tree_label = STRBUF_INIT;
>  	struct strbuf untracked_files = STRBUF_INIT;
> +	struct strbuf stash_msg_buf = STRBUF_INIT;
>  
>  	prepare_fallback_ident("git stash", "git@stash");
>  
> @@ -1188,10 +1189,12 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  		}
>  	}
>  
> -	if (!stash_msg_buf->len)
> -		strbuf_addf(stash_msg_buf, "WIP on %s", msg.buf);
> -	else
> -		strbuf_insertf(stash_msg_buf, 0, "On %s: ", branch_name);
> +	if (!*stash_msg) {
> +		strbuf_addf(&stash_msg_buf, "WIP on %s", msg.buf);
> +	} else {
> +		strbuf_addf(&stash_msg_buf, "On %s: ", branch_name);
> +		strbuf_addstr(&stash_msg_buf, stash_msg);
> +	}
>  
>  	/*
>  	 * `parents` will be empty after calling `commit_tree()`, so there is
> @@ -1206,7 +1209,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  			   &parents);
>  	commit_list_insert(head_commit, &parents);
>  
> -	if (commit_tree(stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
> +	if (commit_tree(stash_msg_buf.buf, stash_msg_buf.len, &info->w_tree,
>  			parents, &info->w_commit, NULL, NULL)) {
>  		if (!quiet)
>  			fprintf_ln(stderr, _("Cannot record "
> @@ -1216,6 +1219,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  	}
>  
>  done:
> +	strbuf_release(&stash_msg_buf);
>  	strbuf_release(&commit_tree_label);
>  	strbuf_release(&msg);
>  	strbuf_release(&untracked_files);
> @@ -1236,7 +1240,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  	if (!check_changes_tracked_files(ps))
>  		return 0;
>  
> -	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
> +	if (!(ret = do_create_stash(ps, stash_msg_buf.buf, 0, 0, &info, NULL, 0)))
>  		printf_ln("%s", oid_to_hex(&info.w_commit));
>  
>  	strbuf_release(&stash_msg_buf);
> @@ -1300,7 +1304,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
>  
>  	if (stash_msg)
>  		strbuf_addstr(&stash_msg_buf, stash_msg);
> -	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
> +	if (do_create_stash(ps, stash_msg_buf.buf, include_untracked, patch_mode,
>  			    &info, &patch, quiet)) {
>  		ret = -1;
>  		goto done;
> 
