Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8134520248
	for <e@80x24.org>; Mon,  4 Mar 2019 20:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCDUPa (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 15:15:30 -0500
Received: from smtp-4.orcon.net.nz ([60.234.4.59]:32776 "EHLO
        smtp-4.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDUPa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 15:15:30 -0500
X-Greylist: delayed 2489 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 15:15:29 EST
Received: from [150.107.172.103] (port=46807 helo=[192.168.20.103])
        by smtp-4.orcon.net.nz with esmtpa (Exim 4.86_2)
        (envelope-from <psainty@orcon.net.nz>)
        id 1h0tLa-0007ye-Mm; Tue, 05 Mar 2019 08:33:59 +1300
Subject: Re: [RFC PATCH 4/4] Add alias option to git branch
To:     Kenneth Cochran <kenneth.cochran101@gmail.com>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
 <7D21A788-5E38-466F-B3CC-F6A5CBEB2E2E@gmail.com>
 <D9CFD250-26D4-4D1F-B0CD-01E24E8606D9@gmail.com>
 <D4829D84-9192-4C7A-8487-0374DAFC324A@gmail.com>
 <C678086A-93E9-4F0B-AAAA-FBBBC27F2BFC@gmail.com>
 <CAJ145vUChd7+5QkmJsOK3bzZsudWfzZYp5wHZDzoq8SKSv0g0A@mail.gmail.com>
From:   Phil Sainty <psainty@orcon.net.nz>
Message-ID: <95defc95-c558-3487-d418-e65f7db5dda5@orcon.net.nz>
Date:   Tue, 5 Mar 2019 08:33:58 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ145vUChd7+5QkmJsOK3bzZsudWfzZYp5wHZDzoq8SKSv0g0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

5/03/19 5:23 AM, Kenneth Cochran wrote:
> Adding Phil for comments

Thank you for following this up, Kenneth.  I'll do some testing with
your patch sometime soon.

I've realised that the last version of my script that I posted to the
mailing list was buggy, and that in wanting to hold off sending another
version for a little while in case I found more bugs, I in fact failed
to send a fixed version at all.

This is probably not relevant to your patches; but just in case,
the up to date code for that script is here:

https://stackoverflow.com/a/23532744/324105

and the fixes since v1.11 were:

* Change incorrect uses of git show-ref, introduced by v1.10 (including
  effective regression of v1.08), to use git symbolic-ref instead.

* Fix the option handling for '--', and added it to the help text.


-Phil
