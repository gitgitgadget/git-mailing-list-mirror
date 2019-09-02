Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8291F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfIBS6X (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:58:23 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45055 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfIBS6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:58:22 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id F03A81C0007;
        Mon,  2 Sep 2019 18:58:20 +0000 (UTC)
Date:   Tue, 3 Sep 2019 00:28:19 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar
 appears
Message-ID: <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com>
 <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/19 12:14AM, Pratyush Yadav wrote:
> On 02/09/19 08:22PM, Birger Skogeng Pedersen wrote:
> > On Mon, Sep 2, 2019 at 8:05 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > > I cannot test windows easily, it looks good on Linux Tcl /Tk 8.6:
> > >
> > > https://kgab.selfhost.eu/s/f38GX4caCZBj4mZ
> > 
> > On Mon, Sep 2, 2019 at 8:12 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > Hmm, it looks fine for me. Which platform are you using? I am running it
> > > on Linux. Screenshot: https://imgur.com/sNp5Ktq
> > 
> > Try resizing the bottom right pane of git gui, you should see that the
> > scrollbar remains at the bottom while the input area moves upwards.
> 
> Yes, I can reproduce the problem when I do this. Interestingly, the 
> vertical scrollbar does move, the horizontal one (which Bert just added) 
> doesn't. So I think there is a slight difference in how the horizontal 
> scrollbar is set up that is causing this.
 
On second thought, wouldn't it make more sense to expand the commit 
message buffer instead? The point of resizing that pane is to see more 
of the commit message. So it makes more sense to make the commit message 
buffer take up all the vertical space, rather than making the scrollbar 
move.

-- 
Regards,
Pratyush Yadav
