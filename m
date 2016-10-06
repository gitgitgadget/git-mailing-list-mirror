Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47001F4F8
	for <e@80x24.org>; Thu,  6 Oct 2016 04:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbcJFEBQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 00:01:16 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48248 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750999AbcJFEBP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Oct 2016 00:01:15 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Oct 2016 00:01:15 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 745F9208E6;
        Wed,  5 Oct 2016 23:55:13 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 05 Oct 2016 23:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=fadxCtahWP8be2K
        Axn4RaY3rWds=; b=ZVIl90jU/fQdKaoZX7RK72qI0nrQw4sQSzeAz3TY1UjgqCk
        SsRGmAYmK1kcicLjga8pgep/yD7dGLYfTgOfi0qEdFVzdj6yfIXiD3dfo0QzHxHq
        y6Vu/dT+eCtxFQ0CgWsaZpNpKACE2xOZ/gN5t9q/fg2U6u0hboTlQfXOeus4=
X-Sasl-enc: Q2nZu/NjCoHa+xOyUSjBU5mSIeuMHAqCOV6FyaT1+Vpa 1475726112
Received: from [192.168.1.72] (unknown [113.53.200.161])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B308F29D2;
        Wed,  5 Oct 2016 23:55:12 -0400 (EDT)
Subject: Re: Setting pager.add=true breaks add --patch
To:     Anatoly Borodin <anatoly.borodin@gmail.com>
References: <e8bdb434-432b-57c6-5cb4-283aca08ab0b@hale.ee>
 <CACNzp2kd6wdE6pGsb5d5+cvkJa9M-gzG+5=oLhZr9dLn4o8gOQ@mail.gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
From:   Tom Hale <tom@hale.ee>
Message-ID: <829bc648-dd9a-d166-c36e-3ad1508f0ba5@hale.ee>
Date:   Thu, 6 Oct 2016 10:55:11 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CACNzp2kd6wdE6pGsb5d5+cvkJa9M-gzG+5=oLhZr9dLn4o8gOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-10-03 00:00, Anatoly Borodin wrote:
> I've reported this one bug recently:
>
> https://public-inbox.org/git/nrmbrl$hsk$1@blaine.gmane.org/
>
> The developers know about it, but it will require some deeper refactoring.

Thanks Anatoly for reporting this.

[Meta] All: For updates, is there an issue I can watch, or a way to 
subscribe/monitor only this one thread?

-- 
Cheers,
Tom
