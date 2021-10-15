Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF12C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FAE60FE3
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbhJOS0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 14:26:37 -0400
Received: from mta-05-3.privateemail.com ([68.65.122.15]:39159 "EHLO
        MTA-05-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJOS0g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 14:26:36 -0400
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id 2B6E718000AA;
        Fri, 15 Oct 2021 14:24:28 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.231])
        by mta-05.privateemail.com (Postfix) with ESMTPA id 8BC8018000AD;
        Fri, 15 Oct 2021 14:24:27 -0400 (EDT)
Date:   Fri, 15 Oct 2021 14:24:20 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v13 1/3] grep: refactor next_match() and
 match_one_pattern() for external use
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-Id: <K4711R.RVTNDQG3R0UQ3@effective-light.com>
In-Reply-To: <xmqqwnme5fkr.fsf@gitster.g>
References: <20211015161356.3372-1-someguy@effective-light.com>
        <Hamza
        Mahfooz's message of "Fri, 15 Oct 2021 12:13:54 -0400">
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 15 2021 at 11:05:24 AM -0700, Junio C Hamano 
<gitster@pobox.com> wrote:
> Makes readers curious what happend in v11 and later...

It was my understanding that no comment means nothing changed since 
then, or is something to the effect of "no changes" preferable?


