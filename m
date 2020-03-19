Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A585C4332E
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7F620658
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgCSQF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:05:57 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42517 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCSQF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:05:57 -0400
X-Originating-IP: 103.227.96.119
Received: from localhost (unknown [103.227.96.119])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B312540011;
        Thu, 19 Mar 2020 16:05:54 +0000 (UTC)
Date:   Thu, 19 Mar 2020 21:35:51 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Subject: Re: [PATCH v2 0/2] git-gui: reduce Tcl version requirement from 8.6
 to 8.5
Message-ID: <20200319160551.ivivebvecw2totnf@yadavpratyush.com>
References: <20200314224159.14174-1-me@yadavpratyush.com>
 <20200317132921.7222-1-me@yadavpratyush.com>
 <CAPig+cQ0YJB25fFaKV2URz39zdS8BwMwwB-a6VJzekkQRLEHpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQ0YJB25fFaKV2URz39zdS8BwMwwB-a6VJzekkQRLEHpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/03/20 11:22AM, Eric Sunshine wrote:
> On Tue, Mar 17, 2020 at 9:29 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > Some MacOS distributions ship with Tcl 8.5. This means we can't use
> > TclOO. So, use our homegrown class.tcl instead.
> >
> > Changes in v2:
> > - Add a note _after_ checking if the user agreed to the deletion.
> >   Otherwise, if the user denies, two "zombie" notes are left lying
> >   around which will never be activated. This means that the chord won't
> >   complete and the index won't be unlocked, leading to git-gui becoming
> >   frozen.
> 
> Thanks. I did some light testing on Mac OS. This re-roll seems to
> address the reported problems[1] and allows the new "delete unstaged
> file" feature to work on older Tcl. As a fix for the Git 2.25
> regression which resulted in git-gui being unable to launch on Mac OS,
> this path series seems "good to go".

Thanks for testing. Merged. Thanks all.
 
> [1]: https://github.com/prati0100/git-gui/issues/26

-- 
Regards,
Pratyush Yadav
