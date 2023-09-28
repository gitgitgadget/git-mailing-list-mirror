Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400ABE743C0
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 20:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjI1Ufe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1Ufd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 16:35:33 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105319C
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 13:35:31 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1695933329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uTrxjq9enkp3vMojvCKt0AtnLiRjhtwPoAOp8Ps9oFk=;
        b=reoct1KzEa2FHTz92LzsOXjB5gk2kItMw38tFLoqlWfbvHqeHvboIGmXwXjp8EjWYNeQ5C
        huCQfWB74a8/PhYVy09EarZuCDfLZGSeeXSss57YERl3hUYWRKTeNL9izKpK7TwSRnFNif
        148rC8bu8Q9K3yyrCNo1+bM/pudFrHRSf5a+sW7f9Q9R5HU/goNZMmA0311x3rUV+E9A72
        Swetl23quqErTiZoG+ub3ULJHClN8ev8yTyJ4LOgpgNLxrfzqtzw2EZbcqZ5n5syg3F9EY
        1+J1kavvLlxBtQhKP4hWRjtzJIGAt2XXafONT++tdktgjY2TGnW4FldQAtFfHQ==
Date:   Thu, 28 Sep 2023 22:35:28 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff --stat: set the width defaults in a helper
 function
In-Reply-To: <xmqq7coajb6a.fsf@gitster.g>
References: <d45d1dac1a20699e370905b88b6fd0ec296751e7.1695441501.git.dsimic@manjaro.org>
 <0570bd5c26caef1ff66a643558305fb0@manjaro.org> <xmqq7coajb6a.fsf@gitster.g>
Message-ID: <69302fd3955f12f282a579d57143e5ed@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-28 22:27, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Just a brief reminder about version 2 of this patch...
> 
> It still is a bit premature to queue this before the topic, to which
> this is a clean-up for, graduates to the 'master' branch, though.

Oh, I agree, thanks.  Actually, I just wanted to check with you does the 
version 2 of this patch require any further cleanups or improvements?
