Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141E0C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC8D20789
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFSJUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:20:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:51560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFSJUi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 05:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 332BAACE1;
        Fri, 19 Jun 2020 09:20:36 +0000 (UTC)
Date:   Fri, 19 Jun 2020 11:20:35 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <bonzini@gnu.org>,
        git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests: do not use "slave branch" nomenclature
Message-ID: <20200619092035.GQ21462@kitsune.suse.cz>
References: <20200618163843.22181-1-bonzini@gnu.org>
 <20200618164554.GA616157@coredump.intra.peff.net>
 <xmqqwo44nt6m.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo44nt6m.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 11:08:01AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Jun 18, 2020 at 06:38:43PM +0200, Paolo Bonzini wrote:
> >
> >> From: Paolo Bonzini <pbonzini@redhat.com>
> >> 
> >> Git does not have slave branches and has never had.  Independent
> >> of any future change to the naming of branches, remove the sole
> >> appearance of the term.
> >
> > I think this is a sensible change, though note that something simpler
> > was proposed recently:
> >
> >   https://lore.kernel.org/git/20200610165441.iktvzuwz44sbytfg@chatter.i7.local/
> >
> > and the review suggested using a name that is even more meaningful to
> > the test case (so we not just remove the unwanted names, but make the
> > test easier to follow).
> 
> Thanks for spotting that both versions share the same issue.  We'd
> just need a single one that is fixed up ;-).
How about s/slave/feature/

This is about simulating some development happening on the new branch so
this name looks appropriate.

Thanks

Michal
