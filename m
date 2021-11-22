Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2388CC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhKVWaN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 22 Nov 2021 17:30:13 -0500
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:49809 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhKVWaL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Nov 2021 17:30:11 -0500
Received: from MTA-14-4.privateemail.com (mta-14-1.privateemail.com [198.54.122.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 4003D80B2F
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:27:04 -0500 (EST)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
        by mta-14.privateemail.com (Postfix) with ESMTP id 0B1F118000A5;
        Mon, 22 Nov 2021 17:27:03 -0500 (EST)
Received: from [192.168.0.46] (unknown [10.20.151.210])
        by mta-14.privateemail.com (Postfix) with ESMTPA id D7BD2180009E;
        Mon, 22 Nov 2021 17:27:01 -0500 (EST)
Date:   Mon, 22 Nov 2021 17:26:51 -0500
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 2/2] ci: add a job for PCRE2
To:     =?iso-8859-1?b?xnZhciBBcm5mavZy8A==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?iso-8859-1?b?QmVs824=?= 
        <carenas@gmail.com>,
        =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Message-Id: <ROVZ2R.2MLACYZXFLRU@effective-light.com>
In-Reply-To: <211118.86h7c96885.gmgdl@evledraar.gmail.com>
References: <20211118084143.279174-1-someguy@effective-light.com>
        <20211118084143.279174-2-someguy@effective-light.com>
        <211118.86h7c96885.gmgdl@evledraar.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Thu, Nov 18 2021 at 11:32:50 AM +0100, Ævar Arnfjörð Bjarmason 
<avarab@gmail.com> wrote:
>> 
> Thanks a lot for following-up on this. Do you have a link to a sample
> run of this to see how it looks?

https://github.com/effective-light/git/actions/runs/1492352516
(it looks like the disable unicode case isn't worth considering, since 
it never runs through the tests successfully).

> But on closer inspection I should have said
> --{enable,disable}-unicode. Eyeballing the configure.ac in pcre2.git 
> now
> and checking if/how it passes our tests I think it might be a noop
> unless --enable-ebcdic is also in play, which we don't need to test.

Looks like ebcdic and unicode can't be enabled at the same time.

> Any reason for picking those specific versions? I think we do need to
> test on older than 10.31 (released in early 2018).

I chose them primarily because they were brought up on the other thread.


