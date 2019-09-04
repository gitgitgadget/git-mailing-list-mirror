Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F501F461
	for <e@80x24.org>; Wed,  4 Sep 2019 22:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfIDWfP (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 18:35:15 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41847 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDWfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 18:35:14 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2C85CFF808;
        Wed,  4 Sep 2019 22:35:11 +0000 (UTC)
Date:   Thu, 5 Sep 2019 04:05:09 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar
 appears
Message-ID: <20190904223508.lmima7iv4pbbhg3z@yadavpratyush.com>
References: <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com>
 <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com>
 <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
 <CAKPyHN1GgXLy0+z=JbuyuSvVXsh6u5Po18OXizPNmfLE5AC00g@mail.gmail.com>
 <CAKPyHN3=QY4+XNhQPq09_PALFwfR5bWBs7q6m6LkfFoW-xeCug@mail.gmail.com>
 <20190903171511.cd6vwn4kz7bdpose@yadavpratyush.com>
 <CAKPyHN39AXJBtuDepb-TgGSGrvqs4a5+yp74L5im3Svmw5S8aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN39AXJBtuDepb-TgGSGrvqs4a5+yp74L5im3Svmw5S8aA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/19 09:39PM, Bert Wesarg wrote:
> On Tue, Sep 3, 2019 at 7:15 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > On 02/09/19 09:13PM, Bert Wesarg wrote:
[snip]
> >
> > One more observation:
> >
> > If I write a particularly long line (and consequently the scrollbar
> > becomes active), and then hit Ctrl+A to select all text, and then
> > backspace to delete it all, the scrollbar does not get updated. It still
> > shows the old position where is is "scrolled" halfway through. As soon
> > as I type in any other character, it takes the correct state, and
> > becomes disabled.
> >
> > The vertical scrollbar behaves correctly in this scenario, and does take
> > the correct state and position as soon as I delete all text, so I
> > suspect it should be a small fix. Maybe a missed option or something
> > like that?
> 
> While I can reproduce this, I don't figured out what is wrong here. I
> tried a minimal example and this also fails. The yScrollCommand is
> issued, but the xScrollCommand not. I have tcl/tk 8.6.8 on Linux.

Well, I don't think this is a big enough problem to block this patch, 
but still something that should ideally be fixed.

I have a really busy week/weekend coming up, so I won't really be able 
to devote much time to this.  I'll see if I can figure something out 
after that.  I'll wait for some comments on your patches, and then get 
around to reading them myself when I get some more time.  Thanks.

-- 
Regards,
Pratyush Yadav
