Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724D81F790
	for <e@80x24.org>; Tue,  2 May 2017 18:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdEBSlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 14:41:09 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35304 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdEBSlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 14:41:08 -0400
Received: by mail-yw0-f175.google.com with SMTP id u70so74419842ywe.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=u0ixqVNmmtnYHk29bWudPTrbTxk+kkUlx2ANqB4Hm4o=;
        b=vgXeqgqcYX7arMFlv/5gH6DYyI/bPkIBfN+ponZ58Er0DI30Pt4f8mBgLZgl3vK4K3
         5kz3GVbIqM1NtBBtb2wvaDviFjs3WzPGRfdeReDBqlpRxnTcrO0DBjOF3l/f25Fq7uuN
         4+wgNWNNAktorQzW+C359CNvDX5Z3syngsBy/YAp/eek50dCzbReKVl7U/G0JBgWjYse
         POm+NSMD6CT/66a+YooKmRc6ep9lk1bglc9aEgGqsO5kQ4QYOUPCxXIeLPdF3fHl9hPz
         9pWzTpX1N4xxKM0lG3RiAEhn+pkJodKEXqMHjn03HTFYwnxaVvRAUebJLkjkfABRWUOF
         0vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=u0ixqVNmmtnYHk29bWudPTrbTxk+kkUlx2ANqB4Hm4o=;
        b=LnqHgBlP5ttHkH+GNGA2QZ3lr0D3qrduG2hGbSEmF9oaj6oeSe6in7ttkzIenhtv4Q
         ia4h4lLHUN59YyVu0f2VLHRBmo0LxjVqnYHnIdSe01n9pM8w/jAHEe7z6C+R7iP30y+X
         yQ2zMBW6Kqbhvjhm25q+OzhjMNDIJz57PDklDuJYIndzGQrB1AORQYAEenqBW1DxUeKM
         bjinRaxMyNEfBCpWNJmD1VLfv+oizSeAQMQsI5wNcUxoZmYVhTuLtlXxawsEXvn71Sk/
         3fHKBcbcRdi6k+ZPSSelcx2X9ziz+7zxM/VM05F2EwOW4ZPkHvhGDEYRfXrkeebqPbxk
         pavQ==
X-Gm-Message-State: AN3rC/5RRq1725TVkEux+QmaXcaTVqpyF28CTeCoVf7TCYklCvad6l9M
        SmREwZi5XIdU/7yAyi03iW+YL7jQoEWq
X-Received: by 10.13.216.132 with SMTP id a126mr28322733ywe.5.1493750466938;
 Tue, 02 May 2017 11:41:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.161.228 with HTTP; Tue, 2 May 2017 11:40:36 -0700 (PDT)
In-Reply-To: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
From:   ankostis <ankostis@gmail.com>
Date:   Tue, 2 May 2017 20:40:36 +0200
Message-ID: <CA+dhYEUYRc1PDio_JO=OPxwB+POTd2fOooTx1nKJFkUGqYK_Kg@mail.gmail.com>
Subject: Re: CYGWIN git cannot install python packages with pip
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that MSYS2 Git-12.2.1 also has no such problem.

On 2 May 2017 at 20:08, ankostis <ankostis@gmail.com> wrote:
> On Windows, with Cygwin-git 02.12.2-1 the python command:
>
>     pip install git+https://github.com/...`
>
> fails to work with the following error:
>
> ...
>
> Git-2.8.3 had no such problem.
>
> Any ideas?
