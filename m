Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA94B1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 05:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbeBWFaD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 00:30:03 -0500
Received: from hosted.mailcow.de ([5.1.76.202]:47799 "EHLO hosted.mailcow.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbeBWFaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 00:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=childno.de; s=default;
        t=1519363798;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=k5DbYwAMIZwtZk0H7cuLNsxXdpiQUCbsFVwx97QFS1w=;
        b=UDxBFZbZ74pPJA2OMbjvQ1tIZXVAqZP+KD6IhG7AA8Fbluvp1DG5bWB5/GHxMLZRpKBFH3
        EKYz3adGhShJgzV+8Ect/Azuo0Z4htbU2Ok03+Y89Qnr1534jK4n7NB0mSy19NrP5peRmb
        WsapKPKpk+TrWz0KwqCPksY9fKVTf3U=
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: marcel@traut.cloud)
        by hosted.mailcow.de (Postfix) with ESMTPSA id 1D96E5C0F76;
        Fri, 23 Feb 2018 06:29:56 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [BUG] [git 2.16.1] yeeek ... my files are gone .. by git pull
 <otherRepositoryUrl>
From:   =?utf-8?B?Ik1hcmNlbCAnY2hpbGROb82hLmRlJyBUcmF1dHdlaW4i?= 
        <c0d3+gitscm@childno.de>
In-Reply-To: <20180222232031.GE256918@aiede.svl.corp.google.com>
Date:   Fri, 23 Feb 2018 06:29:55 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A26AAB4-E2E5-4681-87D4-0D6727CA423A@childno.de>
References: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de>
 <20180222232031.GE256918@aiede.svl.corp.google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=childno.de;
        s=default; t=1519363798;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=k5DbYwAMIZwtZk0H7cuLNsxXdpiQUCbsFVwx97QFS1w=;
        b=YEH+hvWeY+1CeWH/6rlFRZy/iYYqzputjc/SDC8wcEQnftyXEHhRN3TwHJR8wFNckhZjUM
        A5ZMC3zf60yybCMPiUzF8ipKdt3qj4bP5nDFPr7vjM0JuvT8LXbXYRAy3eHTu3m7/Cw4TA
        szxgo1jqv6Ku9QDWxjPCBk9/ojhJhJk=
ARC-Seal: i=1; s=default; d=childno.de; t=1519363798; a=rsa-sha256;
        cv=none;
        b=paltDE5PHKif/gPYixmOe97HMLStSSbaFphZ7kZt9yPR+PCNY7fRZgEgBri2dw0Rx88gcl54N4iGrYKm2jWg8lMkf7KunDXBVupMP9VkAw8Dpegq9l7Y9k6cRY1FmxI8aD4ZuUsoZCCKuh7xn3rlS1Vm6jnsBF4L/osTBN9wRIA=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=marcel@traut.cloud
        smtp.mailfrom=c0d3@childno.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Am 23.02.2018 um 00:20 schrieb Jonathan Nieder <jrnieder@gmail.com>:
>=20
> Hi Marcel,
>=20
> =E2=80=A6
> Sorry, this is not the most helpful reply but:
>=20
> Can you describe a reproduction recipe so that I can experience the
> same thing?
>=20
> That is:
>=20
> 1. steps to reproduce
> 2. expected result
> 3. actual result
> 4. the difference and why it was unexpected
>=20

1. steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```
Last login: Fri Feb 23 00:33:11 on ttys001
~ PATH variable not enhanced, no applications found in =
~/Applications/*-latest


-bash:/Users/marcel:$ mkdir /tmp/$$
change to new directory '/tmp/2608'? [Y/n]=20


-bash:/tmp/2608:$ mkdir a.git
change to new directory 'a.git'? [Y/n]=20


-bash:/tmp/2608/a.git:$ git init
Initialized empty Git repository in /private/tmp/2608/a.git/.git/


-bash:/tmp/2608/a.git:$ touch foo


-bash:/tmp/2608/a.git:$ git add foo


-bash:/tmp/2608/a.git:$ git commit -m "foo" foo
[master (root-commit) ed191c4] foo
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo


-bash:/tmp/2608/a.git:$ cd -
/tmp/2608


-bash:/tmp/2608:$ mkdir b.git
change to new directory 'b.git'? [Y/n]=20


-bash:/tmp/2608/b.git:$ git init
Initialized empty Git repository in /private/tmp/2608/b.git/.git/


-bash:/tmp/2608/b.git:$ touch bar


-bash:/tmp/2608/b.git:$ git add bar


-bash:/tmp/2608/b.git:$ git commit -m "bar" bar
[master (root-commit) 80b0355] bar
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bar


-bash:/tmp/2608/b.git:$ cd -
/tmp/2608


-bash:/tmp/2608:$ git clone a.git c
Cloning into 'c'...
done.


-bash:/tmp/2608:$ cd c


-bash:/tmp/2608/c:$ ll
total 0
drwxr-xr-x  12 marcel  wheel   384B 23 Feb 05:47 .git
-rw-r--r--   1 marcel  wheel     0B 23 Feb 05:47 foo


-bash:/tmp/2608/c:$ git pull ../b.git/
warning: no common commits
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom ../b
 * branch            HEAD       -> FETCH_HEAD
Successfully rebased and updated refs/heads/master.


-bash:/tmp/2608/c:$ ll
total 0
drwxr-xr-x  14 marcel  wheel   448B 23 Feb 05:47 .git
-rw-r--r--   1 marcel  wheel     0B 23 Feb 05:47 bar


-bash:/tmp/2608/c:$ git reflog
80b0355 (HEAD -> master) HEAD@{0}: pull ../b.git/: checkout =
80b03552466bc526b1130ce5ca4a991ba31a0546: returning to refs/heads/master
80b0355 (HEAD -> master) HEAD@{1}: pull ../b.git/: checkout =
80b03552466bc526b1130ce5ca4a991ba31a0546
ed191c4 (origin/master, origin/HEAD) HEAD@{2}: clone: from =
/tmp/2608/a.git


-bash:/tmp/2608/c:$ git remote -v
origin	/tmp/2608/a.git (fetch)
origin	/tmp/2608/a.git (push)


-bash:/tmp/2608/c:$  git log --all --graph --decorate --oneline =
--simplify-by-decoration
* 80b0355 (HEAD -> master) bar
* ed191c4 (origin/master, origin/HEAD) foo
```

2. expected result
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
just an error in case the too trees have no common ancestors

```
-bash:/tmp/2608/c:$ git pull ../b.git/
warning: no common commits
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom ../b
 * branch            HEAD       -> FETCH_HEAD
fatal: refusing to merge unrelated histories
```

3. actual result
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pulls out, removes all files from the first tree

4. the difference and why it was unexpected
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I can=E2=80=99t find words on it =E2=80=A6 it should not work but it =
did? somehow =E2=80=A6 with unexpected results to my local repository

it somehow seems to be an issue of my config, because resetting it, will =
not allow the pull as expected

```
-bash:/tmp/2608/c:$ GIT_CONFIG_NOSYSTEM=3D1 HOME=3D. git config -l
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
core.ignorecase=3Dtrue
core.precomposeunicode=3Dtrue
remote.origin.url=3D/tmp/2608/a.git
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
branch.master.remote=3Dorigin
branch.master.merge=3Drefs/heads/master


-bash:/tmp/2608/c:$ GIT_CONFIG_NOSYSTEM=3D1 HOME=3D. git pull ../b.git/
warning: no common commits
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom ../b
 * branch            HEAD       -> FETCH_HEAD
fatal: refusing to merge unrelated histories


-bash:/tmp/2608/c:$ git pull ../b.git/
=46rom ../b
 * branch            HEAD       -> FETCH_HEAD
Successfully rebased and updated refs/heads/master.
```

