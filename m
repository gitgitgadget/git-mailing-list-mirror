From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 07 Dec 2007 03:11:01 -0800 (PST)
Message-ID: <m3tzmuu57k.fsf@roke.D-201>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
	<7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 12:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0b7F-00075R-7v
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 12:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbXLGLLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 06:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbXLGLLK
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 06:11:10 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:17443 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbXLGLLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 06:11:07 -0500
Received: by mu-out-0910.google.com with SMTP id i10so813806mue
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 03:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=V0BpqmWXIK+Kl9loVFV3sXEwTGBRpbbySKfabF4gZWs=;
        b=T595F4uCD3714r6Zkv9xWmQbVCOJHlkhk71lxH+fhojFka+UUYsWg/we6+6GSLNQVQD4L6CbHmf4yo+QuJGxnHAlbMPgQ788iU0kHJWlyJsg+u9bhCkSVty+6FY7HkunUyr2abujQFYcqT4XCGNvVCZr16AwC2IzQCAzVaWEDMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=n9BIXjIVRrzpYcUWg2UcTz8sGAy737SnH1aaWR5art2qermD+1Zob09Df0cn6+q24Imf2vyacL69jdmiHPCFZKlSKK7ReP0M3KSwJUQUDjloJFSRpra19cPS/qSjY9hE/p9F2L/D4WeIURvCbdFyGq90mLN/Z+hYjOxM7lHUJHc=
Received: by 10.82.171.16 with SMTP id t16mr11682096bue.1197025864915;
        Fri, 07 Dec 2007 03:11:04 -0800 (PST)
Received: from roke.D-201 ( [83.8.224.19])
        by mx.google.com with ESMTPS id y2sm2243972mug.2007.12.07.03.10.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Dec 2007 03:11:01 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB7BEf4m004854;
	Fri, 7 Dec 2007 12:14:42 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB7BEea3004851;
	Fri, 7 Dec 2007 12:14:41 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67411>

Junio C Hamano <gitster@pobox.com> writes:

> * pr/mergetool (Wed Dec 5 09:19:13 2007 +0200) 1 commit
>  + Open external merge tool with original file extensions for all
>    three files
> 
> Waiting for Ted's Ack but I think this is safe.  Hoping to merge before
> v1.5.4-rc0.

Nice. I don't think this would break anything. By the way, this would
I think also make Emacs (emerge) choose correct major mode for syntax
highlighting etc., so it is not only for Meld...
 
> * jc/spht (Thu Dec 6 00:14:14 2007 -0800) 7 commits
>  + Use gitattributes to define per-path whitespace rule
>  + core.whitespace: documentation updates.
>  + builtin-apply: teach whitespace_rules
>  + builtin-apply: rename "whitespace" variables and fix styles
>  + core.whitespace: add test for diff whitespace error highlighting
>  + git-diff: complain about >=8 consecutive spaces in initial indent
>  + War on whitespace: first, a bit of retreat.
> 
> This teaches apply and diff about the customizable definition of what
> whitespace breakages are, and the customization can be refined per-path
> using the attributes mechanism.  It would be to nice to have this in
> v1.5.4.

By the way, is there some helper plumbing scripts can use to check
attributes for given file (given pathname), either in working area, or
in repository (I am thinking there to use gitattributes for
configuring syntax highlighting (extension to syntax) in gitweb);
perhaps even in the index.

> * jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
>  + Support builtin aliases
> 
> Cute hack.

By the way, beside "git view" alias (with configurable backend, be it
gitk, qgit, giggle or gitview) it would be nice to have "git unstash"
as an alias to "git stash apply" (it would not matter here that
command think of itself as 'git stash' here).
 
> ----------------------------------------------------------------
> [On hold]
> 
> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>  - Move all dashed-form commands to libexecdir
> 
> I think this is a sane thing to do in the longer term.  Will be in
> 'next' after v1.5.4.  I think "leave porcelain on PATH" might be also a
> good thing as a transition measure.

We would have to change the paragraph in INSTALL about git wrapper
(which would be no longer optional, or at least no longer optional in
the sense that you can just delete/not install this file), and its
conflict with (old) GNU Interactive Tools (the other 'git').
 
> [Stalled]
> 
> * ns/checkout-push-pop (Wed Dec 5 07:04:06 2007 +0900) 1 commit
>  - git-checkout --push/--pop
> 
> A reasonably cleanly written cute hack, and I do not see this breaking
> the normal codepath, so I do not mind merging this as long as people
> find it useful.

That would be nice to have, although as somebody[*1*] said, you usualy
know that you should have pushed branch into stack when you want to
'pop'. So it would be nice to have (if possible and easy to implement)
also "git checkout --previous" or "git checkout -".

Robin Rosenberg wrote about nice hack to implement "cd -" like
behavior:

Robin Rosenberg wrote:
> I abuse git bisect for this temporary switcing. It only gives me a one
> level memory, but otoh the git prompt tells me I'm on a discourse.
>
> [me@lathund GIT (rr/abspath|BISECTING)]$ git checkout master
> Switched to branch "master"
>
> [me@lathund GIT (master|BISECTING)]$ git checkout HEAD~2
> Note: moving to "HEAD~2" which isn't a local branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
>   git checkout -b <new_branch_name>
> HEAD is now at afcc4f7... Merge branch 'js/prune-expire'
>
> [me@lathund GIT (afcc4f7...|BISECTING)]$ git bisect reset
> Previous HEAD position was afcc4f7... Merge branch 'js/prune-expire'
> Switched to branch "rr/abspath"
> [me@lathund GIT (rr/abspath)]$

[*1*] I'm sorry for no attribution
 
> * jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
>  . pathspec_can_match(): move it from builtin-ls-tree.c to tree.c

What is the status of this thingy, by the way?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
