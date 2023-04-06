Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D792C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 13:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDFNME (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDFNMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 09:12:03 -0400
Received: from mail.zombino.com (c2.zombino.com [65.108.93.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42E123
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 06:11:57 -0700 (PDT)
Received: from [10.168.4.122] (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id 8FEFA3E802;
        Thu,  6 Apr 2023 13:11:55 +0000 (UTC)
Message-ID: <2da9d073-874b-b2b4-8e4a-8ee2254c69b7@zombino.com>
Date:   Thu, 6 Apr 2023 15:11:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: git clone of empty repositories doesn't preserve hash
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g> <xmqq355euj2i.fsf@gitster.g>
From:   Adam Majer <adamm@zombino.com>
In-Reply-To: <xmqq355euj2i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/23 23:15, Junio C Hamano wrote:
> Subject: [PATCH] clone: propagate object-format when cloning from void
> 

Thank you, this fixes this issue.

- Adam
