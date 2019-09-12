Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47ADF1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 16:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfILQ3a (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 12:29:30 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57843 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbfILQ3a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 12:29:30 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E093DFF80F;
        Thu, 12 Sep 2019 16:29:27 +0000 (UTC)
Date:   Thu, 12 Sep 2019 21:59:25 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit"
 check button/menu
Message-ID: <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
 <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com>
 <CAGr--=Jz9xN6NMmiXjHeq9wZsYUx4eqfQrWjjVMkj3J1YCG_8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=Jz9xN6NMmiXjHeq9wZsYUx4eqfQrWjjVMkj3J1YCG_8g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/19 08:05AM, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> On Wed, Sep 11, 2019 at 10:55 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > Also, I notice that the bindings for other letters have the same
> > function bound for both small and capital letters (IOW, same behavior
> > with shift held and released).
> >
> > I don't necessarily think that is a great idea. It is a pretty common
> > pattern to have, say Ctrl+a, do something, and Ctrl+Shift+a, do
> > something else. Just want to pick your brain on whether you think we
> > should do the same thing for both Ctrl+e and for Ctrl+E (aka
> > Ctrl+Shift+e), or just bind it to Ctrl+e, and leave Ctrl+E for something
> > else.
> 
> I just tested what happens when you press Ctrl+e while Caps Lock is
> enabled; the Ctrl+e binding is not invoked. That's probably why other
> key bindings have the same function bound for both lower- and
> upper-case letters, to have the same behaviour with/without Caps Lock
> enabled. With that in mind, we should probably bind Ctrl+E aswell.

Nice catch! Makes sense to have the same behaviour for both caps lock 
enabled and disabled.

> 
> Should I create and send a new patch?

Yes, please do.

-- 
Regards,
Pratyush Yadav
