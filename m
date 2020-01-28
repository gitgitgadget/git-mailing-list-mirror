Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2C3C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 07:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6A22522
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 07:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgA1Hdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:33:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:46060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725776AbgA1Hdm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 02:33:42 -0500
Received: (qmail 7450 invoked by uid 109); 28 Jan 2020 07:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Jan 2020 07:33:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5082 invoked by uid 111); 28 Jan 2020 07:41:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 02:41:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 02:33:40 -0500
From:   Jeff King <peff@peff.net>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] git: update documentation for --git-dir
Message-ID: <20200128073340.GA564804@coredump.intra.peff.net>
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
 <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com>
 <b494114d-02ef-599f-4fa0-d7614974a130@kdbg.org>
 <CACg5j24TNczbZZ3u0UR_MYQgeWk8HRY-cxc3N8HX=v-Tx0vi3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACg5j24TNczbZZ3u0UR_MYQgeWk8HRY-cxc3N8HX=v-Tx0vi3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 05:17:49PM +1300, Heba Waly wrote:

> On Mon, Jan 27, 2020 at 7:29 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Does this render well? Judging by the precedent set by the descriptions
> > of -C and -c options earlier in this file, continuation paragraphs
> > should not be indented and separated by a line with just a plus sign
> > instead of an empty line.
> 
> It doesn't render well, thanks for pointing it out, will send an
> updated version.

One tool that might help as you do documentation patches: there's a
doc-diff script that shows the rendered differences.

Try:

  cd Documentation
  ./doc-diff HEAD^ HEAD

(on a branch with your patch at the tip). It was originally written to
investigate changes to the markup, etc, but I find it's useful just for
looking at any documentation patch, because it takes you right to the
part that changed. :)

-Peff
