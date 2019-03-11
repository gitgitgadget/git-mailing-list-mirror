Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C3720248
	for <e@80x24.org>; Mon, 11 Mar 2019 13:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCKNVa (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 09:21:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:54365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbfCKNTp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:45 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4WRI-1grKpp46G4-00yfXm; Mon, 11
 Mar 2019 14:19:38 +0100
Date:   Mon, 11 Mar 2019 14:19:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org
Subject: Re: Deprecating git diff ..; dealing with other ranges
In-Reply-To: <20190311093751.GA31092@archbookpro.localdomain>
Message-ID: <nycvar.QRO.7.76.6.1903111412280.41@tvgsbejvaqbjf.bet>
References: <20190311093751.GA31092@archbookpro.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6ptgXidaELTzF8OstrcU8BiBDP1qxxaR/+dQqeHwA+2XOQoVwLx
 Y+1behGQ5wPi2vWv9lILmIXaIAJIrqMwYiQZ/WvsltnJfsi1oup+Zz/joyrtmWeIvej0yYm
 GFFo9707F7uibwcnbsVcqugvsv//y3yO0i+Ggq2wHjk9SZtMuoyHGobcQ3+52fzbAUoZSlo
 AilcvMsjbS5oH1Y2iNDmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vqfs1wHq5rg=:rmHhrAwh06DGTTWV5T3jhQ
 sqXToB5Vn8oFaipiIZnrZHxIWqtTQq2EMg9d1YBnn9P0zB2JZfSNDP3gs8urJYok9XXW7faDR
 lwdU+0SdKVIyps4UzNLt+6piBYTyJxuuT+jiCuYCatdR7Fap7qCNrYb7IxIq/RHh2Q1gRj4Mb
 ka2g7toeHzqZwsubA13eF6CRw4CUysCZMskGt2MgBoEBXWbpRz5tljWZRmTv8W9/ODm5FwfKM
 GiBYQjCTRBu2h51DzoIQjPpDcfebH/4qUiQPW6u8DPLgg77hxCHqFGLrcBKlDXJ7TyjNFEajS
 //YJgXwRU8Yl1pmjJYcIACLP3iqMd/7aHQV1QaonxQ1yBCzwv35wjyFiqRtWXbZpxQ/Bue3tm
 vnaMXRQRsZ567PI+9ag3Or7v8sNW0RYXaMFByGbbB9Er1OwVVrxy7v9pDakEHBCfGCyCw6ch4
 2ALWEJkrI8m0cPKm55C8soqqf/IvcBE3pkF33Z/mSmdIFvbN9ytkNbx2I46KUr8r7oTVgLlc9
 X7aiLHV4ykDfix/FFW9dvhmFv/p4EZRIA+Anr7dsrEmiiGMNmVFgRb+aiso+kjSGnmx2l4L93
 O1IR5IOHMm3MmRFlXkeUuacUn9umrSwmTxD4cw75DBxbcQxbqhUEz9Oyq2eJPQaWA50zVlljU
 UAq6HiXyESqPsjeBqYwdFtXXWmZEXKh65/egbdluyawMpctoR73++QBvYzCE9Hc4MUoDhznmI
 BlcrOTPlo8FdL4/nyvljyt+1UNcW0lLbuXoz+BWHHUSoSNZoRhId78Z/a48MAlCnMWQou0mG6
 U7koWrAK3d3RQ9PFlrc0wSFYsvwoZv6sxOlv9xA1FEmFEWhfh9Lr7a9ls+ofo4k1hp4zoliWE
 oCXiywXUtSAj63PhEXk5VcgN7YBD0FtXLoEdd7wr1wX5vRO42CTpEcaTYmc/86YtX/5eL0e4i
 q8b96q2Si5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Mon, 11 Mar 2019, Denton Liu wrote:

> I was in the process of deprecating `git diff <commit>..<commit>` as
> discussed here[1]. However, I ran into a weird case that I'm not sure
> how to deal with.
> 
> In t3430-rebase-merges.sh:382, we have the following test case which
> invokes git diff:
> 
> 	test_expect_success 'with --autosquash and --exec' '
> 		git checkout -b with-exec H &&
> 		echo Booh >B.t &&
> 		test_tick &&
> 		git commit --fixup B B.t &&
> 		write_script show.sh <<-\EOF &&
> 		subject="$(git show -s --format=%s HEAD)"
> =>		content="$(git diff HEAD^! | tail -n 1)"
> 		echo "$subject: $content"
> 		EOF
> 		test_tick &&
> 		git rebase -ir --autosquash --exec ./show.sh A >actual &&
> 		grep "B: +Booh" actual &&
> 		grep "E: +Booh" actual &&
> 		grep "G: +G" actual
> 	'
> 
> It gets caught in my attempt to only deprecate ..'s. Technically, it's
> undocumented behaviour and it only happens to work because git-diff
> accept ranges but it doesn't operate in an intuitive way.

I beg to differ. `git diff <commit>^!` does exactly what I want: it shows
the diff between the commit's first parent and the commit.

And I would not necessarily call this a "range". It is a short-hand. Can't
you allow short-hands in `git diff`, and disallow only ranges that have an
explicit `..` in them? You might need to record that somewhere, but I
think that should be easy enough.

Ciao,
Johannes

> 
> I was just wondering what we should do about this case? Should we
> deprecate all invocations of `git diff <range>` except for the special
> case of `git diff <commit>...<commit>`, or should we _only_ deprecate
> `git diff <commit>..<commit>` and allow all other forms of ranges, even
> though it was undocumented behaviour?
> 
> Thanks,
> 
> Denton
> 
> [1]: https://public-inbox.org/git/xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com/
> 
