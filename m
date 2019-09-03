Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1AE1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 17:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfICRPP (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 13:15:15 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44401 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfICRPP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 13:15:15 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E03751C0003;
        Tue,  3 Sep 2019 17:15:13 +0000 (UTC)
Date:   Tue, 3 Sep 2019 22:45:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar
 appears
Message-ID: <20190903171511.cd6vwn4kz7bdpose@yadavpratyush.com>
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com>
 <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com>
 <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
 <CAKPyHN1GgXLy0+z=JbuyuSvVXsh6u5Po18OXizPNmfLE5AC00g@mail.gmail.com>
 <CAKPyHN3=QY4+XNhQPq09_PALFwfR5bWBs7q6m6LkfFoW-xeCug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN3=QY4+XNhQPq09_PALFwfR5bWBs7q6m6LkfFoW-xeCug@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/19 09:13PM, Bert Wesarg wrote:
> On Mon, Sep 2, 2019 at 9:03 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> >
[snip]
> > > On second thought, wouldn't it make more sense to expand the 
> > > commit
> > > message buffer instead? The point of resizing that pane is to see more
> > > of the commit message. So it makes more sense to make the commit message
> > > buffer take up all the vertical space, rather than making the scrollbar
> > > move.
> >
> > it is, I just broke that ;-)
> 
> is fixed in GitHub:
> 
>     wget https://github.com/bertwesarg/git-gui/commit/56163547604f44688e208393f8941efaf5247d40.patch

I tried the patch out. Works fine on Linux. Thanks.

There is a minor typo in your commit message.

> Sugestted-by: Birger Skogeng Pedersen <birger.sp@gmail.com>

s/Sugestted/Suggested/

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

One more observation:

If I write a particularly long line (and consequently the scrollbar 
becomes active), and then hit Ctrl+A to select all text, and then 
backspace to delete it all, the scrollbar does not get updated. It still 
shows the old position where is is "scrolled" halfway through. As soon 
as I type in any other character, it takes the correct state, and 
becomes disabled.

The vertical scrollbar behaves correctly in this scenario, and does take 
the correct state and position as soon as I delete all text, so I 
suspect it should be a small fix. Maybe a missed option or something 
like that?

-- 
Regards,
Pratyush Yadav
