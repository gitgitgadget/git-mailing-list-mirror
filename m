Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5261FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 10:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCOKSj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 06:18:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:47265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751762AbeCOKSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 06:18:37 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNf1y-1ey4v538nq-007A2b; Thu, 15
 Mar 2018 11:18:33 +0100
Date:   Thu, 15 Mar 2018 11:18:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] rebase: support --signoff with implicit rebase
In-Reply-To: <20180314111127.14217-1-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803151112390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zVg3L+OtBYshq0Wipg6nvO/hyYNxGQt6tlka69wBhSRjX3/dftj
 a8I7UX39yVGu645O5SKRrEO9SiwdX52W5PJTGkhvuYaSigV/IQOKLPBU5vPROhmXUzoSutb
 ADZ8VABnz2V48l864+q3MkleVThBZdUaS6E9wP+/oprekUhz4WluViNuIKlYrzOJ9i54eBQ
 8vNtVUz2PeUCBGgfSAkHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kAEhPvUkxVM=:fxl5XHrh0UvjipqQ96l0fP
 4OeFYE/VwMXKs3fxfk8P4CuOPkWGyz/UACedd0SzEJunX5VMP7LF6HStutU+G0IVTizrxwov3
 7VR/p15IFf0jZnC3TROgvr3VkSul2jmoMvyvO4TS5ihNnV8ISIlSC9bWgBBbTmf13uaMtrKCY
 jZGSyhrSsXjp1FF8Ws6xEnzgAgyuDAOzvE4OOKJrSujJebPrYNAzMIXRhgyiRjJWBJEMZw5DF
 Mbg8CTOUrPRewSxzZhAeMoxk6Pm2uIwCUTts6zzmjwHNHswwjLe3DgxU5EUmhxNMGg5tE5/40
 hdJWCDP9EgYNgajQjEBHcf27+6k5oC6idyXuirtwx5NMbsZUIGrm0KEOuJ4TmIdgvZFpkkYkf
 rfAU80em2q89LTXWX6Rjj+0PPc4e3M6eJ+/YI7gQ5sFq7S/isXQPsxL6jy7W7/O4pmdcFX/ih
 dF0M56AFk9dbLpmkvG5D8ZFHui5+wuyzxCZmVGPJ1+5ZyN6tsb8eB4DoxUjuJMRGLdElcYTwJ
 Iu6vL2GZVIssI/tO6HYEEiyBAC61UPQA4HpjrhB1umWHR/Z6NO0y5tSOLsJxXCYf/Y4j0tWBw
 Hx2bVMT+3ymOwPxvkKetfyg/xPSix/j6XxnJ31GFAYvqrVQl2OxA52K+rTMINMA1TplsTAuj5
 7eNX+4/Ku0b2jOe1FXeQ7eVwh+JWqBqUBjFsD9Zp+OlMpQIRIDYt19qSac4isD5ppoItzWUhF
 hCVPo4+fmeqYAN2WCJa/qVD7+JZjI4knHS2Y6WJKmGgX4C2ZD2yYYRQb9w4ZEPh9L9dHg9JN7
 EtTPne3rg9QetA46Z37ow4xOdiAbiMBrQnnHTKjD9gC9uT3scg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 14 Mar 2018, Phillip Wood wrote:

> diff --git a/git-rebase.sh b/git-rebase.sh
> index b353c33d41..40301756be 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -459,6 +471,18 @@ then
>  	git_format_patch_opt="$git_format_patch_opt --progress"
>  fi
>  
> +if test -n "$signoff"
> +then
> +	test "$interactive_rebase" = explicit &&
> +		die "$(gettext "error: interactive rebase does not support --signoff")"
> +	test "$type" = merge &&
> +		die "$(gettext "error: merge rebase does not support --signoff")"
> +	test -n "$preserve_merges" &&
> +		die "$(gettext "error: cannot combine '--signoff' with '--preserve-merges'")"
> +	git_am_opt="$git_am_opt $signoff"
> +	force_rebase=t
> +fi

I wonder whether we can have this change as a separate commit? Otherwise
we would lump that change (--interactive --signoff was previously allowed
but the --signoff was simply ignored) with the other changes...

As I mentioned in my reply to Junio's comment, it'd be awesome if
--interactive --signoff was supported (and likewise --merge --signoff),
but it feels like an undue feature request to be dumped on you, so I'm
fine with the patch series simply erroring out on those combinations.

(I don't care about --preserve-merges anymore, as everybody knows by now.)

Ciao,
Dscho
