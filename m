Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1CF1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 00:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeKBJJl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 05:09:41 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43781 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeKBJJl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 05:09:41 -0400
Received: by mail-wr1-f52.google.com with SMTP id t10-v6so198490wrn.10
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cPvrHIf49L8cOl8qAkyRVh8ZSreZ3OXpR44xDPDHD2k=;
        b=RvdA/7JIYWcxZwNdGbxK/e0MFsggRcnxXt5cui79l+ZvON0HEwmQXrl/axd6I7VtiT
         e0BqgPtDQtEfzyJeEYp9MMApmAPdkp/Al09q0RRwPpascEnB4hJiw7t5Ld/hD1jhLzXf
         nJC5Dnkm8Z/lLwBACpYp7fpuv7vj2eruo05aMVBbJVdK64pet98KaCsTfjCFkVtxBD4V
         dyDZBlNj7JTr78n6B84mO/he8VUQGYM1PJVirdSYaWAMVtU2d3RxuW7nVcWnoBkdEREL
         6fys8Il84soouj50f4QOTG455XesP4F6UvGGrTam7FKHL33hKQHv8hw5EwHvkegVs+Uj
         9d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cPvrHIf49L8cOl8qAkyRVh8ZSreZ3OXpR44xDPDHD2k=;
        b=qMUtd4BFPa91Ektq7uilOp1pK3LtDmTT+pgUYdFCWmB3R/7JyNlOmky8nz4XmXZy+H
         9AqCcYswOr23PdttcHG5fURsWyprMemmy+WY3C/AcXL/K/59zWtij9zyw5q4P9MeLfzP
         OqinC4mC5obWZChTS7g+OUkTzENXhDe3Valh0wF2DOcjlcARe2kML65oiH9zrB0TYGmx
         5j4tP92vRLPwxmkGmxPZwrvq+KmXGVbSTJzL/lsBksI5oC8u+UVmxu+RSvf804e8zm7o
         /26mFQRr2akCGCjfl3/SexcvPU8cj23Z1kibISVjsqJZyeIJKMV5Z4VpPkS4FnJNj+Pb
         G5rQ==
X-Gm-Message-State: AGRZ1gJlaxpRP2cifRv1UWJ+ubVhaDj9mB7orAAvtnISmns8CLlrUw7Z
        GMlpdlRrE22FyJVGZS6OUFo=
X-Google-Smtp-Source: AJdET5d4plhhtt+WHe1hVESUdITSGn6Vu4NTWrQdpSpXYEb7NbcqUHZ3pOFa77KBGWGV6vcNh9EN3Q==
X-Received: by 2002:a05:6000:12d0:: with SMTP id l16mr3681890wrx.27.1541117071008;
        Thu, 01 Nov 2018 17:04:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z18-v6sm19764932wrh.33.2018.11.01.17.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 17:04:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: master updated? (was Re: What's cooking in git.git (Nov 2018, #01; Thu, 1))
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
        <00d01524-a37f-4958-cb3d-7facaec82906@gmail.com>
Date:   Fri, 02 Nov 2018 09:04:29 +0900
In-Reply-To: <00d01524-a37f-4958-cb3d-7facaec82906@gmail.com> (Derrick
        Stolee's message of "Thu, 1 Nov 2018 12:07:03 -0400")
Message-ID: <xmqqr2g4s5te.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/1/2018 5:59 AM, Junio C Hamano wrote:
>> --------------------------------------------------
>> [Graduated to "master"]
>
> I see that several topics graduated, but it appears the master branch
> was not updated at https://github.com/gister/git. Was this
> intentional?

The "Nov #1" issue of "What's cooking" report lists various topics
including ah/doc-updates, ..., uk/merge- subtree-doc-update in the
"Graduated" section by mistake (probably due to crossing month
boundary); they already were listed in the previous "Oct #6" issue.

Hopefully we'll have the following topics graduate to 'master'
today, as part of the Eighth batch of the cycle.

    js/rebase-i-shortopt
    js/rebase-i-break
    js/rebase-autostash-fix
    cb/printf-empty-format
    jc/rebase-in-c-5-test-typofix
    pk/rebase-in-c-6-final
    js/rebase-in-c-5.5-work-with-rebase-i-in-c
    pk/rebase-in-c-5-test
    pk/rebase-in-c-4-opts
    pk/rebase-in-c-3-acts
    pk/rebase-in-c-2-basic
    ag/rebase-i-in-c
    pk/rebase-in-c

Thanks.
