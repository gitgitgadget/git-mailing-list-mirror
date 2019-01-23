Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E401F453
	for <e@80x24.org>; Wed, 23 Jan 2019 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfAWQAI (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 11:00:08 -0500
Received: from mail-yw1-f44.google.com ([209.85.161.44]:37925 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfAWQAG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 11:00:06 -0500
Received: by mail-yw1-f44.google.com with SMTP id d190so1086679ywb.5
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 08:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EC60+W242373OtXeaMC0qq3x3VGI4oxx0jnk7wiexTw=;
        b=VDESJ0mucb3P3j/7PvrnOjxWKKLXHa8Js2xmndOEwiawdvxMSz/B6bE6Qru4C2lpOO
         UYjqoU7a2fVo0EBYYXQZE8qr5ma80ibvQFa6Bkd2uOz/Uy+pg1CZkCTkV7GsPF6cO1eq
         i1cytpNS1QzVpNQE46XqGChIn5EyNwqpNvfhkadSEKSxn3tYxpcjLrt0XmZDSbue8rnb
         zKetAMDtNDAekE3B+1fBo1ysqmLr9AhOqisSlrB9iIwd/pHanZ0n+QFjMaAGJhY2EW73
         0WRJobcQHLdnR5vSWcSEYXSSuW5/L+KIIT4HjioJWoFkAzFHsikNsQCqshUTuyWJI7jV
         rKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EC60+W242373OtXeaMC0qq3x3VGI4oxx0jnk7wiexTw=;
        b=oz67vr5FLnIrUxgHFgwwVHf1nfoOzi96m6P9uCgLTa1Q+BturqQjFG7PJEVh4/fswl
         0gkzp7D68UMD+cY9jQcY/G5tY8LgXIyRAOho16SWWbZXAWWpXPWzsDdvWRKLBBMMVpvn
         5zXcL7f2sucIiWODrou5FLyIEAg9Nn4OBdRbiyk9Zs7xaLJ4ZXkaoKKvxUWCRRS/gZTV
         DMP/5TukB2/AgN0VivmfJeGmqUQnnp7jXs2FOim8YT6eRYx9UTtnp2Bz3fkcwLMD4DHu
         C7ssql7drlGNjIhhVKu4gU7yzqsz4E1SOtKdK3x/APfE7tVeMVmOzf5HqtMuTMicVcT1
         HaRw==
X-Gm-Message-State: AJcUukdRqTHL628yMGWbjRKL/eoP8FhWAvUUeNw7aUSCa9ZkKJuDIXLe
        kfaUMheqW9nW9xYavjltf4TkVA9F
X-Google-Smtp-Source: ALg8bN4lHxnnS0RBbCkuHFlbbrC93m+40PGseecdzpdSh/wXmLjdsdjue7xhY9TT3gCkZ9gs+0TslQ==
X-Received: by 2002:a81:5142:: with SMTP id f63mr2556784ywb.11.1548259205180;
        Wed, 23 Jan 2019 08:00:05 -0800 (PST)
Received: from ?IPv6:2607:fb90:7d7e:91b8:833:410c:b230:a089? ([2607:fb90:7d7e:91b8:833:410c:b230:a089])
        by smtp.gmail.com with ESMTPSA id a72sm12312192ywh.42.2019.01.23.08.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 08:00:04 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re:
From:   Christopher Hagler <haglerchristopher@gmail.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CAJLF3qjPyg9DKO29eYjqQaf0SZC8fJx-CMKMu29uxP9fbgqxXw@mail.gmail.com>
Date:   Wed, 23 Jan 2019 10:00:03 -0600
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2B5D23D9-FAAA-4CDE-8245-404EAC05F358@gmail.com>
References: <4FC35B6B-457C-4E5E-9B00-7C80F075963E@gmail.com> <CAJLF3qjPyg9DKO29eYjqQaf0SZC8fJx-CMKMu29uxP9fbgqxXw@mail.gmail.com>
To:     Cody Kratzer <cody@lightingnewyork.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Send the email to this address 
Majordomo@vger.kernel.org and it will work

Sent from my iPhone

> On Jan 23, 2019, at 8:16 AM, Cody Kratzer <cody@lightingnewyork.com> wrote:
> 
> I've sent this same email 3 times. I don't think it works. I'm
> researching this morning how to unsubscribe from this git group.
> 
> CODY KRATZER WEB DEVELOPMENT MANAGER
> 866-344-3875 x145
> CODY@LIGHTINGNEWYORK.COM
> M - F 9 - 5:30
> 
> 
> On Wed, Jan 23, 2019 at 5:51 AM Christopher Hagler
> <haglerchristopher@gmail.com> wrote:
>> 
>> Unsubscribe git
>> 
>> Sent from my iPhone
