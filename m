From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Submodules as first class citizens (was Re: Moving to subtrees
 for plugins?)
Date: Thu, 11 Jun 2015 12:11:28 -0400
Message-ID: <CABURp0qf3TCB5ofKG4=MHz1VP4_g8Es8=s9aefW4Sr2b6ZCz_A@mail.gmail.com>
References: <CABURp0og9i9S3_ZWf5Ce9LT785QJo4H-TVtFaKUTXr2N7FB+ew@mail.gmail.com>
 <D2BB8369-E552-4AC3-967E-8F963206E03C@gmail.com> <5573E40A.3020502@gmail.com> <5577330E.3060803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Repo Discussion <repo-discuss@googlegroups.com>, Git <git@vger.kernel.org>, 
	Heiko Voigt <hvoigt@hvoigt.net>, Phil Hord <hordp@cisco.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: repo-discuss+bncBDYMHBPJ3QORBRPG42VQKGQECH26GWA@googlegroups.com Thu Jun 11 18:11:54 2015
Return-path: <repo-discuss+bncBDYMHBPJ3QORBRPG42VQKGQECH26GWA@googlegroups.com>
Envelope-to: gcvr-repo-discuss@m.gmane.org
Received: from mail-ie0-f187.google.com ([209.85.223.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <repo-discuss+bncBDYMHBPJ3QORBRPG42VQKGQECH26GWA@googlegroups.com>)
	id 1Z3556-0007CL-FA
	for gcvr-repo-discuss@m.gmane.org; Thu, 11 Jun 2015 18:11:52 +0200
Received: by ierx19 with SMTP id x19sf3475413ier.1
        for <gcvr-repo-discuss@m.gmane.org>; Thu, 11 Jun 2015 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-spam-checked-in-group:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe;
        bh=GYghGJtEb4RNEfmKtKXSnC0ezQx3826qOQJ6mjUSUWo=;
        b=ow4NRV5Kzrm8hr8dbwGJVrL0aYCC3CmnF44PDGsaau9wAzbleaT1s8acSuPE8tFflt
         Fe3oDHgsoS0AFq2f/SzK/hfR2XTyenX3e6ZP9Que+kelvhUOCghRwBE05KrsbMTwxtTd
         XBNhK0EVxoWb0Fuhai7uXnRCbX5gMjyxiFIL+X+xQ8fxGDPlvlTuZfQK1OTb62nriQuK
         TMSZMeCEOM1aNHEiOWO0wSdRw4OijTaX6S+FrpZ5wZys8rE/4efto4GRUQndX5Df3UIr
         h9DIz6U/wvV3hl/WjydDpRksrJKRkiIyUkCv1Dvd2U1V5YK0b9hnlyNTzQcbrMRjDmCS
         rsAA==
X-Received: by 10.182.186.7 with SMTP id fg7mr23661obc.40.1434039111802;
        Thu, 11 Jun 2015 09:11:51 -0700 (PDT)
X-BeenThere: repo-discuss@googlegroups.com
Received: by 10.182.168.79 with SMTP id zu15ls687680obb.89.gmail; Thu, 11 Jun
 2015 09:11:49 -0700 (PDT)
X-Received: by 10.182.214.104 with SMTP id nz8mr11894233obc.37.1434039109174;
        Thu, 11 Jun 2015 09:11:49 -0700 (PDT)
Received: from mail-yk0-x243.google.com (mail-yk0-x243.google.com. [2607:f8b0:4002:c07::243])
        by gmr-mx.google.com with ESMTPS id s127si17481ywc.6.2015.06.11.09.11.49
        for <repo-discuss@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2015 09:11:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of phil.hord@gmail.com designates 2607:f8b0:4002:c07::243 as permitted sender) client-ip=2607:f8b0:4002:c07::243;
Received: by mail-yk0-x243.google.com with SMTP id 131so676659ykp.1
        for <repo-discuss@googlegroups.com>; Thu, 11 Jun 2015 09:11:49 -0700 (PDT)
X-Received: by 10.170.91.131 with SMTP id i125mr12723972yka.12.1434039109013;
 Thu, 11 Jun 2015 09:11:49 -0700 (PDT)
Received: by 10.37.106.198 with HTTP; Thu, 11 Jun 2015 09:11:28 -0700 (PDT)
In-Reply-To: <5577330E.3060803@web.de>
X-Original-Sender: phil.hord@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of phil.hord@gmail.com designates 2607:f8b0:4002:c07::243
 as permitted sender) smtp.mail=phil.hord@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list repo-discuss@googlegroups.com; contact repo-discuss+owners@googlegroups.com
List-ID: <repo-discuss.googlegroups.com>
X-Spam-Checked-In-Group: repo-discuss@googlegroups.com
X-Google-Group-Id: 540870184241
List-Post: <http://groups.google.com/group/repo-discuss/post>, <mailto:repo-discuss@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:repo-discuss+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/repo-discuss
Sender: repo-discuss@googlegroups.com
List-Subscribe: <http://groups.google.com/group/repo-discuss/subscribe>, <mailto:repo-discuss+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+540870184241+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/repo-discuss/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271434>

