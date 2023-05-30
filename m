Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6BFC77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 21:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjE3V1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjE3V1H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 17:27:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C521E5
        for <git@vger.kernel.org>; Tue, 30 May 2023 14:27:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so1092a12.1
        for <git@vger.kernel.org>; Tue, 30 May 2023 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685482024; x=1688074024;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRb1O7vtNth48GCUJFt8NOUCbqERnfRFwsD+fyS+edI=;
        b=zz3r6ld8u7x+jGXGCE7eO5MxDXINH6Gr7ay6umncMaqEuKkiw4cHnt5mV0lwwwCSQq
         Mn9tOBuQ5kUSNOjXyLw9vb32jKHRrDExPOdeoFvFY6ORTPJ1oKhw9Gz2nb/BBxx66osy
         aRaJ4BeiUPHrqn4ECpNBPzyK7JoZuYI5VUAVNLXYrGOeEXCbJCJAH/AR9rvYT7DrsYyP
         IraE+ExXEVYZDRW4MWKxV1Rg9c7vB0XcGOlpRIE52HyyU38ZlFvLh9SJbKJ7lWYt6JXb
         8xMMlYNuUuw1t8QPsfldf/Tg9C+xC5tT0HLmIcmSrWBEdLX8AffY3j3dGyFotVn/TmSl
         tS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685482024; x=1688074024;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRb1O7vtNth48GCUJFt8NOUCbqERnfRFwsD+fyS+edI=;
        b=bhBPLahO5+e/HgUybYFImBs/cQynY13uC0IV/agb6/bu4VfbeFys25Tr0ycoxXRDfb
         KqEDLUT+lVLI1kpTgOzkn6oAcZ5Zq8UR+36rYDHbQ6IPJmCyCJgDBGe9G7gnf2LIUeyL
         5djm78RC7y0hHvtqS13cQL2MC23tGj8CDIBiaj2a5iaSaSzCM/9eFlmciL7gqVOTzlY0
         C+mSKF/EqHpLgri6pGigA6Hb9e48x2zlA3inknj8I4VfNvzGO9XLDBEkVmv1V6sTlb+p
         qIp2b9FQtgGG9cfbFDkyY5abTf0IfLBUisl86MXxpmolqcv+mpnU+ebGJ00Uszu2resI
         n7AA==
X-Gm-Message-State: AC+VfDxmq9QIsVQ+evTEz1y/9x5azeDG56xTHbBZRSrZWpvqzKstbwAB
        TTGdLPyAVgqamy+c4F2nq4QgqzOmn1Pj1yeNqNF9QC5uL3r17/K5kdM9A+Kh6pE=
X-Google-Smtp-Source: ACHHUZ6TpF0uVwz7GV9Kjx85GX+oA6qDyppxh0LyAzctjONldxzrPx8fOW8UXheiqdOYeNIVOA5iMuzXnyxo/rQvSVk=
X-Received: by 2002:a50:f605:0:b0:507:6632:bbbf with SMTP id
 c5-20020a50f605000000b005076632bbbfmr26766edn.6.1685482024084; Tue, 30 May
 2023 14:27:04 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 30 May 2023 14:26:53 -0700
Message-ID: <CAJoAoZm18rJa3i-SYoXdbVxZ6yBNHfCh8W_0vFbJhr_NuvRVzQ@mail.gmail.com>
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

We typically hold this meeting every Thursday at 10am Pacific (17:00
UTC) via Google Meet; this week it conflicts with a training at Google
so we're moving it to 16:30 UTC.

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
