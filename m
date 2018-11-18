Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611FD1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 15:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeKSBme (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 20:42:34 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40406 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKSBme (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 20:42:34 -0500
Received: by mail-oi1-f172.google.com with SMTP id t204so520501oie.7
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:user-agent:subject;
        bh=k9/mqDA7oZ0F2xAicH637KOXI38JLdrjJsXAbVfEsXA=;
        b=dZ1EXMArArRgPUz80iY8+NAyGn7z7cSaCq4uA8UXrBtPdXg84+y83/o8aXv9uWF59x
         DOxK5ukov3SbQxxS1VzKONpgqtfiQE8iY8mwFfRkwWRucdvb7/2FcAGWvgbScVg396JK
         ndiBRJhXH6YC9oIcXAD3nUYQFm0bKtiymwc4t9plzjU49Ttq9dVq+IApmHOAlDi8LPan
         T1RX+ndvlb+nmeZa4EhpI3cJ0c2NVcOGQPHNuPhbkRToHvpFuqkRPGrfMx1V4uE37rMk
         zz887rihOR/0eGylGNWip3c4hQtu69E4bGVA1D1Q8Gh74zQkBR67y53sqpTK5l9tiEsD
         K2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:user-agent:subject;
        bh=k9/mqDA7oZ0F2xAicH637KOXI38JLdrjJsXAbVfEsXA=;
        b=HSzS8h93ZsXba0mbn4B09v//NSWK67mrGQOzyAadjLUghWo+2v7tbVleQhfjHQxWq2
         UBbeqgh7PrMu06zF3n4pYXcjyqemm0ECzisJVPeIgxKNkIzUnsCwapjvbwj/LHFv6G/o
         BofesG+evGsm0q4Idn9PPuFhc7kt8cPEMQtCMAFpWWQXmKcV3Cw7cfeS5TGZpjDRHlay
         ESsatp6Yz1yIDHpJmPDxcF9F0fFgawlU93YLCqMpxy3Uxkfq9zzp7f/U4vE8UrorDLEX
         85Mq36M7SVwlBTlk7Wz9+Hdetun3fRNKikB4hTUoYMdPdSf+MVqlsJ7P6D1MV6A5bmm/
         aZzQ==
X-Gm-Message-State: AGRZ1gLp7vjhiViaS98mBsXVeoyHfdTXzfxXNrMsjjJ1aMLxYCUuZYMb
        lWoxARxRvcMr9DzuE8PKxXeLQE4dntE=
X-Google-Smtp-Source: AJdET5c8TJGGGIMBFfmxbyqE5m9JkjImgKpm3ID3u2vG5oyrqS6LClic+AQWVc+5qy4/vXM0m4/Fyg==
X-Received: by 2002:aca:5344:: with SMTP id h65mr3092946oib.13.1542554519404;
        Sun, 18 Nov 2018 07:21:59 -0800 (PST)
Received: from JoD ([2605:6000:9fc0:56:740d:e24f:8851:5309])
        by smtp.gmail.com with ESMTPSA id a201sm15273365oii.27.2018.11.18.07.21.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 07:21:58 -0800 (PST)
Message-ID: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
Date:   Sun, 18 Nov 2018 07:21:58 -0800 (PST)
From:   Steven Penny <svnpenn@gmail.com>
X-Google-Original-From: Steven Penny
To:     git@vger.kernel.org
Content-Type: text/plain; charset=utf8; format=flowed
User-Agent: Tryst/2.8.0 (cup.github.io/umber/tryst)
Subject: Cygwin Git with Windows paths
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cygwin programs can handle Unix form paths:

    $ ls /var
    cache  lib  log  run  tmp

and also Windows form paths:

    $ ls 'C:\cygwin64\var'
    cache  lib  log  run  tmp

However current Cygwin Git cannot:

    $ git clone git://github.com/benhoyt/goawk 'C:\cygwin64\tmp\goawk'
    Cloning into 'C:\cygwin64\tmp\goawk'...
    fatal: Invalid path '/home/Steven/C:\cygwin64\tmp\goawk': No such file or
    directory

It seems the problem is that Git thinks the Windows form path is relative
because it does not start with "/". A Git Bisect reveals this:

05b458c104708141d2fad211d79703b3b99cc5a8 is the first bad commit
commit 05b458c104708141d2fad211d79703b3b99cc5a8
Author: Brandon Williams <bmwill@google.com>
Date:   Mon Dec 12 10:16:52 2016 -0800

    real_path: resolve symlinks by hand

    The current implementation of real_path uses chdir() in order to resolve
    symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
    process as a whole and not just an individual thread.  Instead perform
    the symlink resolution by hand so that the calls to chdir() can be
    removed, making real_path one step closer to being reentrant.

    Signed-off-by: Brandon Williams <bmwill@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

This causes problems for any non-Cygwin tools that might call Git:

http://github.com/golang/go/issues/23155

