Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F134EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44E560ED5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJUL7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:59:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:44397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhJUL7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817433;
        bh=YEGcm3U/5uq6ii77bPAe9JOD/lJJQfb3/GMvlO5krNg=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=FFOULsb5xbrfVinEwIoCZw5j5fQj0umppTmGv1KxcyrQ2B5pjtNJ3Uckmbd2TqjYI
         CrtF9LtPWUmEH8X/Unf1c0BQwKqEHrSFbW4B9BoKVqXM4mFHAPMcyzLH5hYJxvY9rb
         uI693VrTCx8NEtcFeVu39xDtNVn0JErQcyLWZQhQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1mvTBa0T5P-00rmXc for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:57:13 +0200
Date:   Thu, 21 Oct 2021 13:57:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Improving reviewer quality of life (patchwork,
 subsystem lists?, etc)
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211150460.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-706194168-1634817283=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211357090.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:Nk0xhfKX5/PumuCS/4MwMSgRj1oju+DFEs6SmqNMvVlScA/xczY
 ekyC5csMif0l5RaW4S65QBwLL4by10VNgylDLZqWs2zJzheNdngHeaoBOfq9+kj8UWtLOFX
 9POIeWYt19BAKbz+05A7/wO75r1aOUW7sVwa8oH237TCEymW85OGHPN5MkNvDxoCqu1wIyH
 E/UgYVTKbyu9TXcARWXMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cFP8Iy0s2M4=:8bybACNNTN5SerHZbQAvfq
 RS7GtTyrb4GIeiNyfO134dKjq3ZEZk64JnlUWP/g6Qv8+xxp0YNXMhJ/rb7gmimY7yWeZaltm
 jjaHzU/g4Xx+aeHXBNQm4ILcN82WVYBu1G08hIJF8HTxcy4ZjzcfTxNkkQH8s9cu1vJM6Vus5
 McJyhs8nWaI9lqCd9ePrcuujA/q6VYKKrfPGERnI4SOBo/yXN2OlObxC5pX2TmjSy9BbEpcsx
 hzguKuO9oP8CeOCeUMhYbdGHCZ89ePIQ/wZeHATmxlOFXCBUTPmP4kboXnjeoutdO9oCljzaR
 uA1PYorK2R5VawrQHjK8FNTb8rjssAoq4b9oaGfUeidWxv48omzRVWRQJQFZBUqVNEW1Hvg7q
 r1t7Y6F2CQzWtBGLIMoRUzZL7DQrN8+xmaOsza0BKfskZfPPPCLHkpk7Fw1kRf8Rkd0N1Xeel
 io24pWwyclWVDyJ+z8WnAHEcM2JCONQ07L8qeaS9ME79DMRyi5ErHXy4jBqoV/vABW9OOqXDZ
 VHdi/I/InYalL2m8aLvZPcQewVHOV0OAtz2vbvLgdJPQtsKfhNxyofc8voBICDp2MR9MXsPdv
 X+4wSOpSWs1mmhGYLmuEIcQ3bjThNn8twmmldbMTVOlz17KJYUSUGF2/njdhQjE8cW2fJeHbV
 erhbySYEHVn/1UDjc4MgDqskd4SvcfrdRuJ2WfRp7riOOgPQgsyD7VUHdi5+8BDD5pmzaSU0T
 u2aZqnoheNUWMnK8A8iQQ/uHWo6usEtf/dgvvMNLUjU2Ao3omF7bb867i/mN0kAL7e3KaUOUX
 qC0cHWV4bRNVLlAK3Po92dT3kfFtGJLhALl7g/RSA77l9Rh9nkjw5C521cxzLMeskAsGuwcnM
 6+gqlAVGlgs3hRrwnk5QtjesrIJGudU4Cyl1tERZCIequl3yFgIKBfAmNvghnVP8mLnygKVfP
 KmE+b/JO3fx6T9lCVlAYxbanxOs939fzdRQZBvF3XUpSv0O03+bPq+OK5o5ZcWtfd9E2DaPrE
 0DFP3X3Ovayu7csPqkFUzbZlfer4EAmC4dJ5Fu2m1APkx1tEyNm/9ugSjhB6sKIpIpJGY0eR/
 8osT3N+89AcxxU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-706194168-1634817283=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211357091.56@tvgsbejvaqbjf.bet>

