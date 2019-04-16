Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E62420248
	for <e@80x24.org>; Tue, 16 Apr 2019 16:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfDPQZR (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 12:25:17 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:34954 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfDPQZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 12:25:17 -0400
Received: by mail-qk1-f175.google.com with SMTP id a71so12528822qkg.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y6vUbZnJHDJogVLUt2xyT9spxPOMPx+1iIuuJt/3BPk=;
        b=ZKu8Xpo5XHLk10jftHeqhAItWqo7rsFNPpwFSqv25HvfFVD+vp7hL/3SfdOjapkTz8
         6ISvDBzg4o4iwUmfQ7Gv2VpYU0YBNtoMwdcTI7jU1inMN+r2bNIr9FzwyHZ8JeykX7/S
         MfptoIwYdj/3NlU/Zx26SDWYr6o4IG2UvwhjCUIdLm1lCLl/esIrVsHlV2J/yhPyif69
         nIpJ1lhUjVGw8LQzbGjhYFEm4ayD14eWb+yn8S2FhEX6ggPdVOU8X57SYT8zDaV6GNOl
         gs9uUXjiwJgWLtvUNMrbi0fckslv6ZTHU9gi8gvGqVBG434wWedTUyTJkiHH5fqFMX8g
         FatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6vUbZnJHDJogVLUt2xyT9spxPOMPx+1iIuuJt/3BPk=;
        b=QnzHhcVSILT2mU3adzrT20S4x+yOXsvRSRRq1EHhOP3968IRxrozn+j/NA9Cd2yqbm
         80sdqsCLAs+La7tCzP1Zo6NTKGKl6xcyH0Bv4VMTyWin1hHA4RxnBI4QEr293aaIm3nM
         /PqJR0vNT6Op3O55lPjFU3NPTziHQ2Gnq3K4EIlSfKOqUBN9ju5kRBvg668CwEAcMRLz
         0EMDrTliBcXhB+4wIH4a/bILBdQU+7plzuGSNxoHZm9pBjOpGOMAZV/tSrirkm9arA4E
         g6raZRA7/+BjnrugvC0e+s5/L3clGy+3HbxCqppMI1hUQC5pw4SF2vDT4+Px77fvu6ni
         i8eA==
X-Gm-Message-State: APjAAAU0m//o5T+VenjFtS8UD4vnpf8YUk24V9rS04Dycln8kYZPZTbh
        PPej6HfOXUpaibHimWUerdmKrTwnYlI=
X-Google-Smtp-Source: APXvYqxmXgrzrcgS1Kko6xe5TqHiujwgNIXCsNtZjSA73MIT5Tbasc4tUj1RhUTOohVfznpXeq7ZyA==
X-Received: by 2002:a37:4a12:: with SMTP id x18mr61046495qka.184.1555431915625;
        Tue, 16 Apr 2019 09:25:15 -0700 (PDT)
Received: from [10.0.1.4] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l6sm30733157qke.65.2019.04.16.09.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:25:15 -0700 (PDT)
Subject: Stalled ds/ branches (was What's cooking in git.git (Apr 2019, #03;
 Tue, 16))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e1329d06-2cfa-09b9-c3a8-69776a8fd777@gmail.com>
Date:   Tue, 16 Apr 2019 12:25:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/16/2019 9:19 AM, Junio C Hamano wrote:

> * ds/midx-expire-repack (2019-01-27) 10 commits
>  - midx: add test that 'expire' respects .keep files
>  - multi-pack-index: test expire while adding packs
>  - midx: implement midx_repack()
>  - multi-pack-index: prepare 'repack' subcommand
>  - multi-pack-index: implement 'expire' subcommand
>  - midx: refactor permutation logic and pack sorting
>  - midx: simplify computation of pack name lengths
>  - multi-pack-index: prepare for 'expire' subcommand
>  - Docs: rearrange subcommands for multi-pack-index
>  - repack: refactor pack deletion for future use
> 
>  "git multi-pack-index expire/repack" are new subcommands that
>  consult midx file and are used to drop unused pack files and
>  coalesce small pack files that are still in use.
> 
>  Comments?

I'll be back to work full-time next week, and I have some ideas
to update this command. Specifically, the 'repack' command can
be improved in a few ways. I will elaborate on-thread when I
send a new version.

> * ds/commit-graph-format-v2 (2019-01-29) 8 commits
>  - SQUASH : misnamed variables and style fix
>  - commit-graph: test verifying a corrupt v2 header
>  - commit-graph: implement file format version 2
>  - commit-graph: add --version=<n> option
>  - commit-graph: create new version flags
>  - commit-graph: collapse parameters into flags
>  - commit-graph: return with errors during write
>  - Merge branch 'bc/sha-256' into ds/commit-graph-format-v2
> 
>  Introduce version 2 of the commit-graph format to correct
>  deficiency in the initial version.
> 
>  Needs update before merging to 'next'.

Sorry for the issues colliding with other topics. I'll send a
new version next week that will resolve the conflicts. Hopefully
I can do this without needing to update the base commit.

Thanks,
-Stolee


