Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=BAYES_50,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_MR_MRS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URG_BIZ
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC25C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 10:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D289F60F21
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 10:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbhHNKWZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 14 Aug 2021 06:22:25 -0400
Received: from mail-vs1-f100.google.com ([209.85.217.100]:35582 "EHLO
        mail-vs1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbhHNKWX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 06:22:23 -0400
Received: by mail-vs1-f100.google.com with SMTP id b10so7854839vsp.2
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 03:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=VAiPDqNUvZgqDJepRHyuUf4TjE4/azdDs3DiusR8+Rk=;
        b=V+wafRLLJo43tgScffDlKrwcELQHvt0OhQ2Xj6oOjV625sihJsKGJd1PxyyxRIqpSf
         JWLK2dcUDLDXuJKluJtoz4Q76ljmWonnJN+1FAInK4M47LvGm/8N6x940hSw6cR4v8u5
         An5fzZwSK2LgHzBd6lT2m/bILJc6q8pMY1/hD/5mUkkm8abufG2MjjMmxvVhvrDoktlQ
         n+F9jezjXf1PH56jBrxXf2Dh9kXH56C22JfE0On8gBTRTMOrMXYfJDZjeGNb2D6s/wzo
         5LPfVCy7xrC1Qik8x2jQHZtcrbdkAFiuVlntFH/1L6guWHoNQj9FiCtXJwJ35dQ/zhfP
         +fRQ==
X-Gm-Message-State: AOAM530qQQtgDnmnsXnyzt8O6HutnsfeqcqBqIfqRZ8BoBfGwDi6wYUg
        FUHEDehI/Aey1uLx32xkuQtkPvibzoo491BTSwWTXsiRV5Ts+ivB0rYZabJ92T3G4w==
X-Google-Smtp-Source: ABdhPJzSiQujPl1SEmPHQgF3APsLKNv6uc7xF4fZ0C4L1JkouR8YmzxTyTW9uERRv3o/k44kWSII9ejfRY5q
X-Received: by 2002:a67:b144:: with SMTP id z4mr4905628vsl.18.1628936514211;
        Sat, 14 Aug 2021 03:21:54 -0700 (PDT)
Received: from mailserver.dinus.ac.id ([2001:470:ed8a::36])
        by smtp-relay.gmail.com with ESMTP id h70sm947246vke.8.2021.08.14.03.21.53;
        Sat, 14 Aug 2021 03:21:54 -0700 (PDT)
X-Relaying-Domain: dinus.ac.id
Message-ID: <61179942.1c69fb81.b05b6.3299SMTPIN_ADDED_MISSING@mx.google.com>
Received: from localhost (localhost [127.0.0.1])
        by mailserver.dinus.ac.id (Postfix) with ESMTP id 70D66B1807;
        Sat, 14 Aug 2021 17:21:50 +0700 (WIT)
X-Virus-Scanned: amavisd-new at dinus.ac.id
Received: from mailserver.dinus.ac.id ([127.0.0.1])
        by localhost (mailserver.dinus.ac.id [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8lKM6qEc_U4H; Sat, 14 Aug 2021 17:21:47 +0700 (WIT)
Received: from ASHMORELLC.dra4a5w2he2ezlmpoo0mstqetb.jx.internal.cloudapp.net (unknown [40.124.133.223])
        by mailserver.dinus.ac.id (Postfix) with ESMTPSA id DA537AD405;
        Sat, 14 Aug 2021 16:31:44 +0700 (WIT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: RE
To:     Recipients <handoko@dinustech.com>
From:   "Mr.MARK TUCKER " <handoko@dinustech.com>
Date:   Sat, 14 Aug 2021 17:31:39 +0800
Reply-To: marktucker001@naver.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are in custody of an inheritance attached to your surname,contact Mr M.Tucker with your full names for validation.Ts & Cs apply.

URGENT REPLY NEEDED 
MARK TUCKER.
