Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7960C1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 05:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeDTFie (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 01:38:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40363 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeDTFid (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 01:38:33 -0400
Received: by mail-qt0-f193.google.com with SMTP id f20-v6so8359883qtp.7
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 22:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5bE/3ArZMVjmSS4yHnroQXUNa8t6MH5kgQ2uhArMFfI=;
        b=OVEC++Tw1LaJEK+Q2MWcT3UIJmrqhJ4xGgZJtA1qF7MW2+d++pjLeqcvQkvnCmwk/e
         bl/9RJOojchXN1mVTmSfsxiHXyjPKTEaI+jk5PNItLEXLnrnNXE52JAUZ+dIV0KjsJyC
         37TBXPE5k3J8tkdyCoCx4eHd14aHcwfck4SatyUb8YfRqtrxhiwnVnVbq4mKKpvxihI8
         OU9j86fXLNMc9KDX+puV8E2KIHwr/dwa9qLZP3uZ89PhlDfNIbwHwNS5qYfct1smzDrG
         YrXnH9YY3Oi1p+GGOwr/PV0GvwKnL4LTEFFkgtJpF+eAvgJKpKa/PKFmjKQLrrhTmuUG
         xq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5bE/3ArZMVjmSS4yHnroQXUNa8t6MH5kgQ2uhArMFfI=;
        b=IpnIHFmbkENf4y/ajH9L/uKIOvjNZJLLmgGi0UhIB60WnSRVBXRVV38wiwUSmJm27g
         lobtDx/kFfMmp3e8fkGGeeFOwEnfafpRaGMRCjxdIM3lFmmUszdVSMcBtqHZBEygBcqI
         KcwqvK1Nu0ASirWW/FpWLvwRLo5TFIin2vecQF8BS0BKX2APYU+MtGr+STgFrmadvTtO
         4+MXNNY4/2/6HLTaJbDZnInfzCeZFB8xIJIzLFJj2nlVk/fS2gIVljui+JH1xqr7x80c
         zQssAvNfIzFCqvBCvE8StSsd2Zbol9PwgFQozpQVPQiDrDEEMNjUasUiwzpfjNyx04eF
         1E1A==
X-Gm-Message-State: ALQs6tAr5hpgkfTXxESNEySVKh17HEnAEnOivEiuI80J0qlSOfCq5GAa
        Lvcg/i5hRi/iiba9LUcwgFl/gkRqnYScFFosgwE=
X-Google-Smtp-Source: AB8JxZqZneKORxSh0sS88t6if9hyQ/+hIbeM7PTLJN3L9xO2t2YzZgW5vrSy8CSmDvS9sURM+TPQf4K7g+kKqeOph3E=
X-Received: by 2002:ac8:22d4:: with SMTP id g20-v6mr190373qta.159.1524202712511;
 Thu, 19 Apr 2018 22:38:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 19 Apr 2018 22:38:32 -0700 (PDT)
In-Reply-To: <f3d13a304aa8586dd49a19947f09c00966590340.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de>
 <cover.1524139900.git.johannes.schindelin@gmx.de> <f3d13a304aa8586dd49a19947f09c00966590340.1524139900.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Apr 2018 01:38:32 -0400
X-Google-Sender-Auth: CM8xDjP8u2Mju1PdpGVbkdZQpJ8
Message-ID: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/17] # This is a combination of 2 commits. # This is
 the 1st commit message:
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 8:20 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> # This is a combination of 2 commits. # This is the 1st commit message:

Botched squash/fixup?

> sequencer: introduce the `merge` command
>
> This patch is part of the effort to reimplement `--preserve-merges` with
> a substantially improved design, a design that has been developed in the
> Git for Windows project to maintain the dozens of Windows-specific patch
> series on top of upstream Git.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> # The commit message #2 will be skipped:
>
> # fixup! sequencer: introduce the `merge` command

Bloop.
