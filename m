Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AF5C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 14:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389097AbiDUOm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389541AbiDUOmn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 10:42:43 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18794092D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650551972;
        bh=M2cMIyyEp3m1KPAAFrAYHtPcuanMw38LidmvAjRLyYM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=qirQJ/BfnXKdK1t5/Dyocj3sHvgmyEiHDjD9Kpoh0dXgka9IdLlM2hW9WsD0yGgPE
         f+ojmCJdP9HxbY7Qvr/EhsASTFm2X0BbfAJpWSthOTHY4kijwVXTdxWdrNQAWNkmFp
         YkFhr+S+hS4qtAnAsBVjV8ou0NfijmwPUdnCSUns=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1npFbk0QiC-007uaf; Thu, 21
 Apr 2022 16:39:32 +0200
Date:   Thu, 21 Apr 2022 16:39:31 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Daniel Habenicht <daniel-habenicht@outlook.de>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug Report
Message-ID: <20220421143931.o53dm2qnfcpsido7@tb-raspi4>
References: <f1647260b37d492d96ac92f8ef30a087AS1P190MB1750B08CC923A45E2C959250ECF59@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
 <YmB7gvfKY/0njjZy@camp.crustytoothpaste.net>
 <017001d85506$bee0adf0$3ca209d0$@nexbridge.com>
 <AS1P190MB1750C249B4857371132C5DF0ECF49@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AS1P190MB1750C249B4857371132C5DF0ECF49@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:eJREiOdYbMB6A9C04IeTG6SbYJjI/nE9z5JGtvXUnyzAJ1cL//G
 0Xv92X/F3yMnPPXGQuAmdsaZIm176iEuSX53jUPknG7YJZgzqzpIyJJJoMHUO173vVQjA4X
 c04b0oQ1qS7rkhSjYrN5x9irI+N3I/Hx/9TPrfS4n4Bn5gbDwmXKyS1vUmyyNY9j7/JydO9
 NbuP0GffwxukQ4Mmxe8+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xOC3jO9YyUY=:R1oXo6A7IkN0eYCf0eRmDH
 IGgYbA7r6c537J6ddX9djBbRlJOz7diNWFnt7Zo00KmuGTCOu/fD1Edx6P2OBkNTl867dz1fX
 QkVX57v5xXAJ76A+u+zRv2eDX2wYN51mPQvPNsUkTHf8QfBOopgo2tGcv8wQeX1xAqDhp4/PY
 WbIe8tV+ZpIccaAL8UmBZARBubbXuQB604wyrgkM5tMrYTraALFVY21xmUrpYWpkxFdBMgzF9
 b9PDi0ozdom0QoKnW7icKG+fx9ABWewWvdbxcX0r6ndo1UCTCuMvih+x2UEMOA4yyLCbjMZaf
 LG1iYmyYk4Bm55SFjRPiFl9yN83/g8UoSJCVxhD0R41PbbpIDZ3Nb2Moz8AXMqDaCZFR7/AsG
 rOlUcsBcrqXdpT7TKTnHGHQ6SwARyBymzeIrmQNXeMExClUgjep90xhl66kTDt0TGF4xpUP5J
 EDVC1OJ79qUeCiiS/DYn8Fvaonqetv9SXUSjDhv6zBfzaCX8WCrEFIpEChCPGHOW9rgXEiA6n
 z0tw+VX6EnUWO3HWzKdr0kB8z0mmnh2nU/GC8ZBmknEePeSloZxM7eDXeNIiI/Xw5VLFVWJah
 Lj2EZD4G6DLcMpl9pb6HWzGbukjMkmahWjsJ6/E/48TfjznoZ6kxWstuNjzeGuREUcMiqVmNI
 fi0gttMa9HjKMyuxyhP7UWazwPJ/nKD4qoFXjBHx1ix3fP8J0+O2OhwiYFY/2Rp5E2WleOiM2
 Ed7NehFRRbkoLb1JFf8CNE5jLDKKoBEOzy+yDTC8Lm0XTROriVreNjBfi25BsTyLP8NaAsDHg
 7eCTz9xoASAb4k8sCm87tTmjXASX01vqijo/ADS0myNSR+JK8A87aSxN/gawZGy1FUzetJ8VR
 5uZ6kV0trKfYI0n96vWEvsiA91fwCKUfGsyNUrGRyYcQ2baWADirO6JRdwDZiN4F8fwou1ybl
 Kt2KTU/8sFXtzTK5qeLnyEqF8CCQZ0/gOiIbbM85h6TNH4iY6d7O3oROAtKwdjIX6Df4X93LP
 KmXVdmZaQ9fVFDCAuczspTeoFMB6X5N8lwOZzFwVhtBbessH0cL34KHBStSO787tj5p60EY3X
 LcRLwl0HMKSe3X1pQazDKjJxc3Qko19czazHVR01O2eHJQCFUaOGWUTVLxwQG73LETmfbIWEs
 cVIew=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hej Daniel,

 $ git clone https://github.com/DanielHabenicht/bug-reproduction.git-repo.=
