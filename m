From: "Gustaf Hendeby" <hendeby@gmail.com>
Subject: Fwd: Problem using git svn clone
Date: Fri, 25 May 2007 00:48:33 +0200
Message-ID: <bf7b2dda0705241548m29bbb9f9y53d9f9d7448e73ae@mail.gmail.com>
References: <bf7b2dda0705241435t1563008o3c47607343a34a56@mail.gmail.com>
	 <m2wsyxnbd9.fsf@ziti.local>
	 <bf7b2dda0705241539i56f1b5b3kcd001e871e8688ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri May 25 00:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrM6q-0005WE-Ig
	for gcvg-git@gmane.org; Fri, 25 May 2007 00:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbXEXWsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 18:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbXEXWsg
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 18:48:36 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:20623 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbXEXWsf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 18:48:35 -0400
Received: by py-out-1112.google.com with SMTP id a73so1078990pye
        for <git@vger.kernel.org>; Thu, 24 May 2007 15:48:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZtXEsVGbFnHOpg1lDAvddqVnDG2AaSjDIFTcSTyiFAl1p3/AWIIwadu9AwyrHdMyXP5bEdlG/LAWold3oh5OMHT/tnnklB2tukK44sM0K5Tb82RYILtHhDYRuctmSiKHmpPOlEc06/GfotMVgTz1DqfJXXaBz0/Qxp1xRIhp57c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XfQdQXYMp2hgSq6YF0EtpFZ461A54HvE7ot2G3Biqfsps9Eh1rZuaiA6sctWEhtC90L/dKI0CfYBp3/dD26vFUs2OAUE60ZSwmf6HPJDMU0VuCg2mNj79YMgzC2AnLs/0+wHz5hn5RgCB6zKqVILwIF+kIxtKycDgP0QPcD9bYg=
Received: by 10.35.90.1 with SMTP id s1mr1104784pyl.1180046914004;
        Thu, 24 May 2007 15:48:34 -0700 (PDT)
Received: by 10.35.18.2 with HTTP; Thu, 24 May 2007 15:48:33 -0700 (PDT)
In-Reply-To: <bf7b2dda0705241539i56f1b5b3kcd001e871e8688ef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48316>

Apparently gmail does some HTMLing on reply unless you watch out, so
this didn't reach the list.

/Gustaf

---------- Forwarded message ----------
From: Gustaf Hendeby <hendeby@gmail.com>
Date: May 25, 2007 12:39 AM
Subject: Re: Problem using git svn clone
To: Seth Falcon <sethfalcon@gmail.com>
Cc: git@vger.kernel.org


On 5/24/07, Seth Falcon <sethfalcon@gmail.com> wrote:
> "Gustaf Hendeby" <hendeby@gmail.com> writes:
>
> > I have a problem with git-svn, which I hope the list can shed some
> > light over.  I'm quite new to git (but so far I really like it, great
> > job guys!) and I never use SVN, so don't really know what information
> > may be needed to be able to help me on the right track.  I hope the
> > below problem description is appropriate.
>
> Although you've described in detail what you did, it isn't clear to me
> what the problem is...

Let me clarify. When trying to check out the module with tags, the
first example I only get the revisions, no content at all!  I have
added some more info on this below.

The second case works as I expected it, I included it as reference,
and to show that it worked (probably not the smartest thing to do I
guess).  Hence, probably just the first example is of interest.

> > The situation is as follows:
> >
> > I plan to use git and git svn to track a module in the middle of a SVN
> > repository (which I have no control over) where I don't have read
> > access more than to this specific module and the base directory, ie
> > the layout is similar to this
> >       https://svn.foo.bar/a/b/c/trunk
> >       https://svn.foo.bar/a/b/c/tags
> >       https://svn.foo.bar/a/b/c/branches
> > and I have read access to https://svm.foo.bar/a,
> > https://svn.foo.bar/a/b/c and below, but nothing else.
> >
> > What I want to do is clone the whole thing, including tags and
> > branches.  I expected to be able to use the following command to do
> > this (git v1.5.2):
> >
> > $ git svn clone https://svn.foo.bar/a/b/c -T trunk -t tags -b branches
> >
> > Initialized empty Git repository in .git/
> > Using higher level of URL: https://svn.foo.bar/a/b/c => https://svn.foo.bar/a
> >
> > W: Ignoring error from SVN, path probably does not exist: (175002): RA
> > layer request failed: REPORT request failed on '/a/!svn/bc/100':
> > REPORT of '/a/!svn/bc/100': Could not read chunk size: Secure
> > connection truncated (https://svn.foo.bar)
> > r306 = 83f0c10b988a8f1e77a3f354126c52f0cfdecf76 (trunk)
> > [...]
> > Found possible branch point: https://svn.foo.bar/a/b/c/trunk =>
> > https://svn.foo.bar/a/b/c/tags/0.1 , 314
> > Found branch parent: (tags/0.1) ad6a2361d0e69d6288ef226bb335bb4bf3bdd12e
> > Following parent with do_update
> > Successfully followed parent
> > r315 = 3b92c4885b9d6f60241533dd99fa5023eebb1c64 (tags/0.1)
> > r316 = 02e3b828b4f11c5fab9d10d85076a8ff209afa00 (trunk)
> > [...]
> >
> > However, it seems I just get the info about the revisions (shows up
> > nicely in gitk) but no content at all.  The config file reads:

I'm really sorry, I mixed up the config files. :(  So I actually get
this for the first example not the second:

[core]
        repositoryformatversion = 0
        filemode = true
         bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://foo.bar/a
        fetch = b/c/trunk:refs/remotes/trunk
        branches = b/c/branches/*:refs/remotes/*
        tags = b/c/tags/*:refs/remotes/tags/*

Which looks good I guess...  But to be a bit more clear about what
this actually gives me in the directory I just cloned to, and this is
the problem:

$ git checkout -f master
Already on branch "master"
$ ls -a
.  ..  .git
$ du -hs .git/objects
186K    .git/objects

There should be hundreds of files here, several MB of code.  So
something has gone seriously wrong here --- or at least did not work
the way I expected it to.  The .git/objects in the second example
contains 5.7 MB data. More stats:

$ git rev-list --all | wc -l
99
$ git tag -l
$ git branch -a
* master
  tags/0.1
  tags/0.1.1
  tags/0.2.0
  tags/0.2.1
  trunk

No tags (I mistook some of the branches for tags in the first post),
but some branches all containing no files, though, still claiming to
be clean...

> >
> >
> > If I instead do:
> >
> > $ git svn clone https://svn.foo.bar/a/b/c/trunk
> > I get all content in trunk and their revision history, but as expected

> That looks like what you want.  Isn't it?

Second example works just as expected.

I assume the listed commands below are assumed to work with the second
example?  They doesn't seem to do any good to my first example.

> With that config, I would expect:
>
> git svn fetch
>    pull updates for trunk and all branches and tags from the svn
>    server.
>
> git checkout -b trunk remotes/git-svn
>    checkout the current trunk
>
> git svn rebase
>    fetch and rebase trunk or current branch.  git svn should determine
>    the right git branch from refs/remotes to rebase against.
>
> Does that help any?

Given the bad info I posted you did a great job, I really didn't
intend to waste the lists time. Thanks!  Though, my problem still
remains.  Given the new information, do you get any other ideas on
what I do wrong?
