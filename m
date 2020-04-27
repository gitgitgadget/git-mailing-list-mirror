Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A49C81857
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832A92078C
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD0V4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:56:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:52428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD0V4H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 17:56:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2F66AD10;
        Mon, 27 Apr 2020 21:56:04 +0000 (UTC)
Date:   Mon, 27 Apr 2020 23:56:04 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200427235604.226e9561@naga.burning-in.hell>
In-Reply-To: <xmqqlfmg7hn7.fsf@gitster.c.googlers.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <xmqqv9lod85m.fsf@gitster.c.googlers.com>
        <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
        <xmqq8sikblv2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
        <20200427200852.GC1728884@coredump.intra.peff.net>
        <xmqqlfmg7hn7.fsf@gitster.c.googlers.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 27 Apr 2020 14:17:32 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think what I'm suggesting is not all that different from this, except
> > that I'd suspect "next" would not get enough exposure. So in my mind
> > merging to master is not so much "hooray, we now have visual studio
> > support" but rather the first step in getting data. But we'd have to be
> > very clear about how the project regards the cmake support: it's there
> > for now, you're encouraged to play with it, but don't be upset if it
> > needs some coaxing to behave like the normal Makefile or if it goes away
> > in the future.  
> 
> I think you said almost everything I would have said.  
> 
> If we were to adopt it as an experiment, hoping to gain exposure,
> nothing above 'master' (or tagged releases) won't work.  And once a
> thing is in 'master', users will ignore the "this is merely an
> experiment" warning and expect it to be fully functional and usable.
> 
> Given the observation in the thread that it would take a fairly
> recent version to benefit platform-agnostic usability features, I
> did not get an impression that it is ready to be anywhere near that,
> not even ready for 'next'.  It is *not* like "Sibi's patches were
> bad but they can become ready with further polishing".  The
> impression I got was that the large part of why it is not ready is
> because it needs time for larger set of distros to adopt more recent
> versions of cmake.
> 
Why do you need distros to adopt more recent versions of cmake?

The cmake support is mainly for VS and you can install current version
of cmake with VS, there is no distro there. It can also work on
distros with recent cmake but that's not really the goal so it's not a
problem if many distros don't work.

Thanks

Michal
