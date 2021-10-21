Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA7C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B8E610CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhJUL7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:59:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:40705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhJUL7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817404;
        bh=XWG998a/QXqySsa8S4HzqFyPIUQz7qnIV/w/DwvYC7M=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=OsmzPNbVB+Gg3XH7C4p0aAaKjVE6cqqfe/vOgS3gjaLXUbXHVWx2Phujy41Zz+UYb
         QXPrN0YLpovswPJPVOpYWLBPNtKLmNr5G9uNsRxHG7/S89VbjUjPAcrOVD9k/engZW
         6NilgjUxS9c8Qgw2TuBl54xWoTJSOujgRr+sO3So=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1mNEK32eFL-00Jcbu for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:56:44 +0200
Date:   Thu, 21 Oct 2021 13:56:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Documentation (translations, FAQ updates, new
 user-focused, general improvements, etc.)
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211149000.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1258084824-1634816810=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211356380.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:SJP0hOfckg7R9p11eFZjYPOIhC2tDBpZ8tTYXrnv8J1IonBgcfq
 LgzPC6o1sbyxSaXSI3kKaL8K1X9WJdO4pPOyfI5yRAVlNqIK9yf01dDxXnFJCIpTURz7Q/6
 VkOQhMKf54CxTobajc8gFrsHdA6KAkpvvjgG3gbA5St3nsuMVaN8gdppsSIBdPc5sMkJh8p
 1mJx1BZb98CZ4QDxsn0uQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L1RLPCArF88=:0hnfK8wTW9uCzRAwgJWGgz
 wIHG6rd5MFMbMsLUl0ms1M/gnYb57V6vyjTurwUfPuKpqLQca3H0uw1lZAoxAaaLtXOE+zAdQ
 iCIh4bP0aIz+khf/O1Bxffo06nSP/f4d9ReLwgC4bnFMmzkoZUPSbJC6nDgN05MbDQfeD78y2
 f0mq/e2oyG0W25Qc4QmsJhVBU7RyoYsbW4RxEAVK0VNDMMNB4ZvDyc7sFEvNPyg+fmItI5mrJ
 1Jm1Spr5DGlFZA5QyJvufPOlZoq0U9++I/SDzx8M+D76SHE0Gu/HQ/gG8bLdDEqCzb5HKMkHM
 T1DbH0QjwaLxVwA4Y1JBXjdxKZxSG+tcfcreaEUtZLgZbkPh2nTqAPBnxpXKRjQrYmTHdjdet
 Wjdn88rMQWT+4O1cfqTiGkQ77wrGfcAQpEAaq89NYZwRAYBcJGtNo9GZ+VG3dm3dMXv2/pKHz
 a5mr/i0WyZ45bzuKF5q/RGul7RbHjVmE1k1YcZPm8dFvv9iQl1r5WdSlmGJCOU64+IDxSdRC0
 bEg40IhG4721vVTF0PObTWcp+wX2xPED1eNwKO9tzUvxuTU17hsyjWYbBGBGR9iRqmqNvMEgy
 5tHuh6Vcn6IoFZE2wagI/b9FY49LW/RiJw1r0lDSIjxWbDcAf0i1Vn3t2B9mX5jJqGLhN3amN
 1Be0ZDCfS2Vdk37l7mHvZU+tilTFROyleNGPh4sQMNq2BTmG1mRb6u6MHUINxQ4soxUDwz8oO
 QZ8XiMToFM8yx2RCR2lZhog1gAEvrivyH6bf/BKctrRs621ep7MzkhcHDGOHBouvkBh5O920a
 2Se0peuEZmy06K1D/94ntlAmf4dC96VDEpToeZQnWWBOfmaFqL9AwzYwGOEd7dCcIH79zc7QK
 C4JAecQ1fMwJwAGs/tA0Vf6qls7wCrTvtQB9ahTPMrj/S0itKJwSDsFwCv7yNv2atWrhPio0B
 xGF0qDest6qlzwuoDRn5RTXUCg1B2IMDqjEvvESPdwn5oaH1M98SCw8z09QwHReBC/4NSdDzu
 6g+OG8vLpNybl2VLG1RbJjmbuy8RzsBI7Erc+rmesocJoITW2lfUm0TAR8rNe60R0mIqFNf9I
 vqE1iw4S/D0MwE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1258084824-1634816810=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211356381.56@tvgsbejvaqbjf.bet>

This session was led by brian m. carlson. Supporting cast: Jeff "Peff"
King, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Taylor Blau, Philip Oakley, =
Emily Shaffer,
CB Bailey, and Jonathan "jrnieder" Nieder.

Notes:

 1. Background: answering on StackOverflow, other avenues for user questio=
ns,
    even users from very large companies

 2. How can we improve documentation?

 3. Maybe even think about translating docs such as FAQs

 4. Peff: there=E2=80=99s an effort to translate manpages

    1. brian: Saw an announcement, haven=E2=80=99t seen what came of it

    2. Peff: Some translated pages are live on git-scm.com (a github repo =
with
       translations)

    3. =C3=86var: It uses a third-party tool (po4a) that uses gettext by m=
