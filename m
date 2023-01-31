Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD29C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 19:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAaTlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 14:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjAaTlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 14:41:51 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4851425
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 11:41:50 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id a1so135227ybj.9
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WudHTvufJt3pfpusTzPs3XScCkc9X5LTtgomd6i7vt0=;
        b=ZpFmuFHBcP8fDJ93dkYZoTpztt4gkolxlhbC1jKYwMJ6whx1QW8Tu5bmaRd8qsqETM
         42kWyWy+3glH4wLTAYWeSO3B6uxQvWPz0tUp3ktYUN0IZkvedHWncxGlOY6lZeeMiOCE
         rZrGzSl3BQzT8h17COAmc1qqQOdqVV0tGNBxPfWYREmmgyRqjsEHT0xugSCg5YSL7l3a
         qqTglTLSnfSiuvs9TuZBCFibKOOfkbDnrmjQ06Y0xh7R6O//S6pp8P/h3+sMR+Rl0poD
         0NoUSKy89P3DSdl3LhvKcybY7RTgrxDjP4DortN5/m4VHX30yvAe6O54jZ4Y/w03GIOM
         GWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WudHTvufJt3pfpusTzPs3XScCkc9X5LTtgomd6i7vt0=;
        b=RA179FWiY6lcxtZtnvH9BhaUquZwq1vD1q6TvCgaOFpWZKVJ7IpSYcHLDGeLF2SXgJ
         gaFGhkOLgASnnEPiTq1IRY0qxPKbBbYKywBjyJkEPRR+qOKcwivuVcfoTNplFObbUFFC
         rX3yVVN7eg81bNmZF5HGj3aE7TXS7lzf7YD9KK2bhnYB+hDG/4MVadiUiH5Xc0JwyACY
         mD9xNTLHbg+1m4DTZN1zTnNyQcxT7sDLrWSonQYxJFyeA97YcGPAgFEufIxcZ0gC2gS1
         6P82WGTlraKOZXmZP9SFIq/zveQ6zhUIE9uw/OZ8zS/dwewinsAI6QqxCIU//8cLcv7b
         otDQ==
X-Gm-Message-State: AO0yUKUfNS0oMy4G4uIBLyBjNMyss4k0KAJXtu71Ndr1yJo+wKWS+ivH
        t73V923IyZ3g6vHuf+rnX611hwu/COV+r/DlElC/SzoQ4oqxd77PDTb7Mw==
X-Google-Smtp-Source: AK7set8ClOPALCVhJhRwQlztnoG2MfNouKogczMADG9rLYKthIpXzw56PNfVnMAZRNnUXy2IY2S3vb71jPk92DDUGw0=
X-Received: by 2002:a25:afd4:0:b0:80b:e8c7:5e0 with SMTP id
 d20-20020a25afd4000000b0080be8c705e0mr17303ybj.286.1675194109803; Tue, 31 Jan
 2023 11:41:49 -0800 (PST)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 31 Jan 2023 11:41:38 -0800
Message-ID: <CAFySSZDOSJ0mpWH=4HE=5w2KVEKWYzOxGQv9GSLc8FbCMBYRwQ@mail.gmail.com>
Subject: Join us for Review Club!
To:     Git Mailing List <git@vger.kernel.org>, zev@bewilderbeest.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Zev Weiss's (new contributor yay!) added
flags to git-format-patch [3]. Let me know if you're interested and would
like to join (off-list is fine), and I'll send you an invite :)

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/git/20230119223858.29262-1-zev@bewilderbeest.net/
