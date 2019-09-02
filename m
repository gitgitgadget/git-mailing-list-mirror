Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03901F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfIBSMS (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:12:18 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54479 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfIBSMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:12:17 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 760CBC0002;
        Mon,  2 Sep 2019 18:12:15 +0000 (UTC)
Date:   Mon, 2 Sep 2019 23:42:13 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar
 appears
Message-ID: <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com>
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/19 07:04PM, Birger Skogeng Pedersen wrote:
> Hi Bert,
> 
> 
> Thanks for picking this up.
> I just gave your patch a go, and I think there are a couple of issues.
> 
> 
> Applying the patch yields:
> 
> $ git apply patch1.patch
> patch1.patch:18: indent with spaces.
>        -yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set} \
> patch1.patch:19: indent with spaces.
>        -xscrollcommand {.vpane.lower.commarea.buffer.sbx set}
> patch1.patch:21: indent with spaces.
>        -orient vertical \
> patch1.patch:24: indent with spaces.
>        -orient horizontal \
> patch1.patch:25: indent with spaces.
>        -command [list $ui_comm xview]
> warning: git-gui.sh has type 100644, expected 100755
> error: patch failed: git-gui.sh:3363
> error: git-gui.sh: patch does not apply
 
It applied fine for me. I got the patch from Bert's GitHub since he said 
he is "unable to send patches per mail". You can run

  wget https://github.com/bertwesarg/git-gui/commit/0bfa0645127c8242a260f1dfe45d7d4c310fa868.patch

to get the .patch file, and then apply that. Maybe his email client 
messed up somewhere, and that's why your patch has whitespace problems.

> Replacing the spaces with tabs before applying, I notice the
> horisontal scrollbar appears to be "outside" of the text input area.
> And it doesn't follow the height of the commit message text input
> area.
> Here's a screenshot: https://i.imgur.com/721axUX.png
 
Hmm, it looks fine for me. Which platform are you using? I am running it 
on Linux. Screenshot: https://imgur.com/sNp5Ktq

-- 
Regards,
Pratyush Yadav
