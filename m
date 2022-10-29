Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A998FC38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 16:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ2QtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ2QtU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 12:49:20 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4378764E1
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 09:49:20 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oop1K-000BgW-5j;
        Sat, 29 Oct 2022 17:49:19 +0100
Message-ID: <52434e09-9da9-e9f8-dad6-7e9121149919@iee.email>
Date:   Sat, 29 Oct 2022 17:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: What's cooking in git.git (Oct 2022, #08; Fri, 28)
Content-Language: en-GB
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <xmqqy1szef49.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqy1szef49.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/2022 23:51, Junio C Hamano wrote:
> --------------------------------------------------
> [Cooking]
> * po/glossary-around-traversal (2022-10-22) 3 commits
>  - glossary: add reachability bitmap description
>  - glossary: add "commit graph" description
>  - doc: use 'object database' not ODB or abbreviation
>
>  The glossary entries for "commit-graph file" and "reachability
>  bitmap" have been added.
>
>  Expecting a (hopefully final) reroll.
>  cf. <746491f4-fb41-92fe-7360-20a845dc21fc@iee.email>
>  source: <20221022222539.2333-1-philipoakley@iee.email>

I've just sent in my re-roll at [1], which should show on list and
GitLore shortly. It's been a while coming. There is one extra patch to
use commit-graph (hyphen) consistently.

Philip

[1] <20221029164112.2097-1-philipoakley@iee.email>
