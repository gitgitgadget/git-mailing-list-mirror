Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB6B1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 18:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbfIPSBE (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 14:01:04 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44103 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfIPSBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 14:01:04 -0400
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 38794C000C;
        Mon, 16 Sep 2019 18:01:01 +0000 (UTC)
Date:   Mon, 16 Sep 2019 23:31:00 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
Message-ID: <20190916180059.aifw5r4c4k5o5hur@yadavpratyush.com>
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com>
 <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
 <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/19 09:55AM, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> On Sat, Sep 14, 2019 at 11:15 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > Why should it only happen when the commit message widget is selected?
> > What's wrong with directly switching focus when all the files are
> > staged?
> >
> > What I have in mind is once there are no more files to stage, the focus
> > directly goes to the staged files section, and the first staged file
> > gets selected. Then if you want you can type in the commit message. And
> > conversely, when unstaging things, once all files are unstaged, the
> > focus goes directly to the unstaged files section.
> 
> Your questions are fair. My reasoning: I imagine it could be a bit
> frustrating that the focus automatically goes away from the "Unstaged
> Changes" widget, when the user actually isn't done doing changes.

I suppose a similar argument can be made against your suggestion though. 
When a user clicks on the commit message buffer, they did one thing: 
click on the buffer. They did not click on any diff. So, wouldn't it be 
disorienting for them if their action of clicking the commit message 
buffer also switches the diff view?

I'm not arguing in favour or against your suggestion, I just want to 
consider all angles/viewpoints before going forward.
 
> For instance (as a user);
> - Do some changes
> - Stage the changes (no more unstaged changes in the repo)
> - Realize that you forgot something, jump back to the IDE and make
> some more changes
> - Jump back again to git-gui, hit refresh
> In this scenario, I imagine the user would want to have focus kept on
> the "Unstaged Changes" widget. Even if it became empty with files
> before.
> 
> When the user focus the "Commit Message" widget, the user is kinda
> stating "I'm done staging stuff for now". And when that happens, it
> really doesn't make sense to show a blank diff any more.

Makes sense. But I'm not sure if this would be beneficial to other 
git-gui users. I'd like to hear about what other people think about this 
change.

-- 
Regards,
Pratyush Yadav
