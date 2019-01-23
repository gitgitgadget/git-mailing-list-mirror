Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36CD91F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfAWOQk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:16:40 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34889 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfAWOQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:16:39 -0500
Received: by mail-qt1-f180.google.com with SMTP id v11so2490237qtc.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightingnewyork-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHiBDSiQbL3qmvbjE/SQ7t8ukg53iU+cZH44QKRwrr8=;
        b=B9Cf6YDA+zYeXuGIQ0yADvwtaG2mprDA03y/Fdw9eIAOOooQtSo6xdYRQ9NYfBNjF6
         vj6bq5/3zUmwQHW/EKxyxI8GdC7LSupB9G9LJfhw9hpuPD+7kFrQt8U3u9i2YvhrAtf9
         7e3xOX+jgovnCgXSlIX9s7bH2VLMemSUhEsLUAooW8tVBbRcdu3q35p6X+Wffxjew4Xo
         GTJCuLPKIeQGqIIbn/QSMe/AANEKUyR6x+9ib7s3fWtkfFLUdcc+FaT/gOoDhooYdrCQ
         QfGgqj1gYnXE9Ri8xgxJanxwufU1vlQfsMBUKQcMxFdRgiSOBemWQ60Tf5ext/iPKDEf
         uOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHiBDSiQbL3qmvbjE/SQ7t8ukg53iU+cZH44QKRwrr8=;
        b=N6+gFu7Q66xZXuMq0lz2KvDGnIH7C2W2pWSYXLbwFjoNDaSG6frtTSAeaPZ9/DV6+y
         Vvsp4rDw4htZL5wpuHiA7e+io6yyJrH0u++ZHFZ6mqgffqwWmNK2+Axp0zh7zdy89mL1
         yJUI/WTeMu4YbRF+HszE1pqA5dDEvfoIMQ3fv2E0FSgM9KNoe2o5pJzBnNDo7FqsVZ95
         a0mBU+zfVeD6+hVRP7KRiJ0pfFcQtAYAdLxNgE4n5t0xCxcIPDLwfaWduXRe8pUZuP9z
         Rsv24XFwrwYWPFsf1osb66LgdRPLXZNMBGbYdu8o63W62PKTUzLdKi9/milk0mbUfWg/
         6Xrg==
X-Gm-Message-State: AJcUukfUJAZxVarBhJ+mEztPflNpX0SEb9wfBh2JefhO64//eIF/h3Ls
        /jt9ULqALeaixYn0k2AKipl1kLEfnpScvDbS09be/g==
X-Google-Smtp-Source: ALg8bN69i7lZviqjPdWoXN3fUg9F6rL9x2jXidAbPZslvEQZCLls/FpLY1j7AGeY4zTC/okFvLNBeZDKin5NuLVi2ww=
X-Received: by 2002:ac8:5344:: with SMTP id d4mr2423687qto.372.1548252998818;
 Wed, 23 Jan 2019 06:16:38 -0800 (PST)
MIME-Version: 1.0
References: <4FC35B6B-457C-4E5E-9B00-7C80F075963E@gmail.com>
In-Reply-To: <4FC35B6B-457C-4E5E-9B00-7C80F075963E@gmail.com>
From:   Cody Kratzer <cody@lightingnewyork.com>
Date:   Wed, 23 Jan 2019 09:16:28 -0500
Message-ID: <CAJLF3qjPyg9DKO29eYjqQaf0SZC8fJx-CMKMu29uxP9fbgqxXw@mail.gmail.com>
Subject: Re:
To:     Christopher Hagler <haglerchristopher@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've sent this same email 3 times. I don't think it works. I'm
researching this morning how to unsubscribe from this git group.

CODY KRATZER WEB DEVELOPMENT MANAGER
866-344-3875 x145
CODY@LIGHTINGNEWYORK.COM
M - F 9 - 5:30


On Wed, Jan 23, 2019 at 5:51 AM Christopher Hagler
<haglerchristopher@gmail.com> wrote:
>
> Unsubscribe git
>
> Sent from my iPhone
