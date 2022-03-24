Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6338FC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 14:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350769AbiCXOZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346276AbiCXOZT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 10:25:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0CA78FE9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648131822;
        bh=f2l/XYC2duCShGd4PFB/2pVG0a7tkJvdhYd+7KEpGvE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DdLoSjTqqBhxTLOP4HkW+UTnsQ1O1cRHsOpQ79ObiyoWKZUhVNJ9R4myqkBKK5nih
         mKZsnrqPBa2LIKB0oc8AILgKHaVLPnuSdwQX0ae4nymL/a4+OZQnaN0PbRDaGu8Zyt
         WtBPWSR0j3aA72EsibN4fQ8TykEwajxSmCWbs7GQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([213.196.212.0]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1nv7zv3JIU-00m0Wy; Thu, 24
 Mar 2022 15:23:41 +0100
Date:   Thu, 24 Mar 2022 15:23:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jan Christoph Uhde <Jan@UhdeJc.com>
cc:     git@vger.kernel.org
Subject: Re: `git rebase -i --rebase-merges` formatting
In-Reply-To: <9c494301-3c52-c953-95ab-48675634ada7@UhdeJc.com>
Message-ID: <nycvar.QRO.7.76.6.2203241505570.388@tvgsbejvaqbjf.bet>
References: <9c494301-3c52-c953-95ab-48675634ada7@UhdeJc.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HdFyTLGxe/0BNLmNhbSAX3q1CNHDcMn89hROJiZk4nYUT+/tff2
 ZhLqRsIbo0lc1FGinszjJnvxMgV1zvLJY4fdDwBy8PchIZsl78/etPVtZEQjfyfuzAvIe0j
 OmujbBHEuH5NjtKVAprn57lX9CqSOjq9dcTw2NaSiSMcOMNjbX75eJVfbBSqR5Q2LI/ka1X
 sXpdlaSmYm9AW0yu9OYlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N72DF43SvL0=:77y907JvTh8Jc1ciLezgOs
 OLGRlZFaieWDGnZDt5FbwbWZvKNNqVoPsCSO1njcb6y4m+cLlLFhrFwEQMrhFflUGWizVX8GS
 Y5L+xNa7ABXLikIy8AjR8ovzF0tgNTqgaMwBwA7z7cH3ayjCHIUDfAoddRdwGdZcy3ZZ8OeOO
 Hsc1ivq65sPifOqVjsFvrP/z5JZulPX0HGbHkJnoD/4zFfokcLMjWGpvVURt1M/lR/JogP56S
 xhtj7nIPYww/kEoPsNIURj31Dh3cGf1L4MtgnilzLuIXL0HVnU4+r1OAiv5G/KCiybW+Fb4F6
 90qJfvPVOaAclqr60PApo3TvJBTF/xk9BYu9V8v23pjq1UVJeJGSSgdlno+G53z1CIfN89Z0G
 CXPoJuuTWBvWZs8jvF3onRj3R55Qxsbwj1mfOtCh8aw4UKMjVrZbkrpsdIptvaoF61tgDWC9u
 leusXuwbubF7rZg/WwSIIUCbeCjBoWxW68RUzDazSKMly/Tfh71ItXpSuBjwk1YYvsgy/ckUK
 7K6d4Wr9fg6i+QWacIQDOjfuLoXzAHG8n/IhbTdriK32TQCjgKkvcLd5k+wmRJ6VwTaZwXuGZ
 f+7mdxG7wW3SDvBtwlTkLqrtdWEtXcDvGx7FUc5KmxwJmDXUU3KQlrF6D/HO2CRhWFgNQ/Hxf
 DHBBgKkJQwzmOfvGqChqPFrepsY6OYf1R661ZRNvMBNkcVgor2h3cRObmPUWVzTxWLSwAQui4
 02+xPVfzSFmVJRkHX5j/MeY5fQtmGwJueCSrEPcnXM9FQ9yRrLD4Oesx1tJ8CWw60XJD06n4U
 gDggICrVTHoxC3hp0nll2hdgzJU/36RpB4O29ub5f+Dll8mtaiTCLW/3ieEYsjl3TJg4iYn+r
 114hRrgYies4O9wYnk9xcC9MLKJhaX3LK6ZQ4U/DVkGe04+YCtE4ssOk3W3ZXYzDtDqv9HHIp
 UC3q20ljhIy39n75nUuapHls/FLCI+hVJzAycWD6nz6Cc/3kQgERlRkBJ8HHLom37ZFHw0/lI
 5Uwqzq4KK/QjJjG8o3Wnox2/GpZCXLbNGw8n4vZfcGg39nDggM4B4GgzxNNcK2DEjFqyIdNN+
 JEEdBJiSh1CgkI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jan,

On Fri, 11 Mar 2022, Jan Christoph Uhde wrote:

> for the following commits:
>
> ``` git log
> *   4fd94fd  (HEAD -> master) 6 hours ago Jan Christoph Uhde Merge branc=
h
> 'b_two'
> |\
> |* cc75466  6 hours ago Jan Christoph Uhde b_two
> |/
> *   9ad8a2b  6 hours ago Jan Christoph Uhde Merge branch 'b_one'
> |\
> |* b23658f  (b_one) 6 hours ago Jan Christoph Uhde one
> |/
> * a9d65bc  6 hours ago Jan Christoph Uhde initial commit
> ```
>
> I get a this merge script when rebasing onto the initial commit.
>
> ``` actual merge script
>   1 label onto
>   2
>   3 # Branch b-one
>   4 reset onto
>   5 pick b23658f one
>   6 label b-one
>   7
>   8 # Branch b-two
>   9 reset onto
>  10 merge -C 9ad8a2b b-one # Merge branch 'b_one'
>  11 label branch-point
>  12 pick cc75466 b_two
>  13 label b-two
>  14
>  15 reset branch-point # Merge branch 'b_one'
>  16 merge -C 4fd94fd b-two # Merge branch 'b_two'
>  17
>  18 # Rebase a9d65bc..4fd94fd onto a9d65bc (11 commands)
>  19 #
> ```
>
> I think it should be more similar to this:
>
>
> ``` suggested merge script
>   1 label onto
>   2 reset onto #Could imo go but probably avoids special cases
>   3
>   4 # Branch b-one
>   5 pick b23658f one
>   6 label b-one
>   7 reset onto
>   8 merge -C 9ad8a2b b-one # Merge branch 'b_one'
>   9 label branch-point
>  10
>  11 # Branch b-two
>  12 pick cc75466 b_two
>  13 label b-two
>  14 reset branch-point # Merge branch 'b_one'
>  15 merge -C 4fd94fd b-two # Merge branch 'b_two'
>  16 # add `label branch-point-1` here to avoid special cases?!
>  17
>  18 # Rebase a9d65bc..4fd94fd onto a9d65bc (11 commands)
>  19 #
> ```

The idea of the current format is to facilitate moving branches around.
Imagine, for example, that you wanted to change the order of b_one and
b_two, or even base b_two directly on top of b_one instead of the merge
commit, or base it on the same branch-point as b_one.

With the `reset` command being a part of the topic branch's commands, it
is pretty easy: you move the block starting with the comment and ending in
the empty line, adjusting the `reset` command if necessary (or removing
it).

With the format you suggested, it would take substantially more mental
energy to do the same.

This is not a hypothetical use case, by the way. We frequently use it to
clean up Git for Windows' branch thicket, usually when preparing the -rc0
versions.

> Looking at the sequencer.c it might not be worth the invested time
> to change the format. If it can not be resolved easily I think
> removing the empty lines and the branch-comments would suffice
> to reduce the confusion. I think they have been introduced to
> help people but here they are a hindrance.
>
> Another unrelated suggestion is to start with `branch-point-0`
> instead of `onto` and keep counting up. This would make the
> edit-distances smaller when you fiddle with the first commits.

It is often quite useful to see immediately which topics are branched off
from `onto`.

Take for example the `ready-for-upstream` sub-thicket of Git for Windows:
https://github.com/git-for-windows/git/commit/7d77d55f1

This is the part of the quite complex set of Git for Windows patches which
is deemed ready to be contributed to core Git. These contributions usually
come in via PRs on top of Git for Windows' `main` and need to be moved
further down, ideally directly on top of `onto` (which corresponds to the
upstream Git tip commit). That way, they can be contributed as-are.

However, while moving some of those patches down on top of `onto`,
build/test failures occasionally indicate a dependency on another topic.
Obviously, that other topic needs to be upstreamed first.

The mental load of translating `branch-point-0` to mean "this is the new
starting point" might not sound much, but juggling branch thickets is hard
enough as it is, there is no need to make it harder.

Ciao,
Johannes
