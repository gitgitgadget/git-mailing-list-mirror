Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C616C3F2C0
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C895024690
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FQcmR0m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgB0VEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:04:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:42505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgB0VEs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 16:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582837475;
        bh=ZiQGALxeLcwzaZotRWqtV8mw9Etd7/12dPK+MTVZ410=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FQcmR0m20Ob3vwu9YijRwztySBJX2LaA+jp6BXJqs55GwHzn+zPo2ECAsREOS9lF5
         hmCAIXmbkSq1mK66cQr5DGLzD4G4NL/OEQ21KFzW24IRWM9NBfVLe+k5JdFVOMn4d6
         bruac8dOVGIthwYvZBC/N3loCERSC9HF6foJkcQg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1jlPud3TxB-00mrgq; Thu, 27
 Feb 2020 22:04:34 +0100
Date:   Thu, 27 Feb 2020 22:04:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        lyle.ziegelmiller@gmail.com, git@vger.kernel.org
Subject: Re: ! [remote rejected] master -> master (unpacker error)
In-Reply-To: <20200218051956.GA1641086@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2002272204150.46@tvgsbejvaqbjf.bet>
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com> <20200216211604.GE6134@camp.crustytoothpaste.net> <20200218051956.GA1641086@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zwnJiBXE8XZ3mSVhMYh178aC17ZcXIYzp5vxyrrYQjne2cAT1Ag
 7QyypJaPA9CO8HPvQptFzbri7XzXoQ0YQraAlQUDp5nJkSFUNLmR0gX/5ChUm58UpFVC/nx
 YZmskXaeDOAFuYdC+/fO0yZojub5hjXCzSSvkYoWR4eGolnrPUtdKQMxwi1VGj6mpwV33d5
 9oGniHxSr6L0ENhk4bL+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CI/hI7himho=:Pvu06maJjPXER7ju9E6c3l
 mhelf9rWmHWSDgubSha9vEUCW6ly3QOXTaGtCDewt9LPQtbTPMU8TwcX+lmh/k3jMSCb9HYph
 CZRo+D7BzQX1HvxVCesI6zJx/fvQ2IFC00VjJuibFZKnRfw1G2qkLihel9RBqr8Yklq7jacID
 btjwpR29V39Jp7BqWq8Imj2B13eGt0buI0jmu2/+RL853/JSTzrEK2C3u4wHs5mEhY5mZDlMN
 CenNUa5PfIL1VFxgTx22aq1teVXfGlE5RvioTfChyyEe8xFNdRIQ7P2kxu2B7pVnltBVW+e/z
 GdkMisuToYS3UReUNhRGl9k/iTHhZV+BVGqIvTqkGTJexLE0lN6nwKuq0BxgnqiHXIGAVxF8a
 mkiOb3phxo0A9aQCstprsETDE0EP3vAtLtJKlQ/dKuGVqJKgoA5UdQo7pW5QnD9KNpzhkXdfw
 W+wjoPnu+A+cCZGY7blLwFnfh5jCPR7YutZYLpBcqKn5fzDPgEW0D9RXvpN77rKMQ3z/OiVSn
 lsN23sV7wABrNmii1YtdxLRkm9ER64NObssKvr/3LN+mQmgLXEp8VqcqqG/6PopZALehyL7Bh
 G8Wtrv15t8R5OPRpaS5NAqsaI+zhePpBc5AnI14BZJVp420Q5ukvpFKP5sGFxMsiUs80fasKS
 2mAwWnFb+fExFtm55CbVD2rN4JApijqBA73raF7gN87p9plOVJMbSxiCQ2i628ys2elz2k9Xw
 59fI2IbnDPu7L8uiHSb/UZcDRui0yHvZpyYXsqo/+uaRoKjDZutrTZKKipLLmY0vSGRUw3JQN
 E1ktPgZ5ci6Rgdn5rePSNGbi5vg9AUIR3SqkccaaiuptHSmfJYZPhQHRluBOz48tO3JpouvxL
 ydQjmOfRuT1SRWVaGvEFqpix3hgnnsleymb+X4PDIjaEqwPg+g9s1l6oVK5+RyO6fp2/I6BH8
 BKM96eNRXpEBwF/IMx0FOp1yzEoAkEEuyg7XR+3wnY/L/3i6Tuc0L+l4ejrct3RVSJxGs9ui1
 SA6oPeWGoNtK2XUnaTbQOt9PK7WNev3U40UsIOR06a//TzktGAQ95Ht2dV8U0Rxj7vCHF8/ax
 5vbS1r2DTCg1i2xXw/XS0WiR5wn50kKBR01AXCrv5ZbyO7YxYMV9iGrLltdKGfduBvYDyLiqF
 bzeVxtcIhljAKzUFn6SmbOw6g1JwSJs/YqPdwrJ8XAZwhSsET/qNFSB+T2QmmK2IscZRsN2EJ
 htUwQfPNn0byl1kWP
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 18 Feb 2020, Jeff King wrote:

