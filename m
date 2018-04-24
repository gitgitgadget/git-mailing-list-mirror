Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794161F42D
	for <e@80x24.org>; Tue, 24 Apr 2018 18:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeDXSFb (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:05:31 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:46645 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeDXSF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:05:28 -0400
Received: by mail-yb0-f176.google.com with SMTP id z16-v6so7064613ybk.13
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=St/ltfVzqyK9Kq5VtF9JbB/s0am2FNrNhsVBa8t2T/Y=;
        b=r5fewDfdxR6XmwjGV7wG5kR21AnZlmgm2X3RiBeqAC8QMoo/5ySgDTkbpRmrMMvjs5
         Dk11uS3+flYWa59xIqDw5z8nDEN48lQ5YOgqrUkoZXTXCNIc1yLRJ9+4aX6DS9OG1M/R
         PIn7KR0I6GcAvhWS3syS5omWE9vJ4DW2XJ6+ObXo3x5DS+JugQ5dn4C1zSjGvZZCR5Mo
         AW7DTrD/jXNkXF5uBvJMD2d6MvpOAvizs6ncdQHufhzGFmqGLkQN/tA2HJJHUDIrIi76
         tf+ZbNRbHEfz9WO3dhiqTQtccQOw5esS3cYAcG1zZpfKiH5hsoImKQEzulVMY6eUqQfv
         kHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=St/ltfVzqyK9Kq5VtF9JbB/s0am2FNrNhsVBa8t2T/Y=;
        b=bJYIqzqigLhMA3QYq3l0bkOvSBg7xCgwhdY6IWJwZKlK4a9zf/Lacy6WUeovqO0qyg
         qDveG4wb9bWRDYRNRpZoBaoPVIga5KnQ2nWIHZHmTLQV6lX0mLsDTFOvM/bUsNLaqG8k
         /yEXgIh1xAmMaImpBRHewz6hfmd8iNL7LFhUyrbk9ksVNwmAtUonTKpIwO5wqH15Be2w
         gf4yvSRW5ZKxigsXe9QpoblTnXdI3ct+7We2si8A0EqjChCNCm9/TdaNq/iXFZiJqyt8
         SIpoR6dEp++t1/1G67XMhy0fs7hF1PVHuMJkaJ3VcpJCAb4tLxZKb6+ehkJB4sLIP2LM
         BF0w==
X-Gm-Message-State: ALQs6tD5KRQNobpgdDZMB0Li3huwugT0tiBu9/Sp45RhHmNoOIgKjn7l
        DWitexLvS6lSo+MHvVy/3sCW5/GkcqFZ6cUWRZuMuA==
X-Google-Smtp-Source: AIpwx48rLe2jaXXrM/9RP34yrLiQfz6GQh7T2ikvXKygUOu8hX+4BqYHzsV0eYobTYnnU8xEbfyozJJh8eQ+gQYyqmE=
X-Received: by 2002:a0d:d0c7:: with SMTP id s190-v6mr13274822ywd.33.1524593127757;
 Tue, 24 Apr 2018 11:05:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 11:05:27
 -0700 (PDT)
In-Reply-To: <xmqqmuxt73tu.fsf@gitster-ct.c.googlers.com>
References: <20180424000900.175235-1-sbeller@google.com> <xmqqmuxt73tu.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Apr 2018 11:05:27 -0700
Message-ID: <CAGZ79kZ5UuoAGN4dmzE21abyGR9pzkoaQn6BEfgSFDg+N-xT+w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Colorful blame output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 7:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This is a revamp of
>> https://public-inbox.org/git/20180416220955.46163-1-sbeller@google.com/
>>
>> Junio had some issue with that version, as it would collide config and command
>> line options. This is fixed now by introducing another option.
>
> Heh, that sounds as if the series was rerolled unnecessarily, only
> because I had unreasonable complaints.

Sorry for that wording, the complaints were of educational nature, so
I rerolled it.

> I was hoping that issues the
> series had were fixed, and my involvement was merely that I happened
> to be the one who pointed out first.

There were multiple issues (many fixed already), but there was one
outstanding design bug, so I had to reroll.

>
> In any case, will replace and take a look at it.  Thanks.

Thanks for looking at it,
Stefan
