Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6505A20958
	for <e@80x24.org>; Tue, 28 Mar 2017 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbdC1IQL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 04:16:11 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35255 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754638AbdC1IQK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 04:16:10 -0400
Received: by mail-wr0-f176.google.com with SMTP id u1so92031257wra.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PdBLulM1dBaxFM850ohwfpoin71n6bQ3qX0VFqBRJo0=;
        b=lEUAOxerXNgOxhEKJbvypYZjbDOSJY8s7Iogt4fbBZ5Ig3YQhiZ2GVa40nOkpVYett
         1W5QOalkKtfArTy7Z9JXAp8r36Wxb1CGEqFRm4LTJ9eYQCnBdZ/QLyWIkBJ6GEodMVYG
         U5seGlRZRTerVO76zfE2nzArf5lmqAAqtSeuX9x6/eVHgKFePwe6WC0RZ2LE8kXIf0Cf
         Ou+RsAR0BSO2xEoTICaaDw9shN3auTtTi+Ea6xjrn9MQIK/30EZzDsJdhGu8q7w/X6lX
         2WrIL1IQEURQExQsvA+/i/AIf+z/HUhsJVPFIwgI9zkAfSZk3fY/FQ0Sp4kAfUD6DSDH
         yWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PdBLulM1dBaxFM850ohwfpoin71n6bQ3qX0VFqBRJo0=;
        b=dInUYDQnXLOCRNElnc6QO7LvACuc1kTlBv47IuIMQ/eE23ianKKCWu/vmYQoQOW83a
         CPK/+KNHnQ70FZ5qEGdygDYtPul8cCnNyEDB157Q/mvUHvGsWOarF3uIHNGp9VS9IzNi
         +FL9fAbYA8Sqv6drgWvXVZw8BCXOgwQSG35Hq4PGKSxafQkuYnqHPl6N2VyySwc7lQY8
         22Z683ZLIRfKdWv4jCPdWpuDFTFsdC5IUGeIleLUAyRKi7a45lCWDuLPKRiuAN2K1nG9
         RW8gVYJUngcwbQ2pJuU9Ztg+0ikRKwi8v2YG5RAot6ioakec7nmFnidiOTe6YxAkcCYU
         qxaw==
X-Gm-Message-State: AFeK/H29M9G6EjUY61GJEigbclMxWHW0TRdfnEO+St2z6EdXuEhzvVrDfaqFey/eZbRA2w==
X-Received: by 10.223.171.11 with SMTP id q11mr17288841wrc.35.1490688935534;
        Tue, 28 Mar 2017 01:15:35 -0700 (PDT)
Received: from [10.146.248.53] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 134sm2557493wmj.6.2017.03.28.01.15.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 01:15:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2017, #11; Mon, 27)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlgrqz6ta.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 28 Mar 2017 10:15:32 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B29D8FB6-4BCF-4110-B70A-56471EA85591@gmail.com>
References: <xmqqlgrqz6ta.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Mar 2017, at 00:35, Junio C Hamano <gitster@pobox.com> wrote:
> ...
> 
> * ls/filter-process-delayed (2017-03-06) 1 commit
> - convert: add "status=delayed" to filter process protocol
> 
> What's the status of this one???
> cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>

I was about to send out a new round last Sunday but then
I discovered a problem. Believe it or not but I am still
working on this :-) ... although way too slow :-(

---

Completely different topic:

Would it be possible to get the travis-ci Windows patch 
queued in pu for testing?
http://public-inbox.org/git/20170324113747.44991-1-larsxschneider@gmail.com/

Thanks,
Lars
