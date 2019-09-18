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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E38B1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 16:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfIRQ4K (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 12:56:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45985 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfIRQ4K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 12:56:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so340920pfb.12
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VJw9UbFp93JEWwkNOmVnHbgkLTcuusnqfiwmmII7xw8=;
        b=BxkavUCLo/TJoCtbUzXr5yrgkTVen0iyTmfNcpuJNurHMVhra6GZ9MuCYg4fygBcHt
         hBu3WCpjfn1cAZo6PdZVAmiKwrp+dwzbkVd/iuO/AkX+5MjxY+PESSW5MzpOLULwHC6B
         pW7aluCm5L5IoZFuJnjkKHhVYghQVhd1z6+HwmeD1AZKVQD7be1qX28/aT6R8DwQSqrb
         Ec/Rd1CiS6YGkPvbtIlOWEl2EZAwKqRjrSRj1mDBScTGZAZ9a4DjvGwYbH2WO8mO/ze6
         kBbRLMZBkCol2eR3cmSPe31K6QJzPwOZbDBlGorisRrXGU+L2Hh62cLLjTS5oS9zj+KO
         0u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJw9UbFp93JEWwkNOmVnHbgkLTcuusnqfiwmmII7xw8=;
        b=B9qt8pEQ3pm9u/rQF4HqyhaUWAN34+eOnO7kFOz5WOvNnuid5SW0AeTJ5Sx4woFKfn
         UF8oEXxdhcFRGY68UQR5lWmjUdoY3iTxhjdif5bNZywFc5VKOSDJKCR4UbJAI4hcQ5Hm
         XEBXOIXATOEZrDzwkCh3niTvFG034/jb2oXQFJDWLHHXBxy52sYWEdp7/h0U9BCe2dct
         3d6x5u4HzPfe9taV76BHcHhbxeksSECQ+cDQxww7x0Bnz6AwUKClQqNxXBLMDKUGaVNH
         wqxCjWFi2Go425rAry7+YnEoDKKf7OdiYrzCyazTR+7M9h/HU+PbtM3LD1DwcFSZAOy9
         O3Qw==
X-Gm-Message-State: APjAAAVcI3qKAg8nSKp/QjxRwPXoS2JzWnsDFB65GvzQdN3L/Ny8TxVQ
        2DNt8+YF5iwqvyngIOXYv70=
X-Google-Smtp-Source: APXvYqz9oeDWmMfiU7JkZLB5c3gMcbv1TEoD4XgdnOQ0EJtK0ACkR+sOxVpEgp4pOv+dVCnXiKYJww==
X-Received: by 2002:a63:c09:: with SMTP id b9mr4751732pgl.245.1568825769292;
        Wed, 18 Sep 2019 09:56:09 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id a8sm9648804pfo.118.2019.09.18.09.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:56:08 -0700 (PDT)
Date:   Wed, 18 Sep 2019 09:56:06 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190918165606.GA1133@dentonliu-ltm.internal.salesforce.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
 <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 18, 2019 at 08:44:04PM +0530, Pratyush Yadav wrote:
> On 18/09/19 02:27AM, Denton Liu wrote:
> > On Wed, Sep 18, 2019 at 09:02:37AM +0200, Birger Skogeng Pedersen wrote:
> > > Hi Pratyush,
> > > 
> > > 
> > > I was comparing your git-gui repo[1] with the source code of
> > > git/git-gui[2]. There seems to be a couple of things missing.
> > > 
> > > For example, I created a patch back in March 2018[3]. Junio pulled it
> > > so the changes are really there in git/git-gui/git-gui.sh (see this[4]
> > > line). This was while there was no git-gui maintainer. I guess the
> > > change never got merged to git-gui, but directly to git.
> > > 
> > > Not sure what you should to about it, I just wanted to let you know.
> 
> This is something I've been aware of, but I have followed the strategy 
> of ignoring the problem till someone complains. Well, that someone has 
> now complained.
> 
> I'm not particularly comfortable with cross-tree/sub-tree merges, so 
> I've been dreading doing this for a while. Guess now its time to get my 
> hands dirty.
> 
> > > 
> > > [1] https://github.com/prati0100/git-gui
> > > [2] https://github.com/gitster/git/tree/master/git-gui
> > > [3] https://public-inbox.org/git/20180302100148.23899-1-birgersp@gmail.com/
> > > [4] https://github.com/gitster/git/blob/master/git-gui/git-gui.sh#L3885
> > > 
> > > 
> > > Birger
> > 
> > As an exercise in writing throwaway scripts, I created this monstrosity.
> > If you're interested in merging all of the git-gui branches that came
> > from mainline back into git-gui's master, perhaps we could do something
> > like this:
> 
> Ah! Thanks a lot for this. This reduces some of the work I've been 
> dreading.
> 
> > 
> > 	#!/bin/sh
> > 
> > 	branches=
> > 	# note that all instances of "master" refer to git.git's "master"
> > 	# also, 5ab7227 is the latest commit in Pat's git-gui repo
> > 	for c in $(git rev-list --children master 5ab7227 | grep ^5ab7227 | cut -d' ' -f2-)
> > 	do 
> > 		merge_commit=$(git rev-list $c..master --ancestry-path --merges | tail -n1)
> > 		branch_name=$(git show -s --format=%s $merge_commit | sed -e "s/Merge branch '\\([^']*\\)' of .*/\\1/")
> > 
> > 		#echo $branch_name: $(git rev-parse $merge_commit^2)
> > 		git branch -f "$branch_name" $merge_commit^2
> > 		branches="$branches $branch_name"
> > 	done
> > 	# this also assumes git-gui's master is checked out
> > 	git merge $branches
> 
> Assuming I have git.git cloned in ../git (relative to git-gui.git), I 
> ran:
> 
>   git pull -Xsubtree=git-gui ../git $branches
> 
> instead of:
> 
>   git merge $branches
> 
> because git-gui's tree doesn't have those commits and branches yet, so 
> we can't merge straight away. This seems to have worked, but I thought 
> I'd mention it in case it would cause some subtle problems.

Did you run the big for loop in git.git to create the branches and then
the `git pull` in git-gui? That should work.

> 
> > This script should resurrect all of the branches that were based on
> > 5ab7227 from mainline's master. Then (assuming you have git-gui's
> > master checked out), it should do a big octopus merge to bring all of
> > the changes in.
> > 
> > We end up with the following branches being merged:
> > 
> > 	js/msgfmt-on-windows: 492595cfc70f97cd99d4c460db1ba01b73dab932
> 
> This branch is already in git-gui (with the exception of one commit. 
> More on that below).
> 
> > 	tz/fsf-address-update: 63100874c1653dd6a137f74143eda322550eabc7
> > 	jn/reproducible-build: 474642b4a47c74a1f277955d7387d1886546fa01
> > 	ls/no-double-utf8-author-name: 331450f18a7fd298ddd6b85cc5e8ed9dba09f9da
> > 	js/misc-git-gui-stuff: 76756d67061076c046973bff2089ad49f5dc2eb6
> > 	bb/ssh-key-files: 6a47fa0efa342daa53c6386538fda313420351a5
> > 	bp/bind-kp-enter: 146a6f1097f451c6b6d332916a515b7ce8c07e9a
> > 	cb/ttk-style: f50d5055bf9bb2aa35e629d31943334afc4a9f10
> > 	py/call-do-quit-before-exit: 5440eb0ea2651c45a0e46f2335ecbb8d1f42c584
> > 
> > Then perhaps you could do a request-pull and development could continue
> > on your fork?
> > 
> > Not sure if this is even desirable but here's the script just in case it
> > ends up useful. I had fun writing it.
> 
> Just to pick your brain: in what case would this not be desirable?

