Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F598C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 10:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBEKJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 05:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBEKJP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 05:09:15 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EB1BAD1
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 02:09:13 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4P8lVC4qBvz5tlC;
        Sun,  5 Feb 2023 11:09:07 +0100 (CET)
Message-ID: <45830cf4-41c1-0bc1-3e4e-26b9f713f452@kdbg.org>
Date:   Sun, 5 Feb 2023 11:09:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/3] userdiff: Java updates
Content-Language: en-US
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        git@vger.kernel.org, Tassilo Horn <tsdh@gnu.org>
References: <877cwxvl3a.fsf@gnu.org>
 <20230204134329.251451-1-rybak.a.v@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20230204134329.251451-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.02.23 um 14:43 schrieb Andrei Rybak:
> On 04/02/2023 10:22, Tassilo Horn wrote:
>> Thanks for including me being the last contributor to java userdiff.
>> The patches look good from my POV and are safe-guarded with tests, so
>> I'm all for it.
> 
> Thank you for review!
> 
> I've realized that I've been writing modifiers "abstract" and "sealed" in a
> technically correct, but not the conventional order.  Here's a reroll with the
> order of modifiers following the style of original authors of
> https://openjdk.org/jeps/409.  It doesn't matter for the purposes of the test,
> but it will be less annoying to any future readers :-)

I've looked through the patches and run the tests, and they all make
sense to me. By just looking at the patch text I noted that no
whitespace between the identifier and the opening angle bracket is
permitted and whether it should be allowed, but the commit messages make
quite clear that whitespace is not allowed in this position. Hence:

Reviewed-by: Johannes Sixt <j6t@kdbg.org>

Thanks,
-- Hannes

