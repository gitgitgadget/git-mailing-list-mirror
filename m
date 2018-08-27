Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2409F1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 17:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeH0VTn (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 17:19:43 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:38523 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0VTn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 17:19:43 -0400
Received: by mail-lf1-f54.google.com with SMTP id i7-v6so12617647lfh.5
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CtNP7C6ZmxEfwmrtNC0dK883O0SypAqGZw5zljFW6C0=;
        b=IQqhUXuYPj74194GqyMuLgr2odj7OzeTnpV7bM0UNqT/GIpgb/auFGt3WunDKHfkSD
         TKGKu86wNbfMO8DzjzMzt789t007XhC3bLIgjRwD6/zBbVFGiT2ENndygSHHwGNdS3M4
         OQUhUCx0NToZlg70+Az0JK0Evu8s+TJ4uJ7WasyUBsPFw0j9YWMLYp0HmB5p1PlqB/mI
         sc+JDJlSvX9Zz3TZzRlQ79BrVub2MsJgzBwlW4XUEyew2QAJIG+2r1u97QiVcX2hc3kV
         DSt4yguBl9zcaDt20M3bY7K8+fiDPASdJ84A/WwFlqsWo5EXorjW1yizaIUTzpWQK+p1
         +5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CtNP7C6ZmxEfwmrtNC0dK883O0SypAqGZw5zljFW6C0=;
        b=Yc9Mg8elqLaaV3AvqpbJZ0ZJ1MnY1+e82jhLeJKAOAioS2hb6WIMKBBdSXEVMtrPcc
         mZIssBItWyj8rM8Ibx20kQ3ZRHOFq97osJfTVTBO1ZZxhclgLOvFC1LBmGARtLGviV+0
         XM7Bk8QPw4Xqq/lU6zNIInXYm545s+XaF58UgmoZo0RGjaPiMpEjsmaXMguKGXbZfnhq
         glPww15Ak1VjRvlA4rSrpeQoHuk9gsjgU7ftUJGjTZn8H7AXbnNERsIc+g41MCVTPPPc
         hwlbKCpnqNwFvCJlURbq8GkuxfriBuBeMZQ0e1WtFEta3F6gk2tJ+mOWqcGXo4xPpbKt
         3x2g==
X-Gm-Message-State: APzg51A4qIOwLvV43tGLX0Y4FYxnDmtYOX2R6hMKJV2I2CmXJ4btL+qM
        WWK6/q5O/wuEhiPIDkYBfGPMU4iX9y/B2Q==
X-Google-Smtp-Source: ANB0VdaJOPj0aKwIADMgk3X+2NBNTea+UyToH6FgSSgoYqT+X6oEvFn8M+9by2uu2lIe4MJgIyYJlg==
X-Received: by 2002:a19:a201:: with SMTP id l1-v6mr8698188lfe.129.1535391130446;
        Mon, 27 Aug 2018 10:32:10 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id m8-v6sm2980036lfh.25.2018.08.27.10.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 10:32:09 -0700 (PDT)
Subject: Re: Automatic core.autocrlf?
To:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180827153524.GA18025@tor.lan>
 <CACsJy8Bik2Hokgv46ifsFhhvGzdcB=FoWnWs6_k2361s15wOPA@mail.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <94afe154-53e1-761a-4a66-4f77188036f7@gmail.com>
Date:   Mon, 27 Aug 2018 19:32:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8Bik2Hokgv46ifsFhhvGzdcB=FoWnWs6_k2361s15wOPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-27 17:52, Duy Nguyen wrote:
> On Mon, Aug 27, 2018 at 5:37 PM Torsten Bögershausen <tboegi@web.de> wrote:
>>> In those cases, when it falls back to
>>> configuration for line ending management, I want it to be
>>> automatically configured based on the host platform.
>>
> 
> An alternative is supporting conditional config includes based on
> platform or host name, but I don't know if there are more use cases
> like this to justify it.
> 

How about just using unconditional includes?

global.gitconfig (synced across machines):

  [include]
      path = platform-specific.gitconfig

And two version of file named "platform-specific.gitconfig", which
are not synced, and include only code.autocrlf setting.

--
Best regards, Andrei R.
