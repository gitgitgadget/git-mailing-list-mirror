From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 26 Dec 2006 12:20:07 +0100
Organization: At home
Message-ID: <emr0bt$hcb$2@sea.gmane.org>
References: <7vmz5bfidj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Dec 26 12:20:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzALy-0000ec-Ug
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 12:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWLZLUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 06:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWLZLUP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 06:20:15 -0500
Received: from main.gmane.org ([80.91.229.2]:46701 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345AbWLZLUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 06:20:13 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GzALi-0008Gd-BB
	for git@vger.kernel.org; Tue, 26 Dec 2006 12:20:02 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 12:20:02 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 12:20:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35416>

Junio C Hamano wrote:

> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.  The topics list the commits in reverse chronological
> order.
> 
> 
> * jc/fsck-reflog (Fri Dec 22 23:42:30 2006 -0800) 9 commits
>  + reflog expire: do not punt on tags that point at non commits.
>  + reflog expire: prune commits that are not incomplete
>  + Don't crash during repack of a reflog with pruned commits.
>  + git reflog expire
>  + Move in_merge_bases() to commit.c
>  + reflog: fix warning message.
>  + Teach git-repack to preserve objects referred to by reflog
>    entries.
>  + Protect commits recorded in reflog from pruning.
>  + add for_each_reflog_ent() iterator
> 
> I'd like to push this out before we go -rc1, since the reflogs
> are now enabled by default, and otherwise would grow unbounded.

I'd still like the preserving reflogged data during pruning and
repacking to be optional (default to on). But failing that I'd
like to have option to "reflog expire" to remove only specific
(pattern match, prefix match?) entries, for example to remove
all the "commit --amend" and StGIT work, but leaving rebases,
resets, merges and other stuff.

> * jn/web (Sat Dec 16 17:12:55 2006 +0100) 1 commit
>  - gitweb: Add some mod_perl specific support

I'm about to send improved series of patches, few first ready to
be applied, the rest for review.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
