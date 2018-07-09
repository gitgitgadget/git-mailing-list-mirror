Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA3221F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932828AbeGIWIU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:08:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:52811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932685AbeGIWIT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:08:19 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlGoc-1gCFzf085m-00b1Dm; Tue, 10
 Jul 2018 00:08:13 +0200
Date:   Tue, 10 Jul 2018 00:08:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment:
 a function to solve least-cost assignment problems
In-Reply-To: <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YO4yqPSGQUiU+NqPIIrW7kJj+wiyvC6eUc313plHHLdH3sxgLyv
 3x7iTn+WuhuDrhp8x41B98bZ1kSuKrYVO0YyX//u3THHrG5fBiStc7Dl3zhYcfmExJPUWnJ
 6LkmT8f2f032Xkcv1L7U4qV6ARCTuYEWpguz/ypaf+c7shLxUW44kzved09q/dpxo7Qa86A
 IrqzELYPUOyy2azz5OvVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GkSu4DYirZU=:JR7uyY/ZgOeE5ykLip+FDG
 qUcFOMT63M+bu9BYbP+F6U46EUq5MS/TL/1deW308Z3gycYatbuAzzsOlNS8nv+ejwI2ggka6
 X8tQJaTKOl455sPd4RFdnF7BCjMGHaleWEr1T6G3LSTtC3lTr8nkp2KdPRMNXS9wwTZx+LFln
 pYOKepVu9MvIK8LAXGxGtNImN4GkQVQ+YoHGuv71NS6kQFm1HKVjzjj2VWd8Jf6mWv6XdiusZ
 tm3uUlVYpVydpwHIXCo4fFOGvAhOladvh+4CJRAIuzRuXtRAdVCVL3Yd0rPgYGnmsSJa32e/S
 8SVjq5/gVxsEvnI8SutfNG5ulV1t1UkBD7dWu0Ezj8uYiJO/tz52UFtBcU2Ig6FesznzKgm14
 Bl8NYeRim5F2AKtdA0jhVfwVXDpQQkvzUwBeCkQi9g2N1Y2oMToiON8m/Sq5h9Z+q/mR56Ex5
 z/fiVEmQUjpZOYtysHbZRlepW0PjxpHipSWN7fa6SEhWoYy3cud3QGwGqMs+BCI3s4cEWAzbz
 UOKudwuRmdZVzqdzKhE8FreKStuhTM6bhw6EkYZQkrxLMZk9/2+rh+hecgAsIbmGxvVdIC7IO
 IHmd3W9ixCrIZL2rZcwmt1tIrpxlJo1EEoJTACbQPJ5zj2CiRYrF0mRVrlv0nlmgRJUMJKeGt
 9ExkBduJH4GEone8/efKR1IaQSeQQccxwe8G8ead1+4ezqaCSOa65lJzepZ7s9Xnwi8WMk0St
 eash836OcMU1JXUzsObMRXVjfQpnU2bMVsx2t0+6bLwywLLoyS0TPmSLtGn75S9ytFPxRs/3a
 aXm7BXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 8 Jul 2018, Johannes Schindelin wrote:

> I just encoutered a problem with your `refs/notes/amlog` and I hope you
> can help me with that.
> 
> Concretely, I want GitGitGadget to be able to identify the commit that
> corresponds to a given mail that contained a patch (if it ever made it
> into `pu`), to automate all kinds of tedious things that I currently have
> to perform manually.
> 
> And here I hit a block: I am looking for the commit corresponding to
> aca087479b35cbcbd7c84c7ca3bcf556133d0548.1530274571.git.gitgitgadget@gmail.com
> 
> When I ask `git notes --ref=refs/notes/gitster-amlog show
> 4cec3986f017d84c8d6a2c4233d2eba4a3ffa60d` (the SHA-1 is the one
> corresponding to `Message-Id: <...>` for that mail), it insists on
> outputting
> 
> 	5902152ab02291af4454f24a8ccaf2adddefc306
> 
> However, I cannot find that commit anywhere.
> 
> When I look for the commit in the same manual, tedious way that I want to
> automate, I find that it *is* in `pu`, but as
> 
> 	5cf8e064747be2026bb23be37f84f2f0b2a31781
> 
> Even curiouser: when I now ask for the commit notes for both of those
> SHA-1s, I get back the correct, same Message-Id *for both of them*, which
> makes me think that it was recorded correctly, but then overwritten due to
> some process I don't understand.
> 
> Would you be able to shed light into this?

I think I reconstructed the culprit:

In https://github.com/git/git/commit/a7cddab6e8, your post-applypatch hook
added the note for commit 5902152ab02291af4454f24a8ccaf2adddefc306 that it
was generated from Message-Id:
<aca087479b35cbcbd7c84c7ca3bcf556133d0548.1530274571.git.gitgitgadget@gmail.com>,
and then https://github.com/git/git/commit/ff28c8f9283 added the note to
map that Message-Id back to that commit.

So far, so good!

But then, https://github.com/git/git/commit/81b08c718e9 indicates that you
ran an interactive rebase and amended the commit
5902152ab02291af4454f24a8ccaf2adddefc306 and the result was a new commit
5cf8e064747be2026bb23be37f84f2f0b2a31781 that was then also mapped to that
Message-Id.

And obviously, you lack a post-rewrite hook a la

```sh
refopt=--ref=refs/notes/amlog
while read old new rest
do
	mid="$(git notes $refopt show $old 2>/dev/null)" &&
	git notes $refopt set -m "$mid" $new
done
```

I was pretty happy to figure that out all on my own, and already on my way
to come up with that post-rewrite hook and a script to parse all of the
commits in refs/notes/amlog whose commit message contains `commit --amend`
to fix those problems, but before starting, I wanted to sanity check the
oldest such commit: https://github.com/git/git/commit/49bc3858e3c

You will be readily able to verify that it maps the commit
73bfebd43e14bcc1502577c0933b6a16ad540b99 to Message-Id:
<20170619175605.27864-3-phillip.wood@talktalk.net>, but that 7c1a3dcf23e
(which corresponds to that Message-Id) maps to
f64760904766db662badf1256923532b9e1a6ebd. So yes, there is the same
problem with this mapping, and we need to fix it.

*However*. Neither https://github.com/git/git/commit/73bfebd43e1 nor
https://github.com/git/git/commit/f6476090476 show any commit!

Does that mean that the patch with that Message-Id never made it into
`master` and was simply dropped and gc'ed at some stage?

Actually, no:
https://public-inbox.org/git/20170619175605.27864-3-phillip.wood@talktalk.net/
corresponds quite clearly to
https://github.com/git/git/commit/1ceb9dfab7e

Now, that commit message was clearly edited by you (I note the capital "A"
in Phillip's "Add" vs your lower-case "a" in "add"), but the patch
quite obviously made it into our code based in its original shape.

So I looked for the commit notes for that commit, but there aren't any!

To summarize, there are two commits recorded for that Message-Id, the
later one not mapped back, and neither is the correct commit that made it
into `master`.

It would be nice to figure out what went wrong there, and how to fix it
for the future (and also to fix up the existing mis-mappings in `amlog`).

However, at this stage I really have not enough information at my hands,
even with as much effort as I spent so far to figure out where my patch
went (which started this bug hunt). Could you kindly spend some time on
that? Otherwise, `amlog` is a lot less useful than it could otherwise be.

Thanks,
Dscho

P.S.: funny side note: it would appear that the rewritten notes all get
the author of the patch author, look e.g. at the author of
https://github.com/git/git/commit/81b08c718e97
