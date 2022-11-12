Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F23EC4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 14:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKLOlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 09:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKLOlI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 09:41:08 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA61A3AD
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 06:41:05 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1otrgn-0006Ks-Er;
        Sat, 12 Nov 2022 14:40:58 +0000
Message-ID: <1675f68d-d3ae-6004-e2b1-a3bcec862264@iee.email>
Date:   Sat, 12 Nov 2022 14:40:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: What's cooking in git.git (Nov 2022, #02; Tue, 8)
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <Y2riRSL+NprJt278@nand.local>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Y2riRSL+NprJt278@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/11/2022 23:12, Taylor Blau wrote:
> --------------------------------------------------
> [Cooking]
> * po/pretty-hard-trunc (2022-11-02) 1 commit
>  - pretty-formats: add hard truncation, without ellipsis, options
>
>  Add a new pretty format which truncates without ellipsis.
>
>  Missing test coverage.
>  source: <20221102120853.2013-1-philipoakley@iee.email>
>
Hi Taylor,
 The summary should have been updated after v3, and we were looking for
a final review <Y2rPAGp96IwrLS1T@nand.local>.

I spotted some left-over comments at the test locations that needed QZ
space conversion in the here-docs, which have now been removed and a v4
submitted.

Philip
