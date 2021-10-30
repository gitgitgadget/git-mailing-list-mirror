Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0FC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 15:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB9060724
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 15:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhJ3PTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 11:19:04 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:11386 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhJ3PTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 11:19:03 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mgq5v-0006Jj-Bg; Sat, 30 Oct 2021 16:16:31 +0100
Message-ID: <ae900419-39ca-10f6-8ff2-d278f1b8e2e0@iee.email>
Date:   Sat, 30 Oct 2021 16:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 0/8] Allow clean/smudge filters to handle huge files in
 the LLP64 data model
Content-Language: en-GB
To:     Johannes Schindelin <johannes.schindelin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
 <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <xmqqk0hvllxp.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2110292239170.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110292311200.56@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <nycvar.QRO.7.76.6.2110292311200.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 29/10/2021 22:12, Johannes Schindelin wrote:
> I am not aware of any other popular platform using the LLP64 data model,
> therefore I do not even think that these patches have to be fast-tracked
> into Git v2.34.0, next cycle would be good enough. Unless you are aware of
> other such platforms that do not rely on the Git for Windows fork, but on
> Git built from your repository?

I was under the impression that the original Raspberry Pi also used the
LLP64 model, or similar, and that had started of Torsten (tboegi) on the
extensive early work on this. I was just looking at the zlib parts
following the Git Merge.

Torsten was compiling for Rasbian (gcc (Raspbian 6.3.0-18+rpi1+deb9u1)
6.3.0 20170516)

Philip
