Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9D9C43219
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 09:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbiDEJyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349212AbiDEJt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:27 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D2122B10
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 02:42:44 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nbfhy-0007sT-C0;
        Tue, 05 Apr 2022 10:42:42 +0100
Message-ID: <8622e48c-9f34-c644-4016-02c3795ac1e9@iee.email>
Date:   Tue, 5 Apr 2022 10:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] blame: report correct number of lines in progress when
 using ranges
Content-Language: en-GB
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        gitster@pobox.com, whydoubt@gmail.com, git@vger.kernel.org
References: <20220404182129.33992-1-eantoranz@gmail.com>
 <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/04/2022 08:34, Bagas Sanjaya wrote:
> On 05/04/22 01.21, Edmundo Carmona Antoranz wrote:
>> When using ranges, use their sizes as the limit for progress
>> instead of the size of the full file.
>>
>
> The progress limit is defined by number of affected lines, right?

I'd also wondered about 'their', thinking it was 'the files', rather
than 'the ranges' [within those files].

perhaps: s/their/range/  

"When using ranges, use the range sizes as the limit for progress' ..

or maybe 'total range size'.
--
Philip
