Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB631F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 12:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfJDMBS (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 08:01:18 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:56119 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDMBS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 08:01:18 -0400
X-Originating-IP: 157.45.233.193
Received: from localhost (unknown [157.45.233.193])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AFC55FF807;
        Fri,  4 Oct 2019 12:01:10 +0000 (UTC)
Date:   Fri, 4 Oct 2019 17:31:07 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     harish k <harish2704@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Message-ID: <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
 <20160331164137.GA11150@gmail.com>
 <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
 <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10/19 10:49AM, Johannes Schindelin wrote:
> Hi Pratyush,
> 
> please don't top-post on this list (yet another of these things
> requiring extra brain cycles in the mailing list workflow).

I didn't top-post, or at least it wasn't the intention. The text above 
the quoted text is the "preface" (just like this line I'm replying to is 
a "preface"). It was a comment on the patch formatting, and it wouldn't 
make sense (at least to me) to have it _below_ the quoted part, 
especially since I did have comments in-line (IOW, bottom-posted).

Maybe because I included the references in the middle of the text you 
thought the message was over (understandably so. I probably shouldn't do 
that), and didn't scroll till the end to read the rest of the message.

Or maybe I don't know something about email etiquette that I should.
 
> On Fri, 4 Oct 2019, Pratyush Yadav wrote:
> 
> > Hi Harish,
> >
> > Thanks for the patch. Unfortunately, it seems your mail client messed up
> > the formatting, and the patch won't apply. I'm guessing it is because
> > your mail client broke long lines into two, messing up the diff.
> >
> > We use an email-based workflow, so please either configure your mail
> > client so it doesn't munge patches, or use `git send-email`. You can
> > find a pretty good tutorial on sending patches via email over at [0].
> > The tutorial is for git.git, but works for git-gui.git as well.
> 
> Ah, well. Mailing list-based workflows are so easy, amirite? They are so
> welcoming and inclusive, yes?
> </sarcasm>
> 
> > If you feel more comfortable with GitHub pull requests, please take a
> > look at Gitgitgadget [1]. Johannes (in Cc) has used it recently to send
> > patches based on the git-gui repo (AFAIK, it was originally designed
> > only for the git.git repo). Maybe ask the folks over there how they do
> > it.
> 
> Harish, it is actually relatively easy to use GitGitGadget: just add a
> remote like this:
> 
> 	git remote add gitgitgadget https://github.com/gitgitgadget/git
> 	git fetch gitgitgadget git-gui/master
> 
> and then rebase your patch on top of that branch:
> 
> 	git rebase -i --onto git-gui/master HEAD~1
> 
> Then force-push your branch to your GitHub fork of git.git and open a
> Pull Request at https://github.com/gitgitgadget/git/pulls, targeting
> git-gui/master.
> 
> GitGitGadget will welcome you with a (hopefully) helpful message ;-)

Thanks for these instructions. I will include them in a "Contributing" 
document I'm writing for git-gui.

-- 
Regards,
Pratyush Yadav
