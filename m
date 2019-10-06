Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A911F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 20:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfJFU16 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 16:27:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:37293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfJFU16 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 16:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570393673;
        bh=Kav6yjPKcVSiCAZbnaFz+ejiTtTyZLc3UkD3o8ygq4A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RNN1XpeRqaI4lzjfAuk9E8kkRshc4hcjYUfe4Ya4VxWg9w78S9PBVH+WFOker79yL
         HQCKY7mBdez8jdvqwOM8j2t6S5TLV/NPhhJaFF62/FbaBEDK+BJIV0fsez4y3+O0DR
         VtTg4Kp9B8aWnz+zXzJOvae2T2bFE/F4JKuL1HJg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1iX4kx1JGg-00LTs3; Sun, 06
 Oct 2019 22:27:53 +0200
Date:   Sun, 6 Oct 2019 22:27:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Harish Karumuthil <harish2704@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
In-Reply-To: <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910062208460.46@tvgsbejvaqbjf.bet>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com> <20160331164137.GA11150@gmail.com> <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com> <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com> <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet> <20191004120107.kpskplwhflnsamwu@yadavpratyush.com> <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com> <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet> <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kgzcQWYStdcpKf7lo467/3vXcONKwqOtXjSADKUshwhIwx0Ytlc
 o5C+zP7ggDL07lBGLNKG/VVMtOBMfZdjbxv4Y9E5jecN4zmjB/6YgafArrZhsJRkM+xhH3g
 wj2Hd43zLH0MOeNY5iY0E9fIehTLNc4lwHSRiI10HWmffpOlKD8y4hHwwG7eB9rb6D48T18
 0TN9LJ1tGLOEdtta/0u9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4j0xFCmNCIM=:NWSuN1BeGvkTOv+GpiQONc
 cRQPmn9wsThIGCUlaSjLxqxhkSnefRwVjdSr3Nf7qi6qfv+7TednjzaNuIgoqPvVGYUUQeGzc
 JKXftkyjqDNHor+0bFZ2E6cqvkwm0H2B1E/ZcGNHa6KGjpaFt/KOXqq4DC5H3mkZh63S0A/0Y
 zt+WOY/q0PQ4fzfnwAUU2DGtWHZITJI9VT0lAl12f7uYEQk0LMpybAZR1VpA1OTtlr9ik00Qn
 4LmcyP4/CqQv6ag9/8SsgzbQUHW9oUJrJpPd6cs1icHDXxrHjwMxgYxzooP4+GSNjvNvt7CMj
 tj8jH05yFpEjqY9nO0ucqmXjMFw8RY6O97a9LUO6BCTXPx15V3uoF/eIfe89vV7MAhPOrNkRw
 I4muPEDuGfG+lwA7a0kD19RizStciCQMPu7Mhs/K0LEmNcb0XmPQ2TfhEx1JWRp8JIOGlWjn9
 iUS4NXEUiuyMmSRDOrKhNpbSkrTvSu7+/YHPQJ5oysz3hR1MGY18GSNrfFFN7AP0hv9Wh8n2m
 upkThJWgiAWiE1xj6BOtfZEQpbuamPV0Qdot6JxuaPMhWa4TAY7W3C9anFcLOxljts1a6Kf9M
 MBk18xBPrlU07suzBHZbykgU00Rqph2D0jyyU1fqPuyPoiYASuIKRc50v+PQ74Y3RM8L2cLkG
 SguNapZuJtDNQHwMQibWqlo+mqzA7o2y02CUAQLahYUx7jtfchRMaMkNQJdjCDl9jUCn8nfxW
 b3Ap0wDyvnngdX8V5Z7ZdBcmTaI5wSKzTEt6qBeoVtT56vWow2JcvKWTz78JWIVLYi4H+W/mQ
 xs+AydpUBYpCNRM7SgoGSOA5u19pj5cy/yDNvWxqCbxNU6nNqtjEjS9fX3AVVSS8k4osD0G8X
 kvBmcrId5gwaJxxvEpqqxowFkMWMXlfUOmKFVuBOY/XzQw1JYzenv3AJ5vG7KbOYLCmqnTPw+
 DfIHYi9nrB/x10wTC3nVVp5uK9YDKYGlTChj9Sswv5C7iY7zSBjLdTMyrEUnw7MvMOrKXuz9e
 IB4HLpRiNzGdKdxR3mXeLZYTkF66eqbyjlwlKQecBDoICY8wUAYLUuOdorFigpzsJKpnAcJGh
 m8Nlk+StFOpt9x1GAhJ2YryaPmo28ChIfLTmpxgPyidS41RP0dKrq+s/HCMXTDwDZarVVnZhW
 6iQgWsof6eyrKUI6Oh4iBfJgje6VPrNE3dG1qsPcuEKPayYMxRkd3dRcyF7FkRS8K3QS9e6JM
 mpTv710mdAzwXB0G/PPFGqgbya+N93asWjWWvwvC0D5JYEgKsrTMxfMmYqAU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Mon, 7 Oct 2019, Pratyush Yadav wrote:

