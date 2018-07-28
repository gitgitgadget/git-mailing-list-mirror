Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECA91F597
	for <e@80x24.org>; Sat, 28 Jul 2018 06:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeG1H4E (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 03:56:04 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44544 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeG1H4E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 03:56:04 -0400
Received: by mail-yb0-f193.google.com with SMTP id l16-v6so2872568ybk.11
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 23:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g86hSJbSsTzD9Q/uxrFQIi06Gt5cp3rnHpX5lY0lbUE=;
        b=ox0RoolpdeYR1Rjd/d5j/kLCEiYx3bJdreBf8e0L3z6376cht4+EjjdIREkXuf5fxu
         W8QEO6xj5aLqnSYUpBqArpRuQWO5CkFuY1hncQ6xneKAZfkoZWqwYEIsnBzrpK+5Csxq
         REjSKdv/ey4gVP2LKHHqQF5wo+Yd+jE3my0AfmWgzHB0lDMmMKhQs4stwrtL8c5HH+aN
         cFrzRqXz2hp3YlIe2WJXnCrJm6ViNpHSMsBLowBj3PmgurPGiayQhS/GsyThSnqJGhTg
         Int5BPkWRJRbhDAD23kTwagOXQ25xkpVZ1tm4Dc0qRilwHtH6u05dIfbvSRukKHMSCVK
         ryZg==
X-Gm-Message-State: AOUpUlHlP9paVsEPC+1hYqgLv1fMmjfdwzkxYH0prbI3aMtC6trpCLnZ
        XCSCfM0C8gXJvj75g1YONIqwKNuPHSqfIjsU0ekKEg==
X-Google-Smtp-Source: AAOMgpdEA5iSdbEbpCN8tlRrzBqWGgfLAB6jBczU9kynpEK7ILhtfuJUNEk2hok6xX/vFYRTvjYl9B3lXq2mk0QZEjk=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr4845553ybf.287.1532759444089;
 Fri, 27 Jul 2018 23:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com> <20180728030448.192177-6-sbeller@google.com>
In-Reply-To: <20180728030448.192177-6-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Jul 2018 02:30:32 -0400
Message-ID: <CAPig+cR2Q2k6Dy6gvkpGt4_YtVVhFN1_nrJrkrHuEFD6zpWeew@mail.gmail.com>
Subject: Re: [PATCH 5/8] diff.c: add set_sign to emit_line_0
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 11:05 PM Stefan Beller <sbeller@google.com> wrote:
> For now just change the signature, we'll reason about the actual
> change in a follow up patch.
>
> Pass set_sign (which is output before the sign) and set that is setting
> the color after the sign. Hence, promote any 'set's to set_sign as
> we want to have color before the sign for now.

ECANTPARSE: "and set that is setting"
