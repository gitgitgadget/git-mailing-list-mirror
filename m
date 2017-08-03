Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E18C1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbdHCUXN (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:23:13 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35873 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdHCUXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:23:12 -0400
Received: by mail-lf0-f45.google.com with SMTP id o85so10716085lff.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GXUMqoROBxU/rT2rvi1x5qE7CWyF7VPzex10Z7fxpqc=;
        b=p8rysepmgSZGTcDIXWCajH0tdSfSizrvFh79aLIUyFpQsItTqiTft3soyyr2+WJFyz
         e5opcG8FOPG83FYmA0fohILgLfyWGsBiGZQP1XpUq0umjseUW2vOvozaerD8xF0WqVBI
         Lu6cbqLbIz9xXP0aQgJ8m06XNADs6ONw2fvybiGe7Y0m0q4mTIipqu9tgX3S1ayXv7Bs
         OKjVD5cy/sJE/+yVV7ERvJnySsJ7DWhV9A95roi1t8OI2+cFjC0O0v6sURvydhgngJfx
         fk1wPNIZREkX7lw0gFy7cLHNrw4zJstsoxt7DXPD2rMD4DZYjafuFCuPZnQC7tS/VXaL
         GlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GXUMqoROBxU/rT2rvi1x5qE7CWyF7VPzex10Z7fxpqc=;
        b=WsuDSfzaqhX0nEhRdgK10U8q0xAlN8Qh/C6fTVP5jXswXpNnPBRXcIG66ijuW9ma80
         /U4pPzyxijeqSBmZowqa/3tVeinj7Jqwu5N1jWDWXF52Ly37lzVFZFCpCl75EgScSSsy
         OXYdh1doUZyHW1yy6x+vXYjnjB2yXh90H9zjPtMLh8tK+yC+9iE4jLKrM2S+KJnpzo5F
         sG4b+GHwDYjDO2aZE0C/pXhxnViS49kOC6MrZA0wEUPmqshqRWNg1V8KtxJFdzDIanDG
         7jjSvhvmkhB23btONCJqO4v+Ulpmmas4+OqLUPTEr1laB0vSW489c57GAodwajMp9+Ct
         iyXA==
X-Gm-Message-State: AIVw1129GCpfIzIdKNN7CjBaGpdnJXW+qZxTm3y8okKgfOyX0fKShYre
        odm5SLxddBUz0Xmnpf1+MpvQyTGG3kbRVBU=
X-Received: by 10.46.5.80 with SMTP id 77mr8350ljf.91.1501791791048; Thu, 03
 Aug 2017 13:23:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 3 Aug 2017 13:23:09 -0700 (PDT)
In-Reply-To: <CALiud+nKTNsr_z528Wwv3ELLk+uKoJkYa8hctg-C1dtXrbkvKg@mail.gmail.com>
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com> <CALiud+nKTNsr_z528Wwv3ELLk+uKoJkYa8hctg-C1dtXrbkvKg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 Aug 2017 13:23:09 -0700
Message-ID: <CAGZ79kbQcWAT=MkVHK2T+n=jUGmShcnN52137TmcKjm1B4UwOQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 1:17 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
>>
>> * sd/branch-copy (2017-06-18) 3 commits
>>   (merged to 'next' on 2017-07-18 at 5e3b9357ea)
>>  + branch: add a --copy (-c) option to go with --move (-m)
>>  + branch: add test for -m renaming multiple config sections
>>  + config: create a function to format section headers
>>
>>  "git branch" learned "-c/-C" to create and switch to a new branch
>>  by copying an existing one.
>>
>>  Will cook in 'next'.
>
> Junio, are we still waiting for interaction with other patches to
> settle down or simply cooking it further for any potential
> feedback/suggestions on this?

I think anything currently cooking in next is waiting for the next
release to happen, and then progress to master IIUC eventually
unless noted otherwise.
