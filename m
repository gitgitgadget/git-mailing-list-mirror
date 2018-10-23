Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4668C1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 04:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJWM0x (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:26:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37914 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJWM0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:26:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id r22-v6so12490644qtm.5
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 21:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NK27hBXrR6smHY8FGW5hYE3HyVqoWNAU9Tg6+pplQRc=;
        b=ryOLWpk82utv4E059CJLJ0QbrSrVw+6Ul4EhT5cRILxjcRutxTGb52cmg2l8bMtimd
         noiASKidGA4dllOgyacfak9VNNapth6yZ4F1B4THyC93upSeABdwwwHl/7KFKS7DkhWP
         8n49KCHTVZQLrBD4vQHkDHU1smMLM4XHJd25K7BiJjoDbHlyeJYOgF+wYSY8Dm9sUsnL
         Xw8QUv28E2q2qHiyOO7HNcrQYWND/sowO9y7h217YUbwtVY+zfa1pil3UY1qqJK6gYNS
         HTe1MzcmJSK6b7Ksux05BbwEhB4dLGq4yPolj5Wf3jBG/uZZzaFDX26KpNRW2xjDa+UT
         AfRA==
X-Gm-Message-State: ABuFfoiV5sMWtrw7uXIHkeOEk+RjqGAOXRvmKbtw6pUJK3N7l6eRNbFo
        zMwOqIVgRwySoYQoBzBIguUPcB0ru9UozLI2slaSVA==
X-Google-Smtp-Source: ACcGV62zYAOqFra3rzUlw4IwUiyKuSDiAQ83j6TsfbWfkIu88omSJ5jDHUWHvcRROl3wcjnS8+PfkVsL23pqcFH6voM=
X-Received: by 2002:ac8:7519:: with SMTP id u25-v6mr47341859qtq.110.1540267521117;
 Mon, 22 Oct 2018 21:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com> <20181023035341.15398-5-ischis2@cox.net>
In-Reply-To: <20181023035341.15398-5-ischis2@cox.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Oct 2018 00:05:09 -0400
Message-ID: <CAPig+cQpz1c9D4-Swqaor1ddDB54wDaAjudKpz+MtRnChsyVdQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] t7500: rename commit tests script to comply with
 naming convention
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 11:53 PM Stephen P. Smith <ischis2@cox.net> wrote:
> When the test naming convention was documented[1] the commit script
> was not renamed.
>
> Update the test description to note that the tests fall into for
> general categories: template, sign-off, -F and squash tests.

s/for/four/

> Chose to not add "File" to the new script name as that did not seem to
> convey the current test contents for that switch.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
