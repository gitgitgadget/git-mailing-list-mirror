Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A481F453
	for <e@80x24.org>; Mon, 29 Oct 2018 08:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeJ2Ri5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 13:38:57 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:37780 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbeJ2Ri5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 13:38:57 -0400
Received: by mail-lf1-f43.google.com with SMTP id a82-v6so5353276lfa.4
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TsrsIs4iMv2Vq1h4UnaP54i9OLF1e8RcPIyZeQKe+rY=;
        b=Cs4zswvLQFa1BBelN9pNXeoImj8dQ8Y/EIbxgmshPknACH7yAYzexMupyLmaSnH4rq
         nzjvuJ90KKioSkxvj27gRvWyh5tIi2iNW1H40x9VF+hsKbCYr1o6ghsdP9OzEGW/wrIo
         tWxvL96Iegy1jqS+OFFhT3O7gu76ItMrJbBFNTsVXXa+kgOBkYeJd3u9GEKgAa4C/ZlI
         jNLwLznbQBelJ7Z0bYvONZJCkZYmngBhxZzCm5Q2BN0HD+m36VP7wEjORHqDLKCzsw9Z
         LGx+wjwDsIOEF4K3l0LfS2Z82ybmICNzlTKPuP2QOtjOQ+DJ48fOOeYAvEOXWZGrO9gY
         Sy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:content-transfer-encoding;
        bh=TsrsIs4iMv2Vq1h4UnaP54i9OLF1e8RcPIyZeQKe+rY=;
        b=nSEk5UaQAOewHwmPGpEGzgCDNMdMIyt46U2i/WOJeqNLcG427pm3fSf9TCS5AEJdDG
         3odBwit7ZfE1VRbZ/9jVF58gtFB3MDg2lU5CqRKjBWismc5CDovw/8+GzMVOkbkjjAq2
         IGr4dvnZymk2mIO9SbV6Khy24vyb0Jw6zJgZIt37CHkEGJ5KFhn6RNUQTxGej8w2xtM5
         715HWo2pZddNlxySPD8Gw4Z3kJ7v8CTX7QKlRW1FQhBqcm1Ek8/mXCNRCTDYBhwMZ8Kf
         ip5iffgXNRKq2RSNtFqulFiFefYJjnkErcUd26lombAuqJKKfLAsfuLOCLrEXPLGnpjh
         E3OA==
X-Gm-Message-State: AGRZ1gIYl9VMwe7uIdq3SXcYGlU+UMOlzQrIFDqSHyt8TUGZVXWbgNlz
        U79eliOmhtMrnFB9bMI9ozwYO8jovadurvx1M56qVw==
X-Google-Smtp-Source: AJdET5eTeF8xeruJREhc+kPBO/uTO89EMmAW7D5VHcXKaEbCNZSvBsBccB0ps9rc1jvRWk+HRRKw5rTO77rGIsSEoEI=
X-Received: by 2002:a19:1019:: with SMTP id f25mr7440020lfi.54.1540803074913;
 Mon, 29 Oct 2018 01:51:14 -0700 (PDT)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Oct 2018 09:51:14 +0100
From:   Gray King <grayking.w@gmail.com>
In-Reply-To: <CAP1N1j7P83XVPx6dDGMSeRbwjdixAdBNZab=TP94=9LSfmsrRQ@mail.gmail.com>
References: <CAP1N1j7P83XVPx6dDGMSeRbwjdixAdBNZab=TP94=9LSfmsrRQ@mail.gmail.com>
X-Mailer: Airmail (528)
MIME-Version: 1.0
Date:   Mon, 29 Oct 2018 09:51:14 +0100
Message-ID: <CAP1N1j6NM-MA0FX7Bi-z7QGXGeFe2faroU5YhrvCWOBcj47QPA@mail.gmail.com>
Subject: Re: Lost changes after merge
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After merged, the latest commit(a008c4d580) has lost and the second
commit(a274b6e7ca) has been the latest,
and changes missed too.



=E5=9C=A8 2018=E5=B9=B410=E6=9C=8829=E6=97=A5 =E4=B8=8B=E5=8D=884:49:20, Gr=
ay King
(grayking.w@gmail.com(mailto:grayking.w@gmail.com)) =E5=86=99=E5=88=B0:

>
>
> Hello,
>
> I have a very strange issue described below:
>
> * Here is the tree before I merge via `git log --format=3D"%h %p %d" -n 2=
0 --all --graph`:
>
> https://upaste.de/9Pe
>
> * Here is the output of `git log --format=3D"%h %p %d" -2 path/to/file`:
>
> a008c4d580 c61f96eb5d
> a274b6e7ca 67c1000ca3
>
> * Here is the merge commands:
>
> git merge f087081868
> # fix conflicts
>
> * Here is the tree after I merged via `git log --format=3D"%h %p %d" -n 2=
0 --all --graph`:
>
> https://upaste.de/8Bx
>
>
> * Here is the output of `git log --format=3D"%h %p %d" -2 path/to/file`:
>
> a274b6e7ca 67c1000ca3
> 67c1000ca3 00bd5c8c89