git
 $ cd bug-reproduction.git-repo.git
 $ git ls-files --eol
 i/none  w/none  attr/                   .gitattributes
 i/lf    w/lf    attr/                   README.md
 i/crlf  w/crlf  attr/text eol=3Dlf        test.cs

Your repo needs to be re-normalized:
 $ git add --renormalize .
 $ git status
 On branch main
 Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
          modified:   test.cs

That is all that needs to be done.

Users which are confused may put their frustration aside,
and read the documentation:

https://git-scm.com/docs/gitattributes

especially the part about the line endings and normalization,
search for "renormalize".

I don't know, if there is something we can do that makes live easier,
but if yes: suggestions are more than welcome.

So yes, thanks for the report.




On Thu, Apr 21, 2022 at 01:20:37PM +0000, Daniel Habenicht wrote:
> Hi Randall and Brian,=A0
>
> thanks for the fast=A0response.
> @Randall: I also tried it with autocrlf=3Dinput and it still reproduces.=
 I included it in the reproduction. I also added more examples for confusi=
ng behaviour.
>
>
> Here is the full bug report:=A0
> (You can view a Markdown rendered version of this reproduction at: https=
://github.com/DanielHabenicht/bug-reproduction.git-repo)
>
> # Description
>
> When changing the `.gitattributes` file not all changes to the checked i=
n files are apparent.
> They only get updated on a new clone or when refreshing the index - that=
's somehow expected.
> But it creates confusion and unexpected behavior if they are not updated=
 together with the `.gitattributes` changes.
> It can make easy changes between branches impossible, break the flow of =
squashing commits or lead to confusing state of everlasting uncommited cha=
nge.
> These edge cases for confusing behaviour I have added below.
>
> # Reproduction
>
> 1. Checkout with the following `.gitconfig` settings set:
>
> ```gitconfig
> # .gitconfig
> [core]
>     autocrlf =3D false
> # Or
>     autocrlf =3D input
> ```
>
> 2. Clone the repository
> ```bash
> git clone https://github.com/DanielHabenicht/bug-reproduction.git-repo.g=
it
> ```
>
> 3. `test.cs` should be shown as `modified`
>
> > This is confusing to the user, he just checked the repo out and did no=
t change a thing. At least there should be a warning?
>
> ```
> git status
> On branch main
> Your branch is up to date with 'origin/main'.
>
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>         modified:   test.cs
>
> no changes added to commit (use "git add" and/or "git commit -a")
> ```
>
> 5. Running any git command like the ones below will not remove the chang=
ed file:
>
> ```bash
> git rm --cached -r .
> git reset --hard
> git add --renormalize .
> ```
>
> > This as well is very confusing and there is no indication on why this =
is happening and there are still modified files after everything should be=
 reset.
> > Keep in mind that this could have happened in error and could be happe=
ning to a totally unrelated (to the inital `.gitattributes` change) user.
>
> 6. Running `git diff` is even more confusing, and doing as the warning s=
uggests (`warning: CRLF will be replaced by LF in test.cs. The file will h=
ave its original line endings in your working directory`) and replacing `C=
RLF` by `LF` does silence the warning but does not change the diff itself:
>
> ```diff
> warning: CRLF will be replaced by LF in test.cs.
> The file will have its original line endings in your working directory
> diff --git b/test.cs a/test.cs
> index 1e230ed..5464a2d 100644
> --- b/test.cs
> +++ a/test.cs
> @@ -1,11 +1,11 @@
> -using System.Diagnostics.CodeAnalysis;
> -using System.Linq;
> -using Xunit;
> -using Moq;
> -
> -
> -
> -namespace Tests
> -{
> -
> -}
> +using System.Diagnostics.CodeAnalysis;^M
> +using System.Linq;^M
> +using Xunit;^M
> +using Moq;^M
> +^M
> +^M
> +^M
> +namespace Tests^M
> +{^M
> +^M
> +}^M
> ```
>
> > This is showing the exact opposite of what git is really doing. Actual=
ly it replaces the line encoding of the index (i/crlf) with the right enco=
ding (i/lf) (see **[1]**)
> > From the git user perspective everything is in great shape, the file i=
s LF, as it should be, but still git complains about a change that is not =
visible to the user without background knowledge about gitattributes and t=
he git index.
>
> 8. Try changing the branch to a modified copy with `git checkout some-ch=
anges` is not possible (also with the recommended command). The only solut=
ion would be to commit - nothing else helps (but thats not really a soluti=
on). :
>
> ```bash
> error: Your local changes to the following files would be overwritten by=
 checkout:
>         test.cs
> Please commit your changes or stash them before you switch branches.
> Aborting
> ```
>
> > This makes changing branches harder, as it can't be force reset and gi=
t will always complain about files being overwritten.
> > It also break the flow for squashing commits as you would need to manu=
ally intervene (and add a commit) if someone forgot to commit all files af=
ter a .gitattributes change and only recognized it at a later date.
>
>
> **[1]**: I hope this answer explained it right to me: https://stackoverf=
low.com/a/71937898/9277073.
> But it is rather unintuitive to me, and possibly other users, as there s=
eems to be a hidden middle layer leading to this problem. See the graph at=
 the github repo)
