Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47B6209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 15:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdINPYI (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 11:24:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:62104 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751509AbdINPYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 11:24:05 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbMmA-1d7eZd2awU-00kw7P; Thu, 14
 Sep 2017 17:23:31 +0200
Date:   Thu, 14 Sep 2017 17:23:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <xmqqpoauyqlp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709141722500.4132@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <20170913163052.GA27425@aiede.mtv.corp.google.com> <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com> <CAGZ79kakGcMJ7HuH+MPsMrvw40uGchr6H-SQw9-p8pgi3Yk_Bw@mail.gmail.com>
 <20170913221854.GP27425@aiede.mtv.corp.google.com> <xmqqpoauyqlp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GdlWODe2jYTiCiAo+2m4dPU4mrCKdwt8+U9EdQaTPO5AkRQFVx1
 9Uc9t8Jq4exOD4JF+VsrmIXsvbluuy0tUC1Px9e2ynag9rvpXCFmFmoYHFaxvRHr506IYXh
 oGxHUKBAhLKmOpisPEEI0H+BG1N0lKkRco/yXFCt/gHILwEc3v8waO2m9sWLGLoVHxd5/Yl
 Qqf5fzdYe219dwJ2Epr1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aSdB6/MbwfA=:simHHn9jC2yoh14IFYsK5x
 hWqPRXUvoOI0FVy5siDCik0srEpDMi9BtZD0gNekLWxN+oYnVSnKatfyGqrbNJE6eFW2Lv3Op
 nHUxrrEyDQ/6fdBrOrndIFGyLU/Ce9ettd4tXE1GuZZ8bJ0H6LdgOYBbMoxwGy+ijXGgpGLtm
 mw0SR4iJy37wsXTl2jA7j0YjWFpmpPWXUQNie7KO89biDxgdZieykjERx1l6H2oImdaGYBJ51
 cAcp//Z1qX3kGH/7XGRw9t84dgDi+QpGjNtjHY4zQtDMktpTf+WRvwuSH/Y4NPRvpcGG1++0/
 MELhCNShnBZ42MxmbjpdjaXHWX7FhMLHlj6FnpXqZG56w43s4knyN0LJEoR565Xv5TJMowbPL
 M+84n5aSf4DMz8p8gGqAaP+13zc1pZnLrPF9f6F2aRpnGneikGxUuNIoOHpgTPF+zYc1U6bvm
 LQGEsr3/25vIunjBiE3qBliAkPWBInGPBbaRWY78qhK5e1svnjUXspbnTJD6LjQ2kD2X7oUzI
 YKfTN/R26qNggJXY9XHcWjqtUfMLHi5plCHH45GXqyg/l8fLE0wZJjviV2NKg11rR2x8LsmnL
 zWeoIVfhzz0KZNRPzqcllXJO5KGmJO2j1d4qJI+6b0ML4aExnKBAG5EpOyezwmK4UvOcwquei
 9K+hG/t6tkC6zN0bdUtFW4KSRCMWb6Vr58+Qrd/sd5BU46Mccu/gPWUV6hpQmKMz+OALpkwqx
 dJzHsAjSu4xLTq5hLoYBwqj22Nc0YXLKfnoYrTVzbk5+GZnGYGPoY9wb4BuPnALkZ/hnR2v8Y
 oGqL94fkmmM5P6M++owUmbuSBMFPUzWlIS7gprNFyT+rr472fU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 14 Sep 2017, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > In other words, a long lifetime for the hash absolutely is a design
> > goal.  Coping well with an unexpectedly short lifetime for the hash is
> > also a design goal.
> >
> > If the hash function lasts 10 years then I am happy.
> 
> Absolutely.  When two functions have similar expected remaining life
> and are equally widely supported, then faster is better than slower.
> Otherwise our primary goal when picking the function from candidates
> should be to optimize for its remaining life and wider availability.

SHA-256 has been hammered on a lot more than SHA3-256.

That would be a strong point in favor of SHA2.

Ciao,
Dscho
