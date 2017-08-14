Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD7320899
	for <e@80x24.org>; Mon, 14 Aug 2017 15:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbdHNPwy (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 11:52:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:52945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752882AbdHNPww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 11:52:52 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ld1CS-1dGmca1SXw-00iBQ4; Mon, 14
 Aug 2017 17:52:40 +0200
Date:   Mon, 14 Aug 2017 17:52:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
In-Reply-To: <xmqqk22b5q9m.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1708141751590.19382@virtualbox>
References: <20170808012554.186051-1-bmwill@google.com> <alpine.DEB.2.21.1.1708081404200.4271@virtualbox> <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com> <20170808182324.GB73298@google.com> <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
 <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com> <alpine.DEB.2.21.1.1708101137190.11175@virtualbox> <xmqqk22b5q9m.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7+lVUVqnuMwv7G0n9ZGlupkTQU7J3xOafCnY1mCxwpraHh7JjcX
 RHJmDY2JKWydcg/TIAUKhffYATM0emXJ8KjaUaPsJCDTFOzhI9vArCMu17jjPMtYzuDv3SS
 ZfBGJZQBarIKHUrJtWiLbzoIYAkzlaBmeGguRH6EXUJ+lmcusoJuqr1btAmdH/fUPkAF9bG
 EvFFXdL4q/AnuxQ44XKUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7pvTA1M4pZ8=:9FV3QWcOlvpkhP0+AKvQob
 quCTyuxblM7S/bCWQn4QCg7HshnWMzL84Tf2V/cM//8mS21JtWzyXCIRi0LO42ZfdD9AAz5zb
 L3pwdhuwGIWvwsIYcxFcFx5ciD9uwg6aUN5Ox1FAiBx27512lRjcCRZkSvmmzKeDu4yOgEG3l
 MsNPBldlfP7OWzIJkgorwLacvca3cDkZjso8yV2NF430zQjaFaagkdRxlubDvcLPaHtN1/wib
 ChbnFQKgipTDG6Jy2AGZwl3vfAWuYmTbhs4fUsNLn+M/CDhhtHDvUUtgojqkcCAlKD96Tcrd7
 r7Nk9LQf2v5TNnoFaRRj6qGT46hx/cCHe1hLiMCmzXK78cyoBT41P5/JXNTfCtKqOqCUVhYfP
 kLDvE9Xh0jdctXAUb/theMGa4EIGJJpKAuA30ajcR3o+TFcP9U/Ine4cluSBFkbRl95ZR8PyK
 IyUemaS8AtGOO1NIAfA2S6vSXPxv35qUQJ5PUceJKtLkPgrkjH6Be8Xd3NXUN17ajFm02L6K8
 IyCDXxs6H07d2q136XuTpisI3v44/QBJt9JxP02ZJTMf/FcDG2do8hfN2G1WyDpjwHyVG3fHX
 a/l/ne2zqgyUAppVvh+YVrZVA7l7gpsilTcp94y/FMJEdAfdo4kyPrN3JWC8cWjHOyWolkpxB
 aVK2yYwYMlIjb+D8z8pyVAN8UUke7sWGv2BFx0wapoy6keHEK1wWEV5951NCDMHEB6gz8jjBj
 XBWzkzFfiEJsZq95UTVvp1ETmp1jK5bAs53AKcAS49JsySHD8dJPEgANd4uPQCQ6AuHOjBeyW
 oGT1tHwH5+J+oe7YDCkiG8HfDnaXHEVGIiodZZDu1X9ctLGHes=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 10 Aug 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 9 Aug 2017, Stefan Beller wrote:
> >
> >> > I am sure that something even better will be possible: a Continuous
> >> > "Integration" that fixes the coding style automatically by using
> >> > `filter-branch` (avoiding the merge conflicts that would arise if
> >> > `rebase -i` was used).
> >> 
> >> I do not quite follow. Is that to be used by Junio while integrating
> >> branches?
> >
> > I was more thinking about a bot on GitHub. "Code cleanup as a service".
> 
> I vaguely recall that there was a discussion to have SubmitGit wait
> for success from Travis CI; if that is already in place, then I can
> sort of see how it would help individual contributors to have the
> style checker in that pipeline as well.  
> 
> I have a mixed feelings about "fixing" styles automatically, though.

That's too bad. I would much rather focus on quality of code than
conformance of style, even if the latter is a lot easier than the former.

Ciao,
Dscho
