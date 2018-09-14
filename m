Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9B71F404
	for <e@80x24.org>; Fri, 14 Sep 2018 10:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeINQCC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 14 Sep 2018 12:02:02 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:36774 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeINQCC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 12:02:02 -0400
Received: by mail-yw1-f50.google.com with SMTP id i144-v6so2434186ywc.3
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 03:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hcjtXqNu9rvR0j1rZ7b/eiRIxPZRsxGrllAaSU4VRvc=;
        b=f4dDlC8pLqLVo4tpM+SydMPsBTXnnG6s/rUccANgYzaGkdP5jVUGuNqjjFcROOWwP2
         wCZG5Kq2V7k6nNVK7KXzpfHOej95nMPMKkpecW25DFtNrdRjx3rmLURXunDLzL4Jlcug
         +ccAkMdU8u7Q/PF/uo1Tg0wfSYUHW856HSVe7v17Ilf3zhF4nn3yrPjOzqDPxsRoUGLS
         aSF6c+1hvot0kYmQt3DueDjm6ms32bIWJ1cN6Q6fUSPhWZOCnHEnVB7OiEksxrcoJl4w
         Yh/EGFLYwYIymK7kPe7SDRMvIV47qNXXeUwTW7J6vnz4S7rThxtI4F7WCghelqWuEqC0
         azrA==
X-Gm-Message-State: APzg51CX0yV14Xq33BHl6grOJbn8XArYgHO4yjQE5zw7SAcvsMMwZG3M
        cMQvPFbf9lrAbdBH5tRim+PmRpTaRAgDGlYrIo4sEQ==
X-Google-Smtp-Source: ANB0VdZ8MsSuLqfGZ2qJZQ03qR2Th9hDAsG8KFUZ8Mw7V8gO/MvMunxg7UC2FcsGhDBwskstjcp+xgbIFFjILR2qN4w=
X-Received: by 2002:a81:2644:: with SMTP id m65-v6mr5245433ywm.327.1536922086181;
 Fri, 14 Sep 2018 03:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANT8FXRbep_32-eeMSa0C1e6q6MUvFddgTUiUgqv54J-2c+iXg@mail.gmail.com>
 <87lg85ljsc.fsf@evledraar.gmail.com>
In-Reply-To: <87lg85ljsc.fsf@evledraar.gmail.com>
From:   Michal Novotny <clime@redhat.com>
Date:   Fri, 14 Sep 2018 12:47:53 +0200
Message-ID: <CANT8FXQrrgj=iVV0tX=MO9LH+=joQUfJmtDeACwyQjNT93e0aw@mail.gmail.com>
Subject: Re: with git 1.8.3.1 get only merged tags
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 13, 2018 at 1:27 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Sep 11 2018, Michal Novotny wrote:
>
> > I need to emulate git tag --merged with very old git 1.8.3.1. Is that
> > somehow possible?
> > I am looking for a bash function that would take what git 1.8.3.1
> > offers and return only the tags accessible from the current branch
>
> Jeff answer the question you had, but I just have one of my own: Is
> RedHat stuck on 1.8-era git in some release it's still maintaining, does
> this mean that e.g. you're still backporting security fixes to this
> 2012-era release?

Yes, that's exactly the case with RHEL-7.

clime
