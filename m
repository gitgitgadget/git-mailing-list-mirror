Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F661F463
	for <e@80x24.org>; Sat, 14 Sep 2019 19:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfINTIi (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 15:08:38 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33829 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfINTIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 15:08:38 -0400
Received: from localhost (unknown [157.49.204.4])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4A861100003;
        Sat, 14 Sep 2019 19:08:35 +0000 (UTC)
Date:   Sun, 15 Sep 2019 00:38:32 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     David <bouncingcats@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Git Gui - enhancement suggestion - Can a double =?utf-8?Q?cli?=
 =?utf-8?Q?ck_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move?=
 =?utf-8?B?IHRoZSBpdGVtIHRvIOKAnHN0YWdlZCBjaGFuZ2Vz4oCd?=
Message-ID: <20190914190656.r2aogh4dcobay5vn@yadavpratyush.com>
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
 <CAKPyHN0=AHzr1V35PDzsq02aeGK1e54CxTeunED_u6GRUygkuA@mail.gmail.com>
 <CAMPXz=qWmHGpDrGVpg1gwEBQsg5pujY-Ghg8icyaPoiMNCXssg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMPXz=qWmHGpDrGVpg1gwEBQsg5pujY-Ghg8icyaPoiMNCXssg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/19 02:07AM, David wrote:
> On Sat, 14 Sep 2019 at 06:51, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > On Fri, Sep 13, 2019 at 4:32 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > On 13/09/19 12:24PM, Allan Ford wrote:
> >
> > I miss a general problem description: Whats wrong with the
> > single-click on the icon to begin with?
> 
> No problem here, but see my other message for further thoughts.
> 
> > I consider adding a second way as not not acceptable. I also consider
> > double-click on a file in a GUI an "open" action.
> 
> Yes!
> 
> In fact, I've often fantasized how useful it would be that if I double
> clicked on that file name in the unstaged pane or the staged pane,
> then that would open the file for editing in my preferred/configured editor.
> 
> Now for me *that* would be a very frequently used improvement!
> 
> I wonder what other readers think about this idea?

Sounds reasonable. I've wanted something similar, but for commit 
messages.

But one major reason I didn't come up with a patch for editing commit 
messages in the editor of your choice is terminal based editors. I don't 
think there is any way of finding out the default terminal emulator in 
Linux, and I don't think there is a standard way of making terminal 
emulator launch programs you want.

So your suggestion works only for GUI based editors. We would have to 
mention that only GUI based editors can open files.

I like the idea, but I thought I'd point a problem I saw with this 
feature.

Also, the file viewer in git-gui opens the blame viewer, but I suppose 
that's not what most people want.

-- 
Regards,
Pratyush Yadav
