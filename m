Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7951F461
	for <e@80x24.org>; Fri,  5 Jul 2019 18:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGESRZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 14:17:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:41321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGESRY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 14:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562350638;
        bh=Voy2/8uG+nGFMpsujZNEExMrzWye065QX4yJbo4M8oY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XuZL+CVbn3awV7NNbduVMQvPuBdpecoKIhwLic91+KkmiorrDUFrGbvN0ATnzUvS/
         yh2lccZPDkAwmPf1FPd+ZKMVEUl48VH6qAMdpxGsCZVK9ZyBb8uArT2QeipoF0nuE1
         uulEAbjZ/7PTByvgCgRGAfDIF760V7E+2k03hY7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Leux5-1iIp743y3j-00qgsM; Fri, 05
 Jul 2019 20:17:18 +0200
Date:   Fri, 5 Jul 2019 20:17:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: mt/dir-iterator-updates, was Re: What's cooking in git.git (Jul
 2019, #01; Wed, 3)
In-Reply-To: <CAHd-oW6PTFY=_j1RDh8_MdeBmMX77kF+=kOpd-GUnbegMC89yQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907052009590.44@tvgsbejvaqbjf.bet>
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907041136530.44@tvgsbejvaqbjf.bet> <CAHd-oW6s1kGJqaRhm2f5ZG1C48upZu8ypeB_rw7do2=Vi3jZqw@mail.gmail.com> <nycvar.QRO.7.76.6.1907042308200.44@tvgsbejvaqbjf.bet>
 <CAHd-oW6PTFY=_j1RDh8_MdeBmMX77kF+=kOpd-GUnbegMC89yQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ejGAApN+8qeHMkVq5uhOQ6qMMoNKb7TXBcpFez5uQb0A9ktY1IN
 vtEzDzCQL3UQ0oUEfVTr7/NS/h04FxV/Evti0flvyALbnD1B8PFfJ08eGlur3TidkwnvHaH
 RmKzhKyhW2G8TPL7hUiByz30Vp/Udzeuz0fn+8BaitQvfhiOrgkyasl0xsL4OhRZRZFZfCy
 og1k7CdsG1Zfj4xU3j1MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ASLepTsQ9x0=:cWCOJaGuEsZNit+a2SVqFE
 kDg5d34giA08oeBJEyRcdmylq3bukUOtP3yDaXMIcOikiWCr1XDjEibInjuZXyLoo6lskWR1i
 Pq3qHIjDaC/oR4JJeslT8ddAKdlisPCu+pxxrEI7pcT5qZASL52mEJ2+I6sufLe36eWIYSVNG
 v9ZPlgSud8ZXnx49lt56UEEQ1FWABR8b7VVSIEE7qlwqF3h4t2DWRvDmDFb6mkHNUw96P2Gut
 efRCokN/tM7IARUUBK8RuRnrwHbyeGNPcIzndk1eyyvnpYruKh6VChkeBx2uPZTvk2XlEFTcL
 /CkKHGRLgKRzhQCB+piC/a5DSWSZstsWhtXnpDT/FS17iyhjfO8aNhQXF3/JbbxDI6sKxXx5Y
 vC8OXDWyQqdDGV31FsvDO+3NKB7OkXxwS5dumkMqUEXq2wr0EMpAao6u2P3dhQ7djh+KmHqAO
 DRv6Dh7FJi3ZdAKBCuYV64rR0k5ylWwsXGtVohwsiyLzBU2tUwu7izdkKJTx2y1yDJ7vVBQao
 g+n+H1tXmrVc5wolxMXoXaSn4Xo28UefZQpsSGKAhS1TJAfTPLtce2UKzZU6YzGM/vFHQHgJS
 IOyhroaGkP7Tfr9FksswAlAtAHig6eemPnPh1byMdc/6JA/ZhXe1OodM/1yLwwFrtyv/1IKh9
 SYr6oH3KI6C8hwdHJbU9iMbyCJ6i13DzDlZCcx2lN8tbxtaJgpubGNQNV0Wv0VCF/cQNbQAik
 zkMriEm4HmK1h/tiz43izGxF8ZXzd9d+CBK8GjXP/w+ZLCqPo7BcqoTkMaGL9Xw1W7eNuIh1I
 x/IiOAcnkToZN+IBtMvQR8t3IQwDj5OQdrkQxE4vhMHWDgHyjdPi7T2pDm+qUzc1kkvSb2M+U
 7K6vEHHraHMcEZvuCyYgSlxP5ziATmgSBCHkWb5WtX1eypTIQQl18QPS3FcHmkmr29BkqN7me
 wrdrwfYkc/iOxv7r4JTyl3+Hd+wbrQTKHI+nmSg+9h63nMpy9XHAPyUgZLokqkz4DyHTGUe6E
 LUt2GGudHS/zXKVx7lk2xp3We87TAz18BZVHHsJC60XAylJtc5Z9VkgdCgo3RUXeax1PT/PWD
 uq9kOV7sG6kNGnS+iNB3YlBn1rBmoyxZdyT
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Fri, 5 Jul 2019, Matheus Tavares Bernardino wrote:

