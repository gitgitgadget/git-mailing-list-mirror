Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A2C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C60606A5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhJUL6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:58:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:58613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhJUL6v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817395;
        bh=9balH0hp16m5RHk+Z6uK+oNi2W6w4VslgfCE+0tCeGw=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=BuO3v5Dy32OpJccFdKS7r8JgGpFhFkX1T/QIvb2k03dWFOhq7FncQLxc0/9l5x5kO
         0B8oQDGjltAchu8CUxahM0fY8ixITypshElrR05f7fA9s5OaZzhQnbm0yAQqAWhZQd
         j5qI7zsn9eWeSRbj7GnQqg+teTahg/eBvkhY6ZSo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1nEEY13nSJ-00bLaI for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:56:34 +0200
Date:   Thu, 21 Oct 2021 13:56:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] The state of getting a reftable backend working in
 git.git
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211148400.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-349729338-1634816746=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211356310.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:9+yKSlQiJj34HaYXG9zLpLE6TsLxOZpLivwH7t41jm4pvZ5yJsJ
 UNc8wPxJDXCMOdaleKOkWC1uwBO8T7Kr2NA0bIdkT1aGkV1EPR5H36lP7x8yKqpduFW9QMG
 PQsCIF1iQlRD1dbwrvjHObac9Spm5pJRPOPPQPbg6q6MD6hvpqRD6rvJ3Z4T0uAtKlxaZA5
 1EdCGW7xoR6Jb90OoI6Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ra409KTN2cc=:yE7cFRH0yoqh8awGbZtxEQ
 uxFv9gUOrJkUv7cPius7zXzJsFhlYZCVUIoGt9cAMJKmjTIbdcXyf75Z0ZpdS+wOmqKaWAUre
 STZnt4sU6vSbaDDIsaFLP5qqviueQDKCqdaxC9OKX7ycQUiWg/I1dJjgVvPJlYIplD2Sw1CXY
 vjVz1qlnuHJrB5v/RP5JM6Xt0QzTU7jvNfe//p1nnY8zCybIpvPIcqhB5s6DUsexjclblZToh
 MggNhLa1ZQEwLQeNOIK0KQI3Bz+QMqIAUNcCgKruo8DZWvzr8lEJofMoSkUUE2p5DvNZX8LoP
 lyX97Tp2zp2GMsjvPwqewAJcvdPQFXy7ouJW7kGFH/cq65KUQjOhRJIXFD6jJ/Z6Hp7W/7l5G
 QJ6coiw+evLGWxAJufZgeTJgM/jIBhMPvBySfg6e3pBzs7KMQzzfIRlMQsnegbJWIyiZygN66
 vgNNK5HZ7AwJU1uGZEYz2OdbzghCRmtKywrg4+MCwoS2mY2H1ZaIrTP+98dtKV8Fu1r+E5eG4
 gLXBQdPLZ80/nBVhMgHifdN/5sMUpAmhRWwhj9D6P1IItiN+XEMO8mLSPeb68raHHBQGEH5mP
 RpLkuW7ZQj5Sl2QaHfffhxf2PUC3gS9wba50v6PhcK5ayrqUQ1MSE1tIrAcII1KVJb+yOE6eK
 rO+hsy9h3zkqpqhV+/RNMaR2iBKk9DhIB3OMT6ED8HByTCnKVO9Goa52tN87iqXohdL8Wtirz
 z2afSHEVW24SPwXaOx3EKXP655jm3z1n0PnjVYDtlZP87IEjxhGTaULwnNOFQJxe6at6fzfuk
 UL9TkRb+SvqkKcEevhyzN3OQDOkd4lTsLaSV+lEB1oHysSIsr4XP5vKIOMhN8YjD6mXCvPOvg
 H0zN3nGjoqlRpTqC9REned71Cy1OzuM/6UC4zdeXvczot0fYJET8ilu3iXo816J+AZgNupJd6
 1a/cxIeJAZSN+ef08WWGqAYre/iBHpic1CZQpa+W3+xPwpK1JlDL19O/7Gd/piaJDWx3TUWcm
 3gkmgygN0mhZdJxejOf5yEq/XPiawzZ+yO2j08Y0C8gm+BgE1K/E74KRqsfcimiqqHWf4rqlk
 WunKEBKBquW0J0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-349729338-1634816746=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211356311.56@tvgsbejvaqbjf.bet>

This session was led by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (on behalf =
of Han-Wen
Nienhuys, the driving force behind the reftable patches, who did not
attend the Summit). Supporting cast: Jonathan "jrnieder" Nieder, Johannes
"Dscho" Schindelin, Philip Oakley, Jeff "Peff" King, and Junio Hamano.

Notes:

 1.  =C3=86var: helping Han-Wen with reviewing

 2.  Was split into multiple patch series

 3.  Han-Wen implemented the reftable library, has been kicking on the mai=
