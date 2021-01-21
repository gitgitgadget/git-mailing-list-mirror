Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8060C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 21:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6722BEF
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 21:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbhAUVGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:06:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:34532 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbhAUVGM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 16:06:12 -0500
Received: (qmail 6887 invoked by uid 109); 21 Jan 2021 21:05:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 21:05:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6006 invoked by uid 111); 21 Jan 2021 21:05:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Jan 2021 16:05:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Jan 2021 16:05:19 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #04; Sat, 16)
Message-ID: <YAnsj7HKNg7jmv2P@coredump.intra.peff.net>
References: <xmqq8s8so84r.fsf@gitster.c.googlers.com>
 <20210121183427.1783539-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121183427.1783539-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 10:34:27AM -0800, Jonathan Tan wrote:

> > * jt/clone-unborn-head (2020-12-22) 3 commits
> >  - clone: respect remote unborn HEAD
> >  - connect, transport: add no-op arg for future patch
> >  - ls-refs: report unborn targets of symrefs
> > 
> >  "git clone" tries to locally check out the branch pointed at by
> >  HEAD of the remote repository after it is done, but the protocol
> >  did not convey the information necessary to do so when copying an
> >  empty repository.  The protocol v2 learned how to do so.
> > 
> >  What's the status of this thing?
> 
> Several people have commented on the high-level approach (and I have
> addressed those comments), but I don't think anyone has said that the
> code itself looks OK. I'll see if I can get some of my colleagues to
> review this.

I hadn't seen the later versions you sent. I just responded with a few
comments. Mostly little implementation nits.

-Peff
