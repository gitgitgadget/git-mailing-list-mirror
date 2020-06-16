Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E56C433E2
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 01:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46070207D3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 01:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFPBB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:01:26 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:36650 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgFPBBY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 21:01:24 -0400
Received: by mail-pj1-f50.google.com with SMTP id h22so744161pjf.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 18:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3T1flP3A+I1bLgu/IH58dInCLksznXOl6eVIpWuUr5U=;
        b=Tn8dgdQqsMOIsSB75PL/7admpDq92kYHsLpbiQhk4l1fM6fIX7HKpGOIDpjNIquA2u
         z1BflDDALedttZNZoOtkIh/NAALaM+uIxp04hX+Uk0pIKn88TBjf2wkFx8bM3t8OFzAZ
         U8RvnX4UZ4U2uRS8+Jhzy4SDNAEaQ5OHP8o4p8QPApTdNw/Qwav12hC348YTbLttXEj1
         A999fokhBtOWJkZ3LnS9fnASJYjuG6apqk2zg5AptU0e5rrNyNyO1I5Q4ECwhAiUgY6l
         pXieJuQYINQ3K9wzOGfnTvuvM9ea4itrz9d/CbgvOBBR06V96pULWNwqd9PKyC9HJkay
         dk2w==
X-Gm-Message-State: AOAM533N6QM4BswdfbHIl/HSf7xP4BHdr888hf3iXofM4A8JAoN/HVUk
        B5r0skvj8eUDHPSpOQLQV5nvwtgRWos=
X-Google-Smtp-Source: ABdhPJyN73ELda7VE5BJltjkDrwTdpdgdNOQ1KhqtEaNB4oOoS2295mb/gD7afb35ESY1l/66Uffnw==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr534438plr.132.1592269282251;
        Mon, 15 Jun 2020 18:01:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-241-217-178.hsd1.ca.comcast.net. [73.241.217.178])
        by smtp.gmail.com with ESMTPSA id ds11sm603088pjb.0.2020.06.15.18.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 18:01:21 -0700 (PDT)
From:   Fang-Pen Lin <hello@fangpenlin.com>
To:     simon@bocoup.com
Cc:     git@vger.kernel.org, "Fang-Pen Lin" <hello@fangpenlin.com>
Subject: Re: Rename offensive terminology (master)
Date:   Mon, 15 Jun 2020 18:00:11 -0700
Message-Id: <20200616010011.6638-1-hello@fangpenlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Fang-Pen Lin" <hello@fangpenlin.com>

Actually, I saw many blak people claimed they think this renaming "master" to "main" branch movement very offensive or even racist. Like this:

Quote:

https://twitter.com/Speedkicks/status/1272291128000167937

> Reading a thread of white people, including the CEO of GitHub, advocating changing the name of the "Master" branch to make black devs more comfortable...
> is the most racially uncomfortable I've ever felt about GitHub.

> Reasoning: Living as a black person is not to constantly remember how different you are but how different other people believe you are and how that changes your experience.
> Now I can't even say "push to master" w/o the paranoia everyone around me's thinking about me being black.

I am not a black person, but I also found this movement to be very offensive. As a person grew up in a country used to have language and thought policing, i.e. people could end up in jail or even got killed because they say something. In that environment, you are taught not to say any opinion at all even it has totally nothing to do with the sensitive topics, like the leader of the country. Sometime it could just because this word sounds like that, people could interpret the way they like it to be, report you to the government and you will disappear very soon. I found this renaming movement pretty much like that.
