From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Fri, 23 May 2008 18:07:34 -0700 (PDT)
Message-ID: <m34p8o4ijg.fsf@localhost.localdomain>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat May 24 03:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JziFl-0007Nb-OX
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 03:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYEXBHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 21:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbYEXBHk
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 21:07:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:10114 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbYEXBHi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 21:07:38 -0400
Received: by ug-out-1314.google.com with SMTP id h2so937880ugf.16
        for <git@vger.kernel.org>; Fri, 23 May 2008 18:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=KPEh1bgwMOJ1UzT87JUbWpMScwLaDVGmQpmK/TTJKEw=;
        b=Mz5LIj+UZ0g0eiTQS2+IW+dEXkkFLDFeaeFRi4uHE7fbH/9VwUQr6Cv9bA/kEEWJqrdJ62iQpSp5TsMNR5+sL8xF6OACQZL2+3WxZXdhdJBBc5lCLfdJ5Ref2gq+QvH9SxSE2ApWj8hfJ5rJXMvcWuFmORjUCG+sc7KIjf2DkUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=jPP0ATt0LUesWgzzFwwKD5ilWgWskgKNeJaKLfXq/xBYw0XavonbV1mijXKShIDrOF4AIPsXD+rMY8A16xOHEf/STcHKxsyqSbQFm969V/LQ6RDvjF5F0acD1lMht1lgx1qd2sHozsnkoTCB3uaWK4x2geCXNFJVVg23BzEN5lE=
Received: by 10.66.250.17 with SMTP id x17mr60240ugh.15.1211591256702;
        Fri, 23 May 2008 18:07:36 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.36])
        by mx.google.com with ESMTPS id 5sm5763106nfv.37.2008.05.23.18.07.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 May 2008 18:07:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4O170L5032411;
	Sat, 24 May 2008 03:07:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4O16h8V032407;
	Sat, 24 May 2008 03:06:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82784>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

> One of the things that has been commented on by almost any review of
> git are the large numbers of commands that are present and the
> endless stream of flags, options, configuration variables and
> syntaxes that are present in git.  They certainly serve a purpose
> and I probably would not be able to do this without all those things
> but it can get in a normal users way some times.  Here are some of
> the steps I have and will be taking.

Which is bogus, because most of those commands are plumbing, [almost]
never to be used by user directly.

If I understand correctly in next major git release those commands are
to be hidden and not present in PATH anymore.
 
> 1) Reduce the number of commands.
> 
> I am currently at 30 total commands, and while I have some more to go, I
> think there are some ways that I can get rid of some of them by
> combining them.  Do we really need a clone, branch and checkout?  Don't
> these all mean the same thing in the end?  They mean get me a working
> directory of the repository starting at X.  For clone, you start
> with 'master'. For checkout, you tell it what to get you.  Branch
> will help you manage things you can locally get.  So perhaps we can
> do something like the following...

Note that you sometimes want to make a branch without checking it out.
Also note that git-branch is overloaded to get a list of branches
available.

> Clone a new repo
> pyt checkout http://foo.com/bar/baz.git mybaz
> 
> It's a URL, I know that I can clone that and I know I am not inside
> a repository.
> 
> Fetch
> pyt co <url> # or remote:origin
> 
> It's a URL, but I am inside the repo, I should tell the user that
> they are about to fetch something.

Not necessary, you might have wanted to have repository inside
repository, either managed using submodules, or ignored, etc.

> Pull
> pyt co -m remote:origin:branch
> 
> Pull is just fetch/merge anyway -m tells it to merge, perhaps a flag -u
> to do it all in one step.
> 
> Merge
> pyt co -m localbranchhead
> 
> Checkout a branch
> pyt co localbranchead # or remote:origin:branch, tag:tagname etc
> 
> Create/switch to new local branch (this should look familiar)
> pyt co -c <newbranch> -b <base>
> 
> The list goes on.

