Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05171F405
	for <e@80x24.org>; Sun, 23 Dec 2018 09:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLWJou (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 04:44:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42490 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeLWJou (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 04:44:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id 68so5735556qke.9
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 01:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLG12stwleBh4BMVCy/k1hEx66PnNPx8+Znc9DBjeHg=;
        b=esnislAQwzLjaeyv2/I6aL0TCyBcwGHM1hp9SGKbdIBNgk/4Fn936Us8MP3D4S3TXt
         ATwcc71RvoLYVbOQskQ9M2ZMQz6e/qj8N3V2+vudu+FaXRUTa4jwayjVNuPky0tFzjxD
         UKcDbxq1WBTbXA2kB2Jh67n7GfStpL1zYO7fNzPylqcG24/0cwhAj8IX/wsq30lyyF9t
         JT3s7No+LsWPf9ZYd2PRuSNhmdT+vrI1I1UfOb3qm5qNmdIhnCBEeM6dScZt1UUWsPFk
         rK7PZNIoKU0jc28gAo3smnYlA0KxTSXL+Xb0bmmxYr8XJp6ICXHZ16tK3ExpTWxOyMjz
         pZFw==
X-Gm-Message-State: AJcUukfiVFJug0GPyLj2vld1kZMfJ13ao0By0+C1i4Ir7k5NwaBZiAKp
        b25/ypfp7jCzNooDtE+PbXCtJXIzAEvTFUesv5s=
X-Google-Smtp-Source: ALg8bN4bhzULYM6GBza0zV3FdshFfmReCbuBB1l7FktbQ9BCBMWnoqXyFqR9VYCrCUPzFsl95Vsy6+9DZTnYGG2HACg=
X-Received: by 2002:a37:9584:: with SMTP id x126mr8197073qkd.36.1545558288737;
 Sun, 23 Dec 2018 01:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181220134820.21810-1-t.gummerer@gmail.com>
 <20181220134820.21810-8-t.gummerer@gmail.com> <CACsJy8B-jB6o2XYG_6UdTrhrGbos-+5rs98qqQQuJYYV+6W+SQ@mail.gmail.com>
In-Reply-To: <CACsJy8B-jB6o2XYG_6UdTrhrGbos-+5rs98qqQQuJYYV+6W+SQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Dec 2018 04:44:37 -0500
Message-ID: <CAPig+cSOyCQZXiG7sJWb12WzzujM-nsqqpt+cFZTFvXB1+-SVQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] checkout: introduce --{,no-}overlay option
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 23, 2018 at 3:05 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Dec 20, 2018 at 2:48 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > +--[no-]overlay::
> > +       In the default overlay mode files `git checkout` never
>
> -ECANTPARSE. Maybe "files" should be removed from this line?

Also, add a comma after "mode".
