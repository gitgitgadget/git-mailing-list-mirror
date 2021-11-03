Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9ECC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 06:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637F161139
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 06:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhKCGed (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 02:34:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:64546 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhKCGed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 02:34:33 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4HkcPQ59Z0z5tlB;
        Wed,  3 Nov 2021 07:31:54 +0100 (CET)
Subject: Re: [PATCH v4 0/8] Allow clean/smudge filters to handle huge files in
 the LLP64 data model
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
 <20211102214615.sflg5xgztdzrb27l@tb-raspi4>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d9c537e6-de37-5cf5-a595-7a61b8df20a3@kdbg.org>
Date:   Wed, 3 Nov 2021 07:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211102214615.sflg5xgztdzrb27l@tb-raspi4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.11.21 um 22:46 schrieb Torsten Bögershausen:
> On Tue, Nov 02, 2021 at 03:46:03PM +0000, Johannes Schindelin via GitGitGadget wrote:
> 
> I could not convince my raspi to apply patch 7/8:
> 
>   git am </tmp/7
>   Applying: odb: guard against data loss checking out a huge file
>   error: patch failed: object-file.c:1344
>   error: object-file.c: patch does not apply
>   Patch failed at 0001 odb: guard against data loss checking out a huge file
>   hint: Use 'git am --show-current-patch=diff' to see the failed patch
>   When you have resolved this problem, run "git am --continue".
>   If you prefer to skip this patch, run "git am --skip" instead.
>   To restore the original branch and stop patching, run "git am --abort".
> 
> I am not sure, what went wrong. I can retry the next days - or is this
> branch/series somewhere available ?

This was submitted via Gitgitgadget. Therefore, the cover letter
that you are responding to has these footers:

> base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1068%2Fdscho%2Fhuge-file-smudge-clean-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1068/dscho/huge-file-smudge-clean-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1068

-- Hannes
