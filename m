From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Wed, 09 Sep 2009 14:54:42 -0700 (PDT)
Message-ID: <m3fxavvl5k.fsf@localhost.localdomain>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Wed Sep 09 23:54:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlV7s-0005Dt-Fj
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 23:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbZIIVyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 17:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbZIIVym
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 17:54:42 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:37496 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbZIIVyl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 17:54:41 -0400
Received: by fxm17 with SMTP id 17so3711483fxm.37
        for <git@vger.kernel.org>; Wed, 09 Sep 2009 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=w21xmCuVz/rp25rRm0HQIjWGfrPlFORo4UgjFOz6XaI=;
        b=vDyARR7yFiHuGuXdq7gTvc5ZJc6PPqT7d8b9q8bCC4ThniciizJ2n9woCJEa59TSra
         66zZbapjLKDGN0Dcyv9xoqy4B78sLvhiMEXOUu6mPtIhjQQbu3En9CTA4jEaGCGHS05e
         qMxt6POf1+Rt1ZTwaokPPdwwtI/wVoi9XW17k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=pLph1XjKqbl9XeF0j4sKGiF/sq8ZoHDhDo+NV9TdJpCLhN/O4Rh7Dr8DYEOS9o7hlX
         5ZEeKuPTlhJIwNLrYjDFE1A2/2MRxdKivSsbHAAD078rxMBR4yQHHZMMvF6nmaBZ7pR1
         Qvm+RIjKXAoZaZmGqnnbhp7n9dA//gB0OZZKo=
Received: by 10.86.170.22 with SMTP id s22mr538722fge.37.1252533283549;
        Wed, 09 Sep 2009 14:54:43 -0700 (PDT)
Received: from localhost.localdomain (abwt218.neoplus.adsl.tpnet.pl [83.8.243.218])
        by mx.google.com with ESMTPS id e20sm359450fga.0.2009.09.09.14.54.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Sep 2009 14:54:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n89Lsn9j003994;
	Wed, 9 Sep 2009 23:54:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n89LsmqS003991;
	Wed, 9 Sep 2009 23:54:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128085>

Brendan Miller <catphive@catphive.net> writes:

> Here are a bunch of really basic usability issues I have with git:

First question: which git version do you use?
 
> 1. cloning from a new empty repo fails, and so do a lot of other
> operations. This adds unnecessary steps to setting up a new shared
> repo.

I think it works in modern git (where modern might mean 'master',
i.e. not yet released version)

> 
> 2. git --bare init. The flag goes before the operation unlike every
> other flag?

"git init --bare" works in fit version 1.6.4.2

In "git --bare init" the --bare option is to 'git' wrapper, not to
git-init command (see git(1)):

  --bare Treat the repository as a bare repository. If GIT_DIR
         environment is not set, it is set to the current working
         directory.

> 
> 3. It's not obvious whether operations work on the working
> directory/the "index"/the repository
> e.g. get reset --soft, --mixed, --hard. git diff --cached

There is "git diff --staged" synonym for "git diff --cached"

> 
> 4. The index is inconsistently referred to as too many different
> things (cache, index, staging area) and only the last one makes any
> intuitive sense to a new user. This is partially a CLI issue, and
> partially a documentation issue, but both add up to cause confusion.

Usage of '--index' and '--cached' in CLI is consistent, and different.
See gitcli(7) manpage.

Some of those inconsistences are historical remainings (I think we got
rid of 'dircache' and 'ent').  Do you offer to do a cleanup?

> 
> 5. Most commands require lots of flags, and don't have reasonable
> defaults. e.g. archive.
> 
> git archive --format=tar --prefix=myproject/ HEAD | gzip >myproject.tar.gz
> 
> Should just be:
> git archive
> run from the root of the repo.

I'd rather not have "git archive" work without specifying tree-ish.
As for having to do compression using separate program: do one thing
and do it well is UNIX philosophy, and Git is UNIX-y tool.

BTW. git-archive _has_ default format type (and empty prefix by
default).

> 
> This is what I want to do 90% of the time, so it should just have the
> proper defaults, and not make me look at the man page every time I
> want to use it.

You learn those idioms.

> 
> 6. Where is the bug tracker? If people users can't find the bug
> tracker, they can't report issues, and obnoxious bugs go unfixed, or
> people have to whine on the mailing list. There should be a nice big
> link on the front page of git-scm.com. A bug tracker is really the
> only way for the vast majority of a community that use a tool can give
> feedback on the problems the tool has.

Do you offer to maintain and manage such bug tracker?  I mean here
taking care of duplicated bugs, tracking which bugs are resolved and
which are not, checking if bug is reproductible, etc.  Do you?
Unmaintained bugtracker is worse than useless.

Using mailing list for bug reports and for patches is time-honored
workflow, which works rather well for smaller projects such as Git.
Note that git mailing list is free for all; you don't need to
subscribe to send, and you can watch it via many archives and gateways
(like GMane).

> 
> 7. Man pages: It's nice we have them, but we shouldn't need them to do
> basic stuff. I rarely had to look at the man pages using svn, but
> every single time I use git I have to dig into these things. Frankly,
> I have better things to do than RTFM.

Learn.  If you learn the philosophy behind git design, you would have
much easier understanding and remembering git.

There is "Git User's Manual", "The Git Community Book", "Pro Git" and
many other references.

> 
> 8. There's no obvious way to make a remote your default push pull
> location without editing the git config file. Why not just something
> like

origin is default, I think.

> 
> git remote setdefault origin
> 
> or even
> 
> git remote add --default origin http://somegiturl.org/
> 
> This come up in the use case where I:
> 1. set up a remote bare repo
> 2. push from my local repo, and thence forth want to keep local and
> remote in sink.
> 
> Right now I have to modify .git/config to do this.

And?

> It's ok to have kind of a weak UI on a new tool, when people are busy
> adding basic functionality. However, at this point git already has way
> more features than most of the competition, and the needless
> complexity of the CLI is the biggest issue in day to day use.

Creating good UI is not easy, especially if you are limited by
backward compatibility.

-- 
Jakub Narebski

Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
