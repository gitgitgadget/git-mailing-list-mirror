Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772C61F597
	for <e@80x24.org>; Thu, 26 Jul 2018 06:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeGZHWU (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 03:22:20 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46090 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeGZHWT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 03:22:19 -0400
Received: by mail-wr1-f42.google.com with SMTP id h14-v6so427979wrw.13
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N4JPRtz5tlGXzfOSj24TeXUZRfY6HhuUzmPa6PDkMnc=;
        b=B0LHOlDZyi2zrDkfgaRy8Sy+2QOjCgsH9MbuahyupCojUnWguZzgb3SNMhIcYdIknf
         FRUQhkY9NZBplsOlnkVIlln17ety1HwdE0cueYNGRamSweuMGlLx2uhh9yHm4/bl1aqe
         Zka6t2j5dpxB7FbDFlpI4tTNLRmmVun3BPN+/XDJRvikoubv4SSKA5UD/zMkDpc4Yvai
         ZTp8bcbZH6R6kfqmegv4c/A/IH7XtRsf9DSHP2t/tzRazx9U0Z7uCbVOHyBVNVLt+mlF
         xpbfc+cLu40sWhbRaBQMogFZpEbzYCadrKYTUZ1l+GsZBZDqgTQuAlE0ojh1TcCPCYct
         PuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N4JPRtz5tlGXzfOSj24TeXUZRfY6HhuUzmPa6PDkMnc=;
        b=pMNZn79/IP2FymfC3nZCeVzE12c8FRB4r7iK2PHRyIX0rpyFjnjWdqhNTnzGBDTWni
         UUmHP+DoIxvx6tN3KReosXY6VbOivjbmKN+wKpBno8ELClW1kpCC6DAZYeMKHtyEQJdq
         zQenxy1dHAIURuLWwwWBf5vRzbLlJBryrtCbs7HmxsDaGvG4+hPvEHYgHji5JCsKzPDZ
         dqKygkdh/u9caoVCNZi5WsXFLLjcgc7armoMDn/yLD/cqwOWttoZW2Ty0WhNWlAPo4Uz
         5Mi15vR3NTu6QFo+TFXUNtvkyA5+59KqcPEwsdR5PMIvX+AxfLx0AptPJGEhLyoqsLQ4
         XROA==
X-Gm-Message-State: AOUpUlHhbWw536gCKxZ+kTv/x2QOTt80MGGFImgLTN7zrGu3KQBQkfSd
        +4KGzlTeQXqv3vWbKfx6n9u+HdLqX1WHBKC+tasTrB88
X-Google-Smtp-Source: AAOMgpdiaZ4VNmwH2c2z5AX7FcbirDV5TBJNqE/wYHVJ/asVH0ZxljbTUyiufSP3H+mWlt0ukoaJhf0LGkT2WMnaCnc=
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr417693wrs.89.1532585224685;
 Wed, 25 Jul 2018 23:07:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c6:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 23:07:03
 -0700 (PDT)
In-Reply-To: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 26 Jul 2018 09:07:03 +0300
Message-ID: <CAL21BmkmxmjVmi3JUaW7vK5yGyzzZDxeMGNSSYV0nzEzWKcs+A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-07-26 1:13 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
>
> * ot/ref-filter-object-info (2018-07-17) 5 commits
>  - ref-filter: use oid_object_info() to get object
>  - ref-filter: merge get_obj and get_object
>  - ref-filter: initialize eaten variable
>  - ref-filter: fill empty fields with empty values
>  - ref-filter: add info_source to valid_atom
>
>  A few atoms like %(objecttype) and %(objectsize) in the format
>  specifier of "for-each-ref --format=<format>" can be filled without
>  getting the full contents of the object, but just with the object
>  header.  These cases have been optimzied by calling
>  oid_object_info() API.
>
>  What's the doneness of this one?
>

It is ready. Thanks.