aking each
       paragraph a translated string. So it=E2=80=99s the same workflow as=
 translating
       code changes

    4. Taylor: https://github.com/jnavila/git-manpages-l10n

 5. Philip Oakley: I see manpages used as reference material instead of
    educational documents

    1.  Audience often already knows what they=E2=80=99re looking up

    2.  That approach makes it harder to bring people in. Examples are of =
the
        difficult things instead of how to get started, workable examples =
that
        can be copy/pasted straight into the shell and tell you how things=
 go

    3.  Emily: We have the two-part Git tutorial (=E2=80=9Cgit help tutori=
al=E2=80=9D) which is
        part of manpages, but I think it=E2=80=99s pretty dated. It starts=
 with how to
        convert your zipfile-based software distribution to Git which is n=
ot
        where most people start these days

    4.  Philip: user manual also is not accessible as part of manual

    5.  CB: I wonder if this is even where people look. A lot of new users=
 will
        hit Google and find git-scm.com/book which historically has been a=
 very
        good introduction

    6.  Slightly misleading calling it Pro Git because it has good
        introductions

    7.  Philip: maybe the Git project wants to state: we don=E2=80=99t mak=
e great
        documentation, look elsewhere

    8.  jrnieder: thank you for the perspective. It=E2=80=99s not quite th=
e intent,
        though, we might just not do a good enough job. For example, when
        examples are too complex, that=E2=80=99s worth improving

    9.  Used to have active contributors who maintained documentation bett=
er
        (e.g., Jon Loeliger)

    10. A part of the problem is the format. Pro Git can include diagrams,=
 the
        Git user manual can=E2=80=99t (or at least doesn=E2=80=99t)

    11. brian: likes Pro Git, but maybe not the best for new folks (it ass=
umes
        some familiarity with source code management)

    12. In stackoverflow you can see how people answer questions, how much=
 less
        existing background they assume

    13. =C3=86var: One issue with the Pro Git book is that it is not under=
 a free
        software license (though it is free of charge). That means it can=
=E2=80=99t be
        included in free software distributions.

    14. I want to close the gap between output we emit and providing backl=
inks
        to relevant documentation. E.g. sometimes when we emit advice outp=
ut,
        we say what config variable is involved and sometimes we don=E2=80=
=99t

    15. Having documentation distributed with Git is also helpful for havi=
ng
        something that=E2=80=99s up to date and matches the code people ar=
e using

    16. Philip Oakley: Google Season of Docs is a place we can help

    17. brian: Mining stackoverflow has been very helpful for FAQs, helps =
avoid
        having to give the same answer again and again

    18. Goal is to have a good FAQ in git/git, to be able to link to from
        StackOverflow

    19. Perl approach of including references in error messages is very us=
eful
        for people being able to solve their own problems

    20. =C3=86var: =E2=80=9Cgit help git=E2=80=9D landing page is not so h=
elpful. I=E2=80=99d prefer
        something like the perl manpage that gives an overview and table o=
f
        contents and nothing else, instead of incorporating reference
        documentation about common options

    21. brian: I=E2=80=99d like to see both in the toplevel manpage. =E2=
=80=9CHow to invoke
        git=E2=80=9D is something people expect to see when they run =E2=
=80=9Cman git=E2=80=9D

    22. =C3=86var: agreed about synopsis, as long as it focuses on the com=
monly used
        options

    23. Peff: every time I want to look up perl commandline options, I run=
 =E2=80=9Cman
        perl=E2=80=9D, get annoyed, and then run =E2=80=9Cman perlrun=E2=
=80=9D. I think =E2=80=9Cman git=E2=80=9D does
        the things you=E2=80=99re describing but organized poorly. Even =
=E2=80=9Cgit help=E2=80=9D
        output does a better job of organizing. I also wouldn=E2=80=99t be=
 sad to see
        the options section coming after.

    24. CB: dashed commands should not be listed

 6. Emily: Side topic: the state of git help on stackoverflow is abysmal

    1. Doesn=E2=80=99t have much Git project presence, devrel teams focus =
on
       company-specific things instead of Git basics.

    2. A lot of answers are just wrong

    3. Someone spending some 20% time on that could improve things a lot a=
nd in
       the process would see where people are struggling, which can help u=
s
       make Git more intuitive and make better intuitive tutorial document=
ation

    4. =C3=86var: Having a commonly cited FAQ used in stackoverflow can be=
 great

 7. Philip: there are commands that are (at least almost) undocumented, e.=
g.
    git rerere

    1. brian: Have seen occasions where people struggled with commands lik=
e
       this

    2. =C3=86var: have seen undocumented patches

    3. Tried to improve documentation e.g. git fetch --prune, sometimes
       phrasing is too concise to be helpful

    4. Emily: getting confused e.g. when notes are transported via operati=
ons
       such as rebase

    5. Philip: may go in hand with the lack of good examples

 8. Lots of good ideas for contributions!

--8323328-1258084824-1634816810=:56--
