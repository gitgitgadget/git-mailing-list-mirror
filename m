Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE131F4C1
	for <e@80x24.org>; Thu, 24 Oct 2019 10:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393193AbfJXKEp (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 06:04:45 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52132 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733186AbfJXKEp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 06:04:45 -0400
Received: by mail-wm1-f47.google.com with SMTP id q70so2121055wme.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ugXqN6xeLlsopTNZg0vUAAy+pCgtqMSUWQMR17YJvRs=;
        b=tuVi0pfBDJq23pKdsk8eIzwCgJwn2UfUy7TJiFLCTEMpyhEncZXvoo3HV+Y97fFoWw
         /zY2tW6x0PjC+YhY1EYBE8qiRnIn85I6l+vvHs4T4sHYqS6CY21MjPexLtlOJKHyE63o
         kp/7g3WCArBmusHVYT5oHjA9Uen6xeQO4qnz3W36pjffz2jnJDudv4ZDZ9GgLWvPXhVV
         npL+3bru12FHeugo2oVq7xTthC2wpFJu1Z73rVsrIvrThyHgodzfsPE7ER4s3cGdFI7t
         6b6g8Kco9LLfIUu7tQJ6R7cTdl5ze7Y5GEbySb93hHKqkFy1myc4B3soswAEsB1NzDs+
         Cq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ugXqN6xeLlsopTNZg0vUAAy+pCgtqMSUWQMR17YJvRs=;
        b=hWL9cLctX6mjchLF3nY+7HeZfSIHWOz89644SuSJqHU2OE1aaNWA17LYauoRDur7nW
         +d8wxlEktVq+3McRJmII6dpmZyygve+EUc8DNfbJs0KToWO1r6cqKgFptPNG9Ri1F/d9
         B6slIXSlVY1HR/leJ+O59VUPH3J/pdZKw3+g5fR+veS/S5bKvDqKQlU5sCBoKhy6qEh8
         mvb58uZGVG+dyVXtxDEjeGhedETUfJS2tBpDw6opEucSCDKul788V3hS7XJE7n1xcPub
         Rn+Epet93EmO5IY53hbNQ9Z6avnu7fmVr/kbWBhfuAzWRAXNVWiEUHeLYXOAQydqubfQ
         MPIQ==
X-Gm-Message-State: APjAAAUE52D+4zNUq2AiJFdwT2sIuZB39DMSnHLNXJ1yXtLaJaORicPI
        JvrjKUJGAhMqog2OmfVhKZk=
X-Google-Smtp-Source: APXvYqwIY+QnyRGCR+xZwHvWsKUQniR3WU7GlOLyG65ku8iG1FY+eRzJBZSAEJ6QCTHl8QiQT96G/w==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr4101822wmi.121.1571911483157;
        Thu, 24 Oct 2019 03:04:43 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.googlemail.com with ESMTPSA id w18sm7221636wrl.75.2019.10.24.03.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 03:04:42 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2019, #05; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <xmqqblue5zxc.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <99072e19-c732-15d1-f4a3-50cc02c9e21a@gmail.com>
Date:   Thu, 24 Oct 2019 11:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqblue5zxc.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/10/2019 07:29, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> * ra/rebase-i-more-options (2019-09-09) 6 commits
>  - rebase: add --reset-author-date
>  - rebase -i: support --ignore-date
>  - sequencer: rename amend_author to author_to_rename
>  - rebase -i: support --committer-date-is-author-date
>  - sequencer: allow callers of read_author_script() to ignore fields
>  - rebase -i: add --ignore-whitespace flag
> 
>  "git rebase -i" learned a few options that are known by "git
>  rebase" proper.
> 
>  Needs to consider existing GIT_COMMITTER_DATE environment, etc.
>  cf. <5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com>

The test coverage is also lacking cf.
<ed8e65a2-72e8-210c-d4a4-eacdb5c7b0e8@gmail.com>

Best Wishes

Phillip
