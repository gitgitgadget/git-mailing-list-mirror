Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47D3208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 15:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbeHGRjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 13:39:53 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40884 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGRjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 13:39:53 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so14306605iob.7
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4A+24kp8WqeSf1Zg8T3OqVkOQ79U5CEvs/rHI8ngoxc=;
        b=fbict1O7n7YHNhAt5n2NuXIJtrSvcIM7MS2tc/91DpJN/vR1Uj2HJWihckqj8qtcGX
         YcYwQ9tvxabGv+dMetY7h8MMfkg/ILkeWo3QKU9e+KkCO51RoRjKnpJpc1L+qECkFOqa
         YT68HE9P82UXBlJbwsJlIlbaggGRMR2d2qTZAhuXtyNrilQc+wg4G7gFITd+P22hRpzw
         3Q3YIulbuOhYDEGDAdO3OFn3bGjHv52WqI8VdcE+599xXiRmQGIPmZuRni0gery2N6YH
         S0cGgK8P37Kbebgn/frZPPTdHYsNYrTSaZ3d+IeCzWHqIopiM3lqGtj4rdU43HGjxKU5
         a3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4A+24kp8WqeSf1Zg8T3OqVkOQ79U5CEvs/rHI8ngoxc=;
        b=DC2t1A6j+pLINi5CW+szCP3D+mfw49lrgpmnS1sPyCubs+fvG5YGj2F0uO6hK6feI0
         R2Uur0cHANMPQnEBgmVEwV59DvzKxCCSaRyt9xlnFh5cbI9CiQ9sUsmi1jVdM+HmMgJs
         HJLfi02f1RnsmLOCpNi2SVy25qE9Jmud8J4bdfRRFIoECSDF8KJYZHYcOvcjzI63JERW
         2Wf0aZPWOs+mc7c+sbrA1WhPFqfIMcMqPR3Ku6d2c5ZAnSv0aJybfvIWbm9BmRYFi5Cd
         pAxIKkzcfkkfHsixbRCW8f7gP8vzkvGpWR8/HICq0yQapJuePWXjNUXojow3IDqn/DMg
         3uew==
X-Gm-Message-State: AOUpUlGkjTM9zDeq1X0KeKdcT7HcWnBBWCBylgDHRuaXNvLuKgrYCpvR
        +XAi9hWqJ97rmmOQHlx3in9jGDCwRBEIbWJKk2I=
X-Google-Smtp-Source: AA+uWPwkVEVjx2lA4Ng2ydVTOgwtkjZNz0yVKaCXWwoNvWw1zrVtlQzy6qVjNi2liKb4Kkh+4LXwwcrGZRLiU/5ThgA=
X-Received: by 2002:a5e:960b:: with SMTP id a11-v6mr18707670ioq.53.1533655503482;
 Tue, 07 Aug 2018 08:25:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 08:25:02 -0700 (PDT)
In-Reply-To: <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
References: <20180724163221.15201-1-alban.gruin@gmail.com> <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-3-alban.gruin@gmail.com> <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 7 Aug 2018 17:25:02 +0200
Message-ID: <CAP8UFD3KbDrvU3zj24F7FF9ui2X75Vih4CoYE=cCZEWMsKP9Fw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 02/20] rebase -i: rewrite append_todo_help() in C
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, Aug 7, 2018 at 3:57 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> On 31/07/18 18:59, Alban Gruin wrote:
>>
>> +
>> +     ret = fputs(buf.buf, todo);
>
> It is not worth changing the patch just for this but strbuf_write()
> might be clearer (you use it in a later patch)
>
>> +     if (ret < 0)
>> +             error_errno(_("could not append help text to '%s'"), rebase_path_todo());
>> +
>> +     fclose(todo);
>
> You should definitely check the return value and return an error if
> appropriate as fputs() might not actually write any data until you try
> and close the file.

I agree about checking the return value from fputs(), but it seems to
me that we don't usually check the value of fclose().

Thanks,
Christian.
