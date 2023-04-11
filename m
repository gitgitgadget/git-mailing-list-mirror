Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32612C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 18:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjDKSkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDKSko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 14:40:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787259DE
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 11:40:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qb20so22375827ejc.6
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681238435;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vWE/G5wdPM15Aqf/V9Ec/FZRgvcuw9tmpSKw+JYRmqk=;
        b=A+e/4UhjDbm374JM6IYFrrEALjfpVeQAi4oFMvo0uyZMosnqi8RadwTZ7Ncn+8eZ+L
         eYiAaiqbGI+nVUPG0chac426p361VeZEmd9c4BQz+4Z5DDVkg/skZARDoz1q8LUNQrQk
         sEvZEsuGhupT2zduP7QFtn4tWiHHlxkqOG+UCjW1TYHfW9Fj9l+mL7thDanjylrANcqM
         eslwAdzt+vQSun7en5S6BqvvtQs5dgqWj84tt9J0FyFpZLZkP/f1tpirJNuKG6mnmNls
         Wp4jtrTArHDIEIoJhGdaHUGQCyT8uIwFf/GQE6ZYfW9raU05FC/SLYdHQzB5TrPoG1BL
         OaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681238435;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWE/G5wdPM15Aqf/V9Ec/FZRgvcuw9tmpSKw+JYRmqk=;
        b=VmFF1Cw0x0X1jOqdNoUs4PjUMUXvz8bbmtNDyTUpGHvpo/xISwQ7aLJ8aNdPpxIvtZ
         XkzWzTkdXtGl2qqpAyb0nS6jVEBCh4gR5TDuuNqtI8mS+AHkr2W7T3exgjLOa/oJQZFt
         Jj1rfa4pLCYm6ucE+IP1aC8N8utmwdo2VLWnpz9TF/H/sfwA+07xke06s5RTllZjSiFg
         8wPb5DqXqgz0Tg13xMQ6T/t+DFl5oDLvkh9dEJ3Ag0G+aKUspEDkNimBlxj1EcqK3lG4
         mxWySmjtZkjjdI1YN1gOgKDhzm6H2w4QS68csFj2L52odqMoUHl35gTsGZnvGavANafL
         UoKg==
X-Gm-Message-State: AAQBX9eT1o+tLTdLfpNFQGTecRleWd5wWT1Q4+3oqsRzZr7zbADnxNuE
        CN8hVzgdWsehwBPATBkneiDm6T8mUnEu/4C+pDolHbruzHLsI5ciaukRWA==
X-Google-Smtp-Source: AKy350ZX904Mze2Fe7TTVCK+kZG+uJ+GQDvfCWqMl2X9IUWrzdzk25slj5W763BmJRj59vBNOl4v/GDDnGZjQb6jSYA=
X-Received: by 2002:a17:907:a08c:b0:8eb:27de:447e with SMTP id
 hu12-20020a170907a08c00b008eb27de447emr5194333ejc.7.1681238434902; Tue, 11
 Apr 2023 11:40:34 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 11 Apr 2023 11:40:23 -0700
Message-ID: <CAJoAoZnBPH6j93eRRuVKZkDix9h7S287eTMfF9dK0CvC+meMxQ@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 16:30 UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

Google is hosting a standing engineering discussion about libifying
Git, for contributors interested in participating in or hearing about
the progress of this effort. Expect this discussion to be free-form
and casual - no powerpoints here!

We're hoping to hold this meeting every Thursday at 9:30am Pacific
(16:30 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

We'll choose a topic to discuss at the beginning of the meeting, and
I'll reply afterwards with the notes.

 - (asynchronous) What's cooking in libification?
   - Patches we sent regarding libification
   - Patches for review related to the libification effort
 - (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
 - (asynchronous) Where are you stuck? What eng discussions do we want
to have? (We'll choose a topic from this list a day ahead of the
meeting.)
 - Session topic: <TBD>
