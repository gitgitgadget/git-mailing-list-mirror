Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D4220964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdDBEZw (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:25:52 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33560 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdDBEZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:25:51 -0400
Received: by mail-lf0-f52.google.com with SMTP id h125so58478059lfe.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 21:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5U00oewVK3l8jGrg7Ix73CFRYOadgQlVMoyrOFqoMFo=;
        b=IUwtYqqIkkUz+Q/cP6lMxYGWgxr4qi12JSzugGSixiCOJev0v7PBMLRTLxvEz6SVaX
         yswtKhIUNw8qGKdOGiRAzUppkaC0SqaI42I3waxvgwf61myYEfifAIgcbefEbb57C2m8
         dWkcQ3Ge44pQqQW1hlKynxpbEf+2KBrEaJThgdtwYOPCJXrKDoQBYGtnWR2OrkzSy/xX
         aAdmalfRCsIKpfLgTgu4czw+GEb47AMlaS54/vwjIGctstIGNEsiWG9W9lghQoEpd9c9
         m7IGZQnvzVEFLYN4iGAcNTURUdf3rfucJagZgVDu+iE5q1bVlFN+m8mgfLNX/KybqukM
         QQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5U00oewVK3l8jGrg7Ix73CFRYOadgQlVMoyrOFqoMFo=;
        b=L30Pd6NcUzFdOkFwc3nWvPlwr3BnzZfK6RTR3yLh1BgQPRtXSXr8uxYEieOaIwHgOQ
         N5jgf8S5DE5V9oqmsdTz2ZtWV8tkwPMnY2lWCOmlDYSjQiY2dZAH7CQGmUYi+NoOAUEz
         Yi30l2ioB7t4ZXU6+CzezxCLQKnbuFxv+Dm4UmpyZ/p0xcA9p8RM0bcAtCr3c31SAOKn
         hiYZzF4uvj87JKcUAq4BsohAS3y3MNA5vLSnY/VZMOIUqk3SyGWtwVw6+wZgttz9lb/M
         QFnOK614eHPc8fR0UykYzQgXOZv4nUL6PBbGOkRzhyfhIrDkHvtLCuRVOe1Xnn4tXjLS
         FMvA==
X-Gm-Message-State: AFeK/H1OmMr1788m1lcY2NVSpHkgsULYKJXRDTcNyZqelbDVDeF4mypoNoXnl8PQbUUSR+srJ56apJI//C2+IA==
X-Received: by 10.25.219.213 with SMTP id t82mr3101060lfi.75.1491107150114;
 Sat, 01 Apr 2017 21:25:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Sat, 1 Apr 2017 21:25:19 -0700 (PDT)
In-Reply-To: <CACsJy8DBa-oH3i+5P=iVr9NhJwsicZ43DO89WmvpYEQu90RrMw@mail.gmail.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-3-git-send-email-bnmvco@gmail.com> <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
 <xmqqk278av4x.fsf@gitster.mtv.corp.google.com> <e412ef09-276b-92df-d2c0-0bf2f80238d2@alum.mit.edu>
 <xmqqinmr70uc.fsf@gitster.mtv.corp.google.com> <1751d788-d1f1-1c97-b33b-f53dab78ef86@alum.mit.edu>
 <CACsJy8DBa-oH3i+5P=iVr9NhJwsicZ43DO89WmvpYEQu90RrMw@mail.gmail.com>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Sun, 2 Apr 2017 01:25:19 -0300
Message-ID: <CAEA2_RKFwL8K=-QBYbmfbjJ44obB+PJit0pd5im0Jy_=E_-+MA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why exactly would it not be applicable to read_directory_recursively()?

On Thu, Mar 30, 2017 at 8:08 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 30, 2017 at 1:39 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> * DIR_ITERATOR_RECURSE -- recurse into subdirectories
>>
>> would make the set of possible options complete. If this option is not
>> set, then the iteration would be over the entries in a single directory
>> without traversing its subdirectories.
>
> And would make it possible to use dir-iterator everywhere (except
> read_directory_recursiveky). That would be really nice :)
> --
> Duy