Note also that if you make all those unrelated (at least a bit) things
into one command you would lose some of error detection.  For example
you want to clone, but due to typo and DWIM-mery of "pyt co" command
it would silently fetch/merge/branch/whatever.  Not good...

Note also that another complaint is that git commands do many fairly
independent things... and you would want to escalate it even
further...

> 2) Reduce complexity.
> 
> This one is easy, not because there are commands in git that don't
> have a use, but because we can usually spell stuff in a simpler way.
> Take for example master@{100}.  If I see someone on the list use that
> on I might expect that that is master 100 commits ago, rather than what
> HEAD was pointing at 100 operations ago.

Errr... master 100 commits ago (in first-parent line) is master~100.
And that it is not where HEAD was (indirectly or directly) pointing,
but where 'master' ref was pointing.

The ref@{n} notation is very, very useful when you want to correct
mistakes such as errorneous rewind ("git reset --hard HEAD^" for
example), or botched rebase, or to view pre-rebase version to compare,
etc.

>  Furthermore, if I have just
> cloned, that won't work because I have no reflog.  So what if we
> spelled that reflog:100:master?  Well now at least I know that I
> am dealing with the reflog.  Perhaps a more refined spelling could
> give the user more information.
> 
> Take ":/message"  I didn't even know that existed until I was looking
> for nifty things to spell, but wouldn't "subject:my subject" work just
> as well?  Thats a little friendlier.
> 
> How about not using the ".." and "..." since it can be surprising to
> users what they actually do without understanding how git works.
> Perhaps something like --revision-start (-r) and --revision-end(-R)
> would help them out.  Add a --symmetric or something for "...".

You don't need two options; first -r is start, second -r is end...
 
> You get the idea.

True, the fact that revisions are non-option parameters, and that
pathspecs are also non-option parameters might be a bit confusing to
newbie.

On the other hand the a..b and a...b notation is matter of convenience
(it is easier to use than "b ^a" or "a b --not $(git merge-base a
b)"); perhaps allowing a..b and a...b notation for git-diff was an
error... but it makes copy'n'paste easier...

> 3) Addons.
> 
> Some functionality isn't for everyone.  I have just put into my
> next branch an addon that gives git revision numbers.  Why, because
> other SCMs that are supposed to be more user friendly have them.
> Because people have been asking for them.  Because they are easier
> to remember.  

Because people does not understand the concept and constraints of
distributed version control system (with implied multiple branches and
nonlinear history).

Revision numbers cannot be all of: decentralized, global, unchanging,
encompassing.  

(Decentralized means no single authority assigning numbers, and no
repositories which are special in any case for example using
merge/pull with different options than other repositories.  Global
means that all repositories have the same numbers for the same
revisions; the opposite is local, that numbers are relevant only in
your local repository (and you cannot say: in revision 'n' to someone
else).  Unchanging means that revsision numbers don't change on pull
for example.  Encompassing means that all revisions are given number.)

> 4) GUI.
> 
> I have a GUI in mind, I haven't had time to work on it, but I have
> started it and the idea is that it should be able to completely
> replace the command line.  Why?  because some people hate command lines
> and more importantly, because I want a GUI that will look like it
> fits into my Gnome desktop and looks decent on my Windows machine
> (which I use because I have to).

Have you checked existing git GUIs, both history viewers and commit
tools?  Gitk, git-gui, QGit, Giggle, ugit, tig,...
 
> 5) One stop shop.
> 
> I tried setting up Apache, lighttpd etc on Windows to do some ad-hoc
> serving of a git repo.  I was painful.  I want my webserver, gui,
> command line, diff tool, merge tool to all come in one package.  And
> I DON'T want it to need a cygwin or msys installation to work.
> 
> That just makes life easier.  And I am all about the not expending
> effort.

Perhaps we could just get more examples in gitweb/README and perhaps
in user's manual.

BTW. there always is git-instaweb.

But having git-serve would be nice...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
