Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D6C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 07:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjAPHYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 02:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjAPHX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 02:23:58 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480EAC657
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 23:23:57 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id A355A260D52;
        Mon, 16 Jan 2023 08:23:55 +0100 (CET)
Message-ID: <3b0af57c-a144-b0e4-d353-6028b3939291@selasky.org>
Date:   Mon, 16 Jan 2023 08:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
 <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/23 00:59, brian m. carlson wrote:
> However, Git is moving in the direction of stronger cryptographic
> algorithms, rather than insecure hashing algorithms.  I don't think your
> proposal is a good idea, nor do I think it's likely to be adopted.

I disagree. There is no need for signing in a version control system. It 
just makes it harder to change things, like the right-to-repair. In my 
eyes there is a high chance of abuse, by vendors that do no want others 
to flash or edit their device firmwares.

--HPS
