Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7561F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 01:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeFABIw (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 21:08:52 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35089 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeFABIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 21:08:52 -0400
Received: by mail-wr0-f171.google.com with SMTP id i14-v6so34683363wre.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j1C6EjalSfAyMVy15pGYsx9rBIMblJkfYp9kXfRXT7I=;
        b=PWS9rDLahq9HZStc0r0odUIM9jiE6i78S1/8pn+x1n/iRL60QVG5QTltf6KuDBKrq9
         OwfLhJf2Op0qJV0S84putIZ/3xBjrGCXMtltb7GStHjskzYuHsuorTZt2icmckweJ97N
         Og9iXjBUBiVtJSnPbCfRv/U9BsCuffBOcIOygK16/VSeYMcTktEFUKiKrPDSt2+4ZOSt
         p5vz6nHgnYoAebFe4meqGIh2rDjC6BkNo+4oFteuS5JFXCZ7ph86GZ3gho1aTo5lSXum
         pOOWN0/iHeeSe/E80YEZshS707SC9x9Pm4XfSkye1P43Zk73YO6MPHfg4lLJ02p3I9KY
         t1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j1C6EjalSfAyMVy15pGYsx9rBIMblJkfYp9kXfRXT7I=;
        b=K3c58I0JVm98PAyTzhFotFdcqe5t9RmN26iToDWpKr/ylDArqGbg5SZu0i5ClaPpwO
         FjrepVIdY3gX2THWDbCRP507B3pe8IjSW1yn63cDuhpiuYmKjzKZV9OYSP/QqEscZBeQ
         L7qNtWXMLpV5w8lNsTv4jqyoQ4t8YaN74Kkb3DmNjVpUPKuGJWcd58LjPC16U56+PBgU
         Zr8JOnYrm7vzkN0Ns17vtLtDx4EUUxKFpIZ3oUURDF2r/N+eyK5xjvUhFUu773a9VvfD
         maR5RTQoX9PuPVMs1MWP9mh4LYudZygnEMv/hZBkFIrofFkg0B21XtshZIbFVyKVMp8c
         TrQQ==
X-Gm-Message-State: ALKqPwdaXa/0Ant9bA89Ph7aLwMf3Zwt10SO5Wwctll1XISELumsjE5S
        gF9xggXg91QpUuvEYmf2m8toWe/d
X-Google-Smtp-Source: ADUXVKIheWF+6g3PphE9EKolDEcrIvE1CeSLUsj5+M7J5yrPVkyIjkQ2ChHiWqfdoMeLNYwuyiCNpQ==
X-Received: by 2002:adf:aa08:: with SMTP id p8-v6mr6674948wrd.140.1527815330730;
        Thu, 31 May 2018 18:08:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c11-v6sm14369327wri.49.2018.05.31.18.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 18:08:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: remove duplicate release note
References: <20180531032414.20506-1-newren@gmail.com>
Date:   Fri, 01 Jun 2018 10:08:49 +0900
In-Reply-To: <20180531032414.20506-1-newren@gmail.com> (Elijah Newren's
        message of "Wed, 30 May 2018 20:24:14 -0700")
Message-ID: <xmqqsh67b9em.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> In the 2.18 cycle, directory rename detection was merged, then reverted,
> then reworked in such a way to fix another prominent bug in addition to
> the original problem causing it to be reverted.  When the reworked series
> was merged, we ended up with two nearly duplicate release notes.  Remove
> the second copy, but preserve the information about the extra bug fix.

Thanks.
