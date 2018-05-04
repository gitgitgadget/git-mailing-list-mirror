Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FECD200B9
	for <e@80x24.org>; Fri,  4 May 2018 18:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeEDSrb (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 14:47:31 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44645 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeEDSra (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 14:47:30 -0400
Received: by mail-pg0-f52.google.com with SMTP id 82-v6so15993142pge.11
        for <git@vger.kernel.org>; Fri, 04 May 2018 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=behaMoZXOAC4lwbxpaU/IlHAo5C1UOxPb/xpbliQD4M=;
        b=aZWlKT9xpub6oeioP/Xsl9dyKqrCSwKuEIp3b/Xh9n1arMCStJ8VwJuk+V6pCgBeCJ
         q0+K6A/SDwCg7NiX7dpsEHf1GkqaJmnTQ9M2iSIt3wRDCfu4ruwwNDB9n8JQJ6icAWvc
         9f7sQ376XzZ7+u2BzH9HzejX64+tDeOvwz7gec+ZW3Li43vooiXQKqOM8NIPHgKtGgnX
         hq5DBWJxlpcKyH/n31XaL+VA1dFMc1veEjll3dib/P9fDQ3TFj1qNkzUH9KrjxavpTFT
         VzQsYkNWEQf6IgnKG2ASpqpPdxk5nPOT565D/w+/RCdaJLX19qr+fikW81dcUfkiOjO2
         ROCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=behaMoZXOAC4lwbxpaU/IlHAo5C1UOxPb/xpbliQD4M=;
        b=CPpGGK3En9nGZ6isPofCWJ06bVMR/uI0XDhosPcmPt3NV+X0bL2RoiwB7XBkj7cCoi
         w2jgl7gMpgpNNQklf+XoqIBa8dyI++47wrzXAktSkOklz3jnvxRTsfqyWccDFq5UOTwt
         /VvDUU8GdImtvGy1Yd9qyId6gfiYggi5BxZNDv3y6MAjuOLN/KHnKb7+6XhrPrewlhhq
         BvQdmHiWDvjL42eHfSNOuSHTSNxOw5GZOF3/SG2Tncv2G7Zw/+P4gk738kP2S/HxZCfw
         Lh9hp62k9gOLqnUcd5dqkBnl1Ssb8xRdEeNSxyRHF2iNbtFilodiLWs6J60Bs+NIqBif
         31ZA==
X-Gm-Message-State: ALQs6tDG6fC8wxH666+emnh1cnKdtueYnWj0AjQf+Ne9IkYsX8xAC6Pr
        Y0h59Lx6GEgG5ciQtlzA6I/m4AUF+/ZcAv3qiL2b3g==
X-Google-Smtp-Source: AB8JxZrMB7pBS5tUXtGwCMf8zEE7H4c6BTntVAz+ch7SEOSx31jP4Rvp22SJl5yny0K4DGWkZdJPNJwe86fZsLBei7c=
X-Received: by 10.98.80.80 with SMTP id e77mr28238362pfb.16.1525459649889;
 Fri, 04 May 2018 11:47:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 4 May 2018 11:47:29 -0700 (PDT)
In-Reply-To: <20180503184830.11889-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com> <20180503184830.11889-1-asheiduk@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 4 May 2018 20:47:29 +0200
Message-ID: <CAN0heSp6_yYfz=tVdZFHMfzWFQ6nhmL8i9BGGF8mi5gctqfFNw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Some doc-fixes
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 May 2018 at 20:48, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Changes since the last reroll:
>
> - Better commit comment for "doc: align 'diff --no-index' in text and synopsis"
>   This includes Martin's `s/with/and/` comment.
> - Eric's typo fix in "doc: add note about shell quoting to revision.txt"
> - Added new patch for git-diff.txt with s/--options/options/.
>   This addresses Eric's and Martin's comments.

FWIW, this version looks good to me. I was a tiny bit surprised that
patch 7/7 was not patch 1/7. Could be just a matter of opinion,
probably nothing to reroll for. Thanks for getting back to this.

Martin
