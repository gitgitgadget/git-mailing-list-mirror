Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44BC020357
	for <e@80x24.org>; Mon, 10 Jul 2017 18:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbdGJSoh (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 14:44:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33587 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754009AbdGJSoh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 14:44:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id e199so15632980pfh.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QrUG88H6wFW7XeW8I3QDU7zSGV7WrJ3LRHcU/NKq2w4=;
        b=dMpKhFXdzzM6Wj1qw2FLoa2t5E4wP4Bmm9mZzQeD33w5WAtrTHp1nGFTMpsqy5KPmZ
         3K2OpYWChgTzr6mYtrLrIrePMeSQtZ3iTHhTTj10fUVNUZf0HAGMxzDnkecXFDdp3gMj
         Iag2saOS+d8FpoNb728A3qFhl5n614E4OIC0QPLwohbXdB1QaVOR+Y8Ha7OM0COokO4e
         KOcneWsZB8MvQgjZSrxAfBPnqgFtErj04tMszsDbsZooNaKc4BiwC/ESLlWz8MYuUDwX
         HItXjmIx+5qSISRZ8fe+mgkNyThAEwK1kcgb7Hh/UImOZEzPXEDN+ZA+gbmkJH2KTMhd
         tZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QrUG88H6wFW7XeW8I3QDU7zSGV7WrJ3LRHcU/NKq2w4=;
        b=uBthmw4bzOjMM3jW1bmXLjwio45SGeJSVKqbNKmW/OAUOsw2hIN7A7pClp+8ot1ByV
         ucHv771KUauXeHMy/ykRSU2NPizlgX0aXbPAsSxiSt29nQ+faEwW2qvphyoKHM5ftzWR
         VkKc9nZ3IIIUKRTrifCvpYyavcDbXGlO2Uz2Q8G4uC7Ze61jpIp9ezWIGDeAlFqFxxf8
         LcPNjjTp1fge3oGlzoqHK8uSAO8+dD5XQm5HlArWFbV7mbMFYbeYnldmBTz8owKGkhOo
         7OU/5VxsownMveoAnkBwkjIRWsOsnu3IO6DG3Oz6e/lLGh4WNo/X2JMpZFiUiJb7MmMm
         ZACw==
X-Gm-Message-State: AIVw112XkmBx/uULyiTW7evBsW/uYV4lBAUqDnZIVFpyAwqxCCMPyPEH
        /0m2/ZEp16HJQg==
X-Received: by 10.84.231.203 with SMTP id g11mr18961489pln.241.1499712276434;
        Mon, 10 Jul 2017 11:44:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id 63sm22205730pgd.57.2017.07.10.11.44.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 11:44:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     andre.hinrichs@gmx.de, git@vger.kernel.org
Subject: Re: [PATCH] l10n: de.po: fix typo
References: <f11120c3-30fb-bdfe-a597-8ceb41097209@gmx.de>
        <20170710162308.22108-1-ralf.thielow@gmail.com>
Date:   Mon, 10 Jul 2017 11:44:34 -0700
In-Reply-To: <20170710162308.22108-1-ralf.thielow@gmail.com> (Ralf Thielow's
        message of "Mon, 10 Jul 2017 18:23:08 +0200")
Message-ID: <xmqqwp7g5dyl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Reported-by: Andre Hinrichs <andre.hinrichs@gmx.de>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Hi Andre,
>
> thanks for the bugreport!
>
> Ralf

Thanks.  Let me take it directly to 'maint'.
