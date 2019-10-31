Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066F51F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 08:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfJaI1L (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 04:27:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:50377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfJaI1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 04:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572510424;
        bh=zJ1PMNDqz9xEpfsBAP4i/JdyJZUsuXa7e8pt6SYyIJM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZpyA14xm8n5fQ2HdaZ0F81cqsVSNauPJuCxcM/lsdfdtuYlRMrXLmAuLL2vFIzzGF
         ep+IT3MXDoDeyiiYNyOZKZpPeXoCX2/sLQUZ6Kd39MLzR3qyCUXD9nKIO/j+vcT+Eg
         7JgjVqrBjPrH9QmYBZzi4P2pO75o4eZ0s0X2fbnk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1idcQw3USf-00MKg1; Thu, 31
 Oct 2019 09:27:03 +0100
Date:   Thu, 31 Oct 2019 09:26:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, matvore@comcast.net,
        jonathantanmy@google.com, jrnieder@gmail.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
In-Reply-To: <20191031003929.GA22855@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet>
References: <20191029003023.122196-1-matvore@google.com> <20191031003929.GA22855@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M8ugoTG6g/X5DnK1boOC60Q0lVNTLXuj5GjLyj9X1W8plGsUHYK
 8eRQaY6Oh2LRZYSTV1VjU6otR7t0GfPLLJP5/ScR9VobEbcM+QMwpiKTJOKOK90QBnnKyVL
 NbRwSpPiKy6rY8DouxZytgTcmD993F/saQ4n6ytYwXXwu3+FkG2TkF72jYYVobCHlmq4k2v
 p1Yw5yWl3IvRA4U/i6ySg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FSk2pF/uHaM=:TDQdOrhRWMptndYewlkJ2n
 nU98FGb5dFYdhkob8+oO/cvg9dJN93uJ6SohUx3NvoxPFsy93n4c1uIuKNzjbqE9WC6gvI9cl
 ZYN+sdk2Q4aptYU6ZpcKnWqEGPHMZ6VMCLa6qjODvUxG3CgstcI3Vo7spnPeoQ6yu9tB63+Pn
 qv7eLOUTVReJPYGx9BrfuWmEpTWTeJn5zUrOsok2puK2fOZbOAJM5t0IJJ2vH72vualqEwnbO
 A6pNbDq4aMjGAdaDKFMnUC02CQCZSgbSGYH8au9S5Q0DVRH6RgiAWCqyTvNBh4hjIy0kqqOxQ
 3x2BM5xfpgVakvUUDDJBqnPNQqtBc/uoMV0y7kLvlVUNA6QQDxMHGcPam8cWgAEXOU4xl3Vm6
 NA3j/dWnHXhIQoweK0Jl4aMVFtRmWYhTRf3J1RqvUlc4WePKaDh4w3TDZthyc0V5LlRF3931r
 e5G6BEvZRIZxg/0YZCi4FqjOOumN5ncFopyqrseneIOfCLKOkYLR7ShFuS73TRIvFFESe/w9J
 bW9xWvoaDcWJNbXNc2sRqBm+c8vMYMI7mzHYwbWtueFz+8jwvb9P81VlaAoXdqfjnWLu6qlp5
 5oTIC52EWlWu52wsYZ9BrJfgdfmwx+wPSMIJrH4grUEXllKhgiWDpBajWayX9oxKafHSRqetc
 uJ+ixOII5pcVL1ykazqRxfG/4v0LJZmNs3OotOu5XWAu5Mg37K+pLt1lHuI07VzrxuM6Xj+zp
 BJBYdf8IC+ixcv8rvp4LXuxhrWkGJQQ7PwrEE3ETx57U2wbZXpa1TcoShk088YUVi0mRwiG+4
 oweTTDuq7FImln4fvLcya4+RsSXJP8KblonRrWkrdjt+VWgkoldp/YxX7rAlYfDmhI6kdovdb
 hRiG7C+k6ygx0J+FlDEYV/8MWSO25Go16yHE8Kq1FJP1TK6T7+c5nCAC1OpZrMSTYEZlYg3og
 xJShaWTYyv6JkUFtT1sI6noTfyrKtxVvxhba+h9A60oVeYvC63dtqqbY6s4vxnTFBlzYIi5++
 95+fysz0A4r6rSk5BLlydUyw3zEpbQJzKzwFS0luZTleQc8UvMSjpLCBzEOsDRRlIfTmKcAdu
 KyVQarLgH6xogjc/yGiwOgQrJ6/ipko9yLS6LSQJtOR+dYPizT6RwMTKs46LctFkAa5a3SFrl
 bOYEAdOkEcqjtM3bMsYNtTeqA1IKQyJlNV2dtYs3E4RblTo/uMaXIxy7PtZ/VwqNKzdxJY13c
 JcNHHq0N7M80FiLmvTsuXRF0fXuU0ArKEQddA8C9Z6uZDd4Rf7m+OsfOgqCw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 30 Oct 2019, Emily Shaffer wrote:

> On Mon, Oct 28, 2019 at 05:30:23PM -0700, Matthew DeVore wrote:
> > From: Matthew DeVore <matvore@gmail.com>
>
> Good to hear from you. One comment - the subject of your mail is "[RFC]"
> but I think folks are used to receiving mails with RFC patches if the
> subject line is formatted like it comes out of 'git format-patch' - that
> is, [RFC PATCH].
>
> >
> > "git xl" shows a graph of recent history, including all existing
> > branches (unless flagged with a config option) and their upstream
> > counterparts.  It is named such because it is easy to type and the
> > letter "x" looks like a small graph.
>
> For me, that's not a very compelling reason to name something, and the
> only command with such a cryptic name in Git that I can think of is 'git
> am'. (mv, gc, rm, and p4 are somewhat self explanatory, and everything
> else besides 'gitk' is named with a full word.)

