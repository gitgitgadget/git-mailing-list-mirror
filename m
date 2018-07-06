Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4371F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 23:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933075AbeGFXXB (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 19:23:01 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:40920 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeGFXXA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 19:23:00 -0400
Received: from [10.13.0.6] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1fba3w-0004y5-13; Fri, 06 Jul 2018 19:22:52 -0400
Received: from thutmose (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 038F544EBE;
        Fri,  6 Jul 2018 16:22:47 -0700 (PDT)
Received: from frederik by thutmose with local (Exim 4.91)
        (envelope-from <frederik@thutmose>)
        id 1fba2t-0000IU-HP; Fri, 06 Jul 2018 16:21:47 -0700
Date:   Fri, 6 Jul 2018 16:21:47 -0700
From:   frederik@ofb.net
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
Message-ID: <20180706232147.GF6343@ofb.net>
Reply-To: frederik@ofb.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706213239.GA867@flurp.local>
 <20180706211828.GC6195@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Jonathan for signaling your willingness to adopt the
documentation philosophy I suggested. That's a quite valuable first
step. Unfortunately my contribution will have to be limited for the
moment to making this suggestion, as I am extraordinarily busy. I hope
it will not be too burdensome to add this item to your TODO list and
keep it there until a willing volunteer comes along.

For what it's worth, I made extensive changes to the Arch Wiki Git
article back in 2015, following an initial attempt of mine to
understand various tutorials. It was the most prominent wiki-based Git
documentation I could find at the time. The article has of course seen
numerous improvements since then.

I don't think that it's really important to find a "best" ordering for
commands or glossary terms; it's more a matter of finding someone who
is willing to take responsibility for choosing a reasonable ordering.
Presumably the head maintainer of this project could delegate the task
to a qualified volunteer, not a newbie like myself but not necessarily
someone with expert knowledge either. It's too bad that a policy of
not listing things alphabetically wasn't adopted from the beginning of
this project, but I guess that's life.

Thanks Eric for the pointer to "git help". This does indeed provide a
finer and better grouping than the man-page (but it also looks like
another candidate for de-alphabetization...!).

Many thanks,

Frederick

On Fri, Jul 06, 2018 at 02:18:28PM -0700, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
> 
> > Ideas?  If you start with a proposal, we're happy to help refine it.
> > People in the #git channel on irc.freenode.net (wechat.freenode.net)
> > might also be useful for inspiration in coming up with a proposal.
> 
> I meant to link to webchat.freenode.net.  But
> https://kiwiirc.com/nextclient/ may have been a better link to use
> anyway.
> 
> Thanks and sorry for the noise,
> Jonathan
> 

On Fri, Jul 06, 2018 at 05:32:39PM -0400, Eric Sunshine wrote:
> On Fri, Jul 06, 2018 at 02:16:00PM -0700, Jonathan Nieder wrote:
> > Frederick Eaton wrote:
> > > I wonder if someone familiar with Git could list the commands in an
> > > order which makes more sense for learning, for example in the order in
> > > which they were invented by Git developers,
> > 
> > Alas, there are plenty of "Main porcelain commands", and I think that
> > is where your question comes from.  It would be nicer to list just five
> > to start, say.
> 
> "git help" makes some attempt at narrowing the list of porcelain
> commands likely to be used on an everyday basis (and it categorizes
> the list by general activity). Of the 21 commands listed, I use 14-16
> in pretty much every development session, so "git help" might be a
> good starting place for someone trying to figure out which commands to
> study, or for someone wishing to help focus the documentation a bit
> more for beginners.
> 
> --- >8 ---
> $ git help
> usage: git ...
> 
> These are common Git commands used in various situations:
> 
> start a working area (see also: git help tutorial)
>    clone      Clone a repository into a new directory
>    init       Create an empty Git repository or reinitialize an existing one
> 
> work on the current change (see also: git help everyday)
>    add        Add file contents to the index
>    mv         Move or rename a file, a directory, or a symlink
>    reset      Reset current HEAD to the specified state
>    rm         Remove files from the working tree and from the index
> 
> examine the history and state (see also: git help revisions)
>    bisect     Use binary search to find the commit that introduced a bug
>    grep       Print lines matching a pattern
>    log        Show commit logs
>    show       Show various types of objects
>    status     Show the working tree status
> 
> grow, mark and tweak your common history
>    branch     List, create, or delete branches
>    checkout   Switch branches or restore working tree files
>    commit     Record changes to the repository
>    diff       Show changes between commits, commit and working tree, etc
>    merge      Join two or more development histories together
>    rebase     Reapply commits on top of another base tip
>    tag        Create, list, delete or verify a tag object signed with GPG
> 
> collaborate (see also: git help workflows)
>    fetch      Download objects and refs from another repository
>    pull       Fetch from and integrate with another repository or a local branch
>    push       Update remote refs along with associated objects
> 
> 'git help -a' and 'git help -g' list available subcommands and some
> concept guides. See 'git help <command>' or 'git help <concept>'
> to read about a specific subcommand or concept.
> --- >8 ---
> 