> On 06/10/19 11:49AM, Johannes Schindelin wrote:
> > Hi Pratyush,
> >
> > On Sun, 6 Oct 2019, Pratyush Yadav wrote:
> >
> > > On 06/10/19 01:46AM, Harish Karumuthil wrote:
> > > >
> > > > From https://www.kernel.org/doc/html/v4.10/process/email-clients.h=
tml, I
> > > > understood that, my current email client ( that is gmail web ) is =
not good
> > > > for submitting patches. So I was tying to setup a mail client whic=
h is
> > > > compatible with `git send-mail`. But I was not able to get a satis=
factory
> > > > result in that.
> > >
> > > You don't need to "set up" an email client with git-send-email.
> > > git-send-email is an email client itself. Well, one which can only s=
end
> > > emails.
> >
> > It also cannot reply to mails on the mailing list.
> >
> > It cannot even notify you when anybody replied to your patch.
> >
> > Two rather problematic aspects when it comes to patch contributions: h=
ow
> > are you supposed to work with the reviewers when you lack all the tool=
s
> > to _interact_ with them? All `git send-email` provides is a "fire and
> > forget" way to send patches, i.e. it encourages a monologue, when you
> > want to start a dialogue instead.
>
> Well, I started with email based patch contribution when I was first got
> started with open source, so I might be a bit biased, but in my
> experience, it is not that difficult to set all these things up. Most of
> the time, all you need to tell git-send-email is your SMTP server,
> username, and password. All pretty easy things to do.

Okay, set it up with a corporate Exchange server.

I'll be waiting right here.

> And you add in your email client (which pretty much everyone should
> have), and it is a complete setup. I personally use neomutt as my email
> client, but I have used Thunderbird before, and it is really easy to set
> it up to send plain text emails. All you need to do is hold Shift before
> hitting reply, and you're in plain text mode. And you can even make it
> use plain text by default by flipping a switch in the settings.

How intuitive. And of course Thunderbird still messes up the patches so
that they won't apply, unless you *checks notes* do things that are
quite involved or *checks notes* do other things that are quite
involved.

But then, everybody reads their mails on their command-line anyway.
Right?

> So while I agree with you that there is certainly a learning curve
> involved, I don't think it is all too bad. But again, that is all my
> personal opinion, and nothing based on facts or data.

Let me provide you with some data, then. Granted, it's not necessarily
all Git GUI, but it includes Git GUI patches, too: Git for Windows'
contributions.

As should be well-known, I try to follow Postel's Law when it comes to
Git for Windows' patches: be lenient in the input, strict in the output.
As such, I don't force contributors to use GitHub PRs (although that is
certainly encouraged by virtue of Git for Windows' source code being
hosted on GitHub), or send patches, or send pull requests to their own
public repositories or bundles sent to the mailing list. I accept them
all. At least that is the idea.

