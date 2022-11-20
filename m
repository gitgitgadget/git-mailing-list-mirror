Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184C0C433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 17:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKTRms (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTRmr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 12:42:47 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C6413CCE
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 09:42:45 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1owoL4-00059k-G4;
        Sun, 20 Nov 2022 17:42:43 +0000
Message-ID: <8791cb85-cf4a-4302-5c1a-54a7e7766cfb@iee.email>
Date:   Sun, 20 Nov 2022 17:42:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Looking for a review (pretty-formats, hard truncation), was What's
 cooking in git.git (Nov 2022, #04; Fri, 18))
Content-Language: en-GB
To:     git@vger.kernel.org
References: <Y3g95OYdwzq2OP3z@nand.local>
From:   Philip Oakley <philipoakley@iee.email>
Cc:     Taylor Blau <me@ttaylorr.com>
In-Reply-To: <Y3g95OYdwzq2OP3z@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping, Hopefully an easy single patch review for someone on-list.

Patch [v4] itself:
https://lore.kernel.org/git/20221112143616.1429-1-philipoakley@iee.email/

Available at: https://github.com/ttaylorr/git/tree/po/pretty-hard-trunc

On 19/11/2022 02:22, Taylor Blau wrote:
> --------------------------------------------------
> [Cooking]
>
> * po/pretty-hard-trunc (2022-11-13) 1 commit
>  - pretty-formats: add hard truncation, without ellipsis, options
>
>  Add a new pretty format which truncates without ellipsis.
>
>  Waiting for review.
>  source: <20221112143616.1429-1-philipoakley@iee.email>

Potential review points:

Is the commit message sufficient?
Are the tests: Sufficient,  Complete, Correct ?
Is `qz_to_tab_space` conversion applied correctly?

--
Philip