I'm not 100% about the accuracy of the script. In particular,

	merge_commit=$(git rev-list $c..master --ancestry-path --merges | tail -n1)

is super hacky and makes a lot of assumptions. It'd probably be best if
someone else also takes a look.

>  
> > Also note that we end up missing two commits that made changes to
> > git-gui/ under mainline git (not directly to the git-gui repo): 
> > 
> > 	* 7560f547e6 (treewide: correct several "up-to-date" to "up to date", 2017-08-23)
> > 	* 00ddc9d13c (Fix build with core.autocrlf=true, 2017-05-09)
> 
> One more commit that is missing: 492595cfc7 (git-gui (MinGW): make use of MSys2's msgfmt, 2017-07-25)
> 
> This commit is comes from the merge of js/msgfmt-on-windows, which has 
> all the commits from the merge 5ab7227 (Merge remote-tracking branch 'philoakley/dup-gui', 2017-03-18)
> in git-gui.
> 
> While merging js/msgfmt-on-windows should get this commit into git-gui, 
> I'd rather have it separate,

Any reason why you'd want to keep it separate?

I'm assuming you're referring to the commit that merges
js/msgfmt-on-windows in:

	commit 90dbf226ba3fae0d932ae4e42d8d3122a47766bc
	Merge: 5800c63717 492595cfc7
	Author: Junio C Hamano <gitster@pobox.com>
	Date:   Jul 25 2017

		Merge branch 'js/msgfmt-on-windows' of ../git-gui into js/git-gui-msgfmt-on-windows
		
		* 'js/msgfmt-on-windows' of ../git-gui:
		  git-gui (MinGW): make use of MSys2's msgfmt
		  git gui: allow for a long recentrepo list
		  git gui: de-dup selected repo from recentrepo history
		  git gui: cope with duplicates in _get_recentrepo
		  git-gui: remove duplicate entries from .gitconfig's gui.recentrepo

Since js/msgfmt-on-windows is based on 5ab7227 (Merge remote-tracking
branch 'philoakley/dup-gui', 2017-03-18), when it was merged into
git.git's master, the merge brought in those other four commits by
Philip Oakley since they weren't merged into git.git yet.

However, you're not going to be merging in the same list of commits if
you merge into git-gui. You'll only end up merging in one commit: the
missing 492595cfc7 (git-gui (MinGW): make use of MSys2's msgfmt,
2017-07-25). This is because Philip's commits are already in the git-gui
repo.

> 
> > 
> > Hope any of this is useful to anyone,
> 
> It is very useful. Thanks :)

Glad I could help!

> 
> -- 
> Regards,
> Pratyush Yadav
