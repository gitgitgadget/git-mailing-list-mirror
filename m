Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEAFE1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 06:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeK0RRK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 12:17:10 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46520 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeK0RRK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 12:17:10 -0500
Received: by mail-yb1-f195.google.com with SMTP id i17-v6so8584658ybp.13
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 22:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ust9hPo3IKyrs/7TLJ4Ap1qepR9isJA5eou/74w8ww=;
        b=Ahd9dbjNhtJP/pjRKelTbkkVA+CBYshEMqVMqQ4J5zCh03NmMIaX3JGpd2KB8EVGra
         ODcEVS+vhnpkaotG4pulgizGQDh5cOS20URDnU5v1N4SQmWbgUPCvCn/P5/GE0Z09xsT
         +2oUgD3peC5u+WMiq/wAVFcyL85YsQE/HaIrapUhWx5uVmzdNADSInVJLSoljQ4jxSjo
         iXSeXPctyQinzEk536Dc1sCrKbLtg0wHugXkatcn964ztGm/o7qRn/wUyf6GVYw3Xf9H
         BsrTg5bEs+WRdbHscVSsEcIc+hI5tb1NmC0DV37fynoiHTEIC+8gs4X8eTyM3XE0cSMw
         lAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ust9hPo3IKyrs/7TLJ4Ap1qepR9isJA5eou/74w8ww=;
        b=LzsB9iNZLVWP45KbcctUg/t2iJ+teA3Pzwnkj8OAsPvkUh8boLNcYKeDanRTWbRlBK
         wB+nqvEWYqXJ6OCA/HZPTPED+JtvlqA5RnWu9m7wEjs/Srh2Z2YmAm7KUSdT5jGQoqPA
         nopzrGgGh61/l8lwqoQ2kgKOgQ37k5mbgB3MCFucPkD6H3ivpfyk1vjwXjRUH9LovSQR
         xsW+bd70Hutl8QeNfh9BpL1JQ9AdLXp8H8q4b4igyai526UYCMK+Mh7hLDQf92dn6jSv
         e2pprNpWEQ8qHetXWHiIov1kM9Ekk9jH1shsJRC4pT9jSYv2P01KhBIaptUZIkC4jXJn
         djbQ==
X-Gm-Message-State: AA+aEWa4Lcj2825ygQP+1xP5lEgDKWCcXV2dKuut/3w3iauJW/ca+GFE
        VAk+MuWg3GIa2pH+mSt16I4gKm3Fsli10TWlAxM=
X-Google-Smtp-Source: AJdET5emCwcg4LrxQtIdZjqV4kb2P/Uy57qC3P3KHWjv8SzGfdk3JQdoNIzGlDvbm8uuOtZOGlqYUHuEwsEphGcmc5w=
X-Received: by 2002:a25:1cc1:: with SMTP id c184-v6mr32358559ybc.421.1543299621791;
 Mon, 26 Nov 2018 22:20:21 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181126173252.1558-1-tboegi@web.de>
 <xmqqtvk3tj45.fsf@gitster-ct.c.googlers.com> <CAAXzdLX4jU7+i1W1A_Q1LpPFa1D4FYVPW5rcMnqr_tDHEJn+tw@mail.gmail.com>
 <xmqqlg5ft7pe.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg5ft7pe.fsf@gitster-ct.c.googlers.com>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Tue, 27 Nov 2018 00:20:14 -0600
Message-ID: <CAAXzdLWtDw09umyr23qZkv2jQ6_mTeFXbktgb-f6S2w6Zf1Egg@mail.gmail.com>
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tboegi@web.de, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 11:23 PM Junio C Hamano wrote:
> Sorry, but I do not see the connection to this question and the
> above example.  The reason why we strip C: is because the letter
> that comes after that colon determines if we are talking about
> absolute path (in other words, the current directory does not play a
> role in determining which directory the path refers to), unlike the
> POSIX codepath where it is always the first letter in the pathname.

while it is true that "C:" and similar do not have a bearing on a path being
absolute versus relative, it does have a bearing on what drive the entry is to
be found.

That is to say "C:\tmp\file.txt" does not equal "D:\tmp\file.txt".

Starting with an absolute path like "C:\tmp\file.txt", after stripping that
would yield "\tmp\file.txt" or "/tmp/file.txt". Starting with a relative path
like "C:tmp\file.txt", after stripping that would yield "tmp\file.txt" or
"tmp/file.txt".

However in all cases we have lost the concept of what drive the file is located
on, and Windows will assume the file exists on the current drive.

So I would expect "git clone URL D:\tmp" to fail if the current directory is on
"C:". Upon testing cross drive clones work fine though with this patch, so maybe
the drive is added back at another place in the code.
