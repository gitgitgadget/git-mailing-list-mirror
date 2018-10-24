Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1F21F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeJXRR3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:17:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:39589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeJXRR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:17:28 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhdex-1fu7F120Yd-00MrfN; Wed, 24
 Oct 2018 10:50:04 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhdex-1fu7F120Yd-00MrfN; Wed, 24
 Oct 2018 10:50:04 +0200
Date:   Wed, 24 Oct 2018 10:50:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] upload-pack: fix broken if/else chain in config
 callback
In-Reply-To: <20181024072752.GA29717@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1810241049200.4546@tvgsbejvaqbjf.bet>
References: <20181024072752.GA29717@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mOwQgs8IPet1mOKiZEqVimdjXRXoSAeLu8TIg4rhRLmgO7nOIQJ
 AHhbynDNxZuIrmJeBICDpYa93IliaZDBp1hdDSrXPICKfUGIDVBZ+arTseoTPajtR1l6Hoy
 +H9yevohnW45kIkzXM0kMaIZetZJR8HbuKdqB9uvTZGbLSc7r9X57iJDLj4bJO5ORs6MZ7g
 2g+PW2Xm//Y2nHBq1V2VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qenL+0zU8Lo=:PDzdhelSb6NYIpqrv1Ifl/
 28CHk6OSJ2fxrKrBnCO2AxrH1pgdnIkmF+gRQGdS0saQzo4MaNO44d8u/nLCyWTrx7DjOh6PN
 +Vh1BXfuJt+GP/g/6mhqLyxZMSL+ADeD3vhTYb6uyI5T9/I61eMtOT6Y7ll4BwviJe6tLAIqo
 ceKTrO/lZo+Ku8hoeIrE+iejCzMC+DBM0rbVfC0kbo52Yxai7zHSrxTaaqE04Xop8W36qB2wN
 tWYrOK/UAYjlyfojRxHdBgI3z4/BGULjma+e6B5CDBzUSqyLooTjDVhpd4lhIa6H8tYlyEz+x
 SEHfaosf7M6jpls8qy+0QaqiZkVBmTJIx+LLBelYO0S7KDM34GUqXXkBFEk+QFXJamcAgNxYv
 5gxNeS+gjwfq6g48M48DLk+MK5Pd7rUqLnTIg8RoNqz1kOwweCmvMUFSVQRUlMGx5hZq/nJ9B
 ISRUlN/rKLVZ9uCvp9+FGzXwSld+F3mtpydSBFHQizUs/ecPgYzrNKb1TFjTK2ecOWNEcGLsU
 00r9Bk/JEfs9mL+lZ6uxu+hfSFgCNfxiSIWOqI8JFUbc+PUoLkGMzMpCNSViq6TEWpJZkgdjJ
 iuK7yxduaJIWHGCXxqE+zmJD/VGZ4OmTyqp8GKXLGKXocvBD/vdhujOB5YyXInTCobIAumFqt
 5NndpZVTdJew8yZxU3Kd7Vyb2JngjJsPBgnqNKoMt6jJFWws44g6Q7zRydrFEzMnLBkyDseNt
 R7SrdVX/XGFmhPjtG9lISHsYZsnkJqy2kCQOlYqKaWNTpNTMpht8IVkNqS/7f+R7fNkMW36FX
 esuYcUu0vLRQNwddzJqdBTKPbAhHkRA5t3z7hdxfWO5cBHphg0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 24 Oct 2018, Jeff King wrote:

> The upload_pack_config() callback uses an if/else chain
> like:
> 
>   if (!strcmp(var, "a"))
>      ...
>   else if (!strcmp(var, "b"))
>      ...
>   etc
> 
> This works as long as the conditions are mutually exclusive,
> but one of them is not. 20b20a22f8 (upload-pack: provide a
> hook for running pack-objects, 2016-05-18) added:
> 
>   else if (current_config_scope() != CONFIG_SCOPE_REPO) {
>      ... check some more options ...
>   }
> 
> That was fine in that commit, because it came at the end of
> the chain.  But later, 10ac85c785 (upload-pack: add object
> filtering for partial clone, 2017-12-08) did this:
> 
>   else if (current_config_scope() != CONFIG_SCOPE_REPO) {
>      ... check some more options ...
>   } else if (!strcmp("uploadpack.allowfilter", var))
>      ...
> 
> We'd always check the scope condition first, meaning we'd
> _only_ respect allowfilter when it's in the repo config. You
> can see this with:
> 
>   git -c uploadpack.allowfilter=true upload-pack . | head -1
> 
> which will not advertise the filter capability (but will
> after this patch). We never noticed because:
> 
>   - our tests always set it in the repo config
> 
>   - in protocol v2, we use a different code path that
>     actually calls repo_config_get_bool() separately, so
>     that _does_ work. Real-world people experimenting with
>     this may be using v2.
> 
> The more recent uploadpack.allowrefinwant option is in the
> same boat.
> 
> There are a few possible fixes:
> 
>   1. Bump the scope conditional back to the bottom of the
>      chain. But that just means somebody else is likely to
>      make the same mistake later.
> 
>   2. Make the conditional more like the others. I.e.:
> 
>        else if (!current_config_scope() != CONFIG_SCOPE_REPO &&
>                 !strcmp(var, "uploadpack.notallowedinrepo"))
> 
>      This works, but the idea of the original structure was
>      that we may grow multiple sensitive options like this.
> 
>   3. Pull it out of the chain entirely. The chain mostly
>      serves to avoid extra strcmp() calls after we've found
>      a match. But it's not worth caring about those. In the
>      worst case, when there isn't a match, we're already
>      hitting every strcmp (and this happens regularly for
>      stuff like "core.bare", etc).
> 
> This patch does (3).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Phew. That was a lot of explanation for a small patch, but
> this was sufficiently subtle I thought it worth it. And
> also, I was really surprised the bug managed to exist for
> this long without anybody noticing.

Maybe a lot of explanation, but definitely a good one. The explanation and
the patch look good to me.

Thanks,
Dscho

> 
>  upload-pack.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index 540778d1dd..489c18e222 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1028,14 +1028,17 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>  		keepalive = git_config_int(var, value);
>  		if (!keepalive)
>  			keepalive = -1;
> -	} else if (current_config_scope() != CONFIG_SCOPE_REPO) {
> -		if (!strcmp("uploadpack.packobjectshook", var))
> -			return git_config_string(&pack_objects_hook, var, value);
>  	} else if (!strcmp("uploadpack.allowfilter", var)) {
>  		allow_filter = git_config_bool(var, value);
>  	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
>  		allow_ref_in_want = git_config_bool(var, value);
>  	}
> +
> +	if (current_config_scope() != CONFIG_SCOPE_REPO) {
> +		if (!strcmp("uploadpack.packobjectshook", var))
> +			return git_config_string(&pack_objects_hook, var, value);
> +	}
> +
>  	return parse_hide_refs_config(var, value, "uploadpack");
>  }
>  
> -- 
> 2.19.1.1094.gd480080bf6
> 
