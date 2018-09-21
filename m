Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E154F1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 02:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbeIUHx3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 03:53:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33585 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388699AbeIUHx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 03:53:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id z78-v6so7390818qka.0
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 19:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjSw7jyOWv6HpJmmHXdFoVdNr52Ga5AQ0zh2p6r12xo=;
        b=OQqImcf/kYpeL3Gj4BaABiWeusZWM7UKgV5etFThoB2rD6dT3hI+AA3YMDF4+kJG0i
         788eFDO1D4M0t8FWe4anYBY+2oMmYV8n3FNWH3E0ZH5pyLPvsdXUVCQue08KjHSNVkux
         M5/hVb2dYU3rJdysVVYIRU1z7iyvaCFy8bNu6QxTWybS9kdYKIyUzxHYqUOdib3MbwJh
         Q8AEb+x1pRuLwuCFhXMBRiUGM/xbKEGAZ7hp5iZm6qLIPho8dAnYgKnpuyly1Xf4fZ4H
         g1oZLxZxxWkZ6g4hPX3DmXP6KeCxsHNH+D71/xx60tBXCXsVY8skTXc9ViTp09Lml9CA
         Nw9w==
X-Gm-Message-State: APzg51BQkQBSJFyj0LyM1s+fnjasGrj4HyJIDYlZAL3kVTJ7ItNJT0yH
        VyCg0Txj7IFR6Dj/S32LIzx0VDeyzMj5uu9SMD4=
X-Google-Smtp-Source: ANB0Vda17nf+8ubt7uP/USKvHD5p5Dv9ANffG9N0kbc/xD8a7AhzsdzpWDIh5WP0lJGlxstydl/uPagN1EcOMRmOacY=
X-Received: by 2002:a37:4653:: with SMTP id t80-v6mr28473999qka.314.1537495618610;
 Thu, 20 Sep 2018 19:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537493611.git.matvore@google.com>
 <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com>
In-Reply-To: <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 Sep 2018 22:06:46 -0400
Message-ID: <CAPig+cT2qMvT2LW482cXQpGnTmNw8KWsH3d0bW4t0vgJ3p59SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] CodingGuidelines: add shell piping guidelines
To:     Matthew DeVore <matvore@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 9:43 PM Matthew DeVore <matvore@google.com> wrote:
> Add two guidelines:

Probably s/two/three/ or s/two/several/ since the patch now adds three
guidelines.

>  - pipe characters should appear at the end of lines, and not cause
>    indentation

The "not cause indentation" bit is outdated since the added guideline
no longer says this.

>  - pipes should be avoided when they swallow exit codes that can
>    potentially fail

And:

    - $(git ...) should be avoided ...
