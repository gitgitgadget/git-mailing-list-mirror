Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0774CC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC20E2083E
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 00:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgGaA5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:57:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:43208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgGaA5W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 20:57:22 -0400
Received: (qmail 17774 invoked by uid 109); 31 Jul 2020 00:57:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 00:57:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22798 invoked by uid 111); 31 Jul 2020 00:57:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jul 2020 20:57:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jul 2020 20:57:21 -0400
From:   Jeff King <peff@peff.net>
To:     lego_12239@rambler.ru
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200731005721.GC240563@coredump.intra.peff.net>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <20200729203856.GA519065@google.com>
 <20200730081743.GA24210@legohost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730081743.GA24210@legohost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 11:17:43AM +0300, lego_12239@rambler.ru wrote:

> On Wed, Jul 29, 2020 at 01:38:56PM -0700, Jonathan Nieder wrote:
> > The commit message describes its intent
> > 
> >   commit 489947cee5095b168cbac111ff7bd1eadbbd90dd
> >   Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >   Date:   Tue Jun 23 22:33:23 2020 +0000
> > 
> >       fmt-merge-msg: stop treating `master` specially
> > 
> >       In the context of many projects renaming their primary branch names away
> >       from `master`, Git wants to stop treating the `master` branch specially.
> 
> Wow. Jonathan, you are a good student of Goebbels! "many projects" :-D.
> You lie. These are few but very noisy projects. Don't kid youself.

Please keep the tone on the list civil. If you want to disagree, fine,
but "you lie" is inflammatory and unconstructive.

In general, also please keep in mind whether any comments are adding
value to the discussion. In particular:

  - the text you are responding to isn't even Jonathan's; it was a
    quoted commit message to give context.

  - his point is unchanged by whether you agree with "many" in the
    original or not. Focusing on that is just derailing the
    conversation.

  - if you really do want re-open the argument about whether projects
    are interested in changing branch names, it might help to provide
    some actual data. Most of the data-less points (on both sides) have
    already been made in past discussions.

-Peff
