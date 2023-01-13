Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2519C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjAMQ0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjAMQZD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:25:03 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211EC82F4F
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:18:42 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 5994B260BB4;
        Fri, 13 Jan 2023 17:18:40 +0100 (CET)
Message-ID: <5971b434-6409-8fd6-130f-f5b871a10f6d@selasky.org>
Date:   Fri, 13 Jan 2023 17:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
 <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
 <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
In-Reply-To: <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 17:06, Hans Petter Selasky wrote:
> What's the point? Only so that one party can stay in control?

Let me phrase it like this:

You clearly believe in the zero-trust principle. I don't.

Why can't git support both beliefs, and it can be configurable somehow then?

--HPS
