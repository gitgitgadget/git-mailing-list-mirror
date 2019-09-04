Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6211F461
	for <e@80x24.org>; Wed,  4 Sep 2019 21:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfIDVjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 17:39:16 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63907 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfIDVjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 17:39:16 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46NxzQ4WhRz5tl9;
        Wed,  4 Sep 2019 23:39:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 24DB4104;
        Wed,  4 Sep 2019 23:39:14 +0200 (CEST)
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
 <20190904143055.11400-1-birger.sp@gmail.com>
 <510e80f4-a8e1-329d-2395-b1268bf7c1f8@kdbg.org>
 <CAGr--=LY4JWdms3GtnKAtN6z-2c-jpXE2HJ5_dMM5gEFayrj_g@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fcf52af1-dc57-fb58-f52c-7581910a28d6@kdbg.org>
Date:   Wed, 4 Sep 2019 23:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGr--=LY4JWdms3GtnKAtN6z-2c-jpXE2HJ5_dMM5gEFayrj_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.19 um 21:20 schrieb Birger Skogeng Pedersen:
> On Wed, Sep 4, 2019 at 8:59 PM Johannes Sixt <j6t@kdbg.org> wrote:
>> Many keyboards do not have a right Alt-key. That means that Alt+1 to
>> Alt+4 combinations must be typed single-handed with the left hand. This
>> is mildly awkward for Alt+4. Can we please have the very important
>> commit widget *not* at Alt+4? I could live with Alt+3.
> 
> (RightAlt wouldn't be used by Europeans, anyways)
> Are you suggesting to keep Alt+1/2/3 for the files/staged/diff
> widgets, but use something other than Alt+4 for the commit dialog? If
> so, which one would you prefer?

I was suggesting Alt+3 for the commit message widget, but my preferences
are actually Alt+1, Alt+2, Alt+3, in this order. My preference for the
diff widget would be Alt+4 (the awkward one) because I do not foresee
that I would use it a lot. Use what remains for the two file lists.

> The initial propsal from me was to use CTRL/CMD+1/2/3/4. What do you
> think of using the CTRL/CMD key instead of ALT?

I would not mind Ctrl instead of Alt. Take your pick.

-- Hannes
