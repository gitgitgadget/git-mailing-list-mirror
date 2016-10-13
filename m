Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378A120989
	for <e@80x24.org>; Thu, 13 Oct 2016 13:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbcJMNgx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 09:36:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:58010 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753779AbcJMNgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 09:36:52 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M9ra4-1bji273Neq-00B3Hl; Thu, 13 Oct 2016 14:40:51
 +0200
Date:   Thu, 13 Oct 2016 14:40:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
In-Reply-To: <xmqqk2de7e70.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610131439400.197091@virtualbox>
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>        <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com> <xmqqk2de7e70.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9zY+wvo5Pro5AtYGB+H6mKvg/66Vpo+ke5ZcubfL7L2FtPxFHo8
 ca7v0s7g4qgGA+yZZZPyF7WlH7MC38DW98y2G4xGo1x5KZApzDSpciG4isZwADVOAO7GaRN
 C1H2Qod4sWBA3Kbl0SSlD48+gvrAALBuGjpgNTCeT8afvJFKK47hgd8SVD4Jc3Mz6O0RANw
 eb56tgls/tFcuU+fXL9wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kHJ8jlXFUZA=:QPmJUIWZYYh0OFw5clBYBX
 IbvY3vhvpUmI9Z2jZXRpl0hsgs0Zaf5j0GYAAkjXpd4TDMg2DZAIFQdi+eZ6TCZ9TTdX4rJsz
 AZEHPLnUWOTCLmRjmCD0qFehb10465Pyn2tswOuDQZYOPmIQMzem5KzpQduPlpNq9xTvYc5Vy
 bGhCAyH55pM1zChxTd628ejZ+OpVWHtSU9UQesKbQDPwkjvqo8IaQWq4rqn93YCD5xKbrOPg0
 DAMkhbfwr/x2ELYdPYAaTDMmpdRK+VUBsBOjtYWC4uRynrfdcicTWvZVqTuH211eeb8MZlo3S
 JwMpEaxWYckqTyL5YIf8MsWmRdhp5ENF5FFDcLIc4ucPUFuyctkDv/0Q+2A96A917FjEKqfWQ
 XLl6gPR96539l+LRLfKI3cUAsdmTOnNGMH5XfIxGhNrtxA3WujlVD15nclv1YQ2hw9ugzQtEp
 9tX8RegOCCLXrQDI58v4Rr3z0VKPJE8HegMpESbm4nsX6zc2IzObfsqDcBoPRFfIiX2gdnXku
 YiFroY41AuMpEdp5w3D3VOutIYqG1FMrGdZu9QNKZDiiwLwZ60jmMlS4Wai3hrPKociPUswPp
 D+ISFcWingPJSRJ/2M22GrIOvjkaZHx/alNN2xiGGht7MZocVsU2XzUaCgEm+vUeRRqeDyoLL
 87bAVlwPOSP/lXXFGwXDRdio8DwrN1Q7rYQWcCVzLY19KfevtluGSWsjoJbxCW0zFdvV6BVZo
 8y9x8gsA34P+1shpUKgORqMDeqT3ArOEn2sERWH7x+l1sG0V5I/gVjWLVy/a7MV33T9aQxDKs
 jFcXoPC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 11 Oct 2016, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > On Tue, Oct 11, 2016 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> * sb/submodule-ignore-trailing-slash (2016-10-10) 2 commits
> >>   (merged to 'next' on 2016-10-11 at e37425ed17)
> >>  + submodule: ignore trailing slash in relative url
> >>  + submodule: ignore trailing slash on superproject URL
> >>
> >>  A minor regression fix for "git submodule".
> >>
> >>  Will merge to 'master'.
> >
> > Going by the bug report, this *may* be more than
> > minor and worth merging down to maint as well, eventually.
> 
> The topic was forked at a reasonably old commit so that it can be
> merged as far down to maint-2.9 if we wanted to.  Which means the
> regression was fairly old and fix is not all that urgent as well.

And if you merge it to `master` and `maint`, I will humbly request to do
that at the same time as whatever fix for the regression I reported we
settle on.

I would *hate* to have a `master` (let alone a `maint`) that breaks in Git
for Windows SDK.

Ciao,
Dscho
