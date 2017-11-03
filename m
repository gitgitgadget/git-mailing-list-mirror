Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8F120450
	for <e@80x24.org>; Fri,  3 Nov 2017 16:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755690AbdKCQVH (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 12:21:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:51452 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755282AbdKCQVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 12:21:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9s8K-1dzhPs154a-00B71G; Fri, 03
 Nov 2017 17:21:04 +0100
Date:   Fri, 3 Nov 2017 17:20:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Orgad Shaneh <orgads@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: Regression[2.14.3->2.15]: Interactive rebase fails if submodule
 is modified
In-Reply-To: <alpine.DEB.2.21.1.1711031658190.6482@virtualbox>
Message-ID: <alpine.DEB.2.21.1.1711031711530.6482@virtualbox>
References: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com> <alpine.DEB.2.21.1.1711031658190.6482@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PAOqbZXQTToK+uy0ElXe1qzWQ7/jIhlMyrovuI+pY254zOAmHbT
 LvpvM7B+g0axOdpngAj44Wn8C8gQXLKERFM+TKSu0pPzlR7FEqQ7312U21UNBebhjkPRm/J
 rcI6muy+Wxl6tGX1rdtDifdJLD5T8g8rYhVFLf1EfmO2I1SCQVKLGR6dS4EahHUbmIv9exS
 bPneZBk7K2lP9VtNgti/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q5C6s6zpyVU=:4lJFN3P8de4aPzPZswL4Ow
 Mp9+8wsD/bkfPPzKmGyIsd+WvoS5Iw/YPtrCtDQHTEk33yqmIO1Pc9u4M7dAt9BPZWSQoo+4E
 cZUdUVcBX4exibD3f6KERwOvZ/ywDeAgfQ+oPVFfH3nZbd7aXd0FFC6t9gK6LpEyEnfdhTRL8
 fUUoOT9iKPKZJOP0xyDjfwTQR3IDCvOqZZo/9odFNjgXsmGHbryhnuEwbv02GFvrwSwWGzF1Y
 KZg2LFvmsQaFDYuIi51E3mu/SWKo3/U64sC6Cvx1XBbWIZqWMbAx73TYgpA8qpbpIR71TjK58
 VMme67QioOPfiTbXIxtc49dsD96YaH387IJQTh/E7KPWyPVKSbPTsjRASI8dt1Elk+NOxy7uP
 qwsyvi3nEjJDX1t1d/CVfVhBYYnKLHQzJ/M/48SG75kWf+KQKrwNKHOdYkt+KJ6BNWdFeqtOz
 u6Afn+lbu2y8h/fhEZV8petx6r0yzfzWqSWWoW7iPKOchh6j2Z8RyzEEZz8V25ug5xczsofPM
 R16pdJVT5+m8aV4J5Mg9OwWCBOZy25feyxU7GNt0YYJj8dRg4ijtiNg+b9ZTAbF6+GEzTQ5lt
 x6/DEBrPONbosnm3egvnh8rZarSUxt9YJeBz4n36boMmqpuzZgnu3caSS1K7LqrG2873eKUYe
 kr6VHVDrTyo+MFmTL10zhrq7F+xACJUVQvhBCrCPmcFui14I3mfDjosSFW9OHDQgNnw/JciZa
 DkW9vXTosDCfNcEeioEdOgtW0r37/zBWS0+t3e5pzN0OfyvHPHLcShYKG1Y1UKGqh9jT9U8kk
 XegpkvJ/gfbBn5S3IzjAi0yIXL1ng0PlLK8mSHfn1I4lIkMtM0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Fri, 3 Nov 2017, Johannes Schindelin wrote:

> On Thu, 2 Nov 2017, Orgad Shaneh wrote:
> 
> > I can't reproduce this with a minimal example, but it happens in my project.

Whoa, I somehow overlooked the "can't". Sorry.

> > What I tried to do for reproducing is:
> > rm -rf super sub
> > mkdir sub; cd sub; git init
> > git commit --allow-empty -m 'Initial commit'
> > mkdir ../super; cd ../super
> > git init
> > git submodule add ../sub
> > touch foo; git add foo sub
> > git commit -m 'Initial commit'
> > touch a; git add a; git commit -m 'a'
> > touch b; git add b; git commit -m 'b'
> > cd sub; git commit --allow-empty -m 'New commit'; cd ..
> > git rebase -i HEAD^^
> > 
> > Then drop a.
> > 
> > In my project I get:
> > error: cannot rebase: You have unstaged changes.
> > 
> > This works fine with 2.14.3.
> 
> I tried to turn this into a regression test, but I cannot make it fail:
> 
> -- snip --
> diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
> index ebf4f5e4b2c..55aebe53191 100755
> --- a/t/t3426-rebase-submodule.sh
> +++ b/t/t3426-rebase-submodule.sh
> @@ -20,7 +20,7 @@ git_rebase () {
>  	git rebase "$1"
>  }
>  
> -test_submodule_switch "git_rebase"
> +#test_submodule_switch "git_rebase"
>  
>  git_rebase_interactive () {
>  	git status -su >expect &&
> @@ -38,6 +38,27 @@ git_rebase_interactive () {
>  	git rebase -i "$1"
>  }
>  
> -test_submodule_switch "git_rebase_interactive"
> +#test_submodule_switch "git_rebase_interactive"
> +
> +test_expect_success '123' '
> +	git init sub &&
> +	test_commit -C sub init-submodule &&
> +	git init super &&
> +	git -C super submodule add ../sub &&
> +	(
> +		cd super &&
> +		test_tick &&
> +		touch foo &&
> +		git add sub foo &&
> +		git commit -m initial &&
> +		test_commit a &&
> +		test_commit b &&
> +		test_commit -C sub new &&
> +		set_fake_editor &&
> +		FAKE_LINES=2 &&
> +		export FAKE_LINES &&

I inserted a `git diff-files` here, and it printed exactly what I
expected:

++ git diff-files
:160000 160000 62cab94c8d8cf047bbb60c12def559339300efa4 0000000000000000000000000000000000000000 M      sub

> +		git rebase -i HEAD^^
> +	)
> +'

There must be something else going wrong that we did not replicate here.
Maybe the `error: cannot rebase: You have unstaged changes.` message was
caused not by a change in the submodule? Could you run `git diff-files`
before the rebase?

This does *not* refresh the index, but maybe that is what is going wrong;
you could call `git update-index --refresh` before the rebase and see
whether that works around the issue?

Ciao,
Dscho
