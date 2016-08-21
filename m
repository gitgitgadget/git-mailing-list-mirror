Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12BC1F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932284AbcHUV33 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 17:29:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52278 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754396AbcHUV32 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 17:29:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AE3AE1F6C1;
        Sun, 21 Aug 2016 21:29:27 +0000 (UTC)
Date:   Sun, 21 Aug 2016 21:29:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Norman Shapiro <norm@dad.org>, Git List <git@vger.kernel.org>
Subject: Re: Editing a typo in the message given to "git commit"
Message-ID: <20160821212927.GA8516@dcvr>
References: <201608211519.u7LFJiMR090069@shell1.rawbw.com>
 <CAFZEwPP=d6fN4MC09JGm4neY5MuXv1JBzx87HC+8=XjEp=DS_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFZEwPP=d6fN4MC09JGm4neY5MuXv1JBzx87HC+8=XjEp=DS_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Sun, Aug 21, 2016 at 8:49 PM,  <norm@dad.org> wrote:
> > I am learning how to use git. I would like to know:
> >
> > How can I correct a typo in the message I gave to an old "git commit"? I see
> > that the typo occurs in exactly two files in .git:
> >
> > .git/logs/refs/heads/master
> > .git/logs/HEAD
> >
> > /usr/bin/file says that they are both ASCII English text. So I could just
> > hand edit them. But that seems somehow sacrilegious and might break git.
> 
> Messages to commits aren't just stored in these two files.
> Hand editing them will definitely break git and its highly advisable
> not to do that. In fact, for beginners its highly recommended to never
> visit the ".git" folder. What you need in this case is `git-rebase
> -i`. Using that you can go to the commit where you want to edit the
> message and mark it as "reword". Also if you want to make some
> modifications in the code, then you can mark it as "edit". Try `man
> git-rebase` for more info on the command.

Agreed.  I use "git commit --amend" if it's the latest commit;
saves typing.  Definitely don't edit anything in .git/logs/ by
hand.

> Also on a side note: This is a developer's mailing list. Please try to
> use the user's mailing list[1] for doubts. But if you have a doubt as
> to why this commands functions in a particular way (in which you think
> it should not) or you find a possible bug then feel free to discuss it
> on this mailing list. Also to save other people's time, first search
> for the doubt in the archives or google about it.

I disagree with this being a developer's-only list and pointing
users to a separate list.  Every git user is a potential
developer (especially for a tool aimed for managing source).
Often user questions turn into bug reports aimed at
developers.

Nothing in our manpages even mentions this git-users list.

> [1]: https://groups.google.com/forum/#!forum/git-users


Keep in mind I have a strong anti-centralization bias and
Google is a big basket, here.  I'll let their history of
discontinuing services like Google Reader, Google Code,
etc. speak for itself :)
