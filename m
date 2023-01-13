Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42ABC67871
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjAMP7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjAMP6U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 10:58:20 -0500
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D1C4D4BA
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 07:50:06 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id F4101260114;
        Fri, 13 Jan 2023 16:50:04 +0100 (CET)
Message-ID: <6061d012-13b7-ca4b-5556-70875b65c887@selasky.org>
Date:   Fri, 13 Jan 2023 16:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230113154516.jxm2cer4sogatayp@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 16:45, Konstantin Ryabitsev wrote:
> I think you're misunderstanding some of the core principles of git.

Maybe, I'm usually commandering git via the terminal.

But if you say you can already edit stuff, why does the commit hash need 
to be cryptographic? I don't get that part. Yeah, I think of git commits 
like blockchain.

--HPS