>
>
>
> Cheers,
> Daniel
>
>
>
>
> Daniel Habenicht
>
>
> From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
> Sent: Thursday, April 21, 2022 00:34
> To: 'brian m. carlson' <sandals@crustytoothpaste.net>; 'Daniel Habenicht=
' <daniel-habenicht@outlook.de>
> Cc: git@vger.kernel.org <git@vger.kernel.org>
> Subject: RE: Bug Report
> =A0
> On April 20, 2022 5:31 PM, brian m. carlson wrote:
> >On 2022-04-20 at 19:45:32, Daniel Habenicht wrote:
> >> Hi there,
> >>
> >> I think I found a bug or at least some unexpected behavior. Please
> >> have a look at the following reproduction repo:
> >>
> >> https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2FDanielHabenicht%2Fbug-reproduction.git-repo%2Fblob%2Fmain&amp;=
data=3D05%7C01%7C%7C145ae6f595d54ac7b5fd08da231de43c%7C84df9e7fe9f640afb43=
5aaaaaaaaaaaa%7C1%7C0%7C637860908535410706%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&amp;sdata=3DHXFm4sBZ5yQGQPkBlkzKhkgDJOXBqSlgETkrhGxgkmI%3D&amp;reserved=
=3D0
> >> /README.md
> >
> >You're more likely to get someone to look at this if you post the actua=
l text to the
> >list.=A0 While I might be willing to look at it on GitHub, other folks =
won't, and I
> >probably won't get a chance to look at this issue anytime soon.
>
> The only thing that I can see that is apparently a problem is that autoc=
rlf=3Dfalse is not documented in the config help, so it is not apparent wh=
at the expected result should be relative to the test case. That could be =
considered confusing. There could also be confusion relative to when the g=
it diff was done relative to what is in the staging area given his test ca=
se. I think what Daniel may really want is to use autocrlf=3Dinput.
>
> Daniel, please post your entire report to this list rather than using Gi=
tHub, links, or attachments. I happened to be on GitHub at that moment, so=
 looked, but otherwise, I would not have specifically looked.
>
> --Randall
>
> --
> Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)
> NonStop(211288444200000000)
> -- In real life, I talk too much.
