Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669F61F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfAHVQe (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:16:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:58330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729704AbfAHVQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:16:34 -0500
Received: (qmail 8430 invoked by uid 109); 8 Jan 2019 21:16:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Jan 2019 21:16:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16589 invoked by uid 111); 8 Jan 2019 21:16:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 Jan 2019 16:16:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jan 2019 16:16:32 -0500
Date:   Tue, 8 Jan 2019 16:16:32 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
Message-ID: <20190108211632.GB22946@sigill.intra.peff.net>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <20190107083150.GC21362@sigill.intra.peff.net>
 <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
 <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com>
 <20190108180522.GA4610@sigill.intra.peff.net>
 <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com>
 <xmqq8szv56e4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8szv56e4.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 08, 2019 at 10:52:19AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> Yeah, they should. I think one of them will need René's patch, which
> >> changes the body of quick_has_loose(). I can roll it as a separate topic
> >> if that's easier (or just wait a week or so until René's cleanups
> >> graduate).
> >
> > Nah, what I got is already good to work with.  Both series are
> > straight-forward and I do not expect them needing long fermentation.
> 
> Yikes, the conflicts with sb/more-repo-in-api is quite irritating.
> I think I'll postpone the later parts of this series and ask this to
> be sent after sb/more-repo-in-api matures a bit mroe.

There were several conflicts, but it was mostly just tedious textual
fixups. I pushed the result to:

  https://github.com/peff/git.git resolve-oid-more-repo

But I'm happy to wait and rebase if sb/more-repo-in-api is close to
graduating.

-Peff
