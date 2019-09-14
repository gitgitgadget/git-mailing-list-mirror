Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6DDE1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 21:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfINVYD (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 17:24:03 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43023 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfINVYD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 17:24:03 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6733940002;
        Sat, 14 Sep 2019 21:24:00 +0000 (UTC)
Date:   Sun, 15 Sep 2019 02:53:58 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     David <bouncingcats@gmail.com>
Cc:     git list <git@vger.kernel.org>
Subject: Re: Git Gui - enhancement suggestion - Can a double =?utf-8?Q?cli?=
 =?utf-8?Q?ck_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move?=
 =?utf-8?B?IHRoZSBpdGVtIHRvIOKAnHN0YWdlZCBjaGFuZ2Vz4oCd?=
Message-ID: <20190914212357.cg7t5cufqwd3wj66@yadavpratyush.com>
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
 <3fac912d-9e3c-bf19-e1e5-2691a835b151@xiplink.com>
 <CAMPXz=pNFpg7B0uYCBWvKwOqG8VZWfOxvf+8mZ9qc7w6DkF=+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMPXz=pNFpg7B0uYCBWvKwOqG8VZWfOxvf+8mZ9qc7w6DkF=+w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/19 01:57AM, David wrote:
> On Sat, 14 Sep 2019 at 08:07, Marc Branchaud <marcnarc@xiplink.com> wrote:
> > On 2019-09-13 10:32 a.m., Pratyush Yadav wrote:
> > > On 13/09/19 12:24PM, Allan Ford wrote:
> 
> > >> Not a bug, but a suggestion consideration for “Git Gui”
> 
> > >> Can a double click on the file name in the “unstaged” area move the
> > >> item to “staged changes” .. (rather than having to click on the small
> > >> icon to the left of the file name?)
> 
> > > It has been something on my radar for some time. Shouldn't be something
> > > too difficult to do.
> 
> > > While I like the idea in general, I have a question that I'd like to ask
> > > other git-gui users:
> 
> Thank you for asking.
> 
> > I've always felt this was a bit of user-experience failure on git-gui's
> > part.  Single-click should not behave differently just because you click
> > the icon.
> 
> > I've seen many new git-gui users find this (mildly) confusing.
> 
> I acknowledge that consistency is an important aspect of GUI design.
> Particularly for new and/or low-competency users. But surely
> efficiency must also be valued too. Repetitive strain injury is not
> nice. I have some days where I have hundreds or possibly even
> thousands of such single clicksto stage and unstage items. Currently
> it is possible to review and accumulate them efficiently due to how
> that pane responds.
> 
> And this seems a very small aspect to learn. if a person is so
> "confused" by such a small thing to learn, I wonder what hope they
> would have to comprehend git itself.
> 
> > I'd be happy if the click behavior was consistent across the entire
> > row: single-click to select,
> > double-click to stage/unstage
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Please, no.
> 
> I can't say it strongly enough. Please do not change stage/unstage
> to require double-click. This would be most unwelcome here, unless it
> comes with a configuration option to preserve the old behaviour.
> 
> Maybe the actual problem is that the present icon (perhaps surprisingly)
> has the behaviour of a blank check-box that relocates. I don't wish for
> any change, but if the desire for change is irresistable then the
> simplest solution is for the icon (that appears to the left of filenames
> in the unstaged pane) to be replaced with blank check box that
> behaves exactly as the current icon does. That is:
> When clicked, it becomes a checked-box alongside the filename in
> the staged area. And if that staged-checked-box is clicked, it reverts to
> an unchecked-box (instead of the icon) in the unstaged pane.

Hmm, I like this idea. But right now the icons also show the state of 
the file (modified, added, etc.), so if you switch them to a checkbox 
you lose that information. Are you and other people willing to lose that 
information.

Though I've personally never been a huge fan of those icons. They never 
really managed to convey too much meaning to me. So I won't mind 
changing them to something like the single-letter git-status status 
flags. This also gives us a bit of consistency with git-status's flags, 
so people used to the command line will recognize them instantly. 
Thoughts?

-- 
Regards,
Pratyush Yadav
