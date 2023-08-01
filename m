Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3183AC04A6A
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjHAUhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHAUhR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 16:37:17 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A842101
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 13:37:12 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-407db3e9669so20691cf.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690922231; x=1691527031;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LRh+KpKe2aT2JsDPFmx1J70WW+7yspjy/oIjrX6hFJY=;
        b=XJ4lO/vqoxwywbPB7xEd34QxhCWQeBNICqaFqD0IJ2NB5GDHRPcwQ8b4IoThAOxKMO
         6EojjrzgrUvGBAsmcm4U9j6KdbDeU58POSk7jOARWOlZkOXCUXqv8mi2zmXCHciPiTer
         VaH41kS+ZLn8YKXBosfV/ZzLS+oqfRvlM/rdhZY3WZUpGXYUE8OaX6RsjvClZ1KBf1TF
         dEqZ0zxJug5arDZg1FkaV5g+jE9x5yqbdbTCKSixLJGkmL61oxygNIipTlMzK6WbfIgJ
         m67cEud1Jxewf4uN/J4Qi/fKA6CeBxa3PCE857x4Twe8wpj4lliF3noh1JO5RR7uSLJ6
         4jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922231; x=1691527031;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRh+KpKe2aT2JsDPFmx1J70WW+7yspjy/oIjrX6hFJY=;
        b=JByF7jKUbNgCk5NeDVxLEruWmZvp2YPWjdmfTcbOpDga6KbGgCGUOGIFRrXIbNl1Qn
         uzsYgZqLlb5CDtpdoYQ6OnAMd/OThJ891cofwLorNFYoFd/LZ6fZMN1ZmLjvlzED0ijn
         5NqIarpGU8TLbsY2zGt8ZqBAggdG7Qg/9aKE6oQS3KC1qlMTUrn0m/Rf5VsWNdWp6jkn
         KEQmVI3X/yLVl0Nn4IClJz8dhRV5rfkwB9MNBEeqQrhFdp5O1rap8AkzlYDNgVvQRh2Z
         zRzeDmpQDURiTiHo+p6O0595LCNL86Msb4r0Iix+CxhNPIwkNgr+cIEHLXQrVUkWTC+F
         jIMw==
X-Gm-Message-State: ABy/qLalFPtU5jDFPzebezcsSddFWQr2NapmFIOpfTwq2VVGBvWMh/IF
        TtNVZWAqVQZdZ/Imzf2/VPiIH4JtgC61gRkjmS25iCpHdIbYW195aKx+GA==
X-Google-Smtp-Source: APBJJlGDlU1TPQmCGCV+uuRBEfOhsuwSMi/GmjRLGg/qcmZFFQ08FvP+oyHMqi/sX+i1oFjJm00Cn0UyzYW5KGUsr/k=
X-Received: by 2002:ac8:5b45:0:b0:3fa:45ab:22a5 with SMTP id
 n5-20020ac85b45000000b003fa45ab22a5mr1050780qtw.27.1690922231134; Tue, 01 Aug
 2023 13:37:11 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 1 Aug 2023 13:36:36 -0700
Message-ID: <CAFySSZAATPsb_ShZktHFjL9jr=xw=xVs-QWPqoqMNcVwZmmXpg@mail.gmail.com>
Subject: Join us for Review Club
To:     Git Mailing List <git@vger.kernel.org>
Cc:     cheskaqiqi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday at 9:30 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Shuqi's integration of check-attr with
sparse-index [3]. Let me know if you're interested and would like
to join (off-list is fine), and I'll send you an invite :)

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/git/20230718232916.31660-1-cheskaqiqi@gmail.com/
