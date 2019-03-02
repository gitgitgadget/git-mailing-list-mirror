Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8160E20248
	for <e@80x24.org>; Sat,  2 Mar 2019 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCBV2W (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 16:28:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:41561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfCBV2W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 16:28:22 -0500
Received: from [10.49.202.116] ([95.208.58.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdafs-1gd0zQ1je0-00PNG0; Sat, 02
 Mar 2019 22:28:20 +0100
Date:   Sat, 2 Mar 2019 22:28:23 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] name-rev: improve name_rev() memory usage
In-Reply-To: <20190301175024.17337-2-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903022224480.45@tvgsbejvaqbjf.bet>
References: <20190301175024.17337-1-alban.gruin@gmail.com> <20190301175024.17337-2-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QeOIvE9kCgVIXe8fnfnmrD2h/7c0Q5FWm5Zb50PAI5ESfJ7pLtk
 oVASbx77durJfjPyCZBcoZQblS4lUzpaeumC+YH+d1vaSgXix9MqQ/BJhfJ9uQe7ugLvSBq
 TJGqSXs5cKLQjj2UxX+ufiJ0P0jHjgYPMxuOL7nrof7QvCGJmPhLC9L6MxQi8X6/KhQwXAu
 eLGVs8e2Oh+ZF+PVk0GxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RBTUaVsKjlc=:+eTQD2rPVTpODm81zSyTuk
 ae9XFPVX0JhInAORcFWrSqEdZ75dy05Sb84q4m5E+iKBJR47DPE/zAP5AfeIQlFnCkqyfOmq6
 n9VKU3aB90DVcF8Z118wb/suiVeZvBTeRnVux3feQRpRv4Oglx6VLxOcI9IAW4qwZ8ZbNNn9G
 w9cfe4/HGlqLJmMX/hcWL3zgxGM9lQ+62qDI9nV3ooZNW44mmXeL5DlGJ/UTDRMHAXe3jYh2s
 XLCVPj4EYciv5VQsc420/wrMa1ZjgHKtVVGJD/uGFI5Xhrbz3nhhrL98Mmy2kJnpchGLZz1tl
 d3E2PZXDiLN1zTxdpRHE6UtwkUBax1BKSjpmk/ECaLizHZkYW7kgjWy4+++5vutdoLqguDsKC
 i2TQPmQLmp5NqPX79z/y/W5m2HVuQLPVMSMlHR+SPi671/x46uVBSeYfKfakkeDArISlEyoLm
 hHeVIfaHwLSlQKr5+AG+ZlZskDoK2EHRUDeVgATk4Q8nMYb2VkfZviAPJZknj5f5sPpHXVTMM
 4RPmMo/WY3GPG8gdomIrcaKrTmXSPcg5lTv5VEMHIEllDIyg0PLgh9rfXd/WbhXyPWuOHsp1T
 FHk7+hp80YoaRZ7X4sqM98A/neLF86W96DsApK+m8NsJzzI6NVtwXwW9fI3qqjawkENmG2oDG
 xE3mfvwsDlDk2VtLIx0YVjONg476DB74dU3S8U5BmrCS4jjwzHixlKTFs2QOVdi8Prd4U2m78
 ZZ4lLHDCXdh/DKCSxBork0Y5u3i+Ecw2CK7K4d4vBQ9ux4Moeu46SRt6y3nKgSiHvzXY4mxSr
 FkNyOlpn8mUbbKmIU3wz4K/nlPLzPbCoB9hkYRAoqmgDbwjM081Wb1N9684OUQqer84VSk6k+
 CiB3VOgZ1dDRC4pK23qA3SPNQBNSeXoc6hwrkTmI2xpbn3fA5KchCksQIgjgrt0yYL8dp+iiT
 +Lrxpfu5qHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Fri, 1 Mar 2019, Alban Gruin wrote:

> name_rev() is a recursive function.  For each commit, it allocates the
> name of its parents, and call itself.  A parent may not use a name for
> multiple reasons, but in any case, the name will not be released.  On a
> repository with a lot of branches, tags, remotes, and commits, it can
> use more than 2GB of RAM.
> 
> To improve the situation, name_rev() now returns a boolean to its caller
> indicating if it can release the name.  The caller may free the name if
> the commit is too old, or if the new name is not better than the current
> name.
> 
> There a condition that will always be false here when name_rev() calls
> itself for the first parent, but it will become useful when name_rev()
> will stop to name commits that are not mentionned in the stdin buffer.
> If the current commit should not be named, its parents may have to be,
> but they may not.  In this case, name_rev() will tell to its caller that
> the current commit and its first parent has not used the name, and that
> it can be released.  However, if the current commit has been named but
> not its parent, or the reverse, the name will not be released.

Makes sense, and the patch looks mostly good to me, just one suggestion:

> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/name-rev.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index f1cb45c227..0719a9388d 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -77,7 +77,7 @@ static int is_better_name(struct rev_name *name,
>  	return 0;
>  }
>  
> -static void name_rev(struct commit *commit,
> +static int name_rev(struct commit *commit,
>  		const char *tip_name, timestamp_t taggerdate,
>  		int generation, int distance, int from_tag,
>  		int deref)
> @@ -86,11 +86,12 @@ static void name_rev(struct commit *commit,
>  	struct commit_list *parents;
>  	int parent_number = 1;
>  	char *to_free = NULL;
> +	int free_alloc = 1;
>  
>  	parse_commit(commit);
>  
>  	if (commit->date < cutoff)
> -		return;
> +		return 1;
>  
>  	if (deref) {
>  		tip_name = to_free = xstrfmt("%s^0", tip_name);
> @@ -111,9 +112,10 @@ static void name_rev(struct commit *commit,
>  		name->generation = generation;
>  		name->distance = distance;
>  		name->from_tag = from_tag;
> +		free_alloc = 0;
>  	} else {
>  		free(to_free);
> -		return;
> +		return 1;
>  	}
>  
>  	for (parents = commit->parents;
> @@ -131,15 +133,18 @@ static void name_rev(struct commit *commit,
>  				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
>  						   parent_number);
>  
> -			name_rev(parents->item, new_name, taggerdate, 0,
> -				 distance + MERGE_TRAVERSAL_WEIGHT,
> -				 from_tag, 0);
> +			if (name_rev(parents->item, new_name, taggerdate, 0,
> +				      distance + MERGE_TRAVERSAL_WEIGHT,
> +				      from_tag, 0))
> +				free(new_name);
>  		} else {
> -			name_rev(parents->item, tip_name, taggerdate,
> -				 generation + 1, distance + 1,
> -				 from_tag, 0);
> +			free_alloc &= name_rev(parents->item, tip_name, taggerdate,
> +					       generation + 1, distance + 1,
> +					       from_tag, 0);

This would be easier to read if it avoided the &=, e.g. by turning it
into:

		} else if (!name_rev(parents->item, tip_name, taggerdate,
				     generation + 1, distance + 1,
				     from_tag, 0))
			free_alloc = 0;

Ciao,
Dscho

>  		}
>  	}
> +
> +	return free_alloc;
>  }
>  
>  static int subpath_matches(const char *path, const char *filter)
> -- 
> 2.20.1
> 
> 
