Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ECDCD611D
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377576AbjJIScM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378066AbjJIScL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:32:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CF0F1
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:32:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c27d653856so70753231fa.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696876324; x=1697481124; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zCBoEKO0UZ2YyxlcXS7R1ytRFORMuZIZBydco1OxzyM=;
        b=IVoxFcunYivsbSGt7/EN33yqxXdt3GyTdTPDw7V0yVqUY2qli6nWiEi2sf1n/BSTrG
         yc8yV9x7SId3v13Q7XywEUgfcdAKOoCntp+XWfEzNp3Da3wkEadiftFXuu6KvdXHfVge
         YEGlfVKKXxsCC7hvCdSGCohecLG/RSSOk3nL6mDJUT5oPMUYTQsbzqdBOm5MKq4RH3og
         oaiBwEjC5Kl7wnQ3hkk9/xTrbq46mRvQopdeu6VGO2fKclwbqWQSo6HLYnJshfnvLqSf
         M+2OE/gx9i4NZ/EExVp2KPQhBd6tP3mOzeGEB9HrfMD8oBKhUjELoq7b+JdJ0bqUXIxX
         VxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876324; x=1697481124;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCBoEKO0UZ2YyxlcXS7R1ytRFORMuZIZBydco1OxzyM=;
        b=l7FXJKGw2jYZdfJaGwtN3bZ91VoWlleTGC4Vb8v4D6mqOGKL3sC2wYWCd9Gbc1KzlV
         7eBPjDaFcXwWxrjbUjc8QivxCYmVcT5qUVXn/ILL1Elj3e6GRoKurzWMnNjEJjKWw/Hc
         gd4xV5SPAFyLpyUizn6Cszi7FDNgoN1oVxvmgV4P+1XWeiyoTo/h8fr17qyHWZ2y3hYK
         8QySDmx/hMm9qxRWX69+uvDfIZ41osQSIYeAtcKcYjXrNU9mkW5BFEgC+NYfAH0ozelG
         /sEnC+9SK55ZkKrVcuZYr+3wtkTIvEtd2gzbKOdzj3A8YU8CGVEiDbKk16pqg89qtpHJ
         rspg==
X-Gm-Message-State: AOJu0YyU3KtNfCGPfjicfZCf2FzYSp4zhAk+IjmrAz2BFaEyIjt0/HpX
        pW0+Ae3SMsNC4Nrc0gW2nAMef6BaRe6/QyEC2K5wLzW+CFT8rg==
X-Google-Smtp-Source: AGHT+IGTTPMCp1VnRoXUJb7uwOPI+AyPV+l1AdQsEEoCTS/7Rd6B5Rb11/i0hHrQWTXFD2IWhyCn13zvbkwKZXXG4A8=
X-Received: by 2002:a2e:8516:0:b0:2c3:ef14:a5c1 with SMTP id
 j22-20020a2e8516000000b002c3ef14a5c1mr1380257lji.21.1696876324440; Mon, 09
 Oct 2023 11:32:04 -0700 (PDT)
MIME-Version: 1.0
From:   Doreen Wanyama <doreenwanyama20@gmail.com>
Date:   Mon, 9 Oct 2023 21:31:52 +0300
Message-ID: <CANhBNnvUx=KG2RkkJEamr2KHerXoDrvW2qe5zKq_xiV1t9V92g@mail.gmail.com>
Subject: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community,

I hope you are all doing well. I am writing to show my interest in
working in the project titled move existing tests to a unit testing
framework. This is because I have always been intrigued by the work
the git community does and hence I am interested in being part of
this. I have gone through the links provided about getting started on
this. I spent yesterday evening and a better part of today trying to
understand the resources. As of now I would like to start working on a
microproject since I understand this is the first step. I am finding
it difficult though to start. Someone to please help me understand how
I should go about this or how I should go about finding my first
microproject. Just a brief explanation will help.
Thank you in advance.

Best regards,

Doreen Wanyama
