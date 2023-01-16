Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D0C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 09:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjAPJ4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 04:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjAPJzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 04:55:36 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA916AC0
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 01:55:35 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id CCA662601AC;
        Mon, 16 Jan 2023 10:55:33 +0100 (CET)
Message-ID: <6a398405-e5f8-0b78-e463-41d79e49e78b@selasky.org>
Date:   Mon, 16 Jan 2023 10:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
 <20230115135245.GB16547@kitsune.suse.cz>
 <b1984123-569a-c290-8048-158c1c5e08b4@selasky.org>
 <20230116091346.GC16547@kitsune.suse.cz>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230116091346.GC16547@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/16/23 10:13, Michal Suchánek wrote:
> when that data is copied to a new location a new
> CRC is calculated that can detect an error in that location.

Yes, that is correct, but what is "copying data"? Are you saying that 
copying data is always error free?

--HPS
