Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D6D1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756414AbcLSQW7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:22:59 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:56032 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbcLSQW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 11:22:57 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1cJ0iG-0003s5-FA; Mon, 19 Dec 2016 16:22:56 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22616.2400.364518.636144@chiark.greenend.org.uk>
Date:   Mon, 19 Dec 2016 16:22:56 +0000
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] git check-ref-format --stdin --report-errors
In-Reply-To: <561c0338-66cd-f806-7b3b-b422f98a1564@alum.mit.edu>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
        <561c0338-66cd-f806-7b3b-b422f98a1564@alum.mit.edu>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty writes ("Re: [PATCH 0/5] git check-ref-format --stdin --report-errors"):
> Thanks for your patches. I left some comments about the individual patches.

Thanks for your review.

> I don't know whether this feature will be popular, but it's not a lot of
> code to add it, so it would be OK with me.

Great.

> Especially given that the output is not especially machine-readable, it
> might be more consistent with other commands to call the new feature
> `--verbose` rather than `--report-errors`.

Sure.

> If it is thought likely that scripts will want to leave a pipe open to
> this command and feed it one query at a time, then it would be helpful
> to flush stdout after each reference's result is written. If the
> opposite use case is common (mass processing of refnames), we could
> always add a `--buffer` option like the one that `git cat-file --batch` has.

I think it should be unbuffered by default, so I will make that
change, along with the fixes from your other mails, and resubmit.

Regards,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
