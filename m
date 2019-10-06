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
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDCE1F4BE
	for <e@80x24.org>; Sun,  6 Oct 2019 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfJFJuO (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 05:50:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:48561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJuO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 05:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570355411;
        bh=Cny+rWs47Pc7WqWpe3vMbPtCXx6lH29gFMG5vGBAv+Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hhSeMt/jv49Y6zsYTNyxqdsS9Rru+Awkcz2uRqJqf7nd63H4lwt/xyzyOoKAuh0fY
         E7Z+V734Fdm0SJWK/b1bTzswNl1osAQon5HibaZIWlNl3yJBi7OxIyUyESxxfVgXhZ
         Mpe5t7ozSc7TIzo9tUBIOjxFUvgExqrphnrlX0bk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1i3B643hYk-0181DT; Sun, 06
 Oct 2019 11:50:11 +0200
Date:   Sun, 6 Oct 2019 11:49:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Harish Karumuthil <harish2704@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
In-Reply-To: <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com> <20160331164137.GA11150@gmail.com> <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com> <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com> <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet> <20191004120107.kpskplwhflnsamwu@yadavpratyush.com> <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
 <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b8Kx8QbHLmsFaGUkp4vdtYC7EBOlQSLUNPoeAfIqCEDdx0SW6qj
 WbNeiYHeUJbu6XPWBQz2s4KsuRMToSLkPvE7drfAYP6KwkChEzMyvNno4LkETUUSIKif5HG
 UImXb9R1/EV2OrmoNRH3hoe9dVVRgKlegDTMx/bFVvNMaOaTXz1kcsBOVjIxS+M8qXgH/DC
 oNIVWFeIXwalnxFQZLUHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ok19sZYyoQ=:uVZgMvPYG8/FGIrtVCXpnl
 g0O4Qp5B9UOx5pN6WfPZBsXMVfIoST2nJ2XxVM2k7o+6cqsjoQsnndxGbdqNuoqsCImnBZvub
 Srb2pLP52/57SDKjbdgVVCCl3ejm+C0vbSo0/xconmDsRfl1h2AgTHMMbOzlP5VozngZSFq9r
 u6wcuVM3dPHUw5JEKWrclnxgz7zY6NzVWtvyAMzdaMReuCzvO666ESWpHWCIuWBsMAfanHEB1
 lVDoQPwrW7tARuqXr3gLw7yrVEfOIYFemnjFXCjiSxm1HjJO53iK6/fMW0kxMbpT0LgsRqcwL
 Iy0EjSpWJWgtMmParG2CkZUPHj6+Wquj0tYSb3HJK/IvbRbZscCtjWYb6ljqeIO5xM9nHG2OC
 kBZCoyj6KeTxcf9FGbKTdkUMlf7RNNsyy4IYuN6LvJEzZcPme/aziEiExyulQ3oWOed1R8YgW
 3i1yoSNA4UzyAsNR7rECLZLEk9esenRwHwiwvVa66SWZdrWzGR/q/P/nvSmndFkznIq0Gp02k
 ViXIPpjVOoFQ4qD6LcNNjopJnr7TBKUKql/bxQ81bmvtQSS3y99ut57aLN4kRpnolrv1BucFC
 1N/JwkE7/JOkvq44X2rwF3AlAAiemPhSypqVEvp7wkrxXgq+8gFoWamib3+EwS94XDH9ObE3m
 gUHeWEjo60Em/MFdHMHwyJdaDJq/wc3bd1oh57YqHE4hFRP+Dx6o7v6dzW80AzG/U53X8nmtv
 9uJRgWJ3QOSyneBo0c4Q4vISY3aC7TZ4fbLuDsIx3Nlgyho61xClJzr7NksE03ifIU2vSU3rg
 mi3X61f5NFZmxNBvpzlmpfqZT3jFbpf4gN8geagJcDbSvrxNAwO0WbdsrPdHqH9WvPftK1VcJ
 NYYNXAhRMGj5gipwj7ju5/VVTfwVqSEledzwtVt3wlJySrILLwiHQOvA0koGj7DoK0Isre2tW
 3WBfIq+UvAE+RbN8lJg/95SgftX7OnhKhmFW6mG9oFbSLgZure1ePGlDyEQ7Jm17adctRUq3f
 ycdnFdk1N6p/+mcpw3JEI5jG/klFLqLDqh5L7sel6JptUuP6BtcA4vz5D+h3CCGxrhkrVxzL8
 ezDcmPPKamWsdk894pCZqhYal83Ium8LHKjpnlXtPyLxeaXFe8YlEfeLs3B14nCJAr5gWK6xK
 /H+6oBWN/HzD4vFukZEPPHip3mTeGnnxTj3JcRfRlMeiTKhvQUt0we5qvuDY7GolHMxx8/aq2
 hhEwDDF/hP9geOhMPbzIZMwVPe1MoNDU8fE3BQu5H5y76KbmnAdHfTg4HGQk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Sun, 6 Oct 2019, Pratyush Yadav wrote:

> On 06/10/19 01:46AM, Harish Karumuthil wrote:
> >
> > From https://www.kernel.org/doc/html/v4.10/process/email-clients.html,=
 I
> > understood that, my current email client ( that is gmail web ) is not =
good
> > for submitting patches. So I was tying to setup a mail client which is
> > compatible with `git send-mail`. But I was not able to get a satisfact=
ory
> > result in that.
>
> You don't need to "set up" an email client with git-send-email.
> git-send-email is an email client itself. Well, one which can only send
> emails.

It also cannot reply to mails on the mailing list.

It cannot even notify you when anybody replied to your patch.

Two rather problematic aspects when it comes to patch contributions: how
are you supposed to work with the reviewers when you lack all the tools
to _interact_ with them? All `git send-email` provides is a "fire and
forget" way to send patches, i.e. it encourages a monologue, when you
want to start a dialogue instead.

> So what you should do is run `git format-patch -o feature master..HEAD`,
> assuming your feature branch is checked out. This will give you a set of
> '.patch' files depending on how many commits you made in your branch in
> the folder feature/. Then, you can run
>
>   git send-email --to=3D'Pratyush Yadav <me@yadavpratyush.com>' --cc=3D'=
<git@vger.kernel.org>' feature/*.patch
>
> This will send all your patch files via email to me with the git list in
> Cc. You can add multiple '--to' and '--cc' options to send it to
> multiple people.
>
> Try sending the patches to yourself to experiment around with it.
>
> A pretty good tutorial to configuring and using git-send-email can be
> found at [0]. And of course, read the man page.
>
> These instructions are for Linux, but you can probably do something
> similar in Windows too (if you're using Windows that is).

Last I checked, `git send-email` worked in Git for Windows.

But of course, it does not only not address the problem it tries to
solve fully (to provide a way to interact with a mailing list when
submitting patches for review), not even close, to add insult to injury,
it now adds an additional burden to contributors (who might already have
struggled to learn themselves enough Tcl/Tk to fix the problem) to
configure `git send-email` correctly.

> > For now, I followed the instruction of Johannes Schindelin and submitt=
ed a
> > pull request . Please see https://github.com/gitgitgadget/git/pull/376
>
> You haven't sent '/submit' over there, so those emails aren't in the
> list (and my inbox) yet. You need to comment with '/submit' (without the
> quotes) to tell GitGitGadget to send your PR as email.

They probably did not hit `/submit` because the initial hurdle is to be
`/allow`ed (a very, very simplistic attempt at trying to prevent
spamming the mailing list by jokesters, of which there are unfortunately
quite a number).

This `/allow` command, BTW, can be issued by anybody who has been
`/allow`ed before, it does not always have to be me.

FWIW you should probably be in that list of `/allow`ed people so that
you can `/allow` new contributors to use GitGitGadget, too.

> [...]
>
> > Since #1 is a serious issue, I tried to find out the function which do=
es the
> > keycode validation, but I haven't succeded till now. ( I found the C f=
unction
> > name  which is "TkStringToKeysym" from TK source, but I couldn't find =
its TCL
> > binding ). It will be helpful if any one can help me on this.
>
> I really think you shouldn't dive around in the C parts of Tcl. I
> haven't looked too deeply into this, but you can probably wrap your bind
> calls in `catch` [2] and handle errors from there. Again, I haven't
> tried actually doing this, so you do need to check first.
>
> You can find examples of how to use `catch` in our codebase. Just search
> for it.

FWIW in addition to the `catch` method, I would also recommend looking
into a minimal (not even necessarily complete) way to translate the Qt
way to specify the keyboard shortcuts (as used by `git-cola`) to Tk
ones.

As indicated in
https://github.com/git/git/pull/220#issuecomment-536045075, the Qt style
`CTRL+,` should be translated to `Control-comma`, for example. In
particular, keystrokes specified in the format indicated at
https://doc.qt.io/archives/qt-4.8/qkeysequence.html#QKeySequence-2 to
the format indicated at https://www.tcl.tk/man/tcl8.4/TkCmd/keysyms.htm.

However, it might not even need to put in _such_ a lot of work: in my
tests, `Control-,` worked just as well as `Control-comma`. To test this
for yourself, use this snippet (that is slightly modified from the
example at the bottom of https://www.tcl.tk/man/tcl/TkCmd/bind.htm so
that it reacts _only_ to Control+comma instead of all keys):

=2D- snip --
set keysym "Press any key"
pack [label .l -textvariable keysym -padx 2m -pady 1m]
#bind . <Key> {
bind . <Control-,> {
    set keysym "You pressed %K"
}
=2D- snap --

So I could imagine that something like this could serve as an initial
draft for a function that you can turn into a "good enough" version:

=2D- snip --
proc QKeySequence2keysym {keystroke} {
	regsub -all {(?i)Ctrl\+} $keystroke "Control-" keystroke
	regsub -all {(?i)Alt\+} $keystroke "Alt-" keystroke
	regsub -all {(?i)Shift\+} $keystroke "Shift-" keystroke
	return $keystroke
}
=2D- snap --

That way, you don't have to introduce settings separate from
`git-cola`'s, and you can reuse the short-and-sweet variable name.

Ciao,
Johannes
