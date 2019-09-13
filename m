Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61651F463
	for <e@80x24.org>; Fri, 13 Sep 2019 21:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfIMVG0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 17:06:26 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35451 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbfIMVGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 17:06:25 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 82491C0002;
        Fri, 13 Sep 2019 21:06:23 +0000 (UTC)
Date:   Sat, 14 Sep 2019 02:36:21 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Allan Ford <allan.ford17@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git Gui - enhancement suggestion - Can a double =?utf-8?Q?cli?=
 =?utf-8?Q?ck_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move?=
 =?utf-8?B?IHRoZSBpdGVtIHRvIOKAnHN0YWdlZCBjaGFuZ2Vz4oCd?=
Message-ID: <20190913210621.tzeq73vpi7iaapd3@yadavpratyush.com>
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
 <CAKPyHN0=AHzr1V35PDzsq02aeGK1e54CxTeunED_u6GRUygkuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPyHN0=AHzr1V35PDzsq02aeGK1e54CxTeunED_u6GRUygkuA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/09/19 10:27PM, Bert Wesarg wrote:
> On Fri, Sep 13, 2019 at 4:32 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > On 13/09/19 12:24PM, Allan Ford wrote:
> > > Dear Git Authors,
> > >
> > > Not a bug, but a suggestion consideration for “Git Gui”
> > >
> > > Can a double click on the file name in the “unstaged” area move the
> > > item to “staged changes” .. (rather than having to click on the small
> > > icon to the left of the file name?)
> >
> > It has been something on my radar for some time. Shouldn't be something
> > too difficult to do.
> >
> > While I like the idea in general, I have a question that I'd like to ask
> > other git-gui users:
> 
> I miss a general problem description: Whats wrong with the
> single-click on the icon to begin with?

The way I see it, there are two parts.

Objectively, it is harder to click the icon than it is to click anywhere 
on the entire row. The small size of the icon adds to the problem.

Subjectively, I personally came from using Atom for quite a while, and 
it staged the file on double click. I think some other editors do this 
too. So, I was used to that way of doing things, and had to adapt to the 
git-gui way.
 
> I consider adding a second way as not not acceptable. I also consider
> double-click on a file in a GUI an "open" action. But in git-gui, this
> "open" action (showing the diff) is already done with a single-click.

Well, that's the other point of view, and it makes sense too. As I was 
afraid, this seems to be a personal preference problem and it will be 
difficult to reach agreement. And I'm generally inclined to keep things 
like they are rather than making drastic changes with debatable benefit.

> From my point of view, it can stay as is.

How about something in the middle? How about larger icon sizes? Will 
that help your workflow Allan?

> >
> > If we implement something like this, what happens when you single-click
> > on the icon? Do we treat that as a stage/unstage command? If we keep the
> > legacy behaviour of single-click on the icon stages/unstages, then a
> > part of the row is single-click and the rest double-click.
> >
> > If we make an entire row of the stage/unstage widget double click, it
> > messes with people who are already used to it.
> >
> > Is partial single and partial double click behaviour acceptable? Or
> > should we make the entire row double click only? Or something else that
> > I missed?

-- 
Regards,
Pratyush Yadav