the logs tells me he rebases ...
```
-bash:/tmp/2608/c:$ git config -l | grep merge
diff.tool=3Dp4merge
merge.tool=3Dp4merge
merge.branchdesc=3Dtrue
merge.log=3Dtrue
branch.autosetupmerge=3Dtrue
branch.master.merge=3Drefs/heads/master


-bash:/tmp/2608/c:$ git config -l | grep pull
pull.rebase=3Dpreserve


-bash:/tmp/2608/c:$ git config -l | grep fetch
fetch.recursesubmodules=3Dtrue
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
```


> I suspect that this information is in your message, somewhere, but it
> is (understandably) unfocussed and I am having trouble pulling it out.
>=20

I=E2=80=99m sorry, I just wanted to write down first any helpful =
information without - being late - having time to go into further =
investigations myself =E2=80=A6 hopefully to get some answers that =
=E2=80=9Ethis is ok, you=E2=80=99re just stupid and didn=E2=80=99t read =
the spec/doc=E2=80=9C or =E2=80=9Eok, this seems strange to me too, can =
we go forward in details and analysis=E2=80=9C ;)

> [...]
>> trying to fix this up by doing another pull failed:
>> ```
>> -bash:$ git remote -v
>> origin	git@bitbucket.org:childnode/marcel.git (fetch)
>> origin	git@bitbucket.org:childnode/marcel.git (push)
>>=20
>> -bash:$ git pull
>> fatal: refusing to merge unrelated histories
>=20
> Ok, this part is something I might be able to help shed some light on.
>=20
> Searching for 'unrelated' in "git help pull" finds:
>=20
>       --allow-unrelated-histories
> 	   By default, git merge command refuses to merge histories that =
do not
> 	   share a common ancestor. This option can be used to override =
this
> 	   safety when merging histories of two projects that started =
their
> 	   lives independently. As that is a very rare occasion, no
> 	   configuration variable to enable this by default exists and =
will not
> 	   be added.
>=20
> So that explains the "what" of that error message.
>=20
> The "why" is a separate question.  Could you share output from
>=20
>  git log --all --graph --decorate --oneline --simplify-by-decoration
>=20
> and
>=20
>  git status
>=20

```
-bash:/tmp/2608/c:$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 1 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

nothing to commit, working tree clean


-bash:/tmp/2608/c:$ git branch -avv
* master                80b0355 [origin/master: ahead 1, behind 1] bar
  remotes/origin/HEAD   -> origin/master
  remotes/origin/master ed191c4 foo

```


> to help us understand your current state?
>=20
> Also, suggestions for improvements to the 'refusing to merge' message
> would be very welcome.
>=20
> Thanks and hope that helps,
> Jonathan

just to say: the latter =E2=80=9Erefused pull=E2=80=9C is what I expect =
the first time too!


SUSPECTED / PROVEN to found a guilty setting
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```
-bash:/tmp/2608/c:$ GIT_CONFIG_NOSYSTEM=3D1 HOME=3D. git -c =
user.name=3D"me" -c user.email=3Dme@example.com pull -r ../b.git/
warning: no common commits
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom ../b
 * branch            HEAD       -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
Applying: foo


-bash:/tmp/2608/c:$ ll
total 0
drwxr-xr-x  14 marcel  wheel   448B 23 Feb 06:21 .git
-rw-r--r--   1 marcel  wheel     0B 23 Feb 06:21 bar
-rw-r--r--   1 marcel  wheel     0B 23 Feb 06:21 foo

```
shows me a quite different behavior, so solely rebase not seems the full =
problem
BUT
`--rebase=3Dpreserve` will .. o=E2=80=99man , really, is this intended?

Yes, I see, rebase is a harmful operation and yes, you might now tell me =
a fool
to apply this per default

but why is this unrelated history check different from pull (merge) to =
rebase to rebase -p ?
Can=E2=80=99t find a word on it
https://git-scm.com/docs/git-rebase#git-rebase---preserve-merges


With regards,
~Marcel=
