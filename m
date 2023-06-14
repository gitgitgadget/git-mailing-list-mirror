Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C21EEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 16:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjFNQ26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjFNQ2x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 12:28:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD25211F
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:28:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so13325a12.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686760131; x=1689352131;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fqKIt8A3p7cgXbyaWWGW9j8hgphWhMv80zSTxzmLKEc=;
        b=Ku/dQRRHcyH3Cd1v0mEfMd7i9wpvKK+AAdoi4X8toEZkleyZyiGDYlsicSIvsDUiQc
         2cDsQOSzS1rbg+ZooDKVJiR0ZRCLhAkwxm78yFxqp/M0dGG7npIIhKKDKQ9dFRH6AuP9
         8nCMTIq8GTz/SI9EvJzNvnauRb/guXebE7/5c7pglDVX99jIEYF7blWT6FLn026uQEUF
         gRrMQSGG8mdfvWkwx18TPc4ajM2tjGS4iNaYfX+zbhoCXk5qESQd0o526hQIObglx11x
         no/s9BdMET5WnqYhbwAbDaQuBydH2pzahkfFhZs/BaF3U3cIJRWq0gXUSea6+6fITEdT
         UT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686760131; x=1689352131;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqKIt8A3p7cgXbyaWWGW9j8hgphWhMv80zSTxzmLKEc=;
        b=Vo4BHNh3c6scIvqoiQYGvyBf1TBlUrvDdY5coLYAZ725oUXCeaNDhTbCwA0AY0osLI
         OUOR9Bva6fLQQ9EhjM9Vh6L0qtu8Vab/rOLNP6671rSj95kANxZQ0bCExn7ISmynneJ+
         sYLXu8hbJwHVuRaUKbZU0lzgbIOWixsRtIoy+ziLOH4V3SgJrK0e0YLCOAba4AA/+1wo
         e4Xa32Y9NTFxT+60trs5ucZxF4IC+P25cIqY18K0MGSTWxtwm72RKTVkoCxFVW8k7Zab
         CvfTQMKJPss9RlLgV6NKFODDZi6FRl9uUBS+k5zn3nUkfVZqC/wEXBeFdEYmRqXYQkGu
         pZvQ==
X-Gm-Message-State: AC+VfDyOSFOy+5lSeQq3EAJRC7wuEVUIJHMZWzDzOZm3m3xejgIPGMsF
        UsjGrTbqaMbgNuw7s+SMMmGK6ugdmfBYxjcQpw/WytRqciqKEGn44ul+fg==
X-Google-Smtp-Source: ACHHUZ4nNE+ZcDDZqritMdgSbuq1YfILfW2Q0AJOAUUzGG/iHghSn5VooU5gpDl2WaxEBqRaDeMcYReNQ8spBVETBSo=
X-Received: by 2002:a50:aad6:0:b0:50b:f6ce:2f3d with SMTP id
 r22-20020a50aad6000000b0050bf6ce2f3dmr130696edc.0.1686760130563; Wed, 14 Jun
 2023 09:28:50 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 14 Jun 2023 09:28:39 -0700
Message-ID: <CAFySSZB5AvP04fF+Uk4E6JovxQGQpU0eUXW3KjeMxffQHmm9Sw@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 17:00 UTC
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

Google is hosting a standing engineering discussion about libifying
Git, for contributors interested in participating in or hearing about
the progress of this effort. Expect this discussion to be free-form
and casual - no powerpoints here!

We typically hold this meeting every Thursday at 10am Pacific (17:00
UTC) via Google Meet.

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
