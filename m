Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2832A1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 13:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390329AbfFJN1S (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 09:27:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33104 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfFJN1S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 09:27:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so5339893pfq.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkDNw/+hu7ojac5oMad59LnTIKelwmC3VlY2R9D8pq8=;
        b=iinRcZiSflTQnvO4PqR2lNcgYHCcV4HB95o3zp6X6Uc7lQpdVR10p9qEoDjkHbabwH
         +aL9lzFCiUsObZ7L6/4+zch9HaCVX6SDHZfR5BrfDBhuwPB51J9veYWRQZ1vRuW7Y48C
         Z6sUWIswl2vYjDYDqswbyWBfp2a52Cs/1aUuPgXPqOvOM0JecPkqrwcqKhQu4DJAqqpU
         jmKHHCpXmzGsC5lVix3IEMpKZAQCqICvvR7m3YfDdq2GknpOAkyBl0o6niF3d5T+jnIE
         UVimqn7DEVtowUPBQNEzXWtacNvzGWgOvIxoN7P9bk36mCx7KsPGoZjnP19Hiv8z4Qq+
         Zmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkDNw/+hu7ojac5oMad59LnTIKelwmC3VlY2R9D8pq8=;
        b=mpGYcacaryt+B+r+F3KUpGjrdRRtTW/tjHRxNtCEsJJNvy3hu9a9ZYlF7Lg2F/RqTg
         HGVTKFtXHKTcKfs+0Q6Up6Bt5yGDu29w7vbnv1MQg8qkJMKoNYFx1y3tTelsDoxjVXmX
         /76FV223uvDHdC3vldIHVnqfQ/b7jZsrWuv+JknOoYuJwnweqZb1mtVCM1NOZ9dhZrgy
         ZH3bOBm7d0UCfSOrfzeMwHihEc9BKiKil7AmHL18VfaYBjpXdQQBmTrt/rszjcmP6PbJ
         Xgc3tkaR19GredIUy11hAkJVe3Qa1Bs8Q6Bmp/paUrpbfEJrfUMRfuY8i1FvkkqmJimd
         3XEQ==
X-Gm-Message-State: APjAAAWPzrIII8oy+wIkykZCgi8xOYk1ScUQOi4ldAPZ765eJvHXzeHr
        ka8DLxj6F1UXRy0ZwRSgxeVn9vlacQw=
X-Google-Smtp-Source: APXvYqyLhmY0J6OXFk3xZUkHqxh0G+BMhrOKhFxP4DGqOaEaQMquLGSDk6s3JeSVVrs013mAu9/FZQ==
X-Received: by 2002:a63:1c59:: with SMTP id c25mr15498660pgm.395.1560173237050;
        Mon, 10 Jun 2019 06:27:17 -0700 (PDT)
Received: from ar135.iitr.local ([223.188.98.146])
        by smtp.gmail.com with ESMTPSA id d4sm10009272pju.19.2019.06.10.06.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 06:27:15 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 1/3] sequencer: add advice for revert
Date:   Mon, 10 Jun 2019 18:55:09 +0530
Message-Id: <20190610132509.7581-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <d59c078c-61da-1c3a-d215-80c9e3d08896@gmail.com>
References: <d59c078c-61da-1c3a-d215-80c9e3d08896@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 2019-06-10 10:39 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>
>Hi Rohit
>
>On 10/06/2019 06:13, Rohit Ashiwal wrote:
>>
>> [...]
>> Firstly, signature of `create_seq_dir` doesn't allow us to call
>> `sequencer_get_last_command()`. Changing that for the sake of a
>> better error message is too much task for this patch as it is a
>> subject of discussion on its own.
>
> There is only one caller and it already has a struct repository pointer
> so it is a two line change, one of which is the insertion of a single
> character to change create_seq_dir() so it can call
> sequencer_get_last_command(). It is normal to change function signatures
> (especially for static functions like this) when making changes, it is
> part of improving the code base. The quality of error messages is
> important to the overall user experience. It's when things go wrong that
> users need accurate advice about what to do.

Nice! I'll do this in next revision then.

>> (Also changing signature only
>> makes sense if this patch series gets merged). FWIW, I think we
>> should left this to further discussions for now and decide what
>> to do later on.
>
> It is only a small change so why not do it now rather than putting it
> off for another series which will be more work in the long run.

I'm fine with changing that here.

Thanks
Rohit

