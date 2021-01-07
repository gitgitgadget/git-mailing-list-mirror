Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95196C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 15:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C8923403
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 15:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbhAGPvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:51:33 -0500
Received: from mout.web.de ([212.227.15.14]:52627 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGPvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 10:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1610034567;
        bh=FS1/ezkkLlnWCg8yR7O2kiLkqLM0AasivCdST5fxWqg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ItHhN8LgI963tp4FEIaBt7fG/rdRXA3e2ghA3SyrXOvi9clK3vk73yPgvgOj3FjTb
         zYMYEdmuKw03/OHYPYqRXqKNdoTnQEFwu1tDsIiN6OGE4k5NCoqQRjC1imvwYHyDe6
         faHmiHhYRrF/1PDQgCybrV+Q0LjYEcKejn5eXc/I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtoCT-1jwjeU1o4j-011DFE; Thu, 07
 Jan 2021 16:49:27 +0100
Date:   Thu, 7 Jan 2021 16:49:26 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Daniel Troger' <random_n0body@icloud.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
Message-ID: <20210107154926.6tb7ukgemn7kmpnl@tb-raspi4>
References: <20210106214737.qwlp4jvg3x2voafs@tb-raspi4>
 <A342FAE0-A363-4280-848C-162F38C22C8E@icloud.com>
 <002601d6e480$c193bd00$44bb3700$@nexbridge.com>
 <ffe0a3ae-780d-95ae-524d-7b029eda21ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ffe0a3ae-780d-95ae-524d-7b029eda21ee@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:LIDrEHbfJu09xJ2GhVkI6XHpeImOVSnp+Dj5Y3p2ZZMUmmT49Iv
 bozNxUjaIPOyRP78EA0kvsYps0MUijj8mIZD+rQpQb2G9692bSquUFuovoCqRoxPVzTS279
 +3Hj9XvaBqtzun0rOKLpZTeUjDTWIUHQO6nHBsctp6XvObeW9GHPEYzpPAd9FCzyhqHDgRH
 fSlTFalxJt3C5RNVqTj5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7koInp6JZTc=:uMPGx/PbHfkPKPHAXE/AL9
 GH2OK5lxEhZ+VSVWeLB37yO1QrluHFKZOggKyjDVmbGta3VtSfQMNWHPq7AV56JPPX2KBb13J
 rgZZGN5Ip11DJ/BE/E4leHtimgKbCNyvz+lODtfZW1UFUI1kGa3qQZWIsYECUMj570TJkV1eR
 KYddaTjC0/AHhvC9L2OLsmB0/AwD/nGhte9QcMElqsNjNOelt0tiajzo/2Vq1FCGccd3Vuhv1
 o5/ShWOBPikraMW80fYleh7zb7ZhtXc7G3eI/tbZRk6CYhMtN3UWpsTSMYsFj3YhzLoL6IqVM
 ne0BogyuYwUUA/nS5pxr5PStx2VMD9AU+JmlHDJf5Bmi37VZTB/Q4wYe8L9q9EnOgJbPJq1S1
 PUT1rHuiUSRt+YW4rwEa2+Wvdlfukuc2/iGk10o9dsw7kgGoR6bbloD+QTOfu5R7sSL/gxErn
 5qPbXvnUWsKSK/LbH01UGYjdK26bHfzMNJCGe1n+o1W56cFcSIA7lVwC/bxbXVquNb2QvxoCM
 lYzNlYER8OdfszfIRz6JhU4txgMf0K5pjKisZXOhUumNtRu+rdbR2OoV1ouzACbA7cXd8RrQX
 eBkOzvIzGJLI8aKsh0xPX8V0HBn676FY3bif8gBUqSkjlLs7xgav0HFAuvFCj9dRr+3EmJb4M
 Vu9aTYwIyfexKpzsi7ke85LFeTJBbf3NiPbqGCWg6VXvThwDLczG2P9LkkISApr/dvLHyhJZD
 bUzVREV5bOGv80bf0Fsb0Yh6gbNCDWQMp+vuuvToilSEzHMCYDCdgjsdEJeEYZwqB/zM9b2/H
 6jnYXuw1v+jbiaMV0SMUsZT0JlhFhbaDz1jhI9F2+PVf8yY2N/Ka/HR6WnWbm5XiwGY3aW0T8
 hJmW2tVKEa2d1K6v0I0w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 07, 2021 at 09:34:35AM -0500, Philippe Blain wrote:
> Hi everyone,
>
> Le 2021-01-06 =E0 18:07, Randall S. Becker a =E9crit=A0:
> > On January 6, 2021 5:22 PM, Daniel Troger wrote:
> > > Hi, maybe this helps you reproduce. I think I should have committed =
before
> > > doing the second changes but I still got the error message and the t=
wo
> > > names for one folder:
> > >
> > > me@iMac:/tmp$ mkdir git_bug
> > > me@iMac:/tmp$ cd git_bug
> > > me@iMac:/tmp/git_bug$ git init
> > > hint: Using 'master' as the name for the initial branch. This defaul=
t branch
> > > name
> > > hint: is subject to change. To configure the initial branch name to =
use in all
> > > hint: of your new repositories, which will suppress this warning, ca=
ll:
> > > hint:
> > > hint: 	git config --global init.defaultBranch <name>
> > > hint:
> > > hint: Names commonly chosen instead of 'master' are 'main', 'trunk' =
and
> > > hint: 'development'. The just-created branch can be renamed via this
> > > command:
> > > hint:
> > > hint: 	git branch -m <name>
> > > Initialized empty Git repository in /private/tmp/git_bug/.git/
> > > me@iMac:/tmp/git_bug$ ls -la total 8
> > > drwxr-xr-x   4 daniel  wheel   128 Jan  6 23:13 .
> > > drwxrwxrwt  27 root    wheel   864 Jan  6 23:13 ..
> > > drwxr-xr-x   9 daniel  wheel   288 Jan  6 23:12 .git
> > > -rw-r--r--@  1 daniel  staff  1283 Jan  6 23:13 paulbrunng=E5rd-spri=
ngyard.zip
> > > me@iMac:/tmp/git_bug$ unzip paulbrunng=E5rd-springyard.zip
> > > Archive:  paulbrunng=E5rd-springyard.zip
> > >     creating: paulbrunnga??rd-springyard/
> > >    inflating: paulbrunnga??rd-springyard/.DS_Store
> > >     creating: __MACOSX/
> > >     creating: __MACOSX/paulbrunnga??rd-springyard/
> > >    inflating: __MACOSX/paulbrunnga??rd-springyard/._.DS_Store
> > >   extracting: paulbrunnga??rd-springyard/empty me@iMac:/tmp/git_bug$=
 rm
> > > -rf __MACOSX/ *.zip me@iMac:/tmp/git_bug$ ls -la total 0
> > > drwxr-xr-x   4 daniel  wheel  128 Jan  6 23:15 .
> > > drwxrwxrwt  27 root    wheel  864 Jan  6 23:13 ..
> > > drwxr-xr-x   9 daniel  wheel  288 Jan  6 23:15 .git
> > > drwxr-xr-x@  4 daniel  wheel  128 Jan  6 12:20 paulbrunng=E5rd-sprin=
gyard
> > > me@iMac:/tmp/git_bug$ cd paulbrunng=E5rd-springyard/
> > > me@iMac:/tmp/git_bug/paulbrunng=E5rd-springyard$ nano empty
> > > me@iMac:/tmp/git_bug/paulbrunng=E5rd-springyard$ cat empty Initial
> > > content me@iMac:/tmp/git_bug/paulbrunng=E5rd-springyard$ git add emp=
ty
> > > me@iMac:/tmp/git_bug/paulbrunng=E5rd-springyard$ nano empty
> > > me@iMac:/tmp/git_bug/paulbrunng=E5rd-springyard$ cat empty Initial
> > > content
> > >
> > >
> > > Line I want to keep
> > >
> > > Line I want gone
> > > me@iMac:/tmp/git_bug/paulbrunng=E5rd-springyard$ git restore -p .
> > > BUG: pathspec.c:495: error initializing pathspec_item Cannot close g=
it diff-
> > > index --cached --numstat --summary
> > > 4b825dc642cb6eb9a060e54bf8d69288fbee4904 --
> > > :(,prefix:27)paulbrunng=E5rd-springyard/ () at
> > > /usr/local/Cellar/git/2.30.0/libexec/git-core/git-add--interactive l=
ine 183.
> > > me@iMac:/tmp/git_bug/paulbrunng=E5rd-springyard$ cd ..
> > > me@iMac:/tmp/git_bug$ git status
> > > On branch master
> > >
> > > No commits yet
> > >
> > > Changes to be committed:
> > >    (use "git rm --cached <file>..." to unstage)
> > > 	new file:   "paulbrunnga\314\212rd-springyard/empty"
> > >
> > > Changes not staged for commit:
> > >    (use "git add <file>..." to update what will be committed)
> > >    (use "git restore <file>..." to discard changes in working direct=
ory)
> > > 	modified:   "paulbrunnga\314\212rd-springyard/empty"
> > >
> > > Untracked files:
> > >    (use "git add <file>..." to include in what will be committed)
> > > 	.DS_Store
> > > 	"paulbrunng\303\245rd-springyard/"
> > >
> > > me@iMac:/tmp/git_bug$
> >
> > Is it possible that the =E5 character is coming from a UTF-16 encoding=
 and is not representable in UTF-8? I'm wondering whether the name has a d=
ouble-byte representation where one of the bytes is null, resulting in a t=
runcated file name coming from readdir(). The file name would not be repre=
sentable on some platforms that do not support UTF-16 path names.
>
> I don't think that's the case (the angstrom is present in UTF-8 [1]).
> I think it's another UTF-8 precomposed/decomposed bug. As far as I
> was able to test it happens as soon as you have a precomposed character
> in the folder name. I observed the same behaviour with a folder named
> "folder=FC", for example. I also tried 'git -c add.interactive.usebuilti=
n restore -p .'
> to see if the new experimental builtin=A7 add-interactive has the same p=
roblem,
> and it does (though the error is less verbose).
>
> Anyway as you show with 'git status', it's not just 'git add -p' that is
> faulty, it's deeper than that, I would say.
>
> Cheers,
>
> Philippe.
>
> [1] https://en.wikipedia.org/wiki/%C3%85#On_computers

Folks, I can not reproduce anything here.
- The zip file mentioned earlier does not include a decomposed "=E5"
  Neither when running unzip under Linux nor under Mac
- Trying to write a test script does not show anything special

My attempt looks like this:
cat test.sh
#!/bin/sh
DIR=3Dgit-test-restore-p
GIT=3D/usr/local/bin/git

Adiarnfc=3D$(printf '\303\204')
Adiarnfd=3D$(printf 'A\314\210')
DIRNAME=3Dxx${Adiarnfd}yy
FILENAME=3D$DIRNAME/file

rm -rf $DIR &&
    mkdir $DIR &&
    cd $DIR &&
    $GIT init &&
    mkdir $DIRNAME &&
    echo "Initial" >$FILENAME &&
    $GIT add $FILENAME &&
    echo  >>$FILENAME &&
    echo  >>$FILENAME &&
    echo "One more line"  >>$FILENAME &&
    echo  >>$FILENAME &&
    echo  >>$FILENAME &&
    echo "Last line"  >$FILENAME &&
    $GIT restore -p . &&
    $GIT restore -p . &&
    echo git=3D$GIT &&
    $GIT --version &&
    echo "OK"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
It points out Git from brew, I think.
And running it (using a decomposed =C4 instead of =E5 or =FC)
shows nothing strange, please see below.

Is anybody able to provide a shell-script, that does reproduce ?
Excuse my bad shell-programming style, this is for demo only.

hint: is subject to change. To configure the initial branch name to use in=
 all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:   git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this comma=
nd:
hint:
hint:   git branch -m <name>
Initialized empty Git repository in ..../2021-01-07-git_decompose_test/git=
-test-restore-p/.git/
diff --git a/xx=C4yy/file b/xx=C4yy/file
index a77fa51..8ea8e21 100644
=2D-- a/xx=C4yy/file
+++ b/xx=C4yy/file
@@ -1 +1 @@
-Initial
+Last line
(1/1) Discard this hunk from worktree [y,n,q,a,d,e,?]? y

No changes.
git=3D/usr/local/bin/git
git version 2.30.0
OK

