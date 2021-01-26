Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F19C10F09
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917E2206A4
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbhAZWEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:04:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:39748 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbhAZVKS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 16:10:18 -0500
Received: (qmail 26703 invoked by uid 109); 26 Jan 2021 21:09:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 21:09:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3702 invoked by uid 111); 26 Jan 2021 21:09:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 16:09:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 16:09:26 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        gitster@pobox.com, Git Mailing List <git@vger.kernel.org>,
        jeffhost@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/1] upload-pack.c: fix filter spec quoting bug
Message-ID: <YBCFBivBLgqEAUr1@coredump.intra.peff.net>
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
 <20210125230952.15468-1-jacob@gitlab.com>
 <20210125230952.15468-2-jacob@gitlab.com>
 <874kj46mwf.fsf@evledraar.gmail.com>
 <CADMWQoP+hgPiSHJ5D-3G0+-bZOYm1hr=ojBeSmUJhiS7bp0zPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADMWQoP+hgPiSHJ5D-3G0+-bZOYm1hr=ojBeSmUJhiS7bp0zPg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 11:29:55AM +0100, Jacob Vosmaer wrote:

> Thanks for the feedback Ævar. I am not sure if I am still supposed to
> make changes to the patch now that it is in "seen" as
> 7c6e2ea381d9aafe0a1eff0616013f81d957c0fd. Am I?

It's OK to send re-rolls of patches that are in "seen". That branch is
rewound and rewritten regularly as part of Junio's integration cycles.
Once a commit is in "next", then it is generally considered set in
stone, and fixes should come on top rather than as re-rolls.

(There is one exception; "next" is rewound after a release, so that is
an opportunity for topics that were so muddled in their earlier
incarnation to get rewritten. That is pretty rare, though).

-Peff
