Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6799FEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 19:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjGRT0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGRT0a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 15:26:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F5D199A
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 12:26:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e55517de3so15692a12.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689708383; x=1692300383;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9CKju0dcoon9lt1FgZ59zTi+XBVt0OpkbZe2Gcwk4kM=;
        b=J84jG0AMU6rs5oPziPNKm6OZABl6TcV4Cfx3cD6bjl1gnaRwqGWmrV+7oP+aiGp+IF
         JZNBTFFZQqIvKTmRiqzbfVB1V9vRoEwI3D/Zimo4hWr2ggfZmVDaqkIg3J0GeOkVeHMc
         EK3CJ2xHd2EJNiCbdLLAwP6Gm6espIlVgzIdrk3/KX8LaavG8RInuJ/RRxrvhu3Lr4Lo
         j8O2liHA04JqttzBNnxc/K+4X154MLhdDVLaRj16mTVVwIabKrAD059hlkZV8+A4J7B4
         TYGKV/VY+ShJ8/tLWmqdXXzaVGTMcl6uASEUvWKQS9Tmkzi+1u1Q4LjFE3aZregsQQcL
         Nolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689708383; x=1692300383;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CKju0dcoon9lt1FgZ59zTi+XBVt0OpkbZe2Gcwk4kM=;
        b=l/sIW6STVmbs6sj4V+q1vdsjma7h78W/TRafgiwVg3t3tvkg+BUUVV6yKjcmkZzb1p
         aMkk4+0NT9RgNkzE1wpZS8niqM02uqbn5L8iAA1qcuX439YBiVrl6qUO5YdrRKAJdsXR
         xpeujABtkf6zGNZnyMJr/uS9PoKTxW2t0I0Rg+AciqoRXuSQdyu2/+jNkEPCYdlhorPj
         BYCBFH2W3Q7TLSfHOSxOat2++9zvaKutlPRLui/ljdGP3XYDTj87e9UYT7YQB95B5okk
         wEAt7BtfaWAM28YhgHxYXbKAb3XKXxKl2PQ+2B6a7HMygvWHd3TCCTrgJPaDOM8ZW4OF
         72nA==
X-Gm-Message-State: ABy/qLb0i0ueMBO3IM9t0Bc0r72MukjTC0Xhw/ik7Ahf7y3YNhOiMDDd
        0wdCVzZBLDVfnpZMBt+jIZgLSFIlO80dbWCpg49Fl7szeq6K43jMPZPA+eoZ
X-Google-Smtp-Source: APBJJlEEP3vS2a2n0eH7eRvHgucpm7Zrh2uwnKZQEdLD7ecIZhOlX0JiQOoNGxXNTW93ay+V62EmfDKXIVxb5S8jURA=
X-Received: by 2002:a50:d0c6:0:b0:51d:ebed:93a6 with SMTP id
 g6-20020a50d0c6000000b0051debed93a6mr131229edf.5.1689708383359; Tue, 18 Jul
 2023 12:26:23 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 18 Jul 2023 12:26:09 -0700
Message-ID: <CAJoAoZmBFTi5SFRuG8uh4ZyGs7pKQTYQLzZAC82zh2pMSggX3A@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 17:00 UTC
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

We're hoping to hold this meeting every Thursday at 10am Pacific
(17:00 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

We'll choose a topic to discuss at the beginning of the meeting, and
I'll reply afterwards with the notes.

*   What's cooking in libification?
    *   Patches we sent regarding libification
    *   Patches for review related to the libification effort
*   What happened in the past 1-2 weeks that interested parties or
intermittent contributors need to know?
*   (asynchronous) Where are you stuck? What eng discussions do we
want to have? (We'll choose a topic from this list at the beginning of
the meeting.)
*   Session topic: TBD
