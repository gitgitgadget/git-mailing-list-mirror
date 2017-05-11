Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756481FF34
	for <e@80x24.org>; Thu, 11 May 2017 11:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754838AbdEKLdn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 07:33:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:63718 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754327AbdEKLdm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 07:33:42 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmazv-1diw2f0brP-00aIPV; Thu, 11
 May 2017 13:33:18 +0200
Date:   Thu, 11 May 2017 13:33:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Automating Coverity, was Re: [PATCH 00/26] Address a couple of
 issues identified by Coverity
In-Reply-To: <CAGZ79kaAYU3cSRdXZTvukib3VNmx+_GdeSV5NkZ1g_OWt07i9A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705111329140.146734@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com> <alpine.DEB.2.20.1704280010160.3480@virtualbox> <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com>
 <alpine.DEB.2.20.1704282205320.3480@virtualbox> <alpine.DEB.2.21.1.1705052227120.146734@virtualbox> <alpine.DEB.2.21.1.1705101801300.146734@virtualbox> <CAGZ79kaAYU3cSRdXZTvukib3VNmx+_GdeSV5NkZ1g_OWt07i9A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XLH7D3ZF/MVEIl8DguBzufGJTZIJFhN/XKm4axm76kdwI5rmj1H
 JGBRE84hGJBn4CamjjRe/1rS055byIzPDhYTHFqtYxaFmjgNmEp/LB/qnErdl4cREdRdN1+
 ySoNyNJeuXuQP5ZfcxwxP5NjAQoZiKctWV4cTVGEYAzclRs9JDxIofrf8RINj0rBet0pAOH
 MsXyZjPf+Z8oTq5y9iJKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KNQaFFkroH8=:qLTHcPYdLvJIXRaFIm7bBY
 APSdjPM8BfwqhwH241AIdVOR1lYOB/RTEgXrg0ykqGhmyxo1a4KxljCTkuzNxjF6dvlaSvGiL
 XKQCY5o2vTnXCSXxw+a2FYh1NPZKaWNbiNfIOQrPz2SIe3vE3ftZbCavyMMjY41mDQbD1sw0/
 1pUxNYxa4q9CPPBxHFLSAodq6fTV/VO78LPvzGhQcgjM14dz6I7Jb3G66TTGzNBo56ccVOODE
 cZbfgf2MYGc4q7XEIGYeNnvM/yIliUrmchWixbDWkBsk2MNadiUOIFuMlPcVDduO4xucnB9ch
 gSE0C5h6CodTnikzwGVHokt2xqWWQi6E5h+8gnrVuEDqOolLf8eHeasiNTuwVE9h00Yj8/0tv
 LHS/tlQAf2ycg96b6iOg7tynxvAcXrZMOWRY/NrLs/BOnb8RK2IilN5TlGsh5iGruP18bWX5f
 aYPn8onWpYzfJZV5mIiKVE/y6x4kCU0Iay7E/uPSvuI8pa6EPmnrQPz1Woyfe8mt4z3agqumm
 rNqE+wuKHmGBepGPZa8X7TRxj7FVgbstzSMLg/JJBbSVObPdHIhfRe63Wa0saxxP9tHNN4KfD
 gKbDqjiBF5ky2dHLWppmk4fUNbHwVDjhTiQCzlbWqC8CR9kfPPArcrWnUGAukdWoIEypXfueB
 LDU5yxpDyxCG5/jDfgQthd+2LkpqB3hzKggGkD7nUSia8jB+keWrwREHH07PBsOBjJSaXH8yG
 W0ysRD3iQOkCZ8ufGvc3ANuEiFFo/LTbvwg7Lsc+Le85fPimUFqUqkV8z2GyJTNsi+bR09NzB
 5AEKMiP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 10 May 2017, Stefan Beller wrote:

> On Wed, May 10, 2017 at 12:48 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 5 May 2017, Johannes Schindelin wrote:
> >
> >> On Fri, 28 Apr 2017, Johannes Schindelin wrote:
> >>
> >> > On Fri, 28 Apr 2017, Stefan Beller wrote:
> >> >
> >> > > On Thu, Apr 27, 2017 at 3:50 PM, Johannes Schindelin
> >> > > <Johannes.Schindelin@gmx.de> wrote:
> >> > >
> >> > > > I still have to find the time to figure out one more detail: how
> >> > > > to download and extract the Coverity tool (the .zip archive has a
> >> > > > variable name for the top-level directory), and doing that only
> >> > > > every once in a while, say, only when there is no previously
> >> > > > unpacked tool, or it is already 4 weeks old.
> >> > >
> >> > > That is an interesting problem, which I ignored as the older
> >> > > versions of their tools still works once they release new versions.
> >> > > So I just manually check every once in a while if they have new
> >> > > versions out there.
> >> > >
> >> > > So if you find a nice solution to that problem, let me know, please.
> >> >
> >> > I think I have a working idea (jotting it down in the editor,
> >> > untested):
> >> >
> >> > [... totally untested snippet ...]
> >>
> >> And now I edited it and tested it. The code is now part of the script I
> >> use for pretty much all administrative (i.e. recurring and boring) tasks
> >> in the Git for Windows project:
> >>
> >>       https://github.com/git-for-windows/build-extra/commit/05b5342128
> >
> > Oh, I completely forgot to mention that I tried to set the FLEX_ARRAY
> > constant to something quite large (I used 64k), but apparently that does
> > not work as expected, Coverity still insists on complaining about strbufs.
> >
> > On a second thought, it is actually quite obvious why it does not fix
> > those reports: STRBUF_INIT has nothing to do with FLEX_ARRAY. D'oh.
> 
> D'oh. I must have been living in an alternate universe for quite some time
> as I seemed to have confused different things here.
> 
> Checkout this commit,
> https://github.com/stefanbeller/git/commit/977f81d6dec4461a1a12da2df6c5c919b41129b4
> that is cherry-picked for the coverity build. That fixes it.

I saw that patch, and since Junio did not pick it up, I figured that it
won't make it into git.git's source code. That's why I went with the `sed`
approach, as the #ifndef __COVERITY__ guard is not even necessary if I
have to patch the code before running the Coverity tool anyway.

> That is about the only patch I apply before sending it off to coverity.
> I am still contemplating a nice solution for FLEX_ARRAYs in other cases.

For FLEX_ARRAYs, I use this:

	cov-build --dir cov-int \
                make -j15 DEVELOPER=1 CPPFLAGS=-DFLEX_ARRAY=65536

I have not had time to go over more than half a dozen CIDs, but I *think*
it helps.

Ciao,
Dscho
