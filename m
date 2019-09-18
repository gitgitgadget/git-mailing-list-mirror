Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF811F463
	for <e@80x24.org>; Wed, 18 Sep 2019 09:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfIRJ1Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 05:27:25 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:37393 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfIRJ1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 05:27:25 -0400
Received: by mail-pg1-f172.google.com with SMTP id c17so3690868pgg.4
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kHHFJWqPWxaXzg3WD0pRSS51GQZMTIc3YVPViT1SCm4=;
        b=lV2qPkY+QVdwdklY6LhlqmIzZmUtFwzuUVviByfMyacUj8QBwwxJONjUGClSUS/Op4
         vAYPm00RPhcnf3AUXwyziaUAUOkVLqtRqW7dVMA8eV9GxoUe9ArqqirzKhbpfLQyEC+O
         24gK2QfRTeCdYSg0wnhwjCgG07dxZrfQrT5yklI1Beig0P1xj9+UYPdo7T5qLgRXQQlA
         2TEkNl/F7B9rs0qf+Cu0pLyIxSRn2O7dc8Vqx9UTvLAWH4Kb3juuxu21kvbwmGAPFjnV
         21bmNmINh15/KsCrH8iQSzK2pmSxcr+w9Atm11Gi0ThiSfDSYqccknBgyv2nIy/WduYU
         RMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kHHFJWqPWxaXzg3WD0pRSS51GQZMTIc3YVPViT1SCm4=;
        b=Iqe5/sYT15s0OVvzj/Jftw3BINqtrXy177NTeS/2GcUiTdJZZBrdS0bu9vLy8pmt1m
         uPv+KmBYDd1z9m865jFX/wFI70OJ6vDe5a438z1BynaSh6m0SF52FYy4fK8CwxYsmI8S
         lYJctU2J4lrzqz9gf137oPITCjRQwT6JiEbixR+MYhjU+TjUv43xLKF0eB1VHiCHY+Ji
         8iijDRVTtRto1uj/vILHNp10nG2V3uENsYNuEKyxzJbdbViVfDp8HfOJEI7Z3pPUSZ09
         u63zcCQVLr4vOCe3nE3FqmQuJVofKLOIGELRJL7VlBoeCVcJpeyuhgQH+R1XFVrpp15j
         GxCw==
X-Gm-Message-State: APjAAAXqx2HF2bSGJboUBC1VFdHCjXD8i/hXgIfmaljWkhHj/L4+wZfa
        DibekTP0NIF4JKFXLZcTuj1Ef6afJZw=
X-Google-Smtp-Source: APXvYqyyrc2mnfWyPSSmheGAob/i0Q2Ez2G7s3jQZHrFPW54DzYyUXZasfxfUJX7Atk4qAIVzfY6dg==
X-Received: by 2002:a62:8702:: with SMTP id i2mr3063084pfe.187.1568798844639;
        Wed, 18 Sep 2019 02:27:24 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id m2sm8417151pff.154.2019.09.18.02.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 02:27:23 -0700 (PDT)
Date:   Wed, 18 Sep 2019 02:27:21 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190918092721.GA76617@archbookpro.localdomain>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 18, 2019 at 09:02:37AM +0200, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> 
> I was comparing your git-gui repo[1] with the source code of
> git/git-gui[2]. There seems to be a couple of things missing.
> 
> For example, I created a patch back in March 2018[3]. Junio pulled it
> so the changes are really there in git/git-gui/git-gui.sh (see this[4]
> line). This was while there was no git-gui maintainer. I guess the
> change never got merged to git-gui, but directly to git.
> 
> Not sure what you should to about it, I just wanted to let you know.
> 
> [1] https://github.com/prati0100/git-gui
> [2] https://github.com/gitster/git/tree/master/git-gui
> [3] https://public-inbox.org/git/20180302100148.23899-1-birgersp@gmail.com/
> [4] https://github.com/gitster/git/blob/master/git-gui/git-gui.sh#L3885
> 
> 
> Birger

As an exercise in writing throwaway scripts, I created this monstrosity.
If you're interested in merging all of the git-gui branches that came
from mainline back into git-gui's master, perhaps we could do something
like this:

	#!/bin/sh

	branches=
	# note that all instances of "master" refer to git.git's "master"
	# also, 5ab7227 is the latest commit in Pat's git-gui repo
	for c in $(git rev-list --children master 5ab7227 | grep ^5ab7227 | cut -d' ' -f2-)
	do 
		merge_commit=$(git rev-list $c..master --ancestry-path --merges | tail -n1)
		branch_name=$(git show -s --format=%s $merge_commit | sed -e "s/Merge branch '\\([^']*\\)' of .*/\\1/")

		#echo $branch_name: $(git rev-parse $merge_commit^2)
		git branch -f "$branch_name" $merge_commit^2
		branches="$branches $branch_name"
	done
	# this also assumes git-gui's master is checked out
	git merge $branches

This script should resurrect all of the branches that were based on
5ab7227 from mainline's master. Then (assuming you have git-gui's
master checked out), it should do a big octopus merge to bring all of
the changes in.

We end up with the following branches being merged:

	js/msgfmt-on-windows: 492595cfc70f97cd99d4c460db1ba01b73dab932
	tz/fsf-address-update: 63100874c1653dd6a137f74143eda322550eabc7
	jn/reproducible-build: 474642b4a47c74a1f277955d7387d1886546fa01
	ls/no-double-utf8-author-name: 331450f18a7fd298ddd6b85cc5e8ed9dba09f9da
	js/misc-git-gui-stuff: 76756d67061076c046973bff2089ad49f5dc2eb6
	bb/ssh-key-files: 6a47fa0efa342daa53c6386538fda313420351a5
	bp/bind-kp-enter: 146a6f1097f451c6b6d332916a515b7ce8c07e9a
	cb/ttk-style: f50d5055bf9bb2aa35e629d31943334afc4a9f10
	py/call-do-quit-before-exit: 5440eb0ea2651c45a0e46f2335ecbb8d1f42c584

Then perhaps you could do a request-pull and development could continue
on your fork?

Not sure if this is even desirable but here's the script just in case it
ends up useful. I had fun writing it.

Also note that we end up missing two commits that made changes to
git-gui/ under mainline git (not directly to the git-gui repo): 

	* 7560f547e6 (treewide: correct several "up-to-date" to "up to date", 2017-08-23)
	* 00ddc9d13c (Fix build with core.autocrlf=true, 2017-05-09)

Hope any of this is useful to anyone,

Denton
