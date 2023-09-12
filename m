Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E37EE3F00
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjILRtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjILRtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:49:06 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75696C1
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:49:02 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1694540940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IoICmtr1oEqS2Wdq2bQLhi+DAh+sqIJ4qLKG5F/Lpc=;
        b=xVLyv0tRlsY4Hvt9zWuVEfhdUWw271OV6F9kY4JEz/jbk4xGBH9Dyr8U+winoYhloESsvO
        /C/yvhtPJoblxCHYmZHbZr2LAe9+UspBJMnyLptEL8vc/UxFx0KH6UHSol2wP0frpx0Vlh
        E4sjwgMkM3KJAcV9KRp8C0JoHwk19UYhqAGVNLiCH00k9tYJxtwcZQ7Z794ekJE3r+eVSv
        QS4agElUuAzSsPhIsv8woAaA8qPcEwuqghZ1UXg5WYaygT8HPPpULanZAl4zHrdg2P4A3L
        1DqS5/apt5Xjd5yR0GO12yocsX1+8Bpj/tolNCdAVu7Ub9gM7I3CPLgE0kwe9w==
Date:   Tue, 12 Sep 2023 19:48:59 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff --stat: add config option to limit filename width
In-Reply-To: <xmqqbke7pb8z.fsf@gitster.g>
References: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>
 <xmqqil8gs3s0.fsf@gitster.g> <487bd30e5a4cdcea8697393eb36ce3f3@manjaro.org>
 <xmqqbke7pb8z.fsf@gitster.g>
Message-ID: <6d286618ef9ad3824c4c40211557bfe7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-12 19:11, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>> Someday, as a follow-up after the dust from this topic settles, we
>>> would probably want to look at how these rev.diffopt.* members are
>>> initialized and refactor the common code out to a helper.  It would
>>> allow us to instead of doing this ...
>> 
>> Another good point.  If you agree, I'd prefer to have my patch
>> accepted and merged as-is, ...
> 
> That is exactly what I meant by "follow-up after the dust settles".
> 
> All of the "we should probably do this and that in the future" are
> called #leftoverbits comments.  Food for thought, something people
> can use to find inspiration for areas they may want to work on, that
> has no impact to how "complete" the current patch being discussed
> is.

Sounds great, thank you.  I already have a couple of code cleanups to 
work on, which I'll do in the following days and send the patches.
