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
	by dcvr.yhbt.net (Postfix) with ESMTP id 742AD1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfJ2Ujm (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:39:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:40865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2Ujm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572381576;
        bh=PeZhqoUeH2bn+zQZ49871aQDUo2v+HwicqMxEhhynhQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dG5GtvyhlJEQpU75iFObU2YiXUgfnVvM06RdHNejVecXz3fPr7toB6drxzPd2fZCv
         aRtz8HaQg29dzAssX7WpkAmWMBiTa6yb5y3AuxqrYk2Wrb46tFfK4VOJUuQ7VTACXM
         ssaitiV1bxw0iogNVG4m1taWqDvYgJ3HgEKqDL3s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1iA90y0Hay-00FTyl; Tue, 29
 Oct 2019 21:39:36 +0100
Date:   Tue, 29 Oct 2019 21:39:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] myfirstcontrib: add 'psuh' to command-list.txt
In-Reply-To: <20191026080057.GP4348@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1910292136080.46@tvgsbejvaqbjf.bet>
References: <20191026005159.98405-1-emilyshaffer@google.com> <20191026005159.98405-2-emilyshaffer@google.com> <20191026010857.GA39574@google.com> <20191026080057.GP4348@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1339988948-1572381576=:46"
X-Provags-ID: V03:K1:9O9FftfbtOZ+gK/7NEkLnQAiEbIggYWjAdQQrDiSUK8I3yyMTtO
 qGXoGiwWqw/hvzYUYv+LjsZunytMxpQyhlHCpr3KM04SWSF7ezUbgEYHLx8ZVi9Z5U3+fu0
 r1OcEf/FowX7mQE7U90RIOGd/SyM7aSNzfgHkB89F/AQEQ0kby3rI4+q78+p2Q491knhiz3
 wizt2cG3Ixedm8iECUcUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zLxrfUgrgO4=:PV7p6TOKxnQTwGrwYh6vMe
 eElIC2WYbG/uXiCDpN43zHp4HXhUrrurlfSFyDCDPm2oaPAF4QWFs0I+RZ/AZxtN8hOvBy2NR
 aegMJKJreQBZIUU5u/Cg9tHHZMzXkVpI8G2b7QgZ48tDXmJtIi8pvLP34KPbqhUrpSEDnERsn
 f4t8yW8Z5nt4SrIyS12S+aFrFERCjwIgCN45B6XpnMRSDhFp1CAeTQd9GDU5g5M1x8X53g4je
 GGLJqhexLHkuhBO4XvTSHV1gr70fr0u4HJ2wK4+DP2Kpxxn68ova2/GJ9SgshI7fiTjc+7k6J
 8Puw/YGQSEULaro/GnTo+UpyoxLgGuv/b3O1euUD0gLN+kYYYcKwGR9+Y6suw/4ZVoZ5soAso
 6mdCaFgg1ccnxJcY/3uQQ/JaY7+lyWtt9e1xZDe182A4tcwViFUAgWCH9bFjUF12V04spPefA
 bDlNoSC7iSvfvNc42fdQ2DJDSDUWUnRDyhADuHuhyxPn+T+YMQwv136StMq/KUxDJ5xYwCco9
 1WLD3RtkDO4mQ0GtNrPixaN6BvQ5WFnwXQpf0euRJPRJtX5ACX8FvkYOT1L+gFTi8xXqdK8A0
 8fk8FUW3lp5uVM03haTUEf8k6BK6fvohcokTkf2RItZom0Za0ZvPhJGuMsR2iczAwB8bSZ8Fs
 gcmQE7tS4Fn8VFsC2q7VqBl37aW+l+8acSpzyhIQtMD472SOHqqyse+5S9O040GRt1zG6Dgv1
 FwZvitzUtji83EpoLS0cnoXy9lmuTO6aEficU891UuDslcE9RqBh9mEmE0udIHgcOi9cfk1TR
 e+n+fw01iYtNiYnQDEbHNCVXHOm1W/SSRtBTbCvXe75gfsubKwHytHqWy5SS7fwka6NMzHQvw
 RhLpucSqCgk4KL7ZJG/uUIKgj1kNpv9j3QV7uBdj+VzKlAMVj8zNpO6VanXVbrqdUu7Sf04Jq
 fE3csy6gF+AViNzLNyHmne/4lMEKWJvCJWvhEVdrHmXFYbTcqzt/Qbsmln0RzTlW/BwaoS5Nn
 gwGgdfWxkh/V1VxbfcNEEPuLOXNwLh2AIjug8QP+jZidCZK8KOB4tzAXyuuy3jV4dpyOE0mqK
 rWwlxuQfUStK7e5/xCiyGtv6vXTYT64qd6vF/pWOS25AXYGYlROxeL6VxFqGnMuN3iA+zxBj7
 nnSQLoYeW7lmVnb//cbLK6O7sUY7M9nvejo87lCPg/XeyXBdXAvRkmtUH+r9VJX+T5VuiKwcD
 Dk0Nf6V3W5IUuGOBYQkhP2c0NE22g6zmu0FtWL7KxbY672/ZLzmfdCh4m00c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1339988948-1572381576=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Sat, 26 Oct 2019, SZEDER G=C3=A1bor wrote:

