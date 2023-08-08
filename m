Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE987C001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjHHUjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjHHUix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:38:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F81173630
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:19:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so4425e9.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515164; x=1692119964;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8HhvFmZjhDliWMxbgCsYnamZJnuPdDL2KrnBCBdr19g=;
        b=KM23f16UKXYHtrQIGUryQAR0l1/3UHG5VnWC5GflJHJstIJaOPVSiTcPmCy9y8jugn
         RTYiQdmoo78p7ufv0Od1IDm3rlKxnhi/3KT1KgYE1Miqy4nVGe2UnA90YhCqcEIhi9vE
         jH3n2NFc1ybNY3RUsfIDy/Fk28EWFTIKjZNwO2cwdExS9mDeK5SIPNL69uCb6ZJIMKBE
         ANJ0hXnBEiT4rFJnfjN2bUzRy+GFpfvxy3mrHFZATDkOq8znZyE9JpotVZEmATc1Tnzh
         BJ1o0N2rMwuGNTTZJOiUwD6DqCCx4kN/Ee3zTG39kw1BlRL1cfu1+Es3z2Qsfdnxwm3C
         aIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515164; x=1692119964;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HhvFmZjhDliWMxbgCsYnamZJnuPdDL2KrnBCBdr19g=;
        b=dktNlVqNrF+RQc9aollkAbiZO60vBUobLd5noWullun1k4ZpAjlGaW6bp480CusynZ
         lWwjGmU7dNRmtfiZm5fLb8hfcHkcHzABGuP0otVfWvJVF4mqz8D9wfdUsinnWMb+RSH4
         eqFcH/DsNRlA4RqkzeVz7xwjUEg6f8VhtW49Cge+yrrNSPcyAWa1BDGKz3fAOY5v5SOJ
         7hu38MJwnBf6oVeFcV7P24LT8tCuESOYeM8wl9z1u6qGaNro/8BgBmhuUOGuRvBlzerP
         Tiu8a4RdoWPWujqKGNfu2mth84O2L7FoOk29ogEvIuWYBD1Wy1sRwOSGVZQVryzaYYSD
         MgiQ==
X-Gm-Message-State: AOJu0Yxh6CZofVzLxDFpVjuArGxiOFyeC+BBK2IAuVLPBOEnLeu6VgQA
        otmP8CMHZJNNjDqRjgesX76rxPLPayEyGY0EOEfGimk5BDYbUZIx1X5dU8+1
X-Google-Smtp-Source: AGHT+IGCzMQHMFAFqYK4dIzaU37YC02YPW4eHQXGnYOffwEPmru/dzu2EYQc5a1QXFOWMz22ddqgInXNcsXmTOpYSV0=
X-Received: by 2002:a05:600c:4f4b:b0:3fe:b38:5596 with SMTP id
 m11-20020a05600c4f4b00b003fe0b385596mr6252wmq.6.1691515164177; Tue, 08 Aug
 2023 10:19:24 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 8 Aug 2023 10:19:13 -0700
Message-ID: <CAJoAoZkYvqrx9_ztBQ0JY1U_b6-FDaS8+v1OSKEX5ONGBzCdgA@mail.gmail.com>
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

We hold this meeting every Thursday at 10am Pacific (17:00 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. The notes document contains historical
notes, including for weeks where I forgot to send them :) Please also
add points to the agenda (template follows) if you want to raise
awareness of them.

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

See you then!
 - Emily
