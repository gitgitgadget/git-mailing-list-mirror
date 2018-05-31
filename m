Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392531F51C
	for <e@80x24.org>; Thu, 31 May 2018 11:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754731AbeEaLuD (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 07:50:03 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47851 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754696AbeEaLuC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 May 2018 07:50:02 -0400
X-AuditID: 1207440e-203ff70000000b39-22-5b0fe16968c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.F1.02873.961EF0B5; Thu, 31 May 2018 07:50:01 -0400 (EDT)
Received: from mail-lf0-f52.google.com (mail-lf0-f52.google.com [209.85.215.52])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w4VBnxJZ029544
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 31 May 2018 07:50:00 -0400
Received: by mail-lf0-f52.google.com with SMTP id n3-v6so9310643lfe.12
        for <git@vger.kernel.org>; Thu, 31 May 2018 04:50:00 -0700 (PDT)
X-Gm-Message-State: ALKqPweSsXE+jjf0m+HzEDJZasL5uvKbzhqktM6CC7o4DSdX+xA8WRHk
        eon8rNi04i1cfbqzz7wixkkYH3wwH82dt4QN2SI=
X-Google-Smtp-Source: ADUXVKI0WqC5/4SSzz320sHIOur9ZraGyTZzoxLERhyCGlqiamRBc0pbctUlZrVNfAOQAlC/xlKDCmzLnSN392hniSY=
X-Received: by 2002:a2e:28b:: with SMTP id y11-v6mr4900065lje.27.1527767399410;
 Thu, 31 May 2018 04:49:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 2002:a2e:9ec3:0:0:0:0:0 with HTTP; Thu, 31 May 2018 04:49:58
 -0700 (PDT)
In-Reply-To: <20180530170302.191176-1-sbeller@google.com>
References: <20180530170302.191176-1-sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 31 May 2018 13:49:58 +0200
X-Gmail-Original-Message-ID: <CAMy9T_Hc_C-bbzcKBq9HJ4ufzcNJa5NtFQb1h2Uwpe6QL2XRCA@mail.gmail.com>
Message-ID: <CAMy9T_Hc_C-bbzcKBq9HJ4ufzcNJa5NtFQb1h2Uwpe6QL2XRCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs/packed-backend.c: close fd of empty file
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqJv5kD/a4Ot1aYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGV0LZrKXrCSvaLz8jzWBsZDrF2MnBwSAiYSlzZfYeli5OIQEtjB
        JPGi/TYThPOISaL5+VtGCGcCo8TmzyuhWsol7nZ2QtlFEi8eT2aCiW89eZkFxOYVEJQ4OfMJ
        mC0kICfxasMNRgg7XOLlhKlgNqeApcSPJUvZIeIWEjfXNIPF2QR0JRb1NIPNZBFQlTjy+gkj
        xPxEie0XjjJCzA+QeHL1P1ivsICbxOyGr2wgtoiAmsTMVbPBbGYBLYnNP7+xQ9iaEq3bf7NP
        YBSZheS8WUhSCxiZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEhDffDsb2
        9TKHGAU4GJV4eDnW8EULsSaWFVfmHmKU5GBSEuV9d44/WogvKT+lMiOxOCO+qDQntfgQowQH
        s5II75QyoBxvSmJlVWpRPkxKmoNFSZyXzWRvlJBAemJJanZqakFqEUxWhoNDSYL3+32gRsGi
        1PTUirTMnBKENBMHJ8hwHqDhW+6BDC8uSMwtzkyHyJ9iNOZY8rS7h5ljwZZJPcxCLHn5ealS
        4ryBD4BKBUBKM0rz4KbBUtQrRnGg54R5Y0GqeIDpDW7eK6BVTECrOtrAVpUkIqSkGhhT2fnW
        +LC/Z3a9L7Tdr/3H5WqLA5MXrItQmBwXMC1XL11799TP/NvkDJ1frjaccV3H3HefR9B2q5XN
        v2KbG2+fF69dk9DKNpvV0UA/2vTrjk9Ox11/JjX/EGFeu9DuDM/vyKjJ62XjhdTYuVznzDr8
        5JQnT1fUsxavfSX/Kz/NfKkmHr511TolluKMREMt5qLiRABDNidLLAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 7:03 PM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This was an oversight in 01caf20d57a (load_contents(): don't try to mmap an
> empty file, 2018-01-24).
>
> This and the following 2 patches apply on master.
>
>  refs/packed-backend.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index cec3fb9e00f..d447a731da0 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -499,6 +499,7 @@ static int load_contents(struct snapshot *snapshot)
>         size = xsize_t(st.st_size);
>
>         if (!size) {
> +               close(fd);
>                 return 0;
>         } else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
>                 snapshot->buf = xmalloc(size);
> --
> 2.17.1.1185.g55be947832-goog
>

+1.

Thanks,
Michael