I cannot tell you how many contributions came in via GitHub PRs. I can
tell precisely you how many contributions were made _not_ using GitHub
PRs. One one hand. Actually, on zero hands.

So clearly, at least Git for Windows' contributors (including some who
provided Git GUI patches) are much more comfortable with the PR workflow
than with the mailing list-based workflow.

Just so you can't say you don't have data.

> > > So what you should do is run `git format-patch -o feature master..HE=
AD`,
> > > assuming your feature branch is checked out. This will give you a se=
t of
> > > '.patch' files depending on how many commits you made in your branch=
 in
> > > the folder feature/. Then, you can run
> > >
> > >   git send-email --to=3D'Pratyush Yadav <me@yadavpratyush.com>' --cc=
=3D'<git@vger.kernel.org>' feature/*.patch
> > >
> > > This will send all your patch files via email to me with the git lis=
t in
> > > Cc. You can add multiple '--to' and '--cc' options to send it to
> > > multiple people.
> > >
> > > Try sending the patches to yourself to experiment around with it.
> > >
> > > A pretty good tutorial to configuring and using git-send-email can b=
e
> > > found at [0]. And of course, read the man page.
> > >
> > > These instructions are for Linux, but you can probably do something
> > > similar in Windows too (if you're using Windows that is).
> >
> > Last I checked, `git send-email` worked in Git for Windows.
> >
> > But of course, it does not only not address the problem it tries to
> > solve fully (to provide a way to interact with a mailing list when
> > submitting patches for review), not even close, to add insult to injur=
y,
> > it now adds an additional burden to contributors (who might already ha=
ve
> > struggled to learn themselves enough Tcl/Tk to fix the problem) to
> > configure `git send-email` correctly.
>
> The way I see it, git-send-email does not need to solve the problem of
> interacting with a mailing list. That problem is already solved by a
> hoard of MUAs. All git-send-email should do is, you guessed it, send
> emails (or patches to be specific).

But of course! And it is natural that you should use two separate MUAs.

> Anyway, GitGitGadget solves a large part of the problem. It eliminates
> the need for using git-send-email, and it even shows you the replies
> received on the list. I honestly think it is a great tool, and it gives
> people a very good alternative to using git-send-email.

GitGitGadget is just a workaround. Not even complete. Can't be complete,
really. Because problems. It has much of the same problems of `git
send-email`: it's a one-way conversation. Code is not discussed in the
right context (which would be a worktree with the correct commit checked
out). The transfer is lossy (email is designed for human-readable
messages, not for transferring machine-readable serialized objects).
Matching original commits and/or branches to the ones on the other side
is tedious. Any interaction requires switching between many tools. Etc

> One feature that would make it complete would be the ability to reply to
> review comments.

And how would that work, exactly? How to determine *which* email to
respond to? *Which* person to reply to? *What* to quote?

> This would remove the need for an email client (almost) completely. I
> have never written Typescript or used Azure pipelines ever, but I can
> try tinkering around to see if I can figure out how to do something
> like that. Unless, of course, you or someone else is already doing it.
> If not, some pointers would be appreciated.

Feel free to give this challenge a try.

> > > > For now, I followed the instruction of Johannes Schindelin and sub=
mitted a
> > > > pull request . Please see https://github.com/gitgitgadget/git/pull=
/376
> > >
> > > You haven't sent '/submit' over there, so those emails aren't in the
> > > list (and my inbox) yet. You need to comment with '/submit' (without=
 the
> > > quotes) to tell GitGitGadget to send your PR as email.
> >
> > They probably did not hit `/submit` because the initial hurdle is to b=
e
> > `/allow`ed (a very, very simplistic attempt at trying to prevent
> > spamming the mailing list by jokesters, of which there are unfortunate=
ly
> > quite a number).
> >
> > This `/allow` command, BTW, can be issued by anybody who has been
> > `/allow`ed before, it does not always have to be me.
> >
> > FWIW you should probably be in that list of `/allow`ed people so that
> > you can `/allow` new contributors to use GitGitGadget, too.
>
> That would be great! How do I get '/allow'ed? Do I have to open a PR
> there for you to '/allow' me?

https://github.com/gitgitgadget/git/pull/376#issuecomment-538784646

> > > [...]
> > >
> > > > Since #1 is a serious issue, I tried to find out the function whic=
h does the
> > > > keycode validation, but I haven't succeded till now. ( I found the=
 C function
> > > > name  which is "TkStringToKeysym" from TK source, but I couldn't f=
ind its TCL
> > > > binding ). It will be helpful if any one can help me on this.
> > >
> > > I really think you shouldn't dive around in the C parts of Tcl. I
> > > haven't looked too deeply into this, but you can probably wrap your =
bind
> > > calls in `catch` [2] and handle errors from there. Again, I haven't
> > > tried actually doing this, so you do need to check first.
> > >
> > > You can find examples of how to use `catch` in our codebase. Just se=
arch
> > > for it.
> >
> > FWIW in addition to the `catch` method, I would also recommend looking
> > into a minimal (not even necessarily complete) way to translate the Qt
> > way to specify the keyboard shortcuts (as used by `git-cola`) to Tk
> > ones.
> >
> > As indicated in
> > https://github.com/git/git/pull/220#issuecomment-536045075, the Qt sty=
le
> > `CTRL+,` should be translated to `Control-comma`, for example. In
> > particular, keystrokes specified in the format indicated at
> > https://doc.qt.io/archives/qt-4.8/qkeysequence.html#QKeySequence-2 to
> > the format indicated at https://www.tcl.tk/man/tcl8.4/TkCmd/keysyms.ht=
m.
> >
> > However, it might not even need to put in _such_ a lot of work: in my
> > tests, `Control-,` worked just as well as `Control-comma`. To test thi=
s
> > for yourself, use this snippet (that is slightly modified from the
> > example at the bottom of https://www.tcl.tk/man/tcl/TkCmd/bind.htm so
> > that it reacts _only_ to Control+comma instead of all keys):
>
> Another benefit to the translation framework would be that we could also
> generate the menu labels (aka "accelerator") for the tools, instead of
> making the user specify both the shortcut and the label.
>
> > -- snip --
> > set keysym "Press any key"
> > pack [label .l -textvariable keysym -padx 2m -pady 1m]
> > #bind . <Key> {
> > bind . <Control-,> {
> >     set keysym "You pressed %K"
> > }
> > -- snap --
> >
> > So I could imagine that something like this could serve as an initial
> > draft for a function that you can turn into a "good enough" version:
> >
> > -- snip --
> > proc QKeySequence2keysym {keystroke} {
> > 	regsub -all {(?i)Ctrl\+} $keystroke "Control-" keystroke
> > 	regsub -all {(?i)Alt\+} $keystroke "Alt-" keystroke
> > 	regsub -all {(?i)Shift\+} $keystroke "Shift-" keystroke
> > 	return $keystroke
> > }
> > -- snap --
> >
> > That way, you don't have to introduce settings separate from
> > `git-cola`'s, and you can reuse the short-and-sweet variable name.
>
> I think a more important question is whether we _really_ need to have
> compatibility with git-cola. Most of our shortcuts don't match with
> them, so is it really worth the effort to try to keep compatibility?
>
> I'm not against something like this, but just want to be sure we
> evaluate whether the effort is worth it.

`git-cola`, by virtue of being there first, squats on the neat config
setting name `shortcut`.

I expect users to be utterly surprised when that name does not work for
them.

Please note that I intended `QKeySequence2keysym` to leave parameters
unchanged that already refer to keysyms. So this is purely a way to
reuse the same name as `git-cola` while still playing nice with existing
configurations targeting `git-cola`.

Ciao,
Johannes
