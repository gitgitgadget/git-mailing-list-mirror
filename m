Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E991F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 14:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdIAOEj (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 10:04:39 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:37437 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdIAOEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 10:04:38 -0400
Received: by mail-io0-f173.google.com with SMTP id d78so1815197ioe.4
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XKy/pTiVTpV06S3CzpcJ8FqborTLjo9gdrq9VFwbzCw=;
        b=lGtjZwXUDkwCcM4KVjMCh8p4EnMnIvoeJJsqYUYRIzhtQzrjdmw0WAfdsluYmKvcaR
         PhqEUU6bMojrrBC5noUpQLngld9+5tFPxJBbjBWRu8ZZWZY8rvzNoYVaNFOSNIgve9Ff
         YvrMED5B08xLFnjJPclPHKOc7VT4nw6YA9937LTIZXmWH6+wDMJGurqhq2MoKnbGmKau
         L9bQuegokZP4cmWgUYUMUJPOyIQncUVTWmFrebhuUAwP4nYlW0P+lntKB1Dn2e8zNIC1
         Ea7GfptwWWZA29zCkpRMXPdwViWurvNFZplwKhSCURvNmj+a4VMdOxgCjIPAaRbvy89b
         UJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XKy/pTiVTpV06S3CzpcJ8FqborTLjo9gdrq9VFwbzCw=;
        b=FZXcCHnvYRq6GVRo5O6+S3ciEFWrVB88SCBj19mfMBzWH32yxPIxLmHw5daNPw52Qg
         YDBM0VuGA0yrN8tsCx2P5Tvq6WtaQpGGs6wmLRMFUTYeDBN+Vi7NuEYXtm/xLcvsQzb4
         /9BC1gT3Fv02I6rVpKQbMSN5XOf5oDvUy4f52yFBA7zngg/IfzX1Hczi2pN1uYak1K6S
         KHlTS7u+yG2ON6/7jgRtOdcA16cXqc0zAyKEeH8lVEgv8ZaCyhT4MvGVQGIpEC2R52GE
         pQisS1INe3b6myUnDKKOeyajpad1GdBnVn47XplvT7ODeyHEYRRsB2yHtS7ZUxSKusU9
         u7mA==
X-Gm-Message-State: AHPjjUhtvCIjhWEfXEvQSliYxuTCRAdxM0f3WbzGNtvWgf3LLKuSHseh
        JdTJEJzWkCWTpV4uvwyGVoodGyTwOql7
X-Google-Smtp-Source: ADKCNb79MaVcVglQETGDZEO3Brlbf8yHgDx9hnLZVVqqdvdUkwDqPMm0AvVdrR4UqJXznShOdDB3qItYCZgGN+iD2SI=
X-Received: by 10.36.207.137 with SMTP id y131mr713510itf.84.1504274677274;
 Fri, 01 Sep 2017 07:04:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.165.25 with HTTP; Fri, 1 Sep 2017 07:04:36 -0700 (PDT)
From:   "josephpattara ." <josephpattara@gmail.com>
Date:   Fri, 1 Sep 2017 15:04:36 +0100
Message-ID: <CAC-YKd1sTQLMUZ6k+-4K09=NOa_HaOf1gp8H51VNZjziUrxOfA@mail.gmail.com>
Subject: HP-UX (git-2.14.0) Depot File / Source Code Build throws SHA1 Error
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear HP-UX Git Maintainers,

Sending this email as I was trying to use the HP-UX depot file which
was recently committed to the
http://hpux.connectinternetsolutions.com/hppd/hpux/Development/Tools/git-2.14.0/.
I tried to use the depot file and also attempted to build the code
from the adapted source code (using native HP-UX compiler as mentioned
in Installation Note) from the website.

But unfortunately both of them failed with an error:

Cloning into xxxx...
remote: Counting objects: 19813, done.
remote: Compressing objects: 100% (9124/9124), done.
remote: Total 19813 (delta 10340), reused 16358 (delta 8293)
Receiving objects: 100% (19813/19813), 6.07 MiB | 9.72 MiB/s, done.
fatal: pack is corrupted (SHA1 mismatch)
fatal: index-pack failed

Looking at the dynamic link I can see the below:

_HP_DLDOPTS="-ldd" /usr/bin/git
  /usr/lib/hpux32/libpthread.so =>        /usr/lib/hpux32/libpthread.so
  libpthread.so.1 =>      /usr/lib/hpux32/libpthread.so.1
  libz.so =>      /usr/local/lib/hpux32/libz.so
  libiconv.so =>  /usr/local/lib/hpux32/libiconv.so
  libintl.so =>   /usr/local/lib/hpux32/libintl.so
  libc.so.1 =>    /usr/lib/hpux32/libc.so.1
  libdl.so.1 =>   /usr/lib/hpux32/libdl.so.1

  Until recently we were using the older GIT version for HP-UX 1.8.5.3
and I can see the older GIT had a dynamic link for libcrypto.so.

_HP_DLDOPTS="-ldd" /usr/local/bin/git
  libz.so =>      /usr/local/lib/hpux32/libz.so
  libiconv.so =>  /usr/local/lib/hpux32/libiconv.so
  libintl.so =>   /usr/local/lib/hpux32/libintl.so
  libcrypto.so => /usr/local/lib/hpux32/libcrypto.so
  libc.so.1 =>    /usr/lib/hpux32/libc.so.1
  libdl.so.1 =>   /usr/lib/hpux32/libdl.so.1

The clarification I have is
1. Is the version 2.14.0 from HPUX connect is it really usable (depot
file and also the source code)
2. Was it deliberate to remove the openssl linkage from the new GIT or
am I really missing any special configure or build flags to enable the
libcrypto.so linkage.
3. Is the SHA1 error which I get is it really to do with the missing
libcrypto.so or I am on a wrong inference track?

Thanks and Regards,
Joseph John
