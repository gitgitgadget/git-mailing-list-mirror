From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: help with git usage
Date: Wed, 30 Apr 2008 00:39:52 -0700 (PDT)
Message-ID: <m3tzhjokox.fsf@localhost.localdomain>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com>
	<alpine.LNX.1.00.0804291354070.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Quinlan <danq@brtt.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 09:40:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr6vo-0005Bq-LW
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 09:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbYD3HkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 03:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105AbYD3HkA
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 03:40:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:28131 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126AbYD3Hj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 03:39:58 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1365753ugc.16
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=lrdN41N8Wgv+T0sG3KYkQ69O7Fb9o9EcuFsfwulBBxE=;
        b=KV1KMBML4nx+05ZWLEzG9I2XsTusC/hhLumzLmrf74lfMqF2JUVVxmQs0xE/9xZZ1TpHgh/ylh4vzQiqSRpELtjSod+k2ZoOdLBxKBne0KGJT31dsoEqfvNVZ+8WWH/pJ5WEtYgHtmpqLECBWGAsNuDO7Q2WHzUQ1ab+vUfBl4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=EFYYaRWCbdVPdb+3TohlWOhk2QYSvIaAzzZJF+4IC1xRCttyt/FHoPXP0TSRVh2bnfTIWdFIPtwXM42CfQ4cVf+Jp6xJZniHymjVSYx47Zfy1yZxcApr/NDtjcMA44qgQrmLf00OnlQDbSuqgS9hCuO/ksAa4fk+0uLyoBpv1SQ=
Received: by 10.67.86.5 with SMTP id o5mr7564462ugl.50.1209541194852;
        Wed, 30 Apr 2008 00:39:54 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.241.224])
        by mx.google.com with ESMTPS id j27sm3376340ugc.65.2008.04.30.00.39.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 00:39:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3U7di9p000563;
	Wed, 30 Apr 2008 09:39:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3U7dgKK000560;
	Wed, 30 Apr 2008 09:39:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LNX.1.00.0804291354070.19665@iabervon.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80805>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 29 Apr 2008, Daniel Quinlan wrote:
>
> > I've been trying to use git for awhile now, (and I've read a lot
> > of documentation, though maybe my comprehension has not been high
> > enough) but there are several operations which I can't figure out:

Many of answers to your questions can be found on GitFaq,
http://git.or.cz/gitwiki/GitFaq
 
> > 1) After cloning a repository from work at home, making some
> > changes and committing them, I use "git push" to push them back to
> > the work repository.  The changes seem to make it to the work
> > repository (I see the commit message in git log), but I can't
> > figure out how to get the changes into the working set at work.
> > (evidently not merge, checkout or reset -- seems like it should be
> > merge, but)

What do you mean that reset doesn't work? "git reset --hard HEAD"
should update index and working tree, even if someone has updated
HEAD behingd git's back ;-)  NOTE, NOTE, NOTE: this is not a correct
solution.

> You shouldn't push to a non-bare repository. You should, instead, set up a 
> bare repository for publishing your changes, and have all of the 
> repositories you work in be clones of that. The issue is that git doesn't 
> expect something outside of the repository to change the current branch 
> (much like CVS doesn't expect something else to update CVS/Entries in your 
> working directory). Another alternative is, from home, to do:
> 
> $ git push origin refs/heads/*:refs/remotes/home/*
> 
> Then, at work, you can do:
> 
> $ git merge home/master

And yet another alternative is, if possible, to always use "git pull"
(or "git fetch").

See also "Why won't I see changes in the remote repo after "git push"?"
http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
and "How would I use 'git push' to sync out of a firewalled host?"
http://git.or.cz/gitwiki/GitFaq#head-46de97a5ac549d3adf406c22674b3325ae25d09c

> > 2) I can't figure out how to get back the latest (or any other)
> > version of a file I've modified (or deleted) in the working set.
> > (Well, I suppose I could checkout the whole tree somewhere else
> > and copy the relevant file, but I'm hoping there's something
> > simpler).
>
> $ git checkout HEAD -- <filename>
> 
> (And you can use any commit instead of HEAD to get other versions)

See also "How to revert file to version from current commit?"
http://git.or.cz/gitwiki/GitFaq#head-f2ac5ecb3db6c54e9977bf969c0456091ac332a3
 
> > 3) Similarly, I can't use the little context diffs I can see in
> > git-gui -- I need to see side by side comparisons; I've become
> > accustomed to tkdiff.  It seems like git mergetool knows how to do
> > that in some restricted circumstances, but I want to do it outside
> > the context of a merge.
> 
> This I don't know, but you can get particular files from particular 
> commits output with "git show <commit>:<path>", and you can likely wire 
> something up.

TkDiff doesn't have support for Git, although I think it wouldn't be
that hard to add.  Tkere is Google Summer of Code project to add DVCS
support, with Git as first example DVCS supported, to KDevelop so
perhaps KDiff3 would learn Git support.

>From the various graphical comparison tools, Meld has supposedly Git
support (http://meld.sourceforge.net/).  Supposedly only because I
have not tested this; see
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-00fbd1ac45fe93dac4653cad3639b3df73d8657e

BTW. I'm working in my spare time to add side-by-side diff, based on
TkDiff actually, to git-gui.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