ling
     list for over a year

 4.  Before reftable, need to merge some preliminaries

 5.  Odd cases:

     1. slightly different semantics of reflog

     2. Probably more things that haven=E2=80=99t cropped up yet

     3. Some tests are still broken, question is still: are the tests wron=
g, or
        the code

 6.  Plan is to get reftable library and underlying fixes in place, and th=
en do
     the process of actual reftable-as-ref-backend afterward

     1. Jrnieder: sounds like you=E2=80=99re alluding to a mailing list th=
read. Do you
        have a link?

     2. =C3=86var: there are multiple, as the initial patch series has bee=
n split
        multiple times

     3. =E2=80=9CReftable plan=E2=80=9D:
        https://lore.kernel.org/git/87h7jqz7k5.fsf@evledraar.gmail.com/

     4. Also alluded to in Han-Wen=E2=80=99s later rerolls

 7.  What is reftable?

     1. It=E2=80=99s a custom way to store refs

     2. Instead of writing individual files per ref, it=E2=80=99s a single=
 file (or
        multiple files when updating the refs)

 8.  Dscho: three issues that were outstanding when I reviewed it

     1. That said, I clashed with Han-Wen

     2. 1. licensing / contribution model

        2. =C3=86var: through the Software Freedom Conservancy we have goo=
d access
           to legal advice. I got advice there about how to document this =
well,
           will be getting us into an end state that will hopefully satisf=
y
           everybody

        3. To be clear, we already have some code in-tree that is under
           different licenses. xdiff is LGPL code used by libgit2, there=
=E2=80=99s
           contrib/ + compat/ code under various licenses

        4. For legal purposes want to make sure this is clear and unambigu=
ous
           to everyone

        5. jrnieder: about contribution model, there is on-list discussion
           about this, taking patches in the normal way to this directory =
in
           git@vger.kernel.org is where I thought that ended up

        6. =C3=86var: yes, git.git as source-of-truth. Not like gitk where=
 there=E2=80=99s a
           separate upstream repo

     3. 2. coding style consistency, + not using git core data structures
           enough

        3. =C3=86var: still substantially true. Integrating into git.git m=
eans any
           stylistic or structural changes to fit well into git are fair g=
ame.
           Carlo has been helping with that

     4. 3. I forgot the third :)

 9.  Philip Oakley: debugging when things go wrong

     1.  When reftable arrives, will people be unable to look behind the s=
cenes
         at what=E2=80=99s going on when issues happen?

     2.  Especially for people who don=E2=80=99t understand refs as well

     3.  Jonathan: format =3D
         www.kernel.org/pub/software/scm/git/docs/technical/reftable.html
         [http://www.kernel.org/pub/software/scm/git/docs/technical/reftab=
le.html]

     4.  =C3=86var: That=E2=80=99s a fair summary. It=E2=80=99s as though =
we didn=E2=80=99t have packfiles
         and only had loose files and then switched to using packfiles. Ca=
n=E2=80=99t
         just =E2=80=9Ccat=E2=80=9D any more. Switching to a binary format

     5.  That said, you get advantages out of that. Situations where peopl=
e end
         up needing to examine the low-level details are

     6.  Not a fully fair comparison, but we have this problem already wit=
h
         packed-refs, having to look in two places

     7.  Philip: An inspection tool to export as a directory tree might be
         handy, as an inspection tool

     8.  Peff: We have pretty good inspection tools that look at the whole=
 ref
         database

     9.  Reftable has a set of files that go together. May want debugging =
tool
         to dump the content of a binary reftable file. But we can
         incrementally add those

     10. As we discover bugs, I expect to have to build tooling

     11. Dscho: We also have a .git/index file and don=E2=80=99t have tool=
ing to
         interact with it other than the standard Git tools

     12. =C3=86var: To be clear, once these patches land it would still be=
 optional,
         would not be the default ref backend

     13. Even if it=E2=80=99s 100% bug free, we still have concern for use=
rs in the
         wild that make it not so easy to just flip the switch

     14. Not going to be the default backend any time soon

     15. jrnieder: makes sense to wait for a while to make it the default,=
 even
         once it is robust, since we have to pay attention to what Git ver=
sions
         + implementations are out there in the wild

     16. =C3=86var: When you run =E2=80=9Cgit init=E2=80=9D, it currently =
still creates a branches/
         directory. Dscho tried to get rid of it before

     17. jrnieder: I think that previous attempt was getting rid of read
         capability, too

     18. Dscho: don=E2=80=99t remember the details, has been a couple year=
s

     19. Junio: I do not think it is a bad idea to drop branches from temp=
late.

 10. jrnieder: Question about how to handle this kind of large contributio=
n

 11. At some point does it make sense to take it, mark as experimental, an=
d
     improve in place?

 12. Hoping the previous discussion will help me think about that

 13. =C3=86var: I agree about importing the bulk of the code as-is and ite=
rating
     from there

 14. At that point it=E2=80=99s still not accessible to users but we get p=
ortability,
     testing, etc

 15. Dscho: Agreed, that makes sense to me

--8323328-349729338-1634816746=:56--
