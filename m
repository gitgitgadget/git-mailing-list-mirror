Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF08E20248
	for <e@80x24.org>; Tue,  5 Mar 2019 15:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCEP3O (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 10:29:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:41167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbfCEP3O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 10:29:14 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4nt7-1hBHet1ps5-00yywD; Tue, 05
 Mar 2019 16:29:02 +0100
Date:   Tue, 5 Mar 2019 16:28:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
In-Reply-To: <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903051627050.41@tvgsbejvaqbjf.bet>
References: <pull.130.git.gitgitgadget@gmail.com> <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com> <20190301213619.GA1518@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet> <20190303171951.GD23811@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet> <20190304214155.GB3347@sigill.intra.peff.net> <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iUjbmHBx3KNnQ7n/Yqokcsmfc+h5eYAjSfAatGWYxnAwutszN2s
 5fNulzyBXD2DWp5F6ayFX2OqnQdQwxYHhbDYx3PSBXYTl931adTTbLkiM1805EIQdm6NZka
 k3CQsHVgS/cgVCM91eK6NxxjiPZI1IHZixB/qfLyOq/Cmz4Kdy13h6VhCOS/TDZr3pHmxvr
 ttlI2aqcbK03wnAV1VmZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NHbi4kiRu2E=:I1GT1y+Y2db2rRuRbyfxFD
 rOuCMN6fEqfrBf/hZI+G3EOHUeO6D0mV9nmU79Zd3i/BjjSZWJRHkuG541ph7JoheU+nNahAv
 MSHLLF/Cb6BDkbgZPxPb5d0FGvDWEJQ93U8YHQtabSFBiNFJlGAcS3+awXlJPvpPFpOe/6ZzA
 4rZiszuHtcTibJKO8yxme/llcSJIKGDQuua9UDN1V8GV1n4uaE6lDTuWgPIT23JM8dqXY5vev
 rjJJ5enopWkxNPkCXFPT+Y+KAfF9p+COVWuotplPcjzIBx3gi3LsN4XN7nPf02JSeGXTK4kp0
 J+ttZ/n8UAOcW5tbUZf/7+GcX4Bt8jqZeRLQL7kFaYeXbHWiiURZQqF1CXUsSzWqRYvEl9HRU
 yEWpfKQDnV9fgjsQ1SwOAaAPKRJgAi7FbNgBlk0txOGGg3tRDniA2DiscBZspZ6OTSdcSEnN3
 mTFAxLtwnUAl64iExSLGghdv0u42iICY+hRXzbxFrMmG330f36hWKLirMhmYk5IGzwOLVwndG
 mNWWXReFAJSdU42j22O0J6lq4DklU9y7R2Gk7GfQ711RAvYEDeXr4fx3zVF5wk4dpo4zIG10z
 7iSqBJADxRE8jnSCM61+5S+Pm+Qca6O1EHf3hZoNE2KodVj9FFopNO/buZRydKk3QFcU0eLRC
 RzBVdOGjNZdR90hFd0T2Cjc3idkVLlsKmt6IF96lYM1UIEwnf8/XekDFcx9H332t4mDqavJ83
 w9O0m9VT6rSD9ao2tA+a3SXO01P9qlkWLXQnXoC/RUsRFoYo+cRhobh4PgEgQkjl+rZbT46P2
 703wcWXpkrYH+KesPlmBZbBwoXGHnV3qR0XZnrVi0ucAe7KJFhnRiAhYt85KL8eIyvaCN8xKM
 j8L37UrtexqkjU2lGzFQw5FQBia4LVeCJyrBNzp5x9h6f+99gas1cTddrSoSSDdt7YDNOcneU
 Bpccz5MWlDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 5 Mar 2019, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This makes sense to me, though as you noted elsewhere, it doesn't fix
> > the gcrypt problem, since that file unconditionally wants to look at the
> > system gcrypt.h (and we control at the Makefile level whether we
> > actually look at sha256/gcrypt.h).
> 
> Hmm, is that because the header check target does not know which *.h
> files we ship are actually used in a particular build?
> 
> After a normal build, with dynamic dependency checking on, we would
> have sufficient information to figure it out.  Would that help?

Yes, *if* the dynamic dependency checking is in effect (read: if we are
compiling with GCC).

However, I think that one of the benefits of the current approach is that
hdr-check finds issues also in headers that are *not* part of the current
build. Read: once hdr-check is run as part of the CI build, it is harder
for some random contributor to break hdr-check for somebody else with
different compile time options.

Ciao,
Dscho
