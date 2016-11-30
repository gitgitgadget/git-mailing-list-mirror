Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2885F1FC96
	for <e@80x24.org>; Wed, 30 Nov 2016 00:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755044AbcK3AJl (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 19:09:41 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34151 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbcK3AJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 19:09:40 -0500
Received: by mail-yw0-f195.google.com with SMTP id a10so13483429ywa.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 16:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2+XsnzCHC/tdp+AlNEdDEq5qmBD63I2sqGnaaLqNGVI=;
        b=l3Y/pNkXqvQforOJ3fHvJYXVWWl1O6/0FbYykXk2bwNa/jWfMwC3lJvgaNKOKNUAKM
         0s91oqXdaPMF+F7JNxRtbQ/ZMn7OrX2zoCSDqNtXZKBvCD4zpMIGoelN0M+fFMT4Etge
         dn87eqGlcEf9gpKqWAZVlDpn5Ys5gA1gpQx7SLTOaxyqn8jKlyONDluDJbWXFSeXahH9
         NNsfQV+HtrGqQBDGasv4lGO6D+Ijtd6W4gpTALm82WiEfXSHRuIAOeXzQRJQOig8a57g
         mzqhkD+AroC3yLmTtMTZd5TAXqULWW5+3xnfpPj4pdCxpyjads1X1N19Tv451rOoO0rc
         mREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2+XsnzCHC/tdp+AlNEdDEq5qmBD63I2sqGnaaLqNGVI=;
        b=axRLjCiWOQ9OMNfSbk0bOUcwpqf19vmrnJYhy+Cc/9g0LjohjcXVfalRQ9QjU0V7fs
         DdI/5bj+8CAQDQqcYYJTMtI+gByv7sOTLJTSVAGMSjteXWTLUOYdHxrMkfD94TCP1N+s
         3kptyBbh0UE5ScpvSEXadMwag6lL7nFYoEoT8L93ojNRXcj36XxPJ0WlKIQO/Uy3mU5W
         2rIiQOtsEYSEPr0mZXE1CcVf5Eu0T2gaGJGBBeM5QlzsK9Onf4T9T6KnmcIhbyvwOiLD
         vPqbUT7VjJWjK4gPWNh+M73nODUwE6MGUtIC6GNq4DjmB8OqEBz95XQa5rRxhTmK6El4
         TnEg==
X-Gm-Message-State: AKaTC02z1FUs8jg6jeX5HeUu3sIIE2BwbUsTL3gS8efmyok5c7nEwjR2XPEmjP01P8HfkBRjSHp3zKTbaUQSOw==
X-Received: by 10.13.226.13 with SMTP id l13mr37052615ywe.77.1480464579111;
 Tue, 29 Nov 2016 16:09:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.162.39 with HTTP; Tue, 29 Nov 2016 16:09:08 -0800 (PST)
In-Reply-To: <c73ec2ee-eed0-414c-63a1-a1bd5c864cef@kdbg.org>
References: <20161112022337.13317-1-pclouds@gmail.com> <20161128094319.16176-1-pclouds@gmail.com>
 <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com> <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DQDPzZGJXLpTVHVFUeupPpp5e=b9z4m7xceJWrxPfF3Q@mail.gmail.com>
 <20161129135646.GA19797@ash> <c73ec2ee-eed0-414c-63a1-a1bd5c864cef@kdbg.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 30 Nov 2016 07:09:08 +0700
Message-ID: <CACsJy8DNJw66n+h5uKtxGHibKJRFOQP5=V35gKo3bRarx2vDsA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] git worktree (re)move
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 4:14 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> diff --git a/copy.c b/copy.c
>> index 4de6a11..b232aec 100644
>> --- a/copy.c
>> +++ b/copy.c
>> @@ -65,3 +65,9 @@ int copy_file_with_time(const char *dst, const char
>> *src, int mode)
>>                 return copy_times(dst, src);
>>         return status;
>>  }
>> +
>> +int copy_dir_recursively(const char *dst, const char *src)
>> +{
>> +       errno = ENOSYS;
>> +       return -1;
>> +}
>
>
> An error message "cannot move directories across devices" or something would
> be preferable over "Function not implemented", of course. Or did you mean to
> set errno = EXDEV?

The exact message is not super important right now. Though I'm
thinking of adding move_directory() that is a wrapper of rename(). We
can die("cannot move directories across devices") then and hopefully
be able to move across devices at some point.
-- 
Duy