> On Sun, Feb 16, 2020 at 09:16:04PM +0000, brian m. carlson wrote:
>
> > On 2020-02-16 at 16:10:12, lyle.ziegelmiller@gmail.com wrote:
> > >
> > > Any updates on this error I emailed a while back?
> > >
> > > lylez@LJZ-DELLPC ~/python
> > > $ git push
> > > Enumerating objects: 5, done.
> > > Counting objects: 100% (5/5), done.
> > > Delta compression using up to 4 threads
> > > Compressing objects: 100% (2/2), done.
> > > Writing objects: 100% (3/3), 279 bytes | 23.00 KiB/s, done.
> > > Total 3 (delta 1), reused 0 (delta 0)
> > > remote: fatal: not a git repository: '.'
> >
> > This error is telling you that Git doesn't think the remote location i=
s
> > a Git repository.  It could be because it really isn't one, or it coul=
d
> > be that the permissions are wrong.
> >
> > It could also be that the repository is mostly there but very slightly
> > corrupt and therefore can't be detected as one.  For example, it could
> > be missing its HEAD reference.
>
> I think it's more subtle than that, though. If it wasn't a git
> repository at all, then receive-pack would fail to start, and you'd get
> something like this:
>
>   $ git push /foo/bar
>   fatal: '/foo/bar' does not appear to be a git repository
>   fatal: Could not read from remote repository.
>
>   Please make sure you have the correct access rights
>   and the repository exists.
>
> The output above, plus the:
>
>   error: remote unpack failed: unpack-objects abnormal exit
>
> makes it looks like receive-pack started just fine, but something about
> the way it set up the environment made the child unpack-objects unhappy
> when it tried to initialize its internal repo variables.
>
> I have no clue what that "something" is, though. Windows and UNC paths
> were mentioned elsewhere, which seem plausible. It mentions ".", so
> presumably we've chdir()'d into the receiving repository and set
> $GIT_DIR. Which I'd think rules out any weird interpretations of UNC
> paths in $GIT_DIR.

I thought that I remembered that it is not possible to `chdir()` into a
UNC path. And it would seem that `cmd.exe` still cannot have a UNC path as
a current directory.

But PowerShell can, and so does `git.exe`, apparently (I tested this using
`wsl bash -lc "cd ~ && git.exe -C . version"`).

But I vividly remember that there used to be a problem even with
`git.exe`, probably still is a problem on older Windows versions. That
might be the problem here?

Ciao,
Dscho

> I'd expect that error if we did a chdir() internally to some other path
> after setting up $GIT_DIR, but I don't know why we'd do that (I thought
> at first that the quarantine code in receive-pack might be related, but
> we don't ever chdir() into the quarantine dir; we just set up
> GIT_OBJECT_DIRECTORY).
>
> -Peff
>
