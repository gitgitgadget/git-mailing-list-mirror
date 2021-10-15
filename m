Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E967C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D3161181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhJOTmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:42:40 -0400
Received: from mta-11-4.privateemail.com ([198.54.127.104]:49780 "EHLO
        MTA-11-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbhJOTmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:42:37 -0400
X-Greylist: delayed 12389 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Oct 2021 15:42:37 EDT
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
        by mta-11.privateemail.com (Postfix) with ESMTP id D059818000A2;
        Fri, 15 Oct 2021 15:40:29 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.241])
        by mta-11.privateemail.com (Postfix) with ESMTPA id 56C7F18000A0;
        Fri, 15 Oct 2021 15:40:29 -0400 (EDT)
Date:   Fri, 15 Oct 2021 15:40:22 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v13 1/3] grep: refactor next_match() and
 match_one_pattern() for external use
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-Id: <ANA11R.PYDS58RTKWNU3@effective-light.com>
In-Reply-To: <xmqqk0ie5bpx.fsf@gitster.g>
References: <20211015161356.3372-1-someguy@effective-light.com>
        <K4711R.RVTNDQG3R0UQ3@effective-light.com>
        <Hamza Mahfooz's
        message of "Fri, 15 Oct 2021 14:24:20 -0400">
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 15 2021 at 12:28:42 PM -0700, Junio C Hamano 
<gitster@pobox.com> wrote:
> 
> Usually people do not want to spam the list with a multi-patch
> series when they have nothing new to show, unless there are other
> reasons to do so, like "there is no change, but I am sending it
> again because nobody seemed to have time reviewing the series the
> last time", in which case that would make a good explanation to put
> there.

I made changes to other patches in the series however, (I only document 
the changes if that patch in particular has changed.)


