Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574DDC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C2B61101
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhIIXvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:51:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:42789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhIIXvw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631231441;
        bh=Yioa4kjBoeaS2JNV4mRCmdgYjXdCR27isJeJfhYNZHg=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Rnllih6Ne8jKEiG/YeBJZh0HaX4XxQ0GlM1e1w7U6E2GxtDIEN/cj8/CX4WO3sxqL
         WP6WJOQKnF+RKtu159svipyUXIRzkZhn6ZxdzMn+sRJGNhvJ9YJp3683VqBpfE+sMI
         vv5R1kfgW0PYOEgEJ13ClCCm0RUDExbMl5Q2G7QY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWASY-1mQD1f1si2-00XYip for
 <git@vger.kernel.org>; Fri, 10 Sep 2021 01:50:41 +0200
Date:   Fri, 10 Sep 2021 01:50:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: =?UTF-8?Q?The_2nd_Virtual_Git_Contributors=E2=80=99_Summit?=
Message-ID: <nycvar.QRO.7.76.6.2109100149410.59@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-563650269-1631231441=:59"
X-Provags-ID: V03:K1:SrgFiAeZmwfZQ1HeGaUUdy4/HFhaNnG+nf3I7JxPgU3DMszRO1e
 jphNCyGPChVhDkeXDEGcEhcimP4/os4KB9OwWOB/UT6UJX8myYMwtXjlsqxOh+dSDpk7rLH
 oROSlw03FOdPxJRDVu4Uia/1GvWJcdM35+9Ty0+z/pdQMotMZ2VQR5JJijKc02a+EIUeZ50
 xvBMRCic1TBPmJKKRItUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T4yAWEixOcw=:55JhQZfoocnoYQJAAvJMW4
 zmDEKmVjrVA0AS50qA7kv+wu0Jm5WG+DwUGBTFlBupOpQ1lpoQ5c9btrqE8Rs3p39AWBQH4wB
 qNfSMFA5IwNT5Fn0qSIdpq718KyPMMInrV6Qq5ofr4WkEk3yt3dvyNAHmx6QfWyz3S4fDbHHD
 P+DYTGCnH7J6LQOP2mascvfRa4GeqS0BhpBphYHoAhqlpt73T03n/jbniSx4cp4wf+pvRMkSK
 /WQSpqisgUu2sIXwHHYKS04CQn8bEfG8xHY/8LSSfZsfwgaNLl7o/lWHusD/YZX/y4ScQRpQx
 KezkV7vXLOA77q9vCnt23jDnejLAREcQfDO6dj4gPbCA0jlqM4Zrokcway9kuyEsVjGgmW2AF
 9UFapWliKWgBFY00lxISVxcwYVF2gYdUOKMqUZA+mirtQrQS6W2nVFuKNwE99E9f+gsjZ+fOa
 Y5lAVpaB9g/+kpS4pixFnHA/sOy/lkCAKCp14/k6jmzFUw+I/zrSI/YFfKR7PaY8nEcaOmXNG
 KAASnseOFLg64sZ5mcwgxmS+eONu61ZzQDpOjQZCA3dlIGxS6xBwykZnuZjh/AhoCFn7rqTin
 b4L5CZXCoq59y/nkg2gX3Wrp9mb1sQG2ju4O6lPLwzC0fXkt9zdYZlGqOrcxOVvVLfinb7qpY
 ktLSYtnGREsHOH+Y3JfEnQ13bKOZsGr6We2Op6D5qvYlBVaYpz4x8xnODkx1kXJHZUFQySmbN
 0hqGLPmvITpHAK91hFsKW429LOzZsP3zzPNo8Ng45Ep/IiVjnRWcluU0ceeKQdBbrYwlZXQIf
 zdGGMvr1/fJ8Pa4igceumDLquWzXPocLmJSoPrG5Hw7WlAAwTOXYMe5SEG4m99k2RZY3n3pMS
 4MTRWa29nRlWSkZOc3YbLY9dNJQl54ONp/RcZtTPTmKIapmvBYxahecuW+9+NdepCgu3rfMTQ
 MIayPqhCk43i7cgSpwpVOoi8p5Evi0vuv8pm1LhCIrOm5W+vDOugWu2e7bjQn8JOpCm7HB6Ot
 SI3llWnqckV+TLKqMXNxWNxL+pskCCyzt2hkbXPsPPC6mjQvRIWyDWVE9DzB9WO0jiF+x9qIi
 273kJXqyAYFor0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-563650269-1631231441=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Team,

In 2019, we had our first all-virtual Git Contributor Summit (Virtual
Summit =E2=80=9819) (see [*1*] for the email that kicked off the organizat=
ion of
that event). In early 2020, we had a hybrid in-person/virtual Summit in
Los Angeles, and later in the year a virtual event focusing on Inclusion &
Diversity organized by Google and Microsoft folks.

We haven=E2=80=99t had a technology-focused summit since March 2020, and a=
 lot is
going on that would be good to talk about. Let=E2=80=99s have another Virt=
ual
Summit.

Just like the Virtual Summit =E2=80=9819, we can use Zoom (thanks GitHub, =
for
letting us use your company license!), spread it out over two days, during
the most timezone friendly range of  15:00-19:00 UTC/17:00-21:00
CEST/11am-3pm EST/8am-noon PST.

To coordinate this event, we=E2=80=99ve started a Google Spreadsheet where=
 you can
indicate date preferences for the event and propose topics for
discussions.

To avoid possible spam from sending the link publicly, please send an
email to git-contributors-summit@googlegroups.com to receive the link to
the spreadsheet.

Ciao,
Johannes

Footnote *1*:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqb=
jf.bet/


--8323328-563650269-1631231441=:59--
