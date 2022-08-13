Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC43C00140
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 02:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiHMC5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 22:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMC5w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 22:57:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCF79DB6A
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 19:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660359468;
        bh=r/K7nDIWRTzsj0nb6YrIo2IhUxUZSqmydNoVs06RMI8=;
        h=X-UI-Sender-Class:From:Subject:Date:To;
        b=RAmjTtThZsBKjLOpg4ejYqXNdIwerttThcZFcG5SUUYzSQJordTHeGcTQ9asUOH2J
         +0kEyhoshp0j+2ITir8Sb3X1Lwlv1lGUdJf4CqN++9q9hzFVuGVF4Ijk/iFcKWwXxS
         7eq1E3RZE+aMCzYXClsDMmTmGPWfwVyl9Di5wSgs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ston-dhcp-160-32-100-48.bloombb.net ([160.32.100.48]) by
 mail.gmx.net (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MOA3F-1o2gSI3aiv-00OZW4 for <git@vger.kernel.org>; Sat, 13 Aug 2022 04:57:48
 +0200
From:   Ryan <rmrmail@gmx.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: "master" term - no one cares
Message-Id: <6896FBE4-9160-4969-8969-D92F9FE19F14@gmx.com>
Date:   Fri, 12 Aug 2022 21:57:46 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Provags-ID: V03:K1:68siEVbqkoWfoepU/1Z9zomjhwlTZcOavxjpW48l3+lL84ddD1G
 gzx5n4y+EuRhEpeA3TH1JBTvNCcltVPyamFZWjjdRYSOEenq79+ErFQ89B+vMI/Q6loZVuJ
 UlcFqmJ/8eA2YGRMw8SK1xPmDvvqKYfBcbJ5+0Zu3x/906hyVvY4EkUzx+Rr70Q1UTGcNyB
 v+OkB/s7SOHfiMzzzCqtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BzcGTTEOPqM=:GKmcmQ3EIzghPuJsUOjxp9
 DFbd8/HJpcYwcxL9NfmU7szUpMpBzCgSqTYuqzVBbUygYdSHCGyGaklB8ntUPnHCRkFhXjJHV
 WMvxFGKLQS+0UDTuOFn2I9Cle5cXZVRajJ+6cO/KGeRYNDHAhyeFWS26szS0CjMWUly7fTz/f
 opL+qawzyyCluT33WFXcU4cM+hxzkL/CQso81Gcp1FBEuiP6uYguR7wxk/BFHM3X63GDl/LP+
 yiuHd3OXSXiJcqZ/bgt8QabN07Mpi0gF50cNv9MD6SrYUxgY2iPtQNKvzr11LHuUJwWqRU+Fw
 IqHBX0fVe0qA8AfCSm7z/gYsajMXkfsVN84hAJZkjeeqU9zpIvHvdi2wEW6jjGTa6sSlzfD5s
 6gHb3oAMVh5AsgLbt7Exdfj2w9Y+L7GD0qgebB07aSvI+nwy6OrRi2BOvhHztV5dsltARgjtw
 W4sq+4RPVgEf88tj4dsf5xWmckyhLyA5Ss5G3mAq92rhENzQCRxBBMB0+amfUZRYWq3t6hchD
 nuJ6v2o1q401pDGOafEeR6hQR7bGxQ75YWuRq8aMfkUYcAQHX/t/51P/Aa8PvzfASKtSZ/lSc
 B9RXE6+X8gR1rGK5M751/X9BGlP7dzpmGpkmylkW+SFa1ckUWqV0XOb/c4S3uSlfDrpVC1yUv
 hLSHlIxuNuryyJe3YQVrJttL2Cdpx5LHZIZ+IA0OIzOqj3pCb+RxjL5/hl2hHUHURzsxkumFo
 AWMlVWGcfVQtnklaTgOWhLoeB4+ykfjJ6ORxuQbQJvq+ffS20rba5JwkaODeWo9pV7A5pFG79
 LUbt0yRQQDyFaG7D2lJkAMPEXCASs4Ih7K+6UNccWWJHYo/W7hQ/LNjbMYcqP1gElNUFsH6dR
 wAQoLsYWRZ3kc2zDx9i/OLa+xXw7YZIpu4rSyGmPYaYAubWm5J7WFwjPepkRAGC2LVLfLqXHP
 nJoa/SvVka517w/HWQCabqO47pY5rLxuIfjFfE31KgYK+UI8lFEjQ387XATeaab85L5tXWp1B
 jmQr9+/wUvPVnwhxVoffr2I46iNJMWZ0/VwEv5xKk5tqiptS9OiiaKMp27xWdnD6sSnLl/38J
 mAC2nmiuXFlPXqG3VhXItze2wvZw8LIPfJkZ6z2Zd1zsCDkjlEfAGgzcg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I installed the windows version of git today and was annoyed with the =
=E2=80=9Cwoke=E2=80=9D message stating that the =E2=80=9Cmaster=E2=80=9D =
branch term will be changed to a different name to be more =
=E2=80=9Cinclusive".

Don=E2=80=99t waste your time, just get rid of this annoying woke =
question in your installer.  Very annoying!!  No one thinks git has =
anything to do with slavery.  On the plus side, git is great, I just =
started learning it.  Thanks!

Ryan

