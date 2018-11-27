Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673301F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 02:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeK0NqH (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 08:46:07 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42299 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeK0NqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 08:46:07 -0500
Received: by mail-yw1-f67.google.com with SMTP id x2so8512924ywc.9
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 18:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGbuWVM0i0Gd39jJBegUD80VSFIuvmiY3PimV7jSp+k=;
        b=MWgH8E7mMpZPUrbNyXtR+ikjfUdajSjpQDzso8LCgWTkikgEo5zupbv5MVpo+MHfhz
         AFiX2xY3/kg5ghnz8X7WTUyfujtYiawO7MbzpK1d2DhfzGctRaqN37HZEalKRKvaZb3N
         5Ynx0Ajc5coKIy1RTyQQ/+FwQbi8Rxu1KkWyMKVzAKPu6dwMoNAka7mGk/OExtL6kYB9
         NT8wR7VYr4J0ihSSKp2xKJ3JUhKGjgj3Uk2ZgFRht9hQDWuRZ+Qy0Yu1xpSMKMz3psSP
         B3/j8bqvl2NVHDnfM/tmgNHK83IaBoSRUpg0df4/tk0TUrWmlz+rIgGIG2ZWGX/fi0i7
         waSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGbuWVM0i0Gd39jJBegUD80VSFIuvmiY3PimV7jSp+k=;
        b=rySTzAIftEELHeqsThr+7QpFPF/VNKImWK71MyX6EKDLRxFtuB8C3t/0PSk+a5Dnk9
         gh4xa/t7ll2AwralOqkH66XLOTW/FgahpVHFTPLSxxUvcuSzLOOQN6Ldl6Kql6KrXRmq
         srAbWaFY9BYOQFDaCw+qgaDjL0pn8nlyFFmDbLbwCGMa604N0ndZXPwCGxBut9frlov1
         luhBuiND3hpl+ZI9pOCKjKucF3+Ema2QsesONhkyarMp+iztUBl2NU2hUEKmZHKHtiin
         WFbSNkUK2UVSX/G37uGMxSzkcH4Lx/xtESLfTfaJGmtjgVgDgRAsGpsv2rMoXzRTERvl
         ZXlQ==
X-Gm-Message-State: AA+aEWb+fKVldvlBRkphz2BJixTXBJh6v+XwNddWHi9HebQI3YybZPMi
        Eqx/UTQOWMF3WkcOeeMNI8UBTk9sHEhEzcZqCtA=
X-Google-Smtp-Source: AFSGD/VPFCGeHEqrUYaJRJwLo4XRRb1bE+WLyjLqMzX6PR0niZjKbIlkIR82o8TYB7yLe1SdJxfK/4bCzkS2YoxTqoE=
X-Received: by 2002:a81:794e:: with SMTP id u75mr8833319ywc.133.1543286986189;
 Mon, 26 Nov 2018 18:49:46 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181126173252.1558-1-tboegi@web.de>
 <xmqqtvk3tj45.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvk3tj45.fsf@gitster-ct.c.googlers.com>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Mon, 26 Nov 2018 20:49:38 -0600
Message-ID: <CAAXzdLX4jU7+i1W1A_Q1LpPFa1D4FYVPW5rcMnqr_tDHEJn+tw@mail.gmail.com>
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tboegi@web.de, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 7:16 PM Junio C Hamano wrote:
> I wonder if it makes the rest of the code simpler if we stripped
> things like /cygdrive/c here exactly the sam way as we strip C:
> For that, has_dos_drive_prefix() needs to know /cygdrive/[a-z],
> which may not be a bad thing, I guess.  Let's read on.

With full paths, Cygwin can traverse drives:

    $ cd 'C:\Users'
    $ pwd
    /cygdrive/c/Users

    $ cd 'D:\Testing'
    $ pwd
    /cygdrive/d/Testing

If you strip the drive, you can still navigate within the same drive:

    $ cd 'C:\Users'
    $ pwd
    /cygdrive/c/Users

    $ cd '\Windows'
    $ pwd
    /cygdrive/c/Windows

but you can no longer traverse drives:

    $ cd '\Testing'
    sh: cd: \Testing: No such file or directory

So a good first question for me would be: why are we stripping "C:" or similar
in the first place?

>  - Is there a point in having cygwin specific variant of these, or
>    can we just borrow from mingw version (with some refactoring)?
>    Is there a point in doing so (e.g. if mingw plans to move to
>    reject forward slashes, attempting to share is pointless).

I would say these could be merged into a "win.h" or similar. Cygwin typically
leans toward the "/unix/style" while MINGW has been more tolerant of
"C:\Windows\Style" and "C:/Mixed/Style" paths, i dont see that changing.
