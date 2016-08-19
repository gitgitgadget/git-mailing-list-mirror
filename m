Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0D71F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbcHSUgO (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:36:14 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34665 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755622AbcHSUgN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:36:13 -0400
Received: by mail-yw0-f195.google.com with SMTP id j12so1250421ywb.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/0I8TFdrZl413KuJvhmL4EeeGTr33e2LXLgeN5XGnk8=;
        b=fKmhfaiex3gHC7UHwEHy/AQSw9QwTzv1Ekqy1fBkTXfZ4wgeP6SYUYtuq/fcd0tSGL
         I4+Jfh4TCTIaYC1mLImomxTxCCNdqegI6hXGTjv3DFwrKj/OIwhu8uhKgI6gx6ONSbB1
         vIgxBOv/eSyNr+xCQuCpU3GDZnKN7gvdCreeSNHI5MdQB/DtabULXvlqTa2cO0ibyCB9
         aMCUwTBwLTv0K/caibmyTKxDT5q9oifZI8TzDyCGqIwU3+a00DYn8vfiB9lhsOIdeMrz
         LXPTXZy/3fDHSs6quiZDGt+ecviKcdRbDilJrcYxkabGPiSpolMczoJnIsbrFtOv+YVs
         A3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/0I8TFdrZl413KuJvhmL4EeeGTr33e2LXLgeN5XGnk8=;
        b=hFEffcF3JWb5Ckqc5hp+FRwo8foHQo9iERZeegw9wPgvzDNrp0+nQMTEHhHDzHOUFj
         8QxozFAtoholNgMTg3j6NQzxiPPWsTxn3zuMvIxRE+X6BDqYOaZceVbDjb4v6jVFMETg
         YChliXKjlUDhZERCGTqs9dZcOjuXYXxKi9ljs3ktyu513iZJtJ+FtX1XZe7Sy0/db6bo
         Oj8htYhvtVZfx2tspbd0YoFuyIi2ZZPsphstgTOafXcx5xIfEJVfwdT8LbQS38HKDZTw
         rR+lEGsUAB9Md8DJJO2kti17WbS234KPOWcm2G/WCYxLTd8dqQkhjg3UKHm5WgHioGYY
         nz4Q==
X-Gm-Message-State: AEkoouvX3Kk/OZBJWtWUgDjTipXEvMO/10NkMqEJEknX+M9k2m+zRn2a9UD6zLGi5Knq1kupoUdQQR2an+V9vw==
X-Received: by 10.13.197.195 with SMTP id h186mr7831785ywd.54.1471638972375;
 Fri, 19 Aug 2016 13:36:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Fri, 19 Aug 2016 13:35:51 -0700 (PDT)
In-Reply-To: <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
 <20160819000031.24854-8-jacob.e.keller@intel.com> <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Aug 2016 13:35:51 -0700
Message-ID: <CA+P7+xp6VDdMnh-srDzToSwh3mZrQei+B8DjpB2N6OkqAuARkw@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] cache: add empty_tree_oid object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Add an empty_tree_oid object which can be used in place of
>> EMPTY_TREE_SHA1_BIN_LITERAL for code which is being converted to struct
>> object_id.
>
> How widely do you envision the users of this symbol would be spread
> across the entire codebase?  I am debating myself if we need a
> singleton in-core copy like this (if we end up referring to it from
> everywhere), or we only need one level higher abstraction,
> e.g. "is_empty_tree_oid()" helper (in which case I do not think we
> even need a singleton; just imitate how is_empty_blob_sha1() is
> implemented).

If I do this, I'd also add an "is_empty_tree_sha1()" as well?

>
> Even if we need such a singleton, I think we avoid ".field = value"
> struct initializations in our code.
>

Is there a reason for that? I've found that .field = value is safer
because it ensures that you don't end up initializing the wrong
values? Or is it a compatibility thing?

Thanks,
Jake
