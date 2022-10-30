Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F50ECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 21:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ3Vlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ3Vlt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 17:41:49 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C4AE56
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 14:41:47 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1opG3t-0005nO-BY;
        Sun, 30 Oct 2022 21:41:45 +0000
Message-ID: <c191963e-cd78-ae49-8fd6-9e974eea7469@iee.email>
Date:   Sun, 30 Oct 2022 21:41:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 0/1] extend the truncating pretty formats
Content-Language: en-GB
To:     GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
References: <20221030185614.3842-1-philipoakley@iee.email>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20221030185614.3842-1-philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/10/2022 18:56, Philip Oakley wrote:
> A recent enquiry on the Git-Users list 

forgot the link
https://groups.google.com/g/git-users/c/ayo_4Sy65TI/m/wRkmrcVWAQAJ

> asked for horizontal log graphs
> similar to those used in the manual ASCII art graphs. These use single
> or double character short strings for commits.
>
> The existing pretty pretty-formats are unable to truncate to single or
> double characters because of their use of ellipsis `..`. As a starter,
> let's add left and right hard truncation options to the existing
> options as a preparatory step for potential `--horizontal` graphs.
>
> It is noted that the  truncation options do not have any tests yet.
>
> Also cc'ing Nsengiyumva who has proposed to look at unifying the 
> ref-filter and --pretty formats [1]
>
> --
> Philip
>
> To: Git List <git@vger.kernel.org>
> Cc: NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
> Cc: Taylor Blau <me@ttaylorr.com>
> Cc: Junio C Hamano <gitster@pobox.com>
>
>
> [1] https://lore.kernel.org/git/CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com/
>
> Philip Oakley (1):
>   pretty-formats: add hard truncation, without ellipsis, options
>
>  Documentation/pretty-formats.txt |  7 ++++---
>  pretty.c                         | 18 +++++++++++++++++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
>

