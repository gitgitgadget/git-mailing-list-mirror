Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369C71F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbeGWWkM (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:40:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46085 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGWWkM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:40:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so2065921wrw.13
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f0JmJa676VGif3Z5+ggqnbptp8M+mLY8OhRaCY+0Vp4=;
        b=PZ9KXwmHgrI0RFKWkoXkAF/X8CWjiV/bpRfh/Tvawfjr7VLlHCTfSjyzlJT5owiIme
         XwkIxnsUNFsqdoo4VVr32L+zz12pWR8tSc6G4u466WBfHq6mjtWdJmsRkRV5U0w4bniJ
         sx4x9TjX35iS6KUs7Dyqhc/7NA3DPaTYfV5eLLuTsoAowlWG1y+h7gG8qOsemQfRyGNd
         c2eA6ANLUnCTWLLVPmGNtxZQ9A4dFMFwZbsgYzgVD6hzSsE54qGUgsbLko6Saq9rEjqm
         Sl/TnruYPk/AvY/SS7qak2LMUwuYAowRTmDWnk/Izlm6lUvxHX5GJdy7d4CIvH8LsW5n
         VTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f0JmJa676VGif3Z5+ggqnbptp8M+mLY8OhRaCY+0Vp4=;
        b=P02z27e6lE/QvUmNhUd4f8YQTQpU03Mq6hSOS+girJim5ILETK5vxxdY6iD0Tt2bi+
         5ldfhNHFW+J55/LKZ5mbr0wML6IozsaRhnsukS66AnjWWOo2+lnOhE7wkVNxIrn5+HZw
         uDsQ9a+lkEvAJJOWU5jtKjgNhXEtz03iACk+X0x80HQ/mAjniEl3KJrReXHqwwJzNl3R
         QuHfQ09vQ9BKdpv0yTkFqaxYm2cAFQUOULdw32pIXUCA/f0lot8cSgSOEpu2h6ohOS+o
         iYhtwJEsQC1eSnZCmXBXFe229V8JghktScaL1B7V67GFLZMKSchmV57Yx7G32AZ0+y+a
         Mhyg==
X-Gm-Message-State: AOUpUlENPsECLgadoT0GkPD4oLeHgrsft1xjzIWdQcfTj4QyIizMOlON
        EJeZyrT/3x+aF1WyLkV+3TU=
X-Google-Smtp-Source: AAOMgpdypFRZ8ImVqeE73phwvuiC087r4ZafM4QH2Lw6wibS0UhlYgBI2yCWFtgMOdU5vbs/ea/c+A==
X-Received: by 2002:adf:fb92:: with SMTP id a18-v6mr9292449wrr.278.1532381822027;
        Mon, 23 Jul 2018 14:37:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b11-v6sm14128072wrv.82.2018.07.23.14.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:37:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/9] contrib: add a script to initialize VS Code configuration
References: <pull.2.git.gitgitgadget@gmail.com>
        <e2e449a00385531d326d6811a871dde59624b818.1532353966.git.gitgitgadget@gmail.com>
        <xmqq1sbt68ec.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 23 Jul 2018 14:37:01 -0700
In-Reply-To: <xmqq1sbt68ec.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 23 Jul 2018 12:48:11 -0700")
Message-ID: <xmqqd0vd4osi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
>> new file mode 100755
>> index 000000000..3cc93243f
>> --- /dev/null
>> +++ b/contrib/vscode/init.sh
>> @@ -0,0 +1,165 @@
>> +#!/bin/sh
>
> This is caued by our usual "git apply --whitespace=warn" as it

"caught"; sorry for a typo.
