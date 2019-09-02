Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0640C1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfIBSoK (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:44:10 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46567 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfIBSoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:44:09 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C3102E000A;
        Mon,  2 Sep 2019 18:44:07 +0000 (UTC)
Date:   Tue, 3 Sep 2019 00:14:05 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar
 appears
Message-ID: <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com>
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com>
 <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/19 08:22PM, Birger Skogeng Pedersen wrote:
> On Mon, Sep 2, 2019 at 8:05 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > I cannot test windows easily, it looks good on Linux Tcl /Tk 8.6:
> >
> > https://kgab.selfhost.eu/s/f38GX4caCZBj4mZ
> 
> On Mon, Sep 2, 2019 at 8:12 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > Hmm, it looks fine for me. Which platform are you using? I am running it
> > on Linux. Screenshot: https://imgur.com/sNp5Ktq
> 
> Try resizing the bottom right pane of git gui, you should see that the
> scrollbar remains at the bottom while the input area moves upwards.

Yes, I can reproduce the problem when I do this. Interestingly, the 
vertical scrollbar does move, the horizontal one (which Bert just added) 
doesn't. So I think there is a slight difference in how the horizontal 
scrollbar is set up that is causing this.

> If not, then it must be a windows-only problem.
> From Bert's screenshot you can see that there is a (small) spacer
> between the scrollbar and the input area.
> 
> Please have a look at this: https://i.imgur.com/unAflET.png
> 
> 
> Br,
> Birger

-- 
Regards,
Pratyush Yadav
