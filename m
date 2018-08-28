Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD59E1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeH2BTZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:19:25 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42534 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2BTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:19:24 -0400
Received: by mail-qk0-f195.google.com with SMTP id g13-v6so2028940qki.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3bHLN/z43KKEc4vUCBiUq9CCrXL9Q9CudSJZEkIZ6k=;
        b=egameU/7UGlzTxmMhFURWiVQupWbj8/HZhIJx7dqmK0D5rykY1OxTUUZwluYOnus9l
         HC9sKF/lEX4NBqZFjEYQTOLmwKhnUuqChv2f0CChPulElDf70cpZ1iTYy2XwJbgy9njL
         I09JiDST9oQumlRHTZtbTyVM2x8WeMjiWZncohNJJQGgHadrP6+z1e9oKCwRglRn0uOh
         9EkDGvwiLl5z01bdipR9kVMgIv8cTmZohmiIlHuCrp9yNHtuDibEkbfRc+Memj0F5mUE
         MUhji/KJZLa1ejdaDpQ6hkxs1uwemgGDweAD0NsvbHxSxkAJpngXWFOUfHeNFhWMMb2b
         5eUQ==
X-Gm-Message-State: APzg51B7U2G3nJpn6Zv+De6OILv4HaT6nfx0xWLu9wd//ywykQ1l4SJ0
        Mhy/7QUIDyR5mesPIbxak8/5FjPLmm8/kgq5rnU=
X-Google-Smtp-Source: ANB0VdZSaBakM2mQ1yx2D+til3jJCRvHn57WGaOQCSaCcm9NuOeg1oh6zhWPjVccW3jzEnNcZDF4K/lNmXbwhvSQofU=
X-Received: by 2002:a37:9306:: with SMTP id v6-v6mr3524619qkd.36.1535491553389;
 Tue, 28 Aug 2018 14:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180828212104.2515-1-timschumi@gmx.de>
In-Reply-To: <20180828212104.2515-1-timschumi@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Aug 2018 17:25:42 -0400
Message-ID: <CAPig+cRnPziVKe0pxqb+QTMTZCDvWvLfQUFLU53aYuOW4Mm52A@mail.gmail.com>
Subject: Re: [PATCH] doc: Don't echo sed command for manpage-base-url.xsl
To:     timschumi@gmx.de
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 5:21 PM Tim Schumacher <timschumi@gmx.de> wrote:
> Previously, the sed command for generating manpage-base-url.xsl
> was printed to the console when being run.
>
> For the purpose of silencing it, define a $(QUIET) variable which
> contains an '@' if verbose mode isn't enabled and which is empty
> otherwise. This just silences the command invocation without doing
> anything else.

One thing that is missing from this commit message is the explanation
of _why_ this is desirable. And, why only this command? Without
understanding the underlying reason(s), it's hard to judge the value
of this change.

Thanks.
