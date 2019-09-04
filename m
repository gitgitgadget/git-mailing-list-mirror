Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E176E1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 14:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfIDOEl (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 10:04:41 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57193 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbfIDOEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 10:04:41 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CD9CAC000D;
        Wed,  4 Sep 2019 14:04:39 +0000 (UTC)
Date:   Wed, 4 Sep 2019 19:34:37 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar
 appears
Message-ID: <20190904140437.xcosp24kpo5fiufa@yadavpratyush.com>
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com>
 <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com>
 <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
 <CAGr--=+UA04F8JtpN3b8SahYtVkYgR45j_xeb3759DrtQOY6rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=+UA04F8JtpN3b8SahYtVkYgR45j_xeb3759DrtQOY6rg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/19 07:42AM, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> 
> Just wanted to chime in on this one:
> 
> On Mon, Sep 2, 2019 at 8:58 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > On second thought, wouldn't it make more sense to expand the commit
> > message buffer instead? The point of resizing that pane is to see more
> > of the commit message. So it makes more sense to make the commit message
> > buffer take up all the vertical space, rather than making the scrollbar
> > move.
> 
> I also think it makes sense to expand the commit message buffer. And

Yes, it was actually a bug. Bert fixed it in his re-roll.

> how about automatic word wrapping? Should the user really have to care
> about the 72 character limit, while typing the commit message? I'm not
> sure what solution would be best.

Yes, that would be a neat feature. Tcl/Tk's text boxes have a "word 
wrap" feature [0], but I'm not sure if that's a soft-wrap or a 
hard-wrap. We can try experimenting with those to see how well it works.  
It would also be a good idea to have an option to disable the word wrap.  
Maybe do that by setting the "Commit message text width" to 0.

[0] https://www.tcl.tk/man/tcl8.4/TkCmd/text.htm#M16

-- 
Regards,
Pratyush Yadav
