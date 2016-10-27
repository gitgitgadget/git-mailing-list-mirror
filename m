Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE10420193
	for <e@80x24.org>; Thu, 27 Oct 2016 15:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935890AbcJ0Prj (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 11:47:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:54457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935209AbcJ0Pri (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 11:47:38 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MbOoG-1cIYlx2Knc-00Iksa; Thu, 27 Oct 2016 17:47:29
 +0200
Date:   Thu, 27 Oct 2016 17:47:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #06; Mon, 24)
In-Reply-To: <23f15627-4964-7ba9-45c3-899366d621bd@kdbg.org>
Message-ID: <alpine.DEB.2.20.1610271746450.3264@virtualbox>
References: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com> <CAGZ79kbtyuSXDiyi2eY6HKCAwEiKgk2KmNakSn=f+RiXCAC1bA@mail.gmail.com> <xmqqoa28s63l.fsf@gitster.mtv.corp.google.com> <CAGZ79kb2XD8+y-Y_oiwSj3DsXjmTS=bd6fj5dn9NADmvDO5xtQ@mail.gmail.com>
 <23f15627-4964-7ba9-45c3-899366d621bd@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dIN7ts2ANj596uA6nEDqaewA1rT1dmQj/q/6fcXIIhUljtDuiN2
 F9r6vLNrWJfgigCrsNa6rIgbA96FlKClbj0CrvENx7NPwh4AY3oHG6J93upzPfgMkRFLdwl
 HhayoME5+pkKb2F1Fx0f4QlVs8m3InnX2KVn57fheLxtMl+cNvBSk6JM5kC7UOf6lOyUrUc
 fUeNU6YR4rlBlpsjN1+FQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i7ADNJx9ytQ=:QLLQBubICNaM5fi4DhIHV+
 wMUmlmxpx8KcK7hn089w1Re34axEc/yG0m2zhC2mL/KrS5EX8sLu8GRoz/q0ZiDktMVGZHNQB
 Sqmt7Mc0TIjT6Y0GQMbWyNRMueiCUW6xQz9l1pnnvlc0ovT82IdqlSThgklrgfh/VWFbl/P19
 zymPPUbIULYwKNPlwLGzkTqOjAscFg4HLri9XQyj4rCcvyyyZ4UebaY8HzW4eBcVpWZAOW24w
 POr4eW/+s8AaBhspucPNM+vINYC9vUZh9LvyT6foRt5o6mwNeanRctjQl9Fok9pDhK0tRfIdv
 bV0c/rCRJmPKghZprEXpVv50ENqtD0qddLNIIRIjlJp0b1wX0ShGric4P2hglTUyxUf6ONHf/
 wIrdNMwcfYv4XzEAsvQJzEi6nBXRx2fSYQB9ZkEpisiVYQhdzoRnwuVfPuHZY1UiDkiAc7g6Y
 aH/ZGV1X5ZWkesF68LJdAFEftdQttgV/7PjtaR7wfoyNd8Q23xXBwUdm1be68BaMTKQOsSbfi
 gRX+N1RE8wvM03pbk3xZM73vpmyGTjZgAdpLljouLWcItzP3QOt4pGTB/j83pPkYz7QZD70KC
 cMMMPLYU2eEa1rJwOlKScavHNjFfb3rttS/Dm9qmoEluy5ghmVz62qO6iJvrthy6uuHEqW2Ke
 BXqYvJWEylkvJ9kGoiiRMc/sN9Oc/gipW52sAZ1DUNR18s+edCAR+Aff5whRXmfb5gVqxCjYH
 1g+BznDYeFc3GEvL5VN6Guca8utM1VdZgJ5/R4NXz2DFlQ0sZbp9lC5gtWb/HwPYQ63Ttofn4
 Y+/fyHY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 25 Oct 2016, Johannes Sixt wrote:

> Am 25.10.2016 um 20:13 schrieb Stefan Beller:
> > On Tue, Oct 25, 2016 at 10:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > >  - the "off-by-one fix" part of sb/submodule-ignore-trailing-slash
> > >    needs to be in the upcoming release but the "trailing /. in base
> > >    should not affect the resolution of ../relative/path" part that
> > >    is still under discussion can wait.  Which means we'd need a few
> > >    more !MINGW prerequisites in the tests by -rc0.
> > >[...]
> >
> > So maybe instead of adding !MINGW we rather want to apply
> > https://public-inbox.org/git/2908451e-4273-8826-8989-5572263cc283@kdbg.org/
> > instead for now?
> 
> I was about to submit this very patch again, and only then saw your message.
> So, yes, that's what I propose, too.
> 
> Dscho, does this patch fix the test failures that you observed, too?
> Unfortunately, it goes against our endeavor to reduce subshells.

I am fine with the patch, even if I did not have a chance to test it yet
(ran out of time today).

Ciao,
Dscho
