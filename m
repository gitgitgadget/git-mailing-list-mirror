Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBF8C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741E0206F2
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 09:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgC0JMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:12:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:53334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726193AbgC0JMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 05:12:07 -0400
Received: (qmail 10054 invoked by uid 109); 27 Mar 2020 09:12:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Mar 2020 09:12:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23355 invoked by uid 111); 27 Mar 2020 09:22:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2020 05:22:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Mar 2020 05:12:06 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/5] Enable GPG in the Windows part of the CI/PR builds
Message-ID: <20200327091206.GB610157@coredump.intra.peff.net>
References: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 03:35:23PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Changes since v2:
> 
>  * Reordered 4/5 before 3/5, as I had intended originally.
>    
>    
>  * Renamed _trace_level to have a trailing underscore, in line with the
>    surrounding code.
>    
>    
>  * Added a note to the commit message why only lib-gpg.sh loses its
>    hash-bang line, and no other files in t/.

Thanks, this version looks fine to me. I left a few other comments
regarding exit/return in the other part of the thread, but frankly all
of it is too arcane and insignificant to spend more brain cycles going
back and forth on.  So if I convinced/inspired you on that point, feel
free to switch it, but otherwise I'm happy with this iteration.

-Peff
