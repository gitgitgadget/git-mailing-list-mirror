Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92737C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5CE2068D
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 18:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbgFISLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:11:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:38683 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388615AbgFISLC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 14:11:02 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49hJ8F4qDtz5tlB;
        Tue,  9 Jun 2020 20:10:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A094816AB;
        Tue,  9 Jun 2020 20:10:52 +0200 (CEST)
Subject: Re: Rename offensive terminology (master)
To:     Simon Pieters <simon@bocoup.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
 <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <448e4f49-d1f8-94df-4fc7-64cd024e668f@kdbg.org>
Date:   Tue, 9 Jun 2020 20:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.06.20 um 18:02 schrieb Junio C Hamano:
> so it might be the matter of teaching "git
> init" (it uses 'master' by default) and "git clone" (it tries to use
> the name of the branch the HEAD at origin points at,...

Don't forget the special treatment of "master" in fmt-merge-msg.c that
skips the " into 'foo'" part of  "Merge branch 'bar'".

-- Hannes
