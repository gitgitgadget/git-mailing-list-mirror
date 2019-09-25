Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E4F1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 13:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406584AbfIYNew (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 09:34:52 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42341 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405963AbfIYNew (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 09:34:52 -0400
X-Originating-IP: 1.186.12.39
Received: from localhost (unknown [1.186.12.39])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 375E6E0006;
        Wed, 25 Sep 2019 13:34:48 +0000 (UTC)
Date:   Wed, 25 Sep 2019 19:04:47 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: git-gui: failure to distinguish 3-way common ancestors in hunk
 markers (#2340)
Message-ID: <20190925133447.pmr3pavsosilbavi@yadavpratyush.com>
References: <b2f412e2-d95f-0f73-5341-73c19ee2c6f7@iee.email>
 <7baf2b10-56fa-1cb4-0571-cb3c6be8feb3@iee.email>
 <CAKPyHN2sORn_ivC33DDsGe5L5UbNDBc5W6m=h85KUCmBCFCdvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN2sORn_ivC33DDsGe5L5UbNDBc5W6m=h85KUCmBCFCdvw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/09/19 08:33AM, Bert Wesarg wrote:
> Pratyush,
> 
> once again, I had done this years ago. I may post an updated patch in
> the evening:
> 
> https://github.com/bertwesarg/git-gui/commit/90ee4a8c260132a6b730040095929fd267cedd7b

Nice! I was about to dive into this bug, but it is great that you have 
already fixed it. Send it on the list when you get the time and we can 
discuss it here :)
 
> On Wed, Sep 25, 2019 at 12:05 AM Philip Oakley <philipoakley@iee.email> wrote:
> >
> > Hi list,
> > cc Pratyush,
> >
> > [resend without attached png file]
> >
> > While rebasing an old series, I had a 3-way merge fall back that didn't
> > show the `||||||| merged common ancestors` very well in git-gui.
> >
> > That is, the conflict markers, and common ancestor lines, are treated as
> > being part of the current HEAD hunk, rather than being separated.
> >
> > I opened a Git for Windows issue
> > https://github.com/git-for-windows/git/issues/2340 which has the
> > screenshot of the git-gui markers.
> >
> > I've not had any chance to look at the underlying code, but thought it
> > worth reporting. I guess the issue has been there a while.

-- 
Regards,
Pratyush Yadav
