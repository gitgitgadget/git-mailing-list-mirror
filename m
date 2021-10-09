Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E42C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41A160F22
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 15:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhJIPyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 11:54:05 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:40064 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234428AbhJIPyF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Oct 2021 11:54:05 -0400
Received: from MTA-11-4.privateemail.com (mta-11-1.privateemail.com [198.54.118.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id E0CA9800B0
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 11:52:07 -0400 (EDT)
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
        by mta-11.privateemail.com (Postfix) with ESMTP id B8B5C18000A5;
        Sat,  9 Oct 2021 11:52:06 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.229])
        by mta-11.privateemail.com (Postfix) with ESMTPA id 0FBA118000A4;
        Sat,  9 Oct 2021 11:52:05 -0400 (EDT)
Date:   Sat, 09 Oct 2021 11:52:00 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v11 3/3] grep: fix an edge case concerning ascii patterns
 and UTF-8 data
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?b?xnZhciBBcm5mavZy8A==?= Bjarmason 
        <avarab@gmail.com>
Message-Id: <O2WP0R.U0CLDS9323JP1@effective-light.com>
In-Reply-To: <xmqqlf32g0jl.fsf@gitster.g>
References: <20211007203148.23888-1-someguy@effective-light.com>
        <20211007203148.23888-3-someguy@effective-light.com>
        <xmqqlf32g0jl.fsf@gitster.g>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 8 2021 at 11:44:14 PM -0700, Junio C Hamano 
<gitster@pobox.com> wrote:
> These lines are flagged as an error by test-lint; I've queued this
> on top to make today's integration result to pass our tests.

I fixed this issue in v12 [1] btw.

[1] 
https://lkml.kernel.org/r/20211008224918.603392-3-someguy@effective-light.com


