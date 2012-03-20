From: =?UTF-8?B?QW5kcsOpIFdhbGtlcg==?= <andre@andrewalker.net>
Subject: Re: Git and Google Summer of Code 2012
Date: Tue, 20 Mar 2012 16:47:15 -0300
Message-ID: <4F68DEC3.2090006@andrewalker.net>
References: <001636c5c21b02c35904bba0ff9a@google.com> <201203201637.10417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 20:47:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA529-0004c7-El
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 20:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab2CTTrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 15:47:47 -0400
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:41226 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756691Ab2CTTrq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 15:47:46 -0400
Received: (qmail 16082 invoked by uid 0); 20 Mar 2012 19:47:46 -0000
Received: from unknown (HELO host245.hostmonster.com) (74.220.215.245)
  by oproxy7.bluehost.com with SMTP; 20 Mar 2012 19:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=andrewalker.net; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=3OfhtsZjErNXO8rZXc6ff70RHsCWDKQrK17Cvtqkbsc=;
	b=jTRNEtf8R4IHhKVVVlBtSSAJHs77JpqUXuVWcy5hVXXyCDtbybPkxoGDse6sOKctMg0shkqdmQQxC8Uu4xb46216/jbZAK+t0F4NDD6JpjO9wdqrpWlEDAc0/xw1ZdmX;
Received: from tor10.anonymizer.ccc.de ([62.113.219.3] helo=[0.0.0.0])
	by host245.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <andre@andrewalker.net>)
	id 1SA51y-0000mD-F9; Tue, 20 Mar 2012 13:47:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
In-Reply-To: <201203201637.10417.jnareb@gmail.com>
X-Identified-User: {2744:host245.hostmonster.com:picloadc:andrewalker.net} {sentby:smtp auth 62.113.219.3 authed with andre@andrewalker.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193537>

On 03/20/2012 12:37 PM, Jakub Narebski wrote:
> Actually the discussion of GSoC project application ideas with mentor=
ing
> organization[1] should take place in the open, on git mailing list,
> git@vger.kernel.org.  (You don't need to be subscribed to send email =
to
> it, and there is custom on this mailing list of Cc-ing all people
> participating in discussion; you can read git mailing list via other
> interfaces e.g. via GMane.)
Right, thanks for pointing it out. Either way (doing GSoC or not), it'l=
l=20
be cool to join the list.

>  From what I understand "Linus's ultimate content tracking tool" is
> rather a sketch of an idea, rather than concrete project proposal.
> You would have to carve a project from this proposal yourself.
> ...
> People on git mailing list could help there, perhaps starting with
> person that suggested it.
Thanks, I'm still thinking about it. I'll read with more time the e-mai=
l=20
in which Linus proposed the idea, and then I'll decide whether to look=20
more into it (mail him, etc).

>> And, well, in the first one (Modernizing Git.pm) they pointed
>> you as a possible mentor, so I'd like to know. First, how much of Gi=
t is
>> actually in Perl? In other words, how much of it is implemented in G=
it.pm
>> and related modules, or who would use it exactly?
> There are quite a few git commands implemented in Perl, and there wer=
e
> even more before "builtin-ification" of git code (moving to C).  Thos=
e
> include the interactive part of git-add (git-add--interactive helper)=
,
> git-cvsimport, git-cvsserver and git-svn, git-send-email, git-difftoo=
l
> and gitweb.  Not all of those use Git.pm module (git-cvsimport,
> git-cvsserver and gitweb do not); changing this might be part of GSoC
> project.
>
> Git.pm currently does mainly cover safe and portable (ActiveState Per=
l)
> invoking of git commands, and a bit of converting / translating
> output to Perl (e.g. config_bool() method).
>
> It is by no means complete; some of code could be refactored and move=
d
> from individual commands to Git.pm module.
Got it. I'm cloning git's code to help visualize it better.

>> Also, why is it not on CPAN? Wouldn't it be useful to other people t=
o
>> write interfaces in Perl for Git?
> It is not on CPAN probably because Git Development Community lack(s|e=
d)
> a Perl hacker, having only Perl dabblers ;-P
Haha, I see :) I hope I can be of some help!

> More seriously, putting Git.pm on CPAN might be a part of this GSoC
> project.  Not that CPAN lacks git modules: Git::Class, Git::PurePerl,
> Git::Repository, Git::Wrapper, Git::XS (libgit2 based)...
>
> Note however that Git.pm must (in my opinion) remain "dual lived" mod=
ule,
> i.e. reside in git.git repository and be installable alongside git
> with nothing but git sources.  This also means that any extra non-cor=
e
> (or even not installed by default with "perl" package) modules that
> Git.pm requires to work need to have copy in git.git repository just
> like private-Error.pm (should be 'inc/Error.pm') does currently.
>
> Git.pm might ultimately be put in separate repository, and subtree-me=
rged
> into git.git like git-gui and gitk subsystems (or as submodule), but =
that
> would require having real maintainer for this module.
Right. Yeah, in a quick look on CPAN I saw those. I understand what you=
=20
mean that it should remain dual lived. Is using local::lib a viable=20
option? It would make it much easier to keep everything updated, and=20
have new required modules, etc. Though I guess that's something that=20
could be decided during development.

>> It mentions replacing Error and Error::Simple for Try::Tiny and
>> Exception::Class. What else should be modernized? And where else is =
there
>> room for expansion?
> You could borrow from IPC::Run, Capture::Tiny and similar modules to =
make
> it possible to capture stderr of git commands to separate string or
> separate filehandle, or just silencing stderr completely.  Perhaps ev=
en
> allowing creating pipelines.
I don't really understand what you mean by this. I should capture stder=
r=20
for Git.pm, or other git commands? And why would I do that? Is it to=20
manually get errors instead of Try::Tiny?

> You could polish and modernize Git::Object, Git::Commit, Git::Tag,
> Git::Repo and Git::RepoRoot from GSoC 2008 project[2], and add simila=
r
> modules for other concepts: diff (tree level and patchset level), tre=
e
> (directory), refs and refspec, etc.  All those with tests.
>
> [2]: git://repo.or.cz/git/gitweb-caching.git
>       http://repo.or.cz/w/git/gitweb-caching.git (gitweb)
Right, thanks, I'm taking a look at that too.

> You could separate somehow the idea of git commands that do not
> require repository like "git version" or "git config --file", or
> "git init" (Git::Cmd?), those that require repository but not working
> area like "git log" or "git show" (Git::Repo?), and those that requir=
e
> working area like "git status" or "git pull" (Git::Repo::Workdir?).
>
> You could, for example based on existing gitweb code, create Git::Con=
fig
> module that would read all configuration at once with `git config -l`=
,
> and not use one git command for one variable like current $git->confi=
g()
> does.
>
> You could create interfaces to persistent "git cat-file --batch",
> "git cat-file --batch-check" and "git diff-tree --stdin".  IIRC gsoc2=
008
> project includes something like that.
Sounds reasonable. Though some parts I still have to take a look at the=
=20
code to understand better.

> And of course borrow^W steal interesting parts of Git::* modules
> available on CPAN.
Seems the best way to go :)

> I think it might be too much work, though prototyping "Linus's ultima=
te
> content tracking tool" in Perl might be good idea...
Yeah, now that you explained better, it's really too much work for GSoC=
=2E=20
I'd better be realistic and pick one. Probably the Git.pm one is more=20
realistic and could be used afterwards by "Linus's ultimate content=20
tracking tool", if it's ever made in Perl.

> HTH
It does, thank you very much!

Cheers,
Andr=C3=A9.
