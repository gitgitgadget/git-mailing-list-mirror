Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C191F424
	for <e@80x24.org>; Fri, 27 Apr 2018 18:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758322AbeD0Smq (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 14:42:46 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36823 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758012AbeD0Smp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 14:42:45 -0400
Received: by mail-wm0-f49.google.com with SMTP id n10so4525096wmc.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=go6ASQfo7Igxe6LYmBRdMz4DEp+nnw/lwilF3FVNV5I=;
        b=TognhANEeSqlpcWn1VOc241IWxwn5w8EGMYetc5Owl1U/Dx9UixaR0D1lB6sBfJVxx
         ddX70kYonW3Ze1Xq8oke7pD5dfc/9skVaOFdWA3YSelKjJXnqPn1NqiTiLn8TyT+PWmd
         i0DWJMhulsqC2bstPAeYS3GmxaE9HO5R1JlzasDlJ6wvptTbwM+ADUU/MyBNTwLOe0H3
         4wfzmbvSMkCYWzO9m+J/SkvhUf8oKigbQoNP/2RhSnLlRomsuQ/UKc0Co31dkZ/4EALE
         aA3Lfb9vw+5c1zZ5Jh5IQ98k0X7vFhTobSnnwUdvpzBoyFd7GrEhDAHq1f6fTwieC/OQ
         5/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=go6ASQfo7Igxe6LYmBRdMz4DEp+nnw/lwilF3FVNV5I=;
        b=XWWQmLkNE3FW2Jy+YtZwaThnZg6QTetEP4rSVKI8kWvYPZ+GLOtuhBk9LIJsgDO8Rc
         dRxAT/cHxuauCil340lBvgnslTQjCXUbSp3TW6usC5LwaiK4Sq4pBAUp2WFW/mteW8Pq
         noYVGdvISFXFyEZ8fAFSa07pL1MBMqQY7R0L19LU1ONUc3cmSyz4kQWGfisQzXA5Obzw
         ZB1gUhsmSxcrzihEzIrzGlNkUvqXK1vQi4fG8xNr/Lcd/kLwb5iQfQBMIHenEM309z1k
         SY9Kb2dIBRcbuUH/e6kyugrDJQoD51JVazltmIl6tDpDRTt+D4rm+UDRJF3urxTD1dJz
         RjUw==
X-Gm-Message-State: ALQs6tDxkkJnaVV9Tevwyup6KnQiIUJQXlEe1rgNpeMxLzUYf5e9iuWP
        XNI/wJSaTaH0GNAk5Bb0Y3U=
X-Google-Smtp-Source: AB8JxZoBWnFixja2LD3f5t48u8ffgYt56I7wzKe9LRJDduqwqCVXMv4jyN333i3ZYSLMdLKQKtjFiA==
X-Received: by 10.28.45.147 with SMTP id t141mr2246147wmt.94.1524854564014;
        Fri, 27 Apr 2018 11:42:44 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:b0f7:2e70:f673:62a9? ([2001:a62:81d:ab01:b0f7:2e70:f673:62a9])
        by smtp.googlemail.com with ESMTPSA id d12-v6sm2068161wrg.2.2018.04.27.11.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Apr 2018 11:42:43 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] doc: add note about shell quoting to revision.txt
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-7-asheiduk@gmail.com>
 <CAPig+cRWn66C6wcmYv5G3qjfZAux6pVCp1H+w9c4+CzevfXMRg@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d6325d96-f44d-c4da-c651-cc4b99ab6d0f@gmail.com>
Date:   Fri, 27 Apr 2018 20:42:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRWn66C6wcmYv5G3qjfZAux6pVCp1H+w9c4+CzevfXMRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.2018 um 19:36 schrieb Eric Sunshine:
> On Fri, Apr 27, 2018 at 1:04 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>> Reviewed-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> @@ -186,6 +190,8 @@ existing tag object.
>> +  Depending on the given text the shell's word splitting rules might
>> +  require additional quoting.
> 
> s/text/&,/
> 

Fixed, Thanks
