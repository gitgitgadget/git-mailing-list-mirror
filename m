Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B811F404
	for <e@80x24.org>; Thu,  8 Mar 2018 16:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756007AbeCHQRu (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 11:17:50 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40143 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbeCHQRt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 11:17:49 -0500
Received: by mail-wr0-f171.google.com with SMTP id o76so6244748wrb.7
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 08:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=c4UlETTQ/NFJ00bnoFaoPTFJF4A5444yhYUmUZV/vJQ=;
        b=FODHXP+zSp0asjLb1azAGq+azsQ8XY42gkqRtVp85dwEw3kfrDU0PJCOSlMuKpnNDS
         aiVzkCAK0JIilk4X8p2DcNCrMbrnc8dhJ58BfK4v6IZh28Gt2gZKQBjQPXT7Asrm8hs9
         xRnLW4ZcgZ8Cg2g1JpDohLB8v2evsZLQfO2x57SS6Fj0Q6xutPdS2jgazXaOEmYYn1V3
         tj0XiS3SqgflNuVZuzz6Yib/XpUhGeZC56qvbGjGtuV9hWginp3HhDOSg958uR0HIH8T
         h/tNBBaJ3GTDMUY6SDJWdGf3DpEUyQP5J1ua9cZlmD+xWYkZnmfBy5cj30Bv9Khe6xMI
         icVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=c4UlETTQ/NFJ00bnoFaoPTFJF4A5444yhYUmUZV/vJQ=;
        b=WaCmRy0sj7d04yITR67Taz98ghXjelYEIywBVtrbgNXiX47ujk5/f64hZkXuEaeVvj
         cQ2OJZ/bpBaxwlU2X6O0Cw65iHqsFOA5fEZhE4CSRAZlGOSnmx2w9Tp1Q2RyuF8vCA2S
         fCOyfHL7gMuVjqmPEBsDSDEu4nZpyKC90orwel3LwUeNBO8XQhIBUEPkKvyT05Ee50NK
         +hZgQoVwe5baCClmujMwAQJs7pPBPn81AlfRVrbdNDpJBX/3MIOXusKSjzpIB1MmUcRR
         XZMG/8Wi+wps3CMwo6T3bzAnKMsM597lhQURoJnSMtDi0HOJyBJdFjZWrAJV3tWPPlRV
         ooFQ==
X-Gm-Message-State: APf1xPBR7+Xor9JSu5jTewEEs+Of59Ca5jJDnP64kPdTGXOQ4SGO1uvO
        877mcVRcJiL9eJ8p17xtuVhbCA==
X-Google-Smtp-Source: AG47ELsGROpjyQro3FSOAPN8bmry6Py5Mlo402z+RACLsJR9+ADbiwMxxvVdrGESFZn88MjxiWFsUg==
X-Received: by 10.223.192.76 with SMTP id c12mr22167634wrf.177.1520525868149;
        Thu, 08 Mar 2018 08:17:48 -0800 (PST)
Received: from localhost.localdomain (x4db106d7.dyn.telefonica.de. [77.177.6.215])
        by smtp.gmail.com with ESMTPSA id f14sm953982wmi.11.2018.03.08.08.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Mar 2018 08:17:47 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Error compiling Git in current master branch
Date:   Thu,  8 Mar 2018 17:17:42 +0100
Message-Id: <20180308161742.26596-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.603.g180c1428f0
In-Reply-To: <ce6250a8-c1e2-433d-7d5f-399115aa9f55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Just to let you know, I get the following error compiling Git in master
> branch:
> 
> $ make prefix=/usr NO_GETTEXT=YesPlease all doc info
> ...
>      GEN git-remote-testgit
>      GEN perl/build/man/man3/Git.3pm
> Can't write-open perl/build/man/man3/Git.3pm: Permission denied at 
> /usr/bin/pod2man line 70.
> Makefile:2317: fallo en las instrucciones para el objetivo 
> 'perl/build/man/man3/Git.3pm'
> make: *** [perl/build/man/man3/Git.3pm] Error 13
> 
> This didn't happen in v2.16.2. Doing a git-bisect I've got the following
> culprit:
> 
> $ git bisect start HEAD v2.16.2 --
> 2530afd3519a34b66e72cc29e7751d650cedc6dd is the first bad commit

That's not the culprit, that's the fix :)

> make clean fails too:
> 
> rm -f -r perl/build/
> rm: no se puede borrar 'perl/build/man/man3/Git.3pm': Permiso denegado
> Makefile:2734: fallo en las instrucciones para el objetivo 'clean'
> make: *** [clean] Error 1

Have a look at the permissions of 'perl/build' and its contents, they
are likely owned by root for reasons described in 2530afd's log
message.

