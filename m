Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB429208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 19:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeG2U7h (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 16:59:37 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39046 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2U7h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 16:59:37 -0400
Received: by mail-yw0-f194.google.com with SMTP id r184-v6so3639517ywg.6
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 12:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Afmsj6MHV3ydd/whPO8yIC+UdIBhbspAKiqK0AOZk4=;
        b=YSLHEZqZNmFG/rNHmm1EENoM74/7/2YfWgsf9KqP3ksiVfNVF7SkfB5FERTk2hTc1Q
         oURIrhiS4OCwL9gQx8XnBBUl3l/mHjx9XvFPkHQOk8OGDMp23xNQV8K+w5dW7sVq6UVC
         h6zj1VuLBOho+87A5Rr4Gn6hr4M0mk2BhHgX47FvqrOi1qjoduPC8QytDN0VoxBN5BaI
         b3ftbRSwC/TLoKttatTAHdu0hC/t8NHS9EBJ+HH9i/+2f7knKvdwm+yexPXf44Z3+v1G
         1qjAQAtbbgJtANYSpfMwDfPP6R9+G89sKkrrvR0Tg6RKmAzG4dKkkEnq692RiTiVzeRz
         Me1g==
X-Gm-Message-State: AOUpUlGVbn/XnOJdSGDCmnOQnmPEnS1Xxe4/Kou9PA62ORCwAWiJMsUJ
        +JszF+67kXzmROSA97cEpkcN36JbcW4Iex99JTA=
X-Google-Smtp-Source: AAOMgpcS+or9VLRhvyTOTCaQbWjZp4NS1k6mocAnZY+uFkUNLWKapmBxktutYMyA2xBo47rAppK1dvKgEjII9jxfGVw=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr7568694ywk.418.1532892487339;
 Sun, 29 Jul 2018 12:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.11.git.gitgitgadget@gmail.com> <86h8ki89sp.fsf@gmail.com>
In-Reply-To: <86h8ki89sp.fsf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Jul 2018 15:27:56 -0400
Message-ID: <CAPig+cSrTnrXRdxRG3b2jatbOtgX6hJ_tP8QFmVbnnE57RETyw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Clarify commit-graph and grafts/replace/shallow incompatibilities
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 29, 2018 at 9:13 AM Jakub Narebski <jnareb@gmail.com> wrote:
> Sidenote: the GitGitGadget doesn't fold/wrap lines properly in the
> cover-letter.  Not that it is much of a problem.

Stefan opened a ticket at the gitgitgadget project:
https://github.com/gitgitgadget/gitgitgadget/issues/26
