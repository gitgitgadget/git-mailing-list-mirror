Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9401FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 19:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbdBPTXF (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 14:23:05 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34019 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932421AbdBPTXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 14:23:04 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so2237626pfb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lDgFIgWb5I8vP3z7FSNZzOZFKs0yUKRogCHqJ+c1oHs=;
        b=MULBa0oarT+YImqG5t5+k6n9sTz6E6BnXjQe7YjGcevET2A3fAnnq97Otuk+yg4eXq
         bKRh0TgZnxa0pfbGn/2Yy6Hem+Xe77agN2gsSHbzhhnbDK2CT/re71Vi63Y0KTi7+yFq
         7/J9+NKEmC26odGZHxGHyoyqyuymW4GvlRsKeLZVWtk9MTlI/iwVMZoX7xG5kpGQARfo
         V64zND8q1xktTUVOobfUvE438vTnU9wM3O16JBJIlsXR07YqAY1eXoBBNxXN6kcNBeuT
         ZP/HqMv8WkSnRmzzjFYw1BuiivrkbQRMtf5h3NeY+7tFn/uETybHeEGXKs7BG7r066Hu
         cGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lDgFIgWb5I8vP3z7FSNZzOZFKs0yUKRogCHqJ+c1oHs=;
        b=uUOX1wXvQ9SIahzL7GIyash3qwQ/Q7TQxD/pEGnrRLS1qaPgK2q1N3pMxx/Lb1RjSZ
         b4Y65hmzshOGJM/97heFsswnWNBmYoNPmhHaI2VIpEqCfnHg+ZwfRfoqLqY7m2g0gQ8G
         iblZ/TRYARmXaVmQku1wKI1rbszfpTayRvGnMnlZ+/uB3HIS8uSeAs5l0MbwtIPiU/wJ
         mwcsOp/y9lJt3lAlOxNaxNyww/UGD9qnD/wmJkOWr2Mm9x8rdboAQCTMnnk6J/5OX2wx
         wBJYcUIPUo0TbtkjCzgGLuWf6LrTn/jDJ4ecV11sADwqYJx1Q468sHmXt6sV9xynbB1x
         SAQA==
X-Gm-Message-State: AMke39nkJlmBNT3GoFR559qP5KXj+x3K0GRBCx9Ptqz3oXMC5T/27gaOQAL90a5j3khd+A==
X-Received: by 10.99.124.10 with SMTP id x10mr4804084pgc.25.1487272983528;
        Thu, 16 Feb 2017 11:23:03 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id n28sm15282360pgd.5.2017.02.16.11.23.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 11:23:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     David Pursehouse <david.pursehouse@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        David Pursehouse <dpursehouse@collab.net>
Subject: Re: [PATCH 1/1] config.txt: Fix formatting of submodule.alternateErrorStrategy section
References: <20170216050535.64593-1-david.pursehouse@gmail.com>
        <20170216050535.64593-2-david.pursehouse@gmail.com>
        <CAGZ79kaPFP3aQB8=gZ+BvRUqJa+NPuDQ+5kvKNqqYs3S28EEew@mail.gmail.com>
Date:   Thu, 16 Feb 2017 11:23:01 -0800
In-Reply-To: <CAGZ79kaPFP3aQB8=gZ+BvRUqJa+NPuDQ+5kvKNqqYs3S28EEew@mail.gmail.com>
        (Stefan Beller's message of "Thu, 16 Feb 2017 10:41:30 -0800")
Message-ID: <xmqqzihmvt2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 15, 2017 at 9:05 PM, David Pursehouse
> <david.pursehouse@gmail.com> wrote:
>> From: David Pursehouse <dpursehouse@collab.net>
>>
>> Add missing `::` after the title.
>>
>> Signed-off-by: David Pursehouse <dpursehouse@collab.net>
>
> Thanks!
> Stefan

Thanks, both.
