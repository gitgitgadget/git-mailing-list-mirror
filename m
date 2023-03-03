Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE8C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 23:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCCX7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 18:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCX7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 18:59:18 -0500
Received: from smtp1.phpwebhosting.com (smtp1.phpwebhosting.com [184.154.71.7])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 74DF3CA2C
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 15:59:16 -0800 (PST)
Received: (qmail 21961 invoked from network); 3 Mar 2023 23:59:17 -0000
Received: from unknown (HELO mailman.drmikehenry.com) (drmikehenry@drmikehenry.com@96.244.102.80)
        by smtp1.phpwebhosting.com with SMTP; Fri, 03 Mar 2023 18:59:17 -0500
Received: from [192.168.254.66] (casey.drmikehenry.com [192.168.254.66])
        by mailman.drmikehenry.com (Postfix) with ESMTP id E83FA1A0284;
        Fri,  3 Mar 2023 18:59:14 -0500 (EST)
Message-ID: <72e2af95-478d-4a15-d8cc-ce910cb7d520@drmikehenry.com>
Date:   Fri, 3 Mar 2023 18:59:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: `git bundle create -` may not write to `stdout`
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net> <xmqqv8jhcvrq.fsf@gitster.g>
From:   Michael Henry <git@drmikehenry.com>
In-Reply-To: <xmqqv8jhcvrq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/23 17:31, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
Jeff,

I'm not subscribed to the git mailing list (I thought it might
be too high volume for me), but I thought I'd be getting any
replies regarding my bug report.  For some reason, though,  I'm
not getting copied on any of the emails you've sent (from
peff@peff.net).  I am getting Junio's emails, but today was the
first time I'd seen a response.  I am able to see the
conversation via the archive at
https://marc.info/?l=git&m=167733032407411&w=2, so I've read
your responses there.

It looks like Junio is also making fast progress on this, and
I'm happy stand back and watch the magic happen this time.

Thanks,
Michael Henry

