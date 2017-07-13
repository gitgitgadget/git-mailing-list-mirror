Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3CCB202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 12:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdGMMoY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 08:44:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:50689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdGMMoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 08:44:23 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lm6IP-1e4hB50yy9-00Zfos; Thu, 13
 Jul 2017 14:44:10 +0200
Date:   Thu, 13 Jul 2017 14:44:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
In-Reply-To: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ciJ/OzfQYAn3Z8GxJysVWOQOwl6MDrKAeXnzp9f8RWY63qzV2kb
 FxNxtZmb28QEE1pcVKjv6Ni2tit7AISjSGYmGT/kc8MorzTtIDBz0Sh+JVeF6615RT3znZY
 IFNUn10+CcTtnYly8KQuTBAUTaS1ucycSUUlRXuj07EHl8dLydKcWfPzF6Jm6pxGAyFWVKE
 uNk/yWm8FzqoUlDW3jJFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6fOVOrzVE6o=:a+2irAPYf24UiZrvTxeTUQ
 tLZgDzNaUbV7Rufw0IB9rOaXCW7z+hfv1sFSVK0nwpuUxb2uu6MVUy9biJDCPIN3BvSvQKYYU
 lzsYlYdxJAza0d4kvtGpnkAUsFeUy902XrdIGZa40ffhcr2MD8lhdqm98lE3KjUkGD5dWIc80
 alD9ztp/YuFLqXu01vegHDEzJ0rOSwYCFv3tQqGfgmz4Iwqzal2Ej45QbEziIYuffWgJ8V1Ji
 QEiyO0wXzozARLk0mqhVGjPx55kT+oNqaqYpW3D1FzpfL/TgR8FYVoSKqRcVoLPjzGoCHcOw+
 wwofkfVirDTZ+cVj8fUfGIEf+t7qgrND+wUgxEWFj6nakALUEJ1fMdZNBgU2rjzjrCCZ4lVKQ
 JilbNytYw7wpPEV7n60Ifl9swPaTpLwZ0MdqoJPRt4Y3rrp8UYvWI83gQvOqYFFXr4CaqpXY1
 JiO4tsqfbAF41yaYBJtLscUUHe8ia+Ixb9r4/JnjKUBx7UDVq9Ajb2Ye0BKq0sC/onLU1AniQ
 94DtG7hE5CIxj5wsNHAvGqpcyIgGnbPSGhsk0+XDJ52J9WLbCZF/NqdLMKPU1wo+TNLTzOwvc
 QkuoCd/Lx0pZfB31HkJE2t1/N9vHiLQcXHe2azlA/MqusUcW4qmA/j3CnuMo51k8JLVVcWsGs
 3obng2nkjGet9YSv0Ln0jKVzyV9tlN2WR7h4xe4GWWVVF2t3v/V2CkWir9Pjii7GmYOcuIgB2
 XxoZRdpLfGb0AG4YmjAd8POkjuO59HIn0e44+m62ZH8MAHpWglGH81SycxSV1d9Edo8Mx3f1R
 4t2b0B9Vz+qp/h7EgvLgec7+RlW9KSOXrozexPQuQHV+vmplO0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Jul 2017, Junio C Hamano wrote:

> * jc/allow-lazy-cas (2017-07-06) 1 commit
>  - push: disable lazy --force-with-lease by default
> 
>  Because "git push --force-with-lease[=<ref>]" that relies on the
>  stability of remote-tracking branches is unsafe when something
>  fetches into the repository behind user's back, it is now disabled
>  by default.  A new configuration variable can be used to enable it
>  by users who know what they are doing.  This would pave the way to
>  possibly turn `--force` into `--force-with-lease`.
> 
>  Will wait for feedback, then merge to and cook in 'next'.

I wonder whether the --force-with-lease option would benefit (and counter
the "unsafe because of behind-the-back operations" argument) from doing
some kind of "reverse pull --rebase".

In other words, --force-with-lease could verify that the upstream branch
has no commits that weren't seen in the current branch's reflog, i.e. that
`git rev-parse HEAD@{upstream}` is identical to `git merge-base
--fork-point HEAD HEAD@{upstream}`.

The assumption would be that you typically want to push with a lease only
when following the `pull --rebase` workflow. Meaning that you would only
want to force-push when your local branch had the upstream branch
integrated at some stage [*1*].

I could imagine, though, that this should be an opt-in option for now, and
could be turned into an opt-out option later. Or maybe just make it
opt-out, adding a kick-ass error message explaining the situation properly
(and how to override the safe-guard from the command-line).

Ciao,
Dscho

Footnote *1*: Of course, if you merge upstream, do some stuff and then
reset --hard to the previous state, this safeguard will not catch. It
would *still* catch when aborting a rebase onto upstream, though.
