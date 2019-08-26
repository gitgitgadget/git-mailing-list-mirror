Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413DD1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfHZOTV (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:19:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:46357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbfHZOTV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566829158;
        bh=uOfw06mu2gRvxXy2D0PfZXYP9Suf7R7oYT7HvZFnmRw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MD7RVK9/gRA7TQZNRs5WBZ9qGFmEJbgGXWKSRTw/Zdt77EM0a1ywpwc7he61lUBFo
         Uc9qg13AYP652KoiMVbYQT5ylmzs+s4yMhTS0akXHs+wuXMu3ZVArrzanJXy9nMn/d
         ePs9OgV56ukgh1KHTQI8FMGX8z6k6kisLri/DZmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlYrb-1ibar32iON-00bN30; Mon, 26
 Aug 2019 16:19:18 +0200
Date:   Mon, 26 Aug 2019 16:19:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Dakota Hawkins <dakota@dakotahawkins.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] Add config option corresponding to --rebase-merges
In-Reply-To: <CAHnyXxScGO6Eex_AEbgH=YFQ2yzY1hnXavyNMkiXbrccVUA=Ug@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908261615440.46@tvgsbejvaqbjf.bet>
References: <CAHnyXxScGO6Eex_AEbgH=YFQ2yzY1hnXavyNMkiXbrccVUA=Ug@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7nC/k5dOA6LJOuZsDj0avutEQa1eYt77/K092eaC+dICANHB0Eh
 zvzHvUfRbDfwsqBHZzzuomdp3ubZatEVo8H+3Q+3Tz2AlfbbijmCnuwOn9fZDntV8b7ast1
 agosY3hdkHB+ym+bwRT0xbGnRIfN1Zs0czdDkHnwFYd568Ktq1Bykzd1C222AUHx2sT7Jc+
 jhdG7G99slOYBjRyUFlxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bfGdbTZxYfw=:yz7ukoNj0ADxA6OLKZaIed
 yTATIz1AY2N7cZQUg7arfM+SPyDJHzJFl/lQKbLXpBIRTM5Khg7fgMn3T9k1wdSMvCVsrGVDb
 os9ijQRM42ikgLRcnl8VmKXEegAzMJv8keWRy1uhEwJ5tz9VuUQ9KlHWc2a1ZifT1acnYLcDy
 4EUMp0ibfQXYGIGZEx3RXTX/F6t+mWl+ZbasGTyAl2Utr20fwoDpKPDLEppG4r3D6w9TILjiH
 n6BJoccD2rUier0rnyJnHvycMvSUW0nhYl5q2XhNOJlE9v/ELfaisl5dzb3CBnbWyCqhAElvw
 oqiKZnHKdd0TvBpGTGKOg7GQ3/7YHRZcnDcdtsyRyOyVw4ngTPNEQc2J79YV5IcuRh53ckmam
 V2hzH+RGX78xBz1GAMWuemkCKYWhtIR4ub+vY5mlnjMhDDa2jm/pQMXqAJUHPa7HnIBJNz6Bt
 waU+DNeMxzS/yz3d+ptd5gUKFXvJ7AgQrMzq9KPGyJESw5F70XVjJLTU0kS7m9PYicXEEPfEG
 RfGfksEpYp/g1nsowrctGSY7QDCqXX+k17yKC/NKwSGJnwgoPSHvxuA1M4yM7z2ghr/j0JYAR
 eckrdhVXp7nNk2ZbAbrjbFP/yMmFEdYy13ym+HvXzVgVw6dK1i8BrEsHTXZX0RLqChg5vkcgQ
 2ziGb6277b7sPePqi9Ms7Ye1YLsD4EnFknrnWhbvNG7z1SPsDukZpq0tqgMMH/V1k/+ArkYQ2
 ECwxD1YIcagRu8e2LTi/V31za4ugEihGWBgXxAo+o0lQ8qhPCZi6A5L//Nh8pSfLo1oTdBh/a
 4c6XxQ4fNYS6L97AP1RuG3GTA5Bdaqb+N0tj6wbweJe0DrZHq+lI85I7zgmIdkDe86aPnDeBt
 E7cUYugsHZRFf7obx9wIGyx9Amx97KCxIp8eIOE0vF0P6fSRct/dcCR2FnFW1qJWhc2TF/UW2
 AZ39WwEaWuuK2myU5oFUrUxqV6t1y+OqNhZr24+eEpxknEXWQMjN8SNha7iFlYMZGoaFM+k/P
 49eTWiHiljU99IyWP4yQTQ2RsNMpgsOJIlEEOdOjEMs2EGqb9Hc2V31LjyumtwqKmZsrHI8Be
 x0ezezQVSE6VAHZBGGINhP7Tn7mjSYHStSMSMUaRnWzStkmyDkr1ReVpGA7czpg1zrqWBGpWz
 WZT+c=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dakota,

On Fri, 23 Aug 2019, Dakota Hawkins wrote:

> I'd like to work on a patch to add config options that correspond to
> rebase's --rebase-merges flag.
>
> In my workflow, while it's uncommon to encounter merge commits during
> a rebase operation, when they are encountered I pretty much always
> want this behavior. Since it's rare, I pretty much always forget to
> ask for it, with interesting and confusing consequences.
>
> If nobody has any opposition to the concept, the following are the
> specific options and values that I think makes sense and covers the
> existing functionality.

I am in favor of this, as indicated at
https://github.com/gitgitgadget/git/issues/318

> # New rebase.merges config that takes effect if set to true or cousins
> + rebase.merges=3D
> +   true
> +   cousins
>
> # New cousins value for pull.rebase
> pull.rebase=3D
> +   cousins
>
> # New pull.rebaseMerges config that takes effect if set to true or
> # cousins. Intended to allow pull.rebase to be set to interactive.
> + pull.rebaseMerges=3D
> +   true
> +   cousins
>
> # Corresponding additions for branch.<name> config
> branch.<name>.rebase=3D
> +   cousins
> branch.<name>.rebaseMerges=3D
> +   true
> +   cousins
>
> I'd like to get feedback on the idea and specific options proposed,
> if only to avoid having to tweak them once they've been added.

I am not quite sure about the "cousins" thing. If at all, I would make
that a global option, I think. But then, maybe you have a use case in
mind where it would make sense to rebase cousins in some, but not in
other cases, cases that can be discerned via branch names?

Ciao,
Johannes