On Tue, Jun 9, 2015 at 2:40 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 07.06.2015 um 08:26 schrieb Stefan Beller:
>>
>> On 06.06.2015 12:53, Luca Milanesio wrote:
>>>>
>>>> On 6 Jun 2015, at 18:49, Phil Hord <phil.hord@gmail.com> wrote:
>>>> On Fri, Jun 5, 2015, 2:58 AM lucamilanesio <luca.milanesio@gmail.com>
>>>> wrote:
>>>>>
>>>>> Ideally, as a "git clone --recursive" already exists, I would like to
>>>>> see a "git diff --recursive" that goes through the submodules as well
>>>>> :-)
>>>>>
>>>>> Something possibly to propose to the Git mailing list?
>
>
> Such an option makes lots of sense to me (though "--recurse-submodules"
> should be its name for consistency reasons). This could be an alias for
> "--submodule=full", as the "--submodule" option controls the format of
> submodule diffs.

To me, --recurse-submodules means submodules are still not first-class
citizens.  But let's put that aside for a moment; I don't care about
the switch name too much as long as I can configure
'diff.recurse-submodules = true'.

[The following is rather long.  I'm sorry for that.  Feel free to look
away when it gets too vague.]

Let me set up a submodule like so:

  $ git init /tmp/Super && cd /tmp/Super
  Super$ git submodule add https://github.com/gitster/git.git Foo

I wish to be able to grep from Super and find matches in all my submodules.

  Super$ git grep --recurse-submodules base--int
  Foo/.gitignore:/git-rebase--interactive
  Foo/Makefile:SCRIPT_LIB += git-rebase--interactive

But I want this to work naturally across git-module boundaries, so I
want this also to work (grepping a super-project from within a
submodule):

  Super$ cd Foo
  Foo$ git grep --recurse-submodules base--int ..
  .gitignore:/git-rebase--interactive
  Makefile:SCRIPT_LIB += git-rebase--interactive

I expect some groans from the audience here, because I think if the
syntax above worked, then so would this:

  $ cd /tmp
  tmp$ git grep base--int /tmp/Super/Foo
  /tmp/Super/Foo/.gitignore:/git-rebase--interactive
  /tmp/Super/Foo/Makefile:SCRIPT_LIB += git-rebase--interactive

This usage has nothing to do with submodules, really, except that it
allows git commands to reach into foreign git directories by virtue of
the path supplied as some argument instead of via $GITDIR, and in
doing so it helps solve some git submodules use cases of mine.

But if that did not turn your stomach, try this one:

  $ cd /tmp/Super
  Super$ printf "Some submodule data">Foo/data.txt
  Super$ git add Foo/data.txt
  fatal: Pathspec 'Foo/data.txt' is in submodule 'Foo'
  Super$ git add --recurse-submodules Foo/data.txt

Some notes on this usage:

1. --recurse-submodules seems like a reasonable name for this switch,
especially when you consider the 'git add --recurse-submodules .' use
case.

2. This recursive 'git add' seems dangerous to me unless git-status
also shows all the changed/untracked files in submodules as well if
the --recurse-submodules switch is included.  This would support the
expectation that 'git add .' is going to add the files shown by 'git
status .'

3. Configuring --recurse-submodules as the default mode for 'git add'
but not for 'git status' seems reckless enough that I think there
should not be separate options for these two commands.  There are
probably many other "cross-command" scenarios with similar coupling.

Moving on, as we have :/ to mean 'workdir root', I wonder how you
would spell "super-project workdir root".  Maybe it would be ::/

I realize the kinds of features I'm talking about require extensive
code changes in Git.  For example, consider the meaning of this:

  Super$ git diff --recurse-submodules origin/next origin/master

Since I created Super just a few minutes ago and it has no remote
named 'origin', this command seems meaningless to me.  But suppose
that origin/next and origin/master did exist in my Super project.
Then, I would expect in my wishlist Git, that

A.  Super$ git diff --recurse-submodules origin/next origin/master
This would include differences in Foo between origin/master:Foo and
origin/next:Foo; that is, the commits referenced from those gitlinks
in Super.

B.  Super$ git diff --recurse-submodules origin/next HEAD
This would include differences in Foo between origin/master:Foo and
HEAD:Foo; that is, the commits referenced from those gitlinks in
Super.

C.  Super$ git diff --recurse-submodules origin/next
This would include differences in Foo between origin/master:Foo and
the current Foo workdir.

D.  Super$ cd Foo && git diff origin/next
This would include differences in Foo between the Foo submodule's
origin/master and the current Foo workdir.

Now, C and D seem confusingly similar to me and technically very
different.  I could understand the results, but I could easily be led
astray, especially if I am writing a script.  But I still think it is
reasonable and correct.

I think this could have dire consequences for some commands like 'git
apply'. But I think it is reasonable for git apply to reject such
cross-project diffs, at least in the beginning.  :-)

While I am thinking about it, let me also mention these cases:
E.  Super$ git diff --recurse-submodules origin/next origin/master -- Foo
I think 'origin/next' and 'origin/master' here are referring to
Super's refs, but I can imagine an implementer choosing to use Foo's
instead.

F.  Super$ cd Foo
      Foo$ git diff --recurse-submodules origin/next origin/master -- ..
If this worked, I would think 'origin/next' and 'origin/master' here
must refer to Super's refs even though I began in Foo.  This one is so
ambiguous I think I would have to call this an error.  More
specifically, I think it would have to be rewritten like this next one
(G).

G.  Super$ cd Foo
      Foo$ git -C .. diff --recurse-submodules origin/next origin/master
That is, at least for 'git diff', the <path> parameter at the end is
only used to filter the results; it is not used to find the git-dir.

But look at me speaking in the present tense.  How silly.  I live too
much in my own imagination.

Phil

-- 
