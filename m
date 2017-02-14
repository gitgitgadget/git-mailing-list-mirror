Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A122A2013B
	for <e@80x24.org>; Tue, 14 Feb 2017 03:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdBNDzy (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 22:55:54 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36383 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdBNDzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 22:55:52 -0500
Received: by mail-qt0-f195.google.com with SMTP id h53so15943135qth.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 19:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E1iqa1OdSNP9ia6Hq0BJWAwtbPtJIKAE0/8tRcPLNmM=;
        b=hg+lG493DhyqKJMkoSgha4u9uRHyJSJdYklBNSrQQvUwjAzk6eaS6x+tD6sK8l9BFx
         CnIkag7I8ROkr4u8zLVlSv+gMKng/YZ8Iw967MJw16mCE1CozE0dwex3qtJULAsAHQO3
         v+3QxOYjBfrJtfg+jZwiguqJxL6p5Te7spsZIhCRpejrX4Zlue5zA0fHBVgj28vcPQIL
         SUo+LZDVVY5ZzhmfTIp5qKlwu/k1Wb4vxvEEn0QL0a512sSCz2ZJIVmASCWTlm5bNtgm
         j61U2tiM7CiDu8rpRv/kQrfC/3tZUdLDfJbnvm7MHV+8jXYpDv1fx5aPaWOdDhN90zG1
         9Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E1iqa1OdSNP9ia6Hq0BJWAwtbPtJIKAE0/8tRcPLNmM=;
        b=Qg8qRoERL7N4g80zV8iU7ZTv/3aMcxHCxkD2TUVUTmNEA+61IrrNUiMvMIdw7MRiWl
         j2dbly3za4Jl53pvcSlQvf4wHW46XmsnYtGhletM5UHUZQVwT7+BjZT7dBD6a3t6ENwz
         Ila88xn1ygsZvhfotPADh0hzQ3eETDCLEJuwOV9YyiVCbbZmpnSB962bpMH/NRGofiEC
         /Z3AFZyOUJ9V9T9kgv+uimrh9WZBTpaDTRjVoBS3XzKi069jWxCRLpIDV4ggiftZmBcb
         SY5SJvEwxGLQIFF6TJROEELz0H+bpgZpw/wQrP7dzV6d90lw+/Jp/ltD9qjnrI6nau2v
         Gl5Q==
X-Gm-Message-State: AMke39mFKBM+THcubIFDG0ouTxveT7r3O8UbeHkYrrjJugo7heCc1sDl3fcQw3duqRa2Ig==
X-Received: by 10.237.60.218 with SMTP id e26mr24081559qtf.271.1487044551834;
        Mon, 13 Feb 2017 19:55:51 -0800 (PST)
Received: from localhost.localdomain (c-24-131-5-126.hsd1.va.comcast.net. [24.131.5.126])
        by smtp.gmail.com with ESMTPSA id c83sm8837465qkg.8.2017.02.13.19.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 19:55:50 -0800 (PST)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Junio C Hamano <gitster@pobox.com>,
        Arif Khokar <arif.i.khokar@gmail.com>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <alpine.DEB.2.20.1702101707060.3496@virtualbox>
 <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
 <xmqqefz1ew1h.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
From:   Arif Khokar <arif.i.khokar@gmail.com>
Message-ID: <acac96da-2404-4f7e-a83d-7648ca448d31@hotmail.com>
Date:   Mon, 13 Feb 2017 22:55:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqefz1ew1h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13/2017 02:21 PM, Junio C Hamano wrote:
> Arif Khokar <arif.i.khokar@gmail.com> writes:
>
>> ... I
>> still think it would be better to be able to list the message-id
>> values in the header or body of the cover letter message of a patch
>> series (preferably the former) in order to facilitate downloading the
>> patches via NNTP from gmane or public-inbox.org.
>
> You are looking at builtin/log.c::make_cover_letter()?  Patches
> welcome, but I think you'd need a bit of preparatory refactoring
> to allow gen_message_id() be called for all messages _before_ this
> function is called, as currently we generate them as we emit each
> patch.

Thank you for the advice; I'll look into it.

One concern I have regarding this idea is whether or not SMTP servers 
typically replace a Message-Id header set by the client.  If that's the 
case, then this approach may unexpectedly fail for some people depending 
on what email provider they use (if they don't maintain their own MTA 
setup).

>> Alternatively, or perhaps in addition to the list of message-ids, a
>> list of URLs to public-inbox.org or gmane messages could also be
>> provided for those who prefer to download patches via HTTP.
>
> Many people around here do not want to repeat the mistake of relying
> too much on one provider.  Listing Message-IDs may be a good idea,
> listing URLs that are tied to one provider is less so.

I agree.  I've actually thought that it would be useful to mirror a 
read-only copy of the mailing list on a public newsgroup that could be 
accessed through a free provider such as eternal-september.org or the 
Google groups interface.  It certainly would reduce the potential losing 
easy access to the archives of this email list if gmane and 
public-inbox.org fail.  But I suspect doing something like that would 
potentially increase the spam volume substantially for regular 
participants/contributors.