am stands for "apply mbox", and I think that the only reason it is not
called `git apply-mbox` is that the Linux maintainer uses it a lot and
wanted to save on keystrokes.

Having said that, I do agree that `xl` is not a good name for this. It
is neither intuitive, nor is it particularly easy to type (on a
US-English keyboard, the `x` and the `l` key are far apart), and to add
insult to injury, _any_ two-letter command is likely to shadow
already-existing aliases that users might have installed locally.

Besides, from the description it sounds to me that this would be better
implemented as a new mode for, say, `show-branch` (I could imagine e.g.
`git show-branch --unpushed` to be a good name for this operation).

> > Like "git branch" it supports filtering the branches shown via
> > positional arguments.

... or `git branch --show-unpushed`...

> > Besides just showing the graph, it also associates refs with all visib=
le
> > commits with names in the form of "h/#" where # is an incrementing
> > index. After showing the graph, these refs can be used to ergonomicall=
y
> > invoke some follow-up command like rebase or diff.
>
> It looks like there's a decent amount of this commit message which
> really ought to be a note to the reviewers instead. Everything above the
> '---' goes into the commit message; everything below it will get
> scrubbed when the patch is applied, so you can give more casual notes
> there - for example this paragraph, as well as "Omissions I might/will
> fix".

In addition, I would think that the introduction of ephemeral refs
should deserve its own patch. Such ephemeral refs might come in handy
for more things than just `xl` (or whatever better name we find).

The design of such ephemeral refs is thoroughly interesting, too.

One very obvious question is whether you want these refs to be
worktree-specific or not. I would tend to answer "yes" to that question.

Further, another obvious question is what to do with those refs after a
while. They are _clearly_ intended to be ephemeral, i.e. they should
just vanish after a reasonably short time. Which raises the question:
what is "reasonably short" in this context? We would probably want to
come up with a good default and then offer a config setting to change
it.

Another important aspect is the naming. The naming schema you chose
(`h/<counter>`) is short-and-sweet, and might very well be in use
already, for totally different purposes. It would be a really good idea
to open that schema to allow for avoiding clashes with already-existing
refs.

A better alternative might be to choose a naming schema that cannot
clash with existing refs because it would not make for valid ref names.
I had a look at the ref name validation, and `^<counter>` might be a
better naming schema to begin with: `^1` is not a valid ref name, for
example.

Side note: why `h/`? I really tried to think about possible motivations
and came up empty.

Another aspect that I think should be considered: why limit these
ephemeral refs to `git xl`? I cannot count how often I look through
some `git log <complicated-options> -- <sophisticated-magic-refspecs>`
to find a certain commit and then need to reference it. I usually move
my hand to move the mouse pointer and double click, then Shift-Insert
(which is awkward on this here keyboard because Insert is Fn+Delete, so
I cannot do that with one hand), and I usually wish for some better way.

A better way might be to introduce an option for generating and
displaying such ephemeral refs, in my case it would be good to have a
config setting to do that automatically for every `git log` call that
uses the pager, i.e. is interactive.

Finally, I could imagine that in this context, we would love to have
refs that are purely intended for interactive use, and therefore it
would make sense to try to bind them to the process ID of the process
calling `git`, i.e. the interactive shell. That way, when I have two
terminal windows, they would "own" their separate ephemeral refs.

> > The test cases show non-trivial output which can be used to get an ide=
a
> > for what the command is good for, though it doesn't capture the
> > coloring.
> >
> > The primary goals of this command are:
> >
> >  a) deduce what the user wants to see based on what they haven't pushe=
d
> >     upstream yet
> >  b) show the active branches spatially rather than as a linear list (a=
s
> >     in "git branch")
> >  c) allow the user to easily refer to commits that appeared in the
> >     output
> >
> > I considered making the h/# tags stable across invocations such that a
> > particular hash will only be tagged with a different number if ~100
> > other hashes are tagged since the hash was last tagged. I didn't
> > actually implement it this way, instead opting for always re-numbering
> > the hashes on each invocation. This means the hash number is
> > predictable based on the position the hash appears in the output, whic=
h
> > is probably better that encouraging users to memorize hash numbers (or
> > use them in scripts!).
>
> If you're worried about folks using something like this in a script (and
> I would be, given that it's dynamically assigning nicknames to hashes)
> then you probably ought to mark it as a porcelain command in
> command-list.txt.

I would like to caution against targeting scripts with this. It is too
easy for two concurrently running scripts to stumble over each other.

Scripts should use safer methods that already exist, like grabbing the
hash while looking for a specific pattern (`sed`'s hold space comes to
mind).

Ciao,
Dscho