This session was led by Jonathan "jrnieder" Nieder. Supporting cast: brian
"bmc" carlson, Emily Shaffer, Johannes "Dscho" Schindelin, CB Bailey,
Junio Hamano, and Matthias A=C3=9Fauer.

Notes:

 1. Been interested in this for a long time

 2. Dscho said he=E2=80=99s not able to follow everything on the mailing l=
ist

    1. if you have just one patch you send, reply-all works okay

    2. mailing list works reasonably well if you=E2=80=99re someone like J=
unio, working
       on it full time, has good mail filters, keeps up to date with every=
thing

    3. If you=E2=80=99re in-between, does not work well

 3. Lessley mentioned in the Diversity & Inclusion context:

    1. you send your patch,

    2. want to have a solid review

    3. want guidance where to go from here

    4. timely feedback

    5. want to know where the patch stands

    6. What happens: guilt-based workflow, where reviewers reply much late=
r
       after being prodded

 4. bmc: I want some way to track patches

    1. What have I reviewed before and what have I not reviewed since last
       time?

    2. Emily: most of this exists in patchwork. Our intern Raxel Gutierrez=
 did
       work on that this summer. Alas, that doesn=E2=80=99t show up on
       patchwork.kernel.org because it=E2=80=99s using patchwork 2.x and t=
he features
       are in 3.x

    3. https://youtu.be/24dL8yqhYNg

 5. bmc: I want some kind of bug tracking system

    1.  In git-lfs when I need a git feature, people are happy to send a p=
atch,
        there=E2=80=99s no point of coordination for this. Don=E2=80=99t k=
now where to send a
        patch, don=E2=80=99t know where to send a bug report

    2.  debbugs works okay, has a huge spam problem, but it works fine; em=
ail
        based

    3.  Emily: Every time this comes up I go oh $&!& because this is
        perennially a source of dispute. I don=E2=80=99t care what tracker=
 we use, just
        want one

    4.  Dscho: everyone else is caught in the crossfire between jrnieder a=
nd
        me.

    5.  CB: Is there an option that makes you both equally miserable?

    6.  bmc: Could we get kernel.org to host something?

    7.  jrnieder: there=E2=80=99s a bugzilla instance at bugzilla.kernel.o=
rg, which
        might satisfy CB=E2=80=99s criterion

    8.  bmc: I want to have whatever we use send out to the list. That wou=
ld
        avoid conversations going on without people in the mailing list ce=
ntric
        workflow being aware of it. If we are all using a GitHub/GitLab ba=
sed
        workflow then that=E2=80=99s not required

    9.  Emily: +1, great point

    10. jrnieder: Sounds like we have some common ground so seems worth
        starting a mailing list thread

    11. Junio: As long as I=E2=80=99m not the person operating the bug tra=
cker, I=E2=80=99m
        happy :)

    12. Dscho: Is it important to you that it sends things to the mailing =
list?

    13. Junio: Not really. The extra tracking conversations are not as
        important to me. I think it=E2=80=99s a feature that if someone re=
quests a
        feature and nothing happens for a while that it no longer produces
        overhead for people is a useful feature. That kind of old filterin=
g
        feature is sometimes valuable.

    14. jrnieder: in a bug tracker, triage + common sense of priorities is=
 very
        useful. Experiences in JGit bugzilla vs the Debian bugtracker (the
        latter is better curated)

    15. brian: I=E2=80=99m happy to volunteer to do some triage on the bug=
tracker. If
        other people will help out and contribute, happy to do that

    16. I=E2=80=99m also happy to work with kernel.org admins to get this =
set up for us
        if that=E2=80=99s what we want

    17. people would expected to be kind+helpful in interactions there, ca=
n=E2=80=99t
        expect it to devolve into a cesspit

    18. Matthias: I=E2=80=99m happy to help with triage too

--8323328-706194168-1634817283=:56--
