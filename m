Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB14C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 15:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjAMPX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjAMPXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 10:23:01 -0500
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D79C10F6
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 07:15:33 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 7F38C26097C;
        Fri, 13 Jan 2023 16:15:32 +0100 (CET)
Message-ID: <ba5f35d2-1c94-9216-6676-d845c73ad6c3@selasky.org>
Date:   Fri, 13 Jan 2023 16:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <009701d9275a$678416b0$368c4410$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 15:21, rsbecker@nexbridge.com wrote:
> Signed content will no longer be verifiable. The whole Merkel Tree representing the commit history becomes easily corruptible by hackers

Hi,

As a long time open sourcer and hacker, I'm totally against signing 
software. Is the GIT project going to build the new infrastructure for 
John-Deers new tractor firmware adventure? It is totally against the 
values of open source craftmanship.

I don't think any of you crypto-enthusiasts understand how propritary 
companies use signed software to keep their power intact.

That's also an argument for using a non-crypto hash.

--HPS
