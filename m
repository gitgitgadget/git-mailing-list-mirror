Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EAFC433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B8464FC4
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhCJVD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:03:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:59889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhCJVDh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 16:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615410211;
        bh=Q0eRBYcA5SvnqI9MPXpybkPTyWrYxQDiz5Eg99EXcyo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GwV31XJMJSBNbjH8kkITMq2Q4gYvcXzjj/5dDmqIX2X4cni4aFWT4TIaAaEZN3tXt
         0MQTcC4CyjtvPXv8zifxjTxZD2gXGR43MavtvvY0DH+V4JviVwCkQOLKZYMI61xE7Q
         1OjiQl8uhLHL1oVbEzeuMcdC1P1ILR/nfL2sZQRM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.222.251] ([89.1.215.248]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1lrnBJ30As-00c7Je; Wed, 10
 Mar 2021 22:03:31 +0100
Date:   Wed, 10 Mar 2021 22:03:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Gruesso <daniel.gruesso@gmail.com>
cc:     "Patricia B. C." <pati.camsky@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: RES: Can git change?
In-Reply-To: <CAFdpPnBG==5L6hwH6h2JTFtYVQqLZUcCi4+wzL_cpKKg_X3yoA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103101038170.50@tvgsbejvaqbjf.bet>
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com> <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com> <xmqqpn1w95dj.fsf@gitster.c.googlers.com> <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
 <xmqqh7n85qwd.fsf@gitster.c.googlers.com> <CAK8LAYUsebOau+XJ66fEesLm4MfMuxJjse0YL408-2jih1d1eg@mail.gmail.com> <nycvar.QRO.7.76.6.2101251650150.57@tvgsbejvaqbjf.bet> <CAFdpPnBG==5L6hwH6h2JTFtYVQqLZUcCi4+wzL_cpKKg_X3yoA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DpmsaMfnUqUKc6S6mnz67mTByX2SqXKttZDuWt1xXmcvJkzytuy
 E8LsVIZpK9ft+hwsXtVD58Us0B0NNWR+iVe7GTpTBFBr8Oe92eiHwCZ6ZHanwdE43KYxzGe
 omsCrwaC/Bug0CDaPBT+IJj23d8vxmAXgDuxXC4NR3gKYi58pWucFIdz4qdnQQ1Nini9xdZ
 JW9LOS46L5a/1SC/U23hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EZRYBXDMDJw=:u+C8dgiduzyMO1mKKW8tVc
 q6byCG/iW6q7jjQMceVKLCZNS7FKla89Mk7kb5fGFvd2x0BtV5dyut5POQgP+dvLcwjIdQM0P
 tq/9oc/XzXJDNxY2q85mZ4XBupfCOe2Sr1YhE2c0mPvTQxs1mEAUTU53MbWkjvpVhJnh8XSep
 x9RQlXqHWwI6vdLHdUdgpEzsAdAIo14rass5sSepdzVPewd5DC7gMk1FtIIpY0ifU5MfJgAI8
 F25YlFHNZxhgX++3eVyxsapkd4zOfOQ0UYnmKIelEivrMD7K4f8Z0RuVrwbY//ndt8VglfcTY
 rIYK27Apj2Xbxefokq9bqBa1Y+lgyf7K1mL6lI5tXggQXtwlHsGq54p1j1QqKqr98480e1RAY
 ba4j1mtKemuJoXP4GR3QFE0k9MKSX2Z87M+SjNO0QqfdoVcQIhjxUaYZFyEA9Y05E5YCeUCUn
 jB8gG2Lc+EffpDame3RW8642E2wwmm4QKxh/NWKqwefxCFz0PycZ/QvpA7iEUfaZOY86eUiK4
 svwBQFXnfzZuNXkwtHmIE4/QfYqjQkVEaQOF2exSFCS0IkNJc/bdc7Q6KrtJy3Ks3Jd5Y4HTZ
 QSweEs7ckCGB3ixI90cArgrDnKF671dg5zoYicRWhRMIbQgEFilSG2MtWt3oyO9mz4Gf+LjuH
 8IBxun+weKID64y1R08KVKJCIoAh7hAiPKGO6WKmYXeii5k8hFu+j2tXWeO+vHGLg92nGuNKp
 QhoMUm9uJ4i1mDWkfUlTVSIyOTv4P5J1qJ7Jm5OmoDOLocN9XbOp0yTIMWVS/wbX+iA/HxnQQ
 7M/ZsyB3vuaeEj0QN2/Kow1yxiWiKgtH7wXF95Xa//GByQIPDE3uZmveCLt18XT2tHubGf6dh
 prF79dphVqW9top62fpg7sksUSMikcRux9uli0ruU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Mon, 8 Mar 2021, Daniel Gruesso wrote:

> Johannes, based on the comments found in
> https://lore.kernel.org/git/xmqqa6vf437i.fsf@gitster.c.googlers.com, I w=
as
> under the impression Git 2.31.0 would ship with 'main' as the default.
> Surprised to see that's likely not the case.

That was the intention of that iteration of the patch series, but it was
pointed out that we need a much longer time frame to let Git users get
used to the idea that the default branch name is subject to change.

Note also that you're linking to Junio's reply, and in the end it matters
more what Junio's intention is than what _my_ intention is.

For now, we do have that advice that's given when you run `git init`. This
has been shipped as part of v2.30.0, IIRC. That is, if you run `git init`
without setting `init.defaultBranch`, Git will tell you this:

    Using 'master' as the name for the initial branch. This default branch=
 name
    is subject to change. To configure the initial branch name to use in a=
ll
    of your new repositories, which will suppress this warning, call:

    	git config --global init.defaultBranch <name>

    Names commonly chosen instead of 'master' are 'main', 'trunk' and
    'development'. The just-created branch can be renamed via this command=
:

    	git branch -m <name>

I guess that something like 6 months of a "deprecation period" (i.e. the
time to keep `master` as the default) _might_ be enough, so we could
potentially move forward with changing the default around end of May (by
my calculation, v2.32.0 should be due around May 24th, that might be a
good candidate to target).

> > ...also for `git init` to change the default in a future
> > version (I am working toward that goal).
>
> Where can we follow these changes and what version of Git should we expe=
ct
> to contain the change?

Unfortunately, I do not have any such link for you. As to what Git version
to expect it to be in: I don't know. That's Junio's call, I guess. Oh, and
I still need to write all those patches.

Ciao,
Johannes

>
>
> Thanks for all you do.
>
>
>
> Daniel
>
> On Mon, Jan 25, 2021 at 11:33 AM Johannes Schindelin <
> Johannes.Schindelin@gmx.de> wrote:
>
> > Hi Patricia,
> >
> > On Sat, 23 Jan 2021, Patricia B. C. wrote:
> >
> > > Yes, as Junio said, my intention was to understand a bit about what
> > > you were doing, so thank you for the explanation!
> > >
> > > The idea isn't really to imitate what you are doing, but just to use
> > > it as a benchmark to show that changing the name of the branch might
> > > not seem like an important thing, but it is a global movement that i=
s
> > > being adopted by many renowned developers.
> >
> > FWIW Git for Windows switched all of its repositories to use `main` as
> > default branch name: its git/git fork, the build-extra, MINGW-packages=
,
> > MSYS2-packages, git-sdk-32, git-sdk-64, git-for-windows.github.io,
> > msys2-runtime, busybox-w32 and WinToast repositories:
> >
> >         https://github.com/git-for-windows/
> >
> > > Quoting one of the comments on the discussion topic I raised:
> > >
> > > "It's only the default name for repositories created inside GitHub.
> > > Since our students only create their repositories locally on their
> > > computers with Git, I don't see how GitHub's decision will affect
> > > them. If Git decides to change over from master to main, and there i=
s
> > > an industry-wide push to adopt this change (which doesn't seem very
> > > likely to me), then I might agree with you"
> >
> > Any repository created on GitHub will have that branch name by default=
.
> > Likewise on Azure DevOps. I fully expect the other hosters to follow a=
t
> > some stage, and also for `git init` to change the default in a future
> > version (I am working toward that goal).
> >
> > And I have to admit that I am somewhat concerned about your students i=
f
> > one of their instructors thinks that their education shouldn't prepare
> > them for more than working locally on their computers. Aren't they at =
all
> > interested in preparing the students for life after university? If so,
> > they will most certainly be affected by GitHub's decision.
> >
> > > So, I just wanted to show that guy that this is an industry-wide pus=
h :)
> >
> > Maybe Git itself is not a good example for that. Bigger projects face
> > dramatically bigger challenges replacing the default branch name becau=
se
> > of the short term disruption caused by it. Nevertheless, a growing num=
ber
> > of projects have already renamed their default branch, such as Snowpac=
k
> > (https://github.com/snowpackjs/snowpack) and the react-refresh webpack
> > plugin (https://github.com/pmmmwh/react-refresh-webpack-plugin) but al=
so
> > bigger ones such as LLVM (https://github.com/llvm/llvm-project).
> >
> > Ciao,
> > Johannes
> >
>
