Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C5EC64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCDKIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCDKIG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:08:06 -0500
Received: from smtp1.phpwebhosting.com (smtp1.phpwebhosting.com [184.154.71.7])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 007D8CA09
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:08:04 -0800 (PST)
Received: (qmail 10087 invoked from network); 4 Mar 2023 10:08:06 -0000
Received: from unknown (HELO mailman.drmikehenry.com) (drmikehenry@drmikehenry.com@96.244.102.80)
        by smtp1.phpwebhosting.com with SMTP; Sat, 04 Mar 2023 05:08:06 -0500
Received: from [192.168.254.66] (casey.drmikehenry.com [192.168.254.66])
        by mailman.drmikehenry.com (Postfix) with ESMTP id 8F9371A1B0A;
        Sat,  4 Mar 2023 05:08:03 -0500 (EST)
Message-ID: <27ae765a-f545-0c0c-706f-c4fb52a97958@drmikehenry.com>
Date:   Sat, 4 Mar 2023 05:08:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: `git bundle create -` may not write to `stdout`
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net> <xmqqv8jhcvrq.fsf@gitster.g>
 <72e2af95-478d-4a15-d8cc-ce910cb7d520@drmikehenry.com>
 <ZAKrd3vWyRxX3ZJ/@coredump.intra.peff.net>
From:   Michael Henry <git@drmikehenry.com>
In-Reply-To: <ZAKrd3vWyRxX3ZJ/@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/23 21:22, Jeff King wrote:
> The problem is that your server supports TLS, but only TLS
> v1.0.

That's good information; I hadn't realized that about my email
provider.

> I relaxed the settings on my server, so you should have gotten
> a flurry of deliveries (including this one). But you might run
> into delivery problems from other people at some point.

Thanks very much for the pointer; I'll definitely look into
getting this fixed.  This is an unexpected side benefit of
posting to the Git mailing list :-)

Michael Henry

