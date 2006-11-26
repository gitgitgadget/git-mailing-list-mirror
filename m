X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Calling all bash completion experts..
Date: Sat, 25 Nov 2006 23:03:58 -0500
Message-ID: <20061126040358.GA29855@spearce.org>
References: <Pine.LNX.4.64.0611230935520.27596@woody.osdl.org> <20061125071351.GE4528@spearce.org> <Pine.LNX.4.64.0611251106250.6991@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 04:04:14 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611251106250.6991@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32327>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoBFS-0004zj-Tu for gcvg-git@gmane.org; Sun, 26 Nov
 2006 05:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967291AbWKZEEH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 23:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967292AbWKZEEH
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 23:04:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:29418 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S967291AbWKZEEE
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 23:04:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoBF6-0007sG-Sw; Sat, 25 Nov 2006 23:03:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 DEEEE20FB09; Sat, 25 Nov 2006 23:03:58 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Sat, 25 Nov 2006, Shawn Pearce wrote:
> > 
> > I added the nospace option because of the completion for fetch/push,
> > cat-file, diff-tree and ls-tree.
> > 
> > The problem is the file completion for e.g. cat-file.  We don't
> > want a space added after we complete a directory name, so you can
> > complete further, e.g.:
> > 
> >   git cat-file -p ma<tab>con<tab>comp<tab>git-com<tab>
> 
> But that's how directory completion _always_ works. Completion doesn't add 
> spaces to directories anyway, it adds a "/".
> 
> The branch-name thing is well-taken: you don't want to add a space after a 
> branch-name, although neither do you want to add a ":" by default.
> 
> So "nospace" after a branch (or tag) name sounds sane, but nowhere else 
> that I can see.

All in all what you are asking is reasonable.  Users really should
expect the Git completion to work just like any other completion
built-in to bash.  I've just run into some difficulty making that
be the case with all of the git commands. :)

I'm trying to push really hard on git-gui right now, to get it to
the point that people who are absolutely terrified of the command
line can still do basic operations (commit, fetch, trivial merge,
push).  'cause I really need to get a some of those users onto
a git repository (like everyone else) rather than an unbacked-up
network share which has no revision history.

I'll come back to the bash completion soon.  Jakub Narebski and
another person have both asked that I do some more work for other
commands.  I was hoping that other person might do some of the
modifications himself and contribute them back, but it looks like
he's just as busy as I am and hasn't found the time.

-- 