> On Thu, Jul 4, 2019 at 6:30 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Matheus,
> >
> > On Thu, 4 Jul 2019, Matheus Tavares Bernardino wrote:
> > >
> > > I wanted to take a look at the failures to see if I could help, [...=
]
> > > Could you point me to the right place, please?
> [...]
> >
> > I usually click on the "Tests" tab in that page:
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11495&=
view=3Dms.vss-test-web.build-test-results-tab
> >
> > You can click on any of the 1,384 (!) failing test cases, it will pop =
up a
> > pane on the right-hand side that shows the trace of that failing test
> > case. For the full trace of that test script, go to "Attachments" and
> > download the `Standard_Error_Output.log` (via the horizontal bread-cru=
mbs
> > menu you can see when hovering over the file name).
>
> Thanks for the explanation! I inspected some of the
> `Standard_Error_Output.log`'s and it seems the problem is always with
> local clone (which started to use dir-iterator in this series). It
> seems all .git/objects/ dirs are being ignored. That makes sense,
> since st_ino will always be 0 on Windows. But your fixup patch should
> solve this. Is there any azure build for it?

There is no direct Azure Pipeline run for it, as I have not created a
branch with the fixup on top of your branch. But the shears/pu branch in
https://github.com/git-for-windows/git/branches does have the fixup, and
passes all tests.

> [...]
> > >
> > > Hm, I think `stat()` itself uses this strategy of an arbitrary cut-o=
ff
> > > when resolving a path. So we may also "ignore" circular symlinks and
> > > let the iteration continue until the point where `stat()` will retur=
n
> > > an ELOOP. (But it may be expensive...)
> >
> > This would not be equivalent, though, as your code also tried to addre=
ss
> > circular references when two or more symlinks are involved, e.g. when
> > one symlink points to a directory that has another symlink that points=
 to
> > the directory containing the first symlink.
>
> Hm, `stat()` also addresses this case doesn't it? For example:
>
> $ mkdir a b
> $ ln -s ../a b/s2a
> $ ln -s ../b a/s2b
> $ stat b/s2a/s2b/s2a/.../s2b
>
> Gives me:
> "too many levels of symbolic links"

Okay, then. Even better.

(With the caveat that I don't know how ubiquitous this behavior is, I
assume you only tested on Linux.)

> > > > Do we _have_ to, though? At some stage the path we come up with is=
 beyond
> > > > `PATH_MAX` and we can stop right then and there.
> > > >
> > > > Besides, the way `find_recursive_symlinks()` is implemented adds q=
uadratic
> > > > behavior.
> > >
> > > Yes, indeed. But it only happens when we have a path like this:
> > > `symlink_to_dir1/symlink_to_dir2/symlink_to_dir3/symlink_to_dir4/...=
`,
> > > right? I think this case won't be very usual on actual filesystems,
> > > thought.
> >
> > No, the check is performed in a loop, and that loop is executed whethe=
r
> > you have symlinks or not. That loop is executed for every item in the
> > iteration, and as we cannot assume a flat directory in general (in fac=
t,
> > we should assume a directory depth proportional to the total number of
> > files), that adds that quadratic behavior.
>
> Oh, you're right. Sorry for the noise, I forgot this function was not
> only called for symlinks but for every directory entry :(
>
> An alternative solution would be to use `lstat()` together with
> `stat()` to only feed symlinked dirs to this function. This should
> reduce a lot the number of calls. Although it'd still be quadratic in
> the worst case, would that be any good?

Why not just skip this logic? At least for now? It really blocks the
development of this patch series, causing `pu` to be broken until the test
failures are resolved.

> [...]
> > > > But I also think there are enough
> > > > reasons to do away with this function in the first place.
> > >
> > > We can delegate the circular symlinks problem to `stat()'s ELOOP`
> >
> > Not really. I mean, we _already_ delegate to the `ELOOP` condition, we
> > cannot even avoid it as long as we keep using `stat()` instead of
> > `lstat()`
>
> Yes, indeed. What I meant is that we may chose to _fully_ delegate to
> ELOOP. The way it is now, we should detect circular symlinks way
> before stat() fails. For example, with the case I showed above, we
> would stop at "b/s2a/s2b" whereas stat() would only fail at a much
> longer "b/s2a/s2b/s2a/s2b/...", far beyond in the iteration.

Sounds like the solution to me that I wanted: drop the special code to
detect circular symlinks. In other words: I like that idea.

> > > The only downside is the overhead of iterating through directories w=
hich
> > > will be latter discarded for being in circular symlinks' chains. I m=
ean,
> > > the overhead at dir-iterator shouldn't be much, but the one on the c=
ode
> > > using this API to do something for each of these directories (and it=
s
> > > contents), may be. Also we would need to "undo" the work done for ea=
ch
> > > of these directories if we want to ignore circular symlinks and cont=
inue
> > > the iteration, whereas if we try to detect it a priori, we can skip =
it
> > > from the beginning.
> >
> > Given that the intent of this patch series is a mere refactoring, I wo=
nder
> > why the new, contentious circular symlink detection is slipped into it
> > anyway. It complicates the task, makes reviewing a lot harder, and it
> > holds up the refactoring.
>
> Yes, I apologize for that. I should have split this into 2 or maybe 3
> patchsets... This series started really simple just trying to apply
> the dir-iterator API into local clone. But then, other things became
> necessary and it got more complex.
>
> So, should I send a fixup patch removing find_recursive_symlinks() or
> reroll the series? There's also the option to use stat()+lstat() to
> reduce calls to this function, but it doesn't solve the problem on
> Windows, anyway.

I would suggest to send another iteration that removes
`find_recursive_symlinks()`. Junio most likely interpreted my objections
as a veto against advancing the current iteration to `next`, meaning that
you're good to even rewrite completely in the next iteration, should you
feel the need to. No need for "Oops, fix that" follow-up commits at this
stage.

Ciao,
Dscho