> On Fri, Oct 25, 2019 at 06:08:57PM -0700, Jonathan Nieder wrote:
> > > Users can discover commands and their brief usage by running 'git he=
lp
> > > git' or 'git help -a'; both of these pages list all available comman=
ds
> > > based on the contents of 'command-list.txt'. That means adding a new
> > > command there is an important part of the new command process, and
> > > therefore belongs in the new command tutorial.
> >
> > Makes sense.
> >
> > Not about this patch: is there a way to detect this automatically?
> > E.g. if a command in git.c::commands doesn't appear in
> > command-list.txt, could we make Git fail "make test"?
>
> We almost detect this already:
>
>   $ sed -i -e '/^git-bisect/d' command-list.txt
>   $ make check-docs
>   make -C Documentation lint-docs
>   make[1]: Entering directory '/home/szeder/src/git/Documentation'
>       GEN cmd-list.made
>       GEN doc.dep
>   make[2]: Entering directory '/home/szeder/src/git'
>   make[2]: 'GIT-VERSION-FILE' is up to date.
>   make[2]: Leaving directory '/home/szeder/src/git'
>   make[2]: Entering directory '/home/szeder/src/git'
>   make[2]: 'GIT-VERSION-FILE' is up to date.
>   make[2]: Leaving directory '/home/szeder/src/git'
>       LINT lint-docs
>   make[1]: Leaving directory '/home/szeder/src/git/Documentation'
>   no link: git-bisect
>   $ echo $?
>   0
>
> See that last "no link: git-bisect" line?  That's what happened to
> catch my eyes when Derrick forgot to add his new 'sparse-checkout'
> builtin to 'command-list.txt'.  I still haven't looked up what that
> 'no link' is supposed to mean, but if it were an error, then we would
> have surely detected the missing entry in 'command-list.txt' in out CI
> builds.

FWIW I think the only reason that this is not an error in `check-docs`
(which _is_ run by our CI/PR builds, in the `Documentation` job) is that
it used to be buggy.

However, I think I managed to address the remaining issues in
`js/misc-doc-fixes` (and maybe there were a couple spill-overs into
`js/check-docs-exe`).

In short: I think we can make this type of issue trigger an error in
`check-docs` now (as in: non-zero exit code).

Ciao,
Dscho

>
> Another possibility would be to auto-generate that long list of
> 'cmd_foo()' function declaration in 'builtin.h' from
> 'command-list.txt', by adding a 'builtin' attribute to mark builtin
> commands.
>
>

--8323328-1339988948-1572381576=:46--
