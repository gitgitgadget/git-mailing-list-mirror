Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E024207B3
	for <e@80x24.org>; Fri,  5 May 2017 14:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbdEEOby (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 10:31:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:53464 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbdEEObx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 10:31:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbPza-1dmszA2iCY-00kx20; Fri, 05
 May 2017 16:31:46 +0200
Date:   Fri, 5 May 2017 16:31:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Start of a journey: drop
 NO_THE_INDEX_COMPATIBILITY_MACROS
In-Reply-To: <CAGZ79kZiBOrY6Qno_wFpvFHpbpCY0BtriqYGW5JKG+1hfgJwiQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705051244310.146734@virtualbox>
References: <20170501190719.10669-1-sbeller@google.com> <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com> <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com> <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZiBOrY6Qno_wFpvFHpbpCY0BtriqYGW5JKG+1hfgJwiQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0RcpwX+uxqXMaErofOxr66BZrpRXMmDfKc09n19tcdXgsFpYJQR
 fkE9VTMIlsVL5pNoLfUBLt8VsA9276nQKtinlFtofNs71M5xXOjvgTg2hsSgpFuTY96Hz95
 iLypKDhNL8PsV/sJd5Amx5Bp1XP/k3XiD1YwurWFZkj205t+6EkjxOHVKI/UYdO80JMreoO
 b9ZSNThRLgEViaOM2QqCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0iN7N9wvFC4=:2bnBghVbB4zWcvTb90NGro
 KtkMlGFXkiCWNzy1gvXwQoaj1bCGSB+cdAlpw6tjEfuiCxbBr6j+DrsbPveyaSoY5XumaIMV2
 ttV/xxy0L+jr57iPWMJm1C+sFSbQ14hBnJjcOSOnZHFX7liLE7Kc7MqghnK6RNZ0sXDCLo9Xi
 iwSzW8HKQDFUEUjOXVkXV/eRPfhYBpvHbcDSsr65mv5odptY3/eD8eU1wYVL6PdFP0bOLSN4e
 wXuNqX5su3/a/tVdW6ZK4hwTVym6JaaTnWENz1DYv6TSMyzBwfHaQZuSDzNFiYnsW7DxggcOu
 mCpOzHkfJbojgXSJj9zNpYS3fAKDmC+8HgoMBLOoBUUK0SNTs0N52wEFxrzm+pqGLvn//9//E
 yVEiXS47tFj5tnsep5TmrO5n2jt7qfwkLgcMcPpO+0LjWD1GjokhtNNq84VMGNcbDeRKPcDZy
 NhWjrfxdCgsOVFcIPIfb3wYR6Zau7Otq+eTFdn2DDXsRKrfUeLzIK9GZdHBCSDk14j/W8K46S
 SbOe68Y3zeFpp8K3o5BkCuXDH2lJB5JC3Xo/4l33PKhoQky2w1xdzZSVNaYVznoCTukrjKEFC
 f0A5sRggev1bcFXLNHk+DDXFQChVzIYlKI4xb577ID/HXIr23N3wgtmgN8QU9pCXeYkvCj1+1
 QUYTexl/YR1kmxfA31L7LoHy+wjjiIITsDYzks7FjU5PQnNCBqI6ctIrtnqN/k87cU5Vp6YG2
 vvydJzHs5dnJq984Wq5E6L+hDHz4fUbzh/hSooTPBS67jhbjlZIkSM2jKtwWXwLvMJxklOOFD
 YLi2W0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan & Junio,

On Thu, 4 May 2017, Stefan Beller wrote:

> So instead of a mechanical replacement, we'd rather want to
> see "the_index" not appearing at all outside of builtins, which
> implies two things:
>
> * If done properly we can move the macros from cache.h to
>   e.g. builtin.h. That way future developers are less tempted
>   to use the cache_* macros in the library code.

Yessss!

> * we'd have to pass through the_index from the builtin function
>   down to the library code, potentially going through multiple
>   function. For this it is unclear if we want to start this now, or wait
>   until Brandon presents his initial repository object struct, which
>   may be suited better for passing-around.

Or the other way round. I guess passing a struct index_state can be a
first step, and we can later convert it to struct repository. I fathom
that more places will need a struct repository parameter than a struct
index_state parameter. That is, if you first identify all the places where
the index_state parameter is required, it should make the struct
repository change easier.

> So if I want to further look into refactoring, I'll have a look into
> the object store and hold off sending a series that drops the_index.
> 
> > Also, dropping compatibility macros at the end of the series is
> > unfriendly to fellow developers with WIPs that depend on the
> > traditional way of doing things.  It is doubly insulting to them to
> > send such a series during the feature freeze period, when it is more
> > likely that they are holding off their WIP in an attempt to allow us
> > to concentrate more on what we should be, i.e. finding and fixing
> > possible regressions at the tip of 'master' to polish the upcoming
> > release and help the end users.
> 
> Personally I have not noticed large variations of patch volume
> correlated to pre-release times.

Speaking for myself, I also use this "slow" time to prepare patch series
that should be submitted directly after a major version bump, patch series
like the timestamp_t one (with which I failed miserably: it got to a
usable state only now, very short *before* a major version bump).

But yes, part of why I set aside a substantial chunk of time to work on
the Coverity report was to prepare for the major version, to make sure
that we did not have anything blatant (like the difftool use-after-free,
which was embarrassing) in v2.13.0.

It may look as if the coverity patches do not focus on critical fixes, but
that's only because I did not find anything major in the Coverity report
(I looked primarily for Git for Windows-specific stuff, though, to be
honest).

Maybe it is a similar situation for other patch contributors: they tried
to focus on critical fixes and ended up not finding anything really
critical?

Having said that, I did see a little shift toward cppcheck & sparse
related patches ;-)

Ciao,
Dscho
