X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 12:19:28 -0300
Message-ID: <200612151519.kBFFJSYn012227@laptop13.inf.utfsm.cl>
References: <jnareb@gmail.com>
NNTP-Posting-Date: Fri, 15 Dec 2006 15:24:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Jakub Narebski <jnareb@gmail.com> 
   of "Fri, 15 Dec 2006 12:27:53 BST." <elu0n5$u0i$1@sea.gmane.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 15 Dec 2006 12:19:29 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34515>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEvY-0000nL-9x for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752733AbWLOPYp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbWLOPYp
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:24:45 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47742 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752733AbWLOPYo (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 10:24:44 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kBFFJTCu028337
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Fri, 15
 Dec 2006 12:19:29 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBFFJSYn012227; Fri, 15
 Dec 2006 12:19:28 -0300
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Andy Parkins wrote:
> 
> > On Wednesday 2006 December 13 22:56, Shawn Pearce wrote:
> > 
> >>   git cat-file -p $REV:$file
> >>
> >> not sure how much easier it gets than that.  Load in the bash
> >> completion from contrib/completion and you can even tab complete
> >> the $file part.
> > 
> > Yes.  I was a little unfair on that one; I forgot about the REV:file syntax.  
> > However, it's still not simple for a new user; I think I'd say "draw" if 
> > the "-p" weren't a requirement.
> 
>   $ git repo-config alias.less "-p cat-file -p"
>   $ git repo-config alias.cat     "cat-file -p"
> 
> remedies that.
> 
> [...]
> >> How is it unfriendly?  What specifically would you change to make
> >> it more friendly?
> > 
> > $ git-ls-tree v1.0.0
> > 100644 blob 906e98492080d2fde9467a9970fc92d7a8cfeaf8    Makefile

> > I'm a newbie: what's that number at the front?  What's a blob?  What's
> > that great big number - I've only seen commit hashes that look like
> > that, and that isn't one.  Definitely not friendly.

> The number in front is octal mode of a file or directory. "blob"
> is a file (or symbolic link), "tree" is a directory, all of this
> can be found in git(7).

I don't want to come through as rude, but that you can find the explanation
somewhere (and as an old(ish) Unix/git hand you know (or should be able to
guess easily) what it means) doesn't help the _newbie_ confronted with this
gibberish one iota. Explaining it it the git list also doesn't help. Either
make it self-explanatory, relegate this command to git-plumbing or axe its
output (perhaps show this only with --verbose or such, with Unix you get
fast to the point where you know --verbose is probably totally mistifying
except for /real/ experts :-).

[...]

> Perhaps we should add git-ls which would be porcelain frontend
> to git-ls-files and git-ls-tree, just like git-diff is frontend
> to git-diff-files, git-diff-index and git-diff-tree (and also does
> pure blob diff).

That is a more newbie-friendly answer.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
