Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7E9C43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiGDP7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiGDP7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 11:59:55 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90DE249
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 08:59:53 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 68so9243514pgb.10
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 08:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcyzXGlo4kPkYLBLJ4WUpDJMUUetd5PLEGnMLGc7cCU=;
        b=kJTiLjV2eWRKzHZfogr6A7HgZd/LLZ7yEHU+7YzIefJnfTHt8K5idD+x9FehNM3qe5
         Lqe5488wGU/QlM/YdcNxZJLxdT8gxI67qIg9abIz6pAnTgKPysWJV668jYPa02xUoI+X
         rLoT1j1v0sm0TOm4oqAc+9VU1BqBK4a4+MxTU8o7wsLV/NHvjjyTbEntUBkTXXmJrttM
         O+YIdYdTe03n4KnOqVwObCM0+Dw5E4W4U80lX1Fj6xwYU4/UsSR0DTstRYI6g7wepEW5
         6TXLiKaYHv9ix8T6oFZKbdbQwUKlfO3cpMZKrCyYocPmQ6hcYPmAKEP8MI6TvgtGjhDl
         bo5Q==
X-Gm-Message-State: AJIora9T1rsSrX5kzXq1PTNWEE36lWp/DNPY7N/kbH0r8wWa0y/rGJ/+
        DgDxL42MotF+LPi1Lc+L5VOK0G7L7VzxETdf+/Ala5rs
X-Google-Smtp-Source: AGRyM1sVMJ7clzT3NwXVOTvazwKietn+AhkVgI4P3c+8gX46muOsr1GA21PM0fSQkwRlxaGKj2j2EyqA/3E00lYFqrA=
X-Received: by 2002:a05:6a00:21c8:b0:4c4:4bd:dc17 with SMTP id
 t8-20020a056a0021c800b004c404bddc17mr36218365pfj.57.1656950393113; Mon, 04
 Jul 2022 08:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo7y85t44.fsf@gitster.g> <15631ea2-6722-fd24-c8a6-0cee638b0602@github.com>
In-Reply-To: <15631ea2-6722-fd24-c8a6-0cee638b0602@github.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 4 Jul 2022 08:59:40 -0700
Message-ID: <CAPc5daXCq-JB0Uy_mGk-itLtJBug7sZJ0iE3JX+qX3Y_fpWRDQ@mail.gmail.com>
Subject: Re: ds/rebase-update-re (was Re: What's cooking in git.git (Jul 2022,
 #01; Fri, 1))
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for a heads-up. I thought that all of you were supposed to be
off this week, by the way ;-)?
