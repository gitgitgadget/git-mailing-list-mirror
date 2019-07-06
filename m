Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90FD1F461
	for <e@80x24.org>; Sat,  6 Jul 2019 08:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGFIZt (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jul 2019 04:25:49 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:39703 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfGFIZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jul 2019 04:25:48 -0400
Received: by mail-pf1-f179.google.com with SMTP id j2so5254208pfe.6
        for <git@vger.kernel.org>; Sat, 06 Jul 2019 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eeja5YDLTXaBlqyWlvJCf5SXnvzD20Uadkc3vjAGS4=;
        b=hSLvnB+iASv/zXo7PPHpd4g7FLrWQ00e+3Dr9v2cV6jFEhrNdRPqkgVebOdqG1ipdb
         jiw76Tcf4AV2alnjU0QyEK9Yi3rwbwUQLbCFldwTlP7NITmK4Hp6DMqvmnTu49jJAg0P
         qNBNmXgN7guhhAIqxJUhWPXfvXAkTt9HA7lELKnT7v9KMXeKJWqjmlo2RC4FXqRN+KsX
         TuaYzr0WlJ3vetdUKvmndkvFghcH3w8nGEWIwJcpYCs5jpiJRj9r9cQq5rFlsaOBoF1E
         n4ZO3XygzLMOYcSnFXau4raeUeegBi16ChhMr8XLWCi8u/CimwUyFsXip26j5x1UHcaj
         A+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eeja5YDLTXaBlqyWlvJCf5SXnvzD20Uadkc3vjAGS4=;
        b=dO1zY4SAK+47TNgAQH/Rc5CqUyyyFaLhqKigLHqoqijVC0diAbwAL46MwsAVk/MJh8
         ntTGC/QQfbMTbS6sfln40+HXBtZTjk4N9jakUHkshu3zPjp8npt8oH2VmelEZ32BXTnL
         B0lDeLd2c77swosIV1NJVP9D8G9qce99z4JNRmC/UBXF5TEu7b8C0iTQ36SBnAwN5pGX
         nqv0T5wUWtXUxIJxjbWZM0LWCndi46CFG0idB7ELSd587HAwoJmiDdOc80a6gx00Xf+3
         98LJt+TDpX94Hsz+s5qY9uLT6Jdb3nzshRqELsSOPS8B/aI4dzmbZUDjbs/WvBov+VOr
         CONw==
X-Gm-Message-State: APjAAAWs9VsvcAZEWTzUSpKYGN//QXAEVx0ybXLC32v9Xb/CRcf1+YNd
        pfmDCCXzwKFxkaA7Eea/WoTa12gwlGs=
X-Google-Smtp-Source: APXvYqztiYVL0N4h2Lu3HI2KUUoAvEm1klOlCGHML8F17Q/5Z2ENy3JTuACM/BZn+ZSc5wXD851Xnw==
X-Received: by 2002:a63:7e42:: with SMTP id o2mr9816527pgn.162.1562401547755;
        Sat, 06 Jul 2019 01:25:47 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.226])
        by smtp.gmail.com with ESMTPSA id b5sm30573340pga.72.2019.07.06.01.25.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 01:25:47 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     philipoakley@iee.org
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org
Subject: Re: Virtual Git Contributor Summit
Date:   Sat,  6 Jul 2019 13:53:14 +0530
Message-Id: <20190706082314.7371-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <e7f2393a-0eb3-ad3e-4e0c-0500b974e3c5@iee.org>
References: <e7f2393a-0eb3-ad3e-4e0c-0500b974e3c5@iee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip

On 2019-07-05 14:09 UTC Philip Oakley <philipoakley@iee.org> wrote:
>
> Will there also be an opportunity for a listen/read -only mode for those
> of us on the lower reaches of the contributor list? I'd certainly like
> to at least keep up with progress.

+1

It'd really be a nice addition if contributors, like us (the new ones),
can get a nice audio feed.

Best
Rohit

