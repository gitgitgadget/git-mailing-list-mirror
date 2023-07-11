Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5428CEB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 22:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGKW60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGKW6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 18:58:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1FEE60
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 15:58:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so6068a12.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689116303; x=1691708303;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yelit3cLWNOuwPN5+7Vn60snCIhCe7tQ9jqhvkttvjg=;
        b=VnpgRoRg5uid84n6zXgdpkMpyaWT/Gj4x1Og+iwZ8Nby+4Nqzkb+tqOZ0eHHJHRle9
         cF94KAYn05bVdDz8kkzmn/+Ovp6UsE//YWurVeLiXAHDPMD3bs4BZytG/btM8zyK7ADr
         tyCoOdNCSGr1R7oBj1HDQZUwr8KPUQIRctnnjdWc7GiZ3c/hlZlGqXYm4MxfwlFOKbea
         haT2c1M3E7V90MrpbuQ9eXuOJP83XjA6xEBK61DpXumZC46ZUUo+7v40Og+39DJO0NP1
         Xr08+eee+etyJD+7MKrILc5ZicN9eZFNHEVgD3SNDJpebhRH3jC0VDnBBNV2QEl2VlYo
         8iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689116303; x=1691708303;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yelit3cLWNOuwPN5+7Vn60snCIhCe7tQ9jqhvkttvjg=;
        b=duB8pploebQ7x+BnHUjhhXH23mzh9qmtJONo31NzsX94Wc6aJcB1SlVIe0LhX1EvYM
         65c7Qn1buNZPMI4Uk43PBbTC6PpCFOk+KbfTYyrBxSNOBSaVRx0323iCsdSVx8NN4fdQ
         IZXAghTYxeDGo5pkuStHfIYCp1MEH3hI+T0KmzPO8/CwKXY9K18WicQyOvDto3eyscqS
         tShhfGKvS82TGBGbL70T5GqYrScirhyVF9gChNHpCSyD3Tj2cnDdEjU/9JmY8J7znQxp
         R/CUh8lO574U8nV+ea4D79ypUdZIfrXI2Jd7u5Sx2eKaV4pK/7g9kqjrEy/maVwsFIK/
         /tXA==
X-Gm-Message-State: ABy/qLbsSCiEGuRwMGMo3oXwBOmLIpt+LsDkjuAmykEprpLx/5V6p5gM
        G8TSOd0bukiCU9qB05WcPSBkJNv3TX1HRtrjehf5MkiEqgSeYp/k+Y3E14cF
X-Google-Smtp-Source: APBJJlFs6bP5gVZ2Ssd5bFQ9P6xGRGAqnyT+CjQdO6Sh9D7iaUnGp8WtaKo8vZ9jzZ3vPL1KmtOlEAw8ESitxvcXatw=
X-Received: by 2002:a50:d685:0:b0:50b:c48c:8a25 with SMTP id
 r5-20020a50d685000000b0050bc48c8a25mr53210edi.6.1689116302681; Tue, 11 Jul
 2023 15:58:22 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 11 Jul 2023 15:58:11 -0700
Message-ID: <CAJoAoZmzBfPDyvK33eEeW=YSK_RzBnQNB3pgA84fuv4mMTVuLA@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 17:00 UTC
To:     Git List <git@vger.kernel.org>, ethomson@edwardthomson.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

Google is hosting a standing engineering discussion about libifying
Git, for contributors interested in participating in or hearing about
the progress of this effort. Expect this discussion to be free-form
and casual - no powerpoints here!

We're hoping to hold this meeting every Thursday at 10am Pacific
(17:00 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

We'll choose a topic to discuss at the beginning of the meeting, and
I'll reply afterwards with the notes.

*   (asynchronous) What's cooking in libification?
    *   Patches we sent regarding libification
    *   Patches for review related to the libification effort
*   (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
*   (asynchronous) Where are you stuck? What eng discussions do we
want to have? (We'll choose a topic from this list at the beginning of
the meeting.)
*   Session topic: TBD
