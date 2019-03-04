Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD92620248
	for <e@80x24.org>; Mon,  4 Mar 2019 09:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCDJgC (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 04:36:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48014 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDJgB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 04:36:01 -0500
Received: from [IPv6:2a02:ab04:3b9:5e00::3] (2a02-ab04-03b9-5e00-0000-0000-0000-0003.dynamic.v6.chello.sk [IPv6:2a02:ab04:3b9:5e00::3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DCA89261176;
        Mon,  4 Mar 2019 09:35:59 +0000 (GMT)
Subject: Re: [PATCH 1/2] gitk: refresh the colour scheme
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
References: <20190226110535.29172-1-andrew.shadura@collabora.co.uk>
 <20190302230228.GA26937@blackberry>
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.shadura@collabora.co.uk; prefer-encrypt=mutual;
 keydata=
 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
 Ooa/yj03j5gtPgECL7c=
Organization: Collabora
Message-ID: <7e696805-4b80-cd26-aaaa-261a05ead964@collabora.co.uk>
Date:   Mon, 4 Mar 2019 10:35:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190302230228.GA26937@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03/2019 00:02, Paul Mackerras wrote:
> On Tue, Feb 26, 2019 at 12:05:34PM +0100, Andrej Shadura wrote:
>> The colours gitk is currently using are from the basic 16 colour
>> palette, and are a bit too intensive to be comfortable or pleasant
>> to work with.
>>
>> Adjust the main colours (commit nodes, remotes, tags and one branch
>> colour) to be slightly softer.
>>
>> Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
> 
> Thanks for the patch, but I disagree.  I do like the change you made
> to the tag colours, but the blue you have for the commit node circles
> is pretty blah.  That needs a more definite colour.

I see.

1) Would you accept the patch without that change?
2) What colour would you prefer (except the already existing one)?

> Also, the "too intensive to be comfortable or pleasant" in the commit
> message reflect a personal preference, and the way it is put seems to
> me to be too intensive to be comfortable or pleasant.

Hmm, sorry if that came across not the way I intended. I was trying to
formulate the thought in a way that would not be emotional or
subjective, but I guess the end result was exactly opposite.

-- 
Cheers,
  Andrej
