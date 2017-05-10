Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC1B1FF34
	for <e@80x24.org>; Wed, 10 May 2017 10:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbdEJKgC (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 06:36:02 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:32827 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbdEJKgB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 06:36:01 -0400
Received: by mail-yw0-f173.google.com with SMTP id 203so13258211ywe.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=canonical-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6M8gKMJCANfVQZNc02kyhg8lZqkA85ES7sL+wXtYwMY=;
        b=Njx2c8jDzuSzcwENDFJKsjS7HrVH4oKMLNJuCoSsjKFUsb5RhU3G0wjYMbeuw3Vh1J
         RH7FIS3tYWRS7TCaLpJtSo5iylSMSHYUhQOxPnJ9X/Et7S5H9qKOoLEPMH/2JbY/d5HR
         lh2W/RZ89vKiZbiyIfvzgiyDOUHIkv8FiJuKBD6UIi++XKbnswfJfgMwJg51QRLs5ekw
         MrVQugmy4wiN1htG2PHoMyF27YSdOlH5GB8TyYbJ74/qEEFjaSHj2+K+T6D2a3BcLAvs
         LA/dz/j1QAk4xHuQtKr+WWo1m8cTjsbalGi5+MdPpzq9VphcbFzr/xuX1p4pDQfTxE+T
         vpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6M8gKMJCANfVQZNc02kyhg8lZqkA85ES7sL+wXtYwMY=;
        b=FUoKrhoQvU4fYnT09fe9ad8BHUBIwxzh4S/iFdxFQHQvX1uSMqpynA0OBHLY/ChL7W
         qpkn/ihyxhJRl0ksrg1iVSGOLT3M0rRIYNVOJE1iJtRUEi7p3Y2l19ygdB5FjnVnaPtR
         tHoBI325qA4NHKcQKGXyyblHjGF7injF2ubD8rKoGv9aap8fe3FFVKNAbzrAAoNVQ6kh
         JJ+fk+F+i55JuZGFQbWQBVDbn5DDAY8ciFXVc9KWzAwU8WDPe2bgBl3jPyWPvjMAwDhN
         FSo2bIvYe7XwUEsW9mxcey/sNPSPIOWQYxzyTqeBN5WEfWUtbjuChEM4apmKqN1UdHhA
         unnA==
X-Gm-Message-State: AODbwcCF0KPfGgRzrdsh4R+a4IoUq597zfOayJQabjRtg6HOqxaiaHXJ
        Kepvxie5wPPCdt3Tx8/MeTo2fZanogV1evU=
X-Received: by 10.129.121.197 with SMTP id u188mr4284868ywc.288.1494412555049;
 Wed, 10 May 2017 03:35:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.194.71 with HTTP; Wed, 10 May 2017 03:35:54 -0700 (PDT)
From:   Alan Pope <alan.pope@canonical.com>
Date:   Wed, 10 May 2017 11:35:54 +0100
Message-ID: <CAMxnTANw-eMhju1qMr8Vgq5j-8t0AU6yj2fCJmMhowgAp=tzmw@mail.gmail.com>
Subject: Snapping git
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I work at Canonical as part of the engineering team around Ubuntu and
Snapcraft [1].

We=E2=80=99re working on snaps, a platform to enable ISVs to directly contr=
ol
delivery of software updates to their users, and make their software
available on many Linux distributions to a wide audience via our
snappy store.

Snaps enable you to have the latest build of git available directly
from github master to adventurous users in minutes, and your stable
tagged releases to more conservative users automatically.

Ideally I'm looking for someone in the community who can spend a
little bit of time over the next week or so creating a snap package
out of the latest source from git master. We have documentation [2]
and a forum [3] where the snap developers and users hang out. We're
keen to find out where the rough edges are in our docs / process, and
improve them, so feedback (+ve/-ve) from this process is essential to
us.

Ultimately the outcome would be a single package in the snap store
'edge' channel which has the latest git master build that adventurous
developers on various Linux [4] distributions can install with a
simple 'snap install git --edge'.

Anyone fancy taking on this challenge? :)

[1] http://snapcraft.io/
[2] http://snapcraft.io/docs
[3] http://forum.snapcraft.io/
[4] https://snapcraft.io/docs/core/install

Best regards
--=20
Alan Pope
Snap Advocate

Canonical - Ubuntu Engineering and Services
+44 (0) 7973 620 164
alan.pope@canonical.com
http://ubuntu.com/
