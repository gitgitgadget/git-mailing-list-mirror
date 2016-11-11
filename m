Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F81B2021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965998AbcKKJNs (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:13:48 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34024 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965090AbcKKJNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:13:46 -0500
Received: by mail-yw0-f180.google.com with SMTP id t125so6269437ywc.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ysz2s0ihi/BhbHfSs6sVVASkVl8qu04UfXXeNXXOr9U=;
        b=jCXErumLzHjMKxYOZmY6rApk4zxoCp4e2nXde+zhu8LV7g1x2P/r8wkk9bvoXlfFmd
         ZeAXVggb8irW8ygOBscCfWJZRVX+1HgtDOYNC5fIZZ9Jcotiu6v8Kd/sjyYkllD4cKdN
         saIzfrdEdlfSLxSMVbLwaXeaQGm5oWqCYuQ/+geSjm/9d2zpfpqGb6p3exAHRPOb4KjP
         SmwNpC2CzoMJaph5EOUv5s48qvmrG+8hRUGdxA5YjHcIYsMlrpKwrbTQSdszFjJ5VWdC
         mkL4VIU18st12CuFR0p4gvVB8sgiv5vS3H7dW7VZ/whmuVnY6M7svBAGEUEiK4CBMCtT
         GUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ysz2s0ihi/BhbHfSs6sVVASkVl8qu04UfXXeNXXOr9U=;
        b=QAdTJyJ5eU1/8ls0qfcl9YoWViv7UFMUbtbAMQ/U1EmnRkY392gM2DkR1AnhvVWUNe
         n57R+jDKs8ca96qJoGy1O0W0mVpYK/zPTq7BWImu0Tmv+rk/5Ts3UMZViSz57+bt4LmT
         TdLKxhXVXl9LyUYjYQacBNuWdKgUNc7nxVJMH2FMIcLNarQRqJ2EM+6MpYTGdx+zniGf
         /ihpgQDZBW730V+ld+rwNb4xj5cpupbtE79tCB1AzYXJs0PwVH3H4fXP9d12Qh/oQqJY
         hxPy0KD/XeW6t6zekgfsPPAU0DGCIXsriVSasosto3jbXm+j10XJGCXe9oMN/OB9jWfm
         q+xw==
X-Gm-Message-State: ABUngvfSBaNbQS4ScOsenrxe8dVEWZSugS7PmfXiG7gtsCZnf9L9/X9fop4FkGkWt6QYVSoHg+aaNmugS5ZWZw==
X-Received: by 10.129.78.84 with SMTP id c81mr1638340ywb.346.1478855625208;
 Fri, 11 Nov 2016 01:13:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Fri, 11 Nov 2016 01:13:14 -0800 (PST)
In-Reply-To: <xmqqshqy53cj.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-2-Karthik.188@gmail.com>
 <CA+P7+xoAmYqi0OazZux+rooXW+D_N9L5s+2BzUyJJJXtmLZX-Q@mail.gmail.com>
 <CAOLa=ZS_V5SNSbiC_sT6E9rJMbxCMm=BRaoPL44xBNXAG2pgbA@mail.gmail.com> <xmqqshqy53cj.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Fri, 11 Nov 2016 14:43:14 +0530
Message-ID: <CAOLa=ZQ_Z+AJBf-=i3hW9M2ng5+HfR5AbdWGJp+_z5xthoqdXA@mail.gmail.com>
Subject: Re: [PATCH v7 01/17] ref-filter: implement %(if), %(then), and
 %(else) atoms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 4:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> Minor nit. I'm not sure what standard we use here at Git, but
>>> traditionally, I prefer to see { } blocks on all sections even if only
>>> one of them needs it. (That is, only drop the braces when every
>>> section is one line.) It also looks weird with a comment since it
>>> appears as multiple lines to the reader. I think the braces improve
>>> readability.
>>>
>>> I don't know whether that's Git's code base standard or not, however.
>>> It's not really worth a re-roll unless something else would need to
>>> change.
>>>
>> I believe this is the syntax followed in Git, xdiff/xmerge.c:173 and so on.
>
> That is a bad example for two reasons, if you mean this part:
>
>         if ((size = file->recs[i]->size) &&
>                         file->recs[i]->ptr[size - 1] == '\n')
>                 /* Last line; ends in LF; Is it CR/LF? */
>                 return size > 1 &&
>                         file->recs[i]->ptr[size - 2] == '\r';
> *       if (!i)
>                 /* The only line has no eol */
>                 return -1;
>         /* Determine eol from second-to-last line */
>
>
> What Jacob prefers is this:
>
> ---------------------------------------------
>         if (cond)
>                 simple;
>         else if (cond)
>                 simple;
>         else
>                 simple;
> ---------------------------------------------
>         if (cond) {
>                 simple;
>         } else if (cond) {
>                 no;
>                 longer;
>                 simple;
>         } else {
>                 simple;
>         }
> ---------------------------------------------
>
> That is, as long as all arms of if/else if/.../else cascade is
> simple, {} is used nowhere in the cascade, but once even one of them
> requires {} then all others gain {}.

I see, I mistook Jacob then.

I was talking about if we need to use {} whenever there's only a
single line of code
but followed by a comment which extends the if/else if/.../else block.

-- 
Regards,
Karthik Nayak
