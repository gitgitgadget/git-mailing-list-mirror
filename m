Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B731F597
	for <e@80x24.org>; Mon, 23 Jul 2018 15:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbeGWQbQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 12:31:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38060 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388490AbeGWQbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 12:31:16 -0400
Received: by mail-it0-f66.google.com with SMTP id v71-v6so1826337itb.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JNzU/1Rwn1rCTkUaoHQAgds0KfNE634EM+dzaN+7l3E=;
        b=WdPyYIyDOL33yTPAEK6eOyrKM0G96QfLEaWZLkslPD7OCbuRsYoLyYenQcSMiqaFRG
         +ScYfq/TkPVawG5I9Pp8U9TPteJQ7liXRV+TPsqp9+l9+UwIvk281Bsnw8Gthrz9iMpM
         7qTMRg9A5ITBJRGhuAEpeiXhyzqU1ZgaJ2Z2EwthMAQOCSywYl3VEXwT/EnoVJgEg39x
         EBnlJacuPmmtmgfQ/Zme/yS7kd6OMDG4oRQiRQde0J20Yx33fVHL8RUGdkOm31UEIkm5
         MIir+VFY3e18ujx8mQkPTYv9UY41NTWcIqK1fb9T8r+C4qRbARXdrcOIc6FJEhDwWuRX
         t0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JNzU/1Rwn1rCTkUaoHQAgds0KfNE634EM+dzaN+7l3E=;
        b=kS0rBGdLWmfRcObOwF4+ft3iVqWyr+vxfVbfI45TLgDjA+h9/ysxXvzrFwnR+8dwaH
         AT/ZQtQCjX2n6XUL9hwJPCXDKPGFhHN94IdaJKN9ylf45o26PPPOVXpKOB2FGFF38N4t
         NeXVCBXSpZsZ2NyITZw2KmjFHYTBbcLrYDjs46GpC1Udp/InlirhsjdtJ0/oeoDJwLQx
         ygKwlHkXl3oduVFhxFEDOB74684q4mZilIgPZALDXH7PQKOsQlkoVdxYQtwi9rRwZF5T
         2v7UWRTHxRZfpDRknxR+aVQaKkGDreCFAOrGftkR3SPdjJRcX7sLJZum093EQ25GwKE6
         hU8w==
X-Gm-Message-State: AOUpUlFSgEcum/daJS0qi74duuRziHtJOsj3mkbNW0ixPnksTFcXChz3
        lElz1zwCsnpP//3ykxWxNas098dXXLcn0x234wQ=
X-Google-Smtp-Source: AAOMgpfFyl2c2OzHHmYX2r28wTDcpYPd69jK7yTQanpG4HkLqMVfQs9dEtqOHh6Ei0N13Um9DW6LO9DjeaXVw6X5xHQ=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr12125218jam.61.1532359771244;
 Mon, 23 Jul 2018 08:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180723135100.24288-1-szeder.dev@gmail.com>
In-Reply-To: <20180723135100.24288-1-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 17:29:04 +0200
Message-ID: <CACsJy8Av5vBY_fGGyHXdqezZJpdE-_-roro96+WAc2xiSbOYPQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Misc Coccinelle-related improvements
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 3:51 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> Just a couple of minor Coccinelle-related improvements:
>
>   - The first two patches are small cleanups.
>
>   - The last three could make life perhaps just a tad bit easier for
>     devs running 'make coccicheck'.

I'm not a heavy cocci user and probably won't spot any corner case
problems. With that in mind, I've read this though and the series
looks good to me.
--=20
Duy
