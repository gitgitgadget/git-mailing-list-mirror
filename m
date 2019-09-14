Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714851F463
	for <e@80x24.org>; Sat, 14 Sep 2019 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfINV1g (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 17:27:36 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54663 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfINV1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 17:27:36 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 66FFB40005;
        Sat, 14 Sep 2019 21:27:34 +0000 (UTC)
Date:   Sun, 15 Sep 2019 02:57:32 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
Message-ID: <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/19 02:45AM, Pratyush Yadav wrote:
> On 14/09/19 02:24PM, Birger Skogeng Pedersen wrote:
> > Hi everyone,
> > 
> > 
> > I personally prefer to have the changes I am about to commit visible
> > in the diff view, while I write my commit message. So usually I do
> > this:
> > 1. Stage the file(s) I've been working on.
> > 2. Select a file I just staged, so I can see the changes in the diff widget.
> > 3. Jump to the "Commit Message" widget to type up my commit message.
> > Basically, I would like to be able to skip step 2. When the user
> > stages the last file in the "Unstaged Changes" widget, no file is
> > selected and the diff view becomes blank. When this is the case, I
> > would prefer that git-gui automatically selects one of the staged
> > files and shows it in the diff widget before I type up my commit
> > message. Naturally, this automatic selection should **only** happen
> > when the user chooses focus the "Commit Message" widget.
> 
> Why should it only happen when the commit message widget is selected? 
> What's wrong with directly switching focus when all the files are 
> staged?

Re-reading this email, this might have come across as a bit too harsh. 
That was not my intention. I just want to know why you think it should 
only happen when focussing on the commit message, and what in your mind 
is the problem with directly switching when no more files are left.

> 
> What I have in mind is once there are no more files to stage, the focus 
> directly goes to the staged files section, and the first staged file 
> gets selected. Then if you want you can type in the commit message. And 
> conversely, when unstaging things, once all files are unstaged, the 
> focus goes directly to the unstaged files section.
>  
> > I propose:
> > (When the user focuses the "Commit Message" widget, if no file is
> > currently selected (i.e. diff widget shows no text))
> > automatically select the first file listed in the "Staged Changes"
> > widget so the changes of that file show up in the diff widget.
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Regards,
Pratyush Yadav
