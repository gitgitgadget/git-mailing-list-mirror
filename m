Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B1520A40
	for <e@80x24.org>; Tue, 28 Nov 2017 11:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbdK1LhG (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 06:37:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:53869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbdK1LhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 06:37:04 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZTw5-1eXbD51MfF-00LDrW; Tue, 28
 Nov 2017 12:36:58 +0100
Date:   Tue, 28 Nov 2017 12:36:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Dan Jacques <dnj@google.com>, avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] exec_cmd: RUNTIME_PREFIX on some POSIX systems
In-Reply-To: <xmqq374z83p8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711281231510.6482@virtualbox>
References: <alpine.DEB.2.21.1.1711280039010.6482@virtualbox> <20171128032538.98071-1-dnj@google.com> <xmqq374z83p8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jO0ptCT5QnRmmlVXNIJkf7fX7Rnlhtp0csS9e+SUPUrUXg2dxex
 1/guX6Nv5HMD6QwMkquDpIFLflDE/9Z+VgfQbPlLPD60tzRMe20H/hkWOHs1q5eKwGWsBar
 PvfjQ52vnSrji228qT2ES//loQr6L6MA6lkuzjKteIkZP6mPLsesAZhnj/9d/dA0RFtXxpW
 0LvBiaW+iitn9IA+hxDbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OwPRQhLsQz8=:PfYTMyiCRvQ2YbBvKq4/c9
 9hOITJ5Lk/7K4qc4ynWOS7mPY5F/tvjSkrmUpI8EMMFuuwWBOGerifLwb/p15gRmTfTl1c4Nw
 ojhZzX7p7kKz8Kee+8B517JyfgQQ1wNQfq67PJ5YqW2cJWJ67F3UneFbNTSqV4QpqD1XaDGsP
 +nZkgkpX+axkkD3l9X/oDmR+UIx2XaguLLCjinf7JzQumpbnDIAVa2TtgXtEcCulV5Kdcs+6t
 SU7iZXXAbZiR4IWETK/SNJTLc7fjRFpE+N0K9QaGRMkVfCCafVWDDY4AmkR0WyfDbwQ3ExWdv
 T9lVwfU3R2Py79cVUB4mBDeSE23756pXH6nyJxlRXQ+alc/OburOSa792jMa1OdrjZBMQtLV/
 kD3Q43NEN8VpCMZdHZ3iGNAwceq9GuViS2X19+VyUoXM5jPM5s1Vur31F46T7izWneRZGIFUq
 jBzSknDwquHSf6LzvKj/JFrIAHrN+0YrzdA3TWp6bwWhH4qeqsHi6weLuBcUiBYi3I3NRv3cA
 lgDUrwN5emW2IVyxMcOam6lm05xduktDF6X2R2n40HzYgoaO9owPkCY8Zm7w6c4p7Pe9lpSAo
 cdXue4PEw4IfhfqgTmVKmAHSX5BDGv20xGDQ9BgYjp5cFaFJr921gBi9/VSu7FNT7oFARWy7t
 G32gRAjt1/Dyzq4MDEleSngHLN3HVH7gd14xC42aNYNZsWSbg6y6CXRy8TiZJAL2VXhi/qd9K
 hJ8xSDYMsx02r77A+YLLTa/zFO7LRBiw5CRYWe9D7ph/doqbU484gfK6gMidBUNHDpPg1F3dV
 h5VYCV4tnkBX2c+P+a3pinl3dwdN4qNVXbICUu70adUunN15oc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 28 Nov 2017, Junio C Hamano wrote:

> Dan Jacques <dnj@google.com> writes:
> 
> >> In Git for Windows, we have an almost identical patch:
> >>
> >> https://github.com/git-for-windows/git/commit/bdd739bb2b0b
> >>
> >> We just guard the call to system_path() behind a test whether podir is
> >> already absolute, but these days, system_path() does that itself.
> >>
> >> I am too little of a Perl expert to be helpful with the other patches, but
> >> I would gladly runa build & test on Windows if you direct me to an
> >> easily-pullable branch.
> >
> > Oh interesting - I've only peripherally looked at Git-for-Windows code,
> > since Chromium uses its packages verbatim (thanks, BTW!). I think you're
> > correct though - this patch set seems to be doing the same thing.
> >
> > I've been force-pushing my changes to the "runtime-prefix" branch of my Git
> > fork for travis.ci testing. The latest commit on that branch adds a
> > "config.mak" for testing, so one commit from the branch head will contain
> > the sum set of this patch series applied at (or near) Git's master branch:
> >
> > https://github.com/danjacques/git/tree/runtime-prefix~1
> >
> > Let me know if this is what you are looking for, and if I can offer any
> > help with Windows testing. Thanks!
> 
> FWIW, I plan to include this somewhere on 'pu' for today's
> integration cycle, so dj/runtime-prefix topic branch would also be
> what can easily be grabbed.

Thanks for the offer.

Having said that, I prefer to work with Dan's branch directly, as that
would be the branch that would need changes in case I need to patch
anything. It's better to save the time on the roundtrip through your
branch (that may display other side effects, too, as you almost certainly
chose a different base commit than Dan did).

Also, I could easily offer the changes in a PR which is *a lot* more
convenient on my side.

Ciao,
Dscho
