Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE401F461
	for <e@80x24.org>; Tue,  3 Sep 2019 17:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfICReX (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 13:34:23 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51913 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICReX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 13:34:23 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 23723FF80E;
        Tue,  3 Sep 2019 17:34:19 +0000 (UTC)
Date:   Tue, 3 Sep 2019 23:04:18 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>, bouncingcats@gmail.com
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
Message-ID: <20190903173418.32hqxfzr7wajtikx@yadavpratyush.com>
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
 <CAGr--=JaTvZ_mUK5+dW6eM3-71ROUR4c58TF9G=-jAw3GDzYTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=JaTvZ_mUK5+dW6eM3-71ROUR4c58TF9G=-jAw3GDzYTQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/19 04:06PM, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> 
> On Tue, Sep 3, 2019 at 2:45 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > Can you try doing a Shift+Tab? For me on Linux, if I hit Shift+Tab, it
> > immediately takes me to the "Amend last commit" option. Then I can press
> > space to select it and Tab again to get back to the commit message.
> 
> It seems that Shift+Tab doesn't do anything (on Windows 10).

Ah, too bad.

> Regardless, imo there should be a binding dedicated to toggle amend.
> 
> > Also, since we are on this topic, how about making the "Amend last
> > commit" button a toggle instead? This would act as a "turn amend mode
> > on/off" button. Since "Amend last commit" and "New Commit" are mutually
> > exclusive, a single toggle to switch between those modes makes sense to
> > me.
> 
> I assume you're talking about the button in the "Commit" dropdown

Yes. That one and the two tick boxes on the top right of the commit 
message buffer/editor.

> menu. I agree, it could be just a single entry which is a toggle to
> enable/disable amending. And (above the commit message dialog) perhaps
> just a single checkbox; "Amend Last Commit". In other git GUIs (Git
> Cola and TortoiseGit) I see they're using just a single checkbox for
> this option. But maybe that is a slightly different topic, the hotkey
> behaviour would remain the same.

Yes, of course your patch is independent of the two-button behaviour. I 
was just pointing it out to see how others feel about it.

> 
> 
> > ... do you still feel the need for a dedicated binding for amends?
> 
> How do you guys feel about it? So far it seems we're at two "yay" and
> one "nay". I really feel it is in the best interest of the git-gui
> project to implement this hotkey. And not just because it is my
> personal preference to have it :-)

Well, I do think amending commits is a common enough operation to 
warrant a dedicated keyboard binding for it. So it is a "yay" for this 
feature from my side at least.

-- 
Regards,
Pratyush Yadav
