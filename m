Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5621F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfHRU3b (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:29:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53522 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfHRU3a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 16:29:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so1236715wmp.3
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 13:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrGbVPc4Mb9Zm+uea8EKBvM6GLXFdvY7FcgWW4NJ3vg=;
        b=lrlpO9DVGcpBppBGmMnDw+RjTCxL3tsNipeDJ5Z9EtvJX7+D7JoPPGg/E1lBmf3iSm
         gGmUgT4EWznJCDTTd9IqcXRrjX/HwiWWr7uxfWFyuTqty8d9G3Z8ZrnawsYWQ20B3xFr
         2fBol3XPJHcJwDXgMbEM/P+c7du1dpnR9exoRhDzP7kTnplwYamr6VZ0llLZidS2tia8
         lKpMGCehrKK2kPkFa0juM8yf2y6aHu8wbUNpP7RvDwh7h/diLIOjEBkrAC6JAsUzLd/b
         VaiiO60GftFHLMV+KfUVQaWqzO2nl5UV1FUrQM7agYox/0uo1dmYz6E5KGDBBXUy6uwo
         xMcA==
X-Gm-Message-State: APjAAAXRy+sHGsOuug/Dgvmjj9pG6mBRft4X1NxKRu3eNHRQPyaQn+Ca
        vGEW373+NqXfIc0YYxHkJZZohLVbkTNTjM5at40=
X-Google-Smtp-Source: APXvYqzKdKGkgkzzHV8j5SSHwRMwf3IK4APrnSK+rXH9hOhELiVqGO0lawSbEAq0OMnssN4UFCaTXgKllg2ClvQ47Tg=
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr16940508wmg.120.1566160169153;
 Sun, 18 Aug 2019 13:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190818191646.868106-1-sandals@crustytoothpaste.net> <20190818191646.868106-14-sandals@crustytoothpaste.net>
In-Reply-To: <20190818191646.868106-14-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Aug 2019 16:29:18 -0400
Message-ID: <CAPig+cQkcyfWui_4jchtQ_=+_u-+N5uas7zGKdHB1=1mZCh39g@mail.gmail.com>
Subject: Re: [PATCH 13/14] t4002: make hash independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 18, 2019 at 3:21 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Refactor out the hard-coded object IDs and use test_oid to provide
> values for both SHA-1 and SHA-256.

s/Refactor out/Factor out/

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
