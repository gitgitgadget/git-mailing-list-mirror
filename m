Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC0631F424
	for <e@80x24.org>; Fri, 27 Apr 2018 18:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758146AbeD0Sko (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 14:40:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54659 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbeD0Skm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 14:40:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6so4103334wmc.4
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y18sd6dXj8nt+0IshcsbLOybLDXCdo3iMRU9rPN52bQ=;
        b=avkNVR8zIhjkJGyT6jbPympzzHe+miwKGgrM4o8Dd4Mm2QMPD8Jyiuvp6RgJXa7eHP
         1rKsRIxEcldC20k7DmeeNH1L3EswNWERQUeCoG446toPMgdFSZajDXGu+BhqdtzMYZcv
         bgqE/vxU9RmQcJ2IpGOQ6yteMQnlGNha3C/5MQ4388izb56xb/vvfA4Lbh0arnt/JLJc
         WObLl0l1HE1sZZk+1cVbDKhdwThkTKpDS7kYifXZ/0PyZ0GtGaC9hg4LDTofYU7kLUja
         fLpzj+ijt7lsFe50vFxPjMrrvHrR7hFr3h/bx2VvOOAxlwrMe5hqcSO5rs/vtoI82Vhm
         PJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y18sd6dXj8nt+0IshcsbLOybLDXCdo3iMRU9rPN52bQ=;
        b=Wjj8nsW8ER/O9pxeo1x8d4J8DHwFvV/3NTcdYjfklvHdEy7y9j/wD03hZwj3zJdBsb
         hK/R8SZhKhIrOYIt+8Arl1MupsnUvFVzGeDZUlvwRfxTmEqy3AexNiBCSlOZ9kaH3xpM
         r23NH4Uf9ocDSHa0RougdRWkiNpzmQA3qcJsRtBjy8EO/oGZ97J5DhAkg5sMEZxAvtrG
         OJc6qgqzy3K8Dr/Q2swocEkojwwf9PAkKDh5REg3SZl5QOd1bLzpccciFHjva9RwUSbL
         9ixJ9KYwtAHa8Co3bq9JTWT6lr1HqmrMsTGMGRo6udGylhZk62LPZrrQH2B0ogm1pi10
         WtAA==
X-Gm-Message-State: ALQs6tBeNIGh5MTPZa2y5zwfKklXHbu/l+sKO7m1ZGXR69VJcxdhUrOb
        ykGMlll1gVY9a3rYWRzCwHhR/sgJ
X-Google-Smtp-Source: AB8JxZqnGbn0DG1Kk2+4iBfineRVy/SQh8F2xmHCbHsa1l7mrmnY7+Yz2oThbSKWVzjQTYWW5alAGw==
X-Received: by 10.28.20.66 with SMTP id 63mr2037943wmu.100.1524854441514;
        Fri, 27 Apr 2018 11:40:41 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:b0f7:2e70:f673:62a9? ([2001:a62:81d:ab01:b0f7:2e70:f673:62a9])
        by smtp.googlemail.com with ESMTPSA id 19sm1960105wmv.18.2018.04.27.11.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Apr 2018 11:40:40 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-3-asheiduk@gmail.com>
 <CAPig+cTM1J35hvwYwj9BOkFxw0tGQJFZjPL_WnCa=wDxzYzj0g@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <bb44e716-a57b-71fb-4446-20809ddb73d1@gmail.com>
Date:   Fri, 27 Apr 2018 20:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTM1J35hvwYwj9BOkFxw0tGQJFZjPL_WnCa=wDxzYzj0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.2018 um 19:33 schrieb Eric Sunshine:
> On Fri, Apr 27, 2018 at 1:04 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> The two '<path>' parameters are not optional but the option
>> '--no-index' is. Also move the `--options` part to the same
>> place where the other variants show them.
>>
>> All three items are already correct in the synopsis.
>>
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>> ---
>> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
>> @@ -13,7 +13,7 @@ SYNOPSIS
>> -'git diff' [options] [--no-index] [--] <path> <path>
>> +'git diff' [options] --no-index [--] <path> <path>
>> @@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
>> -'git diff' --no-index [--options] [--] [<path>...]::
>> +'git diff' [--options] --no-index [--] <path> <path>::
> 
> Not a problem introduced by this patch, but shouldn't this say
> "[options]" rather than "[--options]"? Since the aim of this patch
> series is to clean up botches and normalize documentation, perhaps it
> could also fix this oddness(?).
> 

Well, in the SYNOPSIS it is always `[options]` for all variants but in
the DESCRIPTION it is always `[--options]` for all variants. Fixing the
other variants would stretch the "subject" line of the patch a little
bit to far ;-)
