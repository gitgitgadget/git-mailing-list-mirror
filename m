Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62985C433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 23:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiDDXdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiDDXdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 19:33:06 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936474C408
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 16:31:07 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 234NV5HG001670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Apr 2022 19:31:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Neeraj Singh'" <nksingh85@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqilropo3z.fsf@gitster.g> <20220404232014.GA75@neerajsi-x1.localdomain>
In-Reply-To: <20220404232014.GA75@neerajsi-x1.localdomain>
Subject: RE: ns/batch-fsync (Mon Apr 4, 2022)
Date:   Mon, 4 Apr 2022 19:31:00 -0400
Organization: Nexbridge Inc.
Message-ID: <034a01d8487c$0e067b40$2a1371c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHgz8MBZJf3S/CuZmv3EZ4jEckt8gHVGvnBrMCvirA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 4, 2022 7:20 PM, Neeraj Singh wrote:
>On Mon, Apr 04, 2022 at 01:53:04PM -0700, Junio C Hamano wrote:
>> * ns/batch-fsync (2022-03-30) 14 commits
>>  - core.fsyncmethod: performance tests for batch mode
>>  - t/perf: add iteration setup mechanism to perf-lib
>>  - core.fsyncmethod: tests for batch mode
>>  - test-lib-functions: add parsing helpers for ls-files and ls-tree
>>  - core.fsync: use batch mode and sync loose objects by default on
>> Windows
>>  - unpack-objects: use the bulk-checkin infrastructure
>>  - update-index: use the bulk-checkin infrastructure
>>  - builtin/add: add ODB transaction around add_files_to_cache
>>  - cache-tree: use ODB transaction around writing a tree
>>  - core.fsyncmethod: batched disk flushes for loose-objects
>>  - object-file: pass filename to fsync_or_die
>>  - bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
>>  - bulk-checkin: rename 'state' variable and separate 'plugged'
>> boolean
>>  - Merge branch 'ns/core-fsyncmethod' into ns/batch-fsync
>>
>>  Introduce a filesystem-dependent mechanism to optimize the way the
>> bits for many loose object files are ensured to hit the disk  platter.
>>
>>  Will merge to 'next'?
>>  source: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
>
>Please expect a reroll today to address the remaining issues in that
thread.

Does this relate to why I cannot compile with the new fsync code at
2.36.0-rc0?

