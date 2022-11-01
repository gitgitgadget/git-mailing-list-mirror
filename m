Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39623C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiKAXIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiKAXGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:06:17 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F06209BA
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:53 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oq0KO-000AZZ-9t;
        Tue, 01 Nov 2022 23:05:52 +0000
Message-ID: <95cf6a8c-2f51-a79f-2270-82f0c3e1cea7@iee.email>
Date:   Tue, 1 Nov 2022 23:05:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/1] pretty-formats: add hard truncation, without
 ellipsis, options
To:     GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
References: <20221030185614.3842-1-philipoakley@iee.email>
 <20221101225724.2165-1-philipoakley@iee.email>
 <20221101225724.2165-2-philipoakley@iee.email>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20221101225724.2165-2-philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/11/2022 22:57, Philip Oakley wrote:
> Instead of replacing with "..", replace with the empty string "",
> having adjusted the padding length calculation.
>
> Needswork:
> There are no tests for these pretty formats, before or after
> this change.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
Doh. Too busy doing code and text fixup!'s  to notice the commit message
needed  a tweak.

It's late already so that'll be tomorrow.

Philip
