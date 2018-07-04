Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302821F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 09:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbeGDJiw (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 05:38:52 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37736 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932652AbeGDJin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 05:38:43 -0400
Received: by mail-yb0-f195.google.com with SMTP id r3-v6so1857060ybo.4
        for <git@vger.kernel.org>; Wed, 04 Jul 2018 02:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gHd8lTtP7woNtMYbHAocrA84/sTBZL2Leuq+GNH8wA=;
        b=J+jKUThgVe79p97k05fmQsuHig0czROoTnmG5qkqXcMXYxk/yO9U18fUuSa7KqBcC0
         Y2MRDTMqnVrgpVj+0vi7TQNVh0VW9GZRp7tlj7cFLZ5yBsHTQYYNgdfcF0fGkDnqw1Yn
         1GbgLT59qxSMgmy2VFrghcsmoXxz6rYdzxWzQgXFmxhcB9I/Tt4ExsN23IlP5AjrsweJ
         07nOJsLUHgyq5gLvQLnYcX6GIq8I8cYj/NqghQNigD+CuDjvYZF1R241VQXnNKGtWa9j
         BXUChBVLlRPyt85aN6fMNxTky0fosugEIc5jU/Nz6ZQGwl2JLKCGH4jeiL5Ok0bRToTA
         e6KA==
X-Gm-Message-State: APt69E0xdVHeLAWkXFcQEgc5Sgbj3N+ieyvPa5c017c2A1MtleA9itoE
        so8W2qqo0bZE7W8ng6UqkzrO+Io9JmUyWiL4BLs=
X-Google-Smtp-Source: AAOMgpceoX5KgNOxHbqQJRpPz9IA9q/IbuNLTtUUtdtIM95DO6biIDfNNM3HenzpRBdyCl095a9Cvtv9YywzpbrAgEE=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr559456ybq.295.1530697123217;
 Wed, 04 Jul 2018 02:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <26b538bd-df59-d9a6-460d-0b1042b35250@gmail.com>
 <20180703235337.31770-1-jyn514@gmail.com> <368608dc-4351-541c-0236-9f5760ca5d97@gmail.com>
In-Reply-To: <368608dc-4351-541c-0236-9f5760ca5d97@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Jul 2018 05:38:32 -0400
Message-ID: <CAPig+cR4=0r5qRmKzV7Tzph49Ln0kJDAGtSMxF0BNxujwjeiWg@mail.gmail.com>
Subject: Re: [PATCH] ls-tree: make <tree-ish> optional
To:     jyn514@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 8:05 PM Joshua Nelson <jyn514@gmail.com> wrote:
> Is it customary to send a new patch or second patch that builds on the
> first?

It depends what you mean. If there were problems with a version of a
patch you sent, then you "re-roll", which means you re-send the patch
in its entirety as if it's brand new (not building on the problematic
previous version). You'd also indicate the attempt number in the
subject; for instance "[PATCH v2]" for the second attempt.

If you're working on some functionality that is built up over a series
steps, then you would send all those patches as a "patch series", in
which each patch in the series builds upon the patch or patches
preceding it in the series.

> If I specify a commit range to git-send-email it sends both, not
> just the latest.

I'm not quite sure what you mean.
