Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C7FC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDNV4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDNV4q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:56:46 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4411FF0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:56:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n203so8593152ybg.6
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681509404; x=1684101404;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Cc+duMJQzhbNZo69XZts93KicNOKgojmaaLGk7nPk4=;
        b=H4hkbMP8fB8tcTbDil/j7+Q3p8FAGvcvSXbNCC4bsVXGXtuiZpHyXLN5LCJH+ytkMq
         GVrVSOBdkkgfwge+6hYz3ylUDC2lv5Ox79dkzgwfDG17KTXTVTIhLva63ESIyDX/18j+
         qb96u6VtsPTSxvZEzUjEk0CtEdI0h5XGVEAfSlUk0iehDqJcTBbWrNtfNxVcw6sKHRBZ
         UsNkye9upZx7XDKakjFTFCaapuSQc9/aIYxOwsB/MBgpq++H7l+tqdBDy2M9bJKTvJFt
         jOz3EcBAmA1e4OkR7M09/p/1GB8+TMfYPaqn5ssnmLsoLQdrceUuKlmhLVH5TDeC653q
         6FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681509404; x=1684101404;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Cc+duMJQzhbNZo69XZts93KicNOKgojmaaLGk7nPk4=;
        b=QCaG6HHvs8qSwbpwGYrejDNEkTOF2Alg6zpC1HQfLFfY8OT1qXv/Ht+CRTFpHJlfDX
         oErQFm8nP8GnQh3IgVtzAZqdBYWwo4MzMGNkvu5YvN76o9hLD8BzsbzG9sqSzvtoLTcR
         RpTsPFllKraQWqLJD+kwpofE12GpnPCCwwcLzCV+PxfzKY7pZUUaD6wb6hJsE6mRrlnL
         I5ePwUJNKyPgGnlR4NTEP/7u+gq/TQEaW32/0PDpy24KAO+Tm4O38B6zKhmGelJTdYfA
         3zvmHjOeJ5Q7F7D90OyMtsY3iwxaKYXfkzupEJVeYKyVjWgJ0jh+jNkuCvn2WtH1XiHj
         pZAQ==
X-Gm-Message-State: AAQBX9d41BolNeDACfX06P4oXXDk2oGCqW2y5C1o3YMZF0RLkY2RHRgF
        L48aDMEz3IHpR7dfcvDWYJe3cBsd6rVM76rBleSQRaA5Rjvc4KvQ5IhlKw==
X-Google-Smtp-Source: AKy350bUhVypdVmJE3hoNIoKhxUt6Jc6x7mvxwhWYOFj4oxCLGxR7/Sncvn2Fo8GSEA9yu+sS6W/WGd0mVVN0FXyzWk=
X-Received: by 2002:a25:d708:0:b0:b8f:448e:2f9a with SMTP id
 o8-20020a25d708000000b00b8f448e2f9amr4688222ybg.4.1681509404201; Fri, 14 Apr
 2023 14:56:44 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Fri, 14 Apr 2023 14:56:33 -0700
Message-ID: <CAFySSZAja6bJqffG39B3y=K+8ThLgwh8D+j8hfvbEu+tFa9Uuw@mail.gmail.com>
Subject: Join us for Review Club
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Tuesday at 9:30 Pacific time (UTC-8).
(CET friendly time for this week!). You can find more info at [1] and
on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Christian Couder and Elijah Newren's new `git
replay` command [3]. Since this patch series is too long to cover
entirely in a one hour review club session, we'll mainly be focusing
on the cover letter and patches 7 and forward. Let me know if you're
interested and would
like to join (off-list is fine), and I'll send you an invite :)

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/all/20230407072415.1360068-1-christian.couder@gmail.com/
