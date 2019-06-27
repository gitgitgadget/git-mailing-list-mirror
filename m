Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC401F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfF0FWX (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:22:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45298 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0FWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:22:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so860677wre.12
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 22:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOndFmX3iwRxKfQuVUkq3F3oF7XnsiBjt5wqrKIrLSE=;
        b=ZRa+woPRNCC5cidNURV43QKBsLw7/tCpkxvbsyTHNPe1Y534GCcE+ucM7pgoMdWNp+
         tB3vAn1EC3XzBylrgTYZzuG5rZFQRbAr8hDPJqnNPNCDdTgrZ8TTfXzou5L8zmS0oLnM
         3P+H5ZNAW4IG/OZCFka7ajLNVtEthkteallAeRcyb9jG/upWeOWKebxHZ1LlTuKegATR
         UK/ztCeycMoqZ0AqMW58gnYcA3pwLo2xwRlqBHDg+p5UiJaefbjrWBmiaXrVdNJpSEt4
         WWNlwdA/WSQb+6BezHcaST6el+0O4cfTE6++HhpxiPPwEXAOBLJ59dbWpLcMnp+mkgGi
         l0+Q==
X-Gm-Message-State: APjAAAWL2re7jUAN85D9paK3Gyoso5mtmqsh3brZWd7A/UHzoDWXE6Ao
        m0Ub59lkfy2LSJ3fWGndrOfIUnkSTQynfLHFD8g3ng==
X-Google-Smtp-Source: APXvYqwPqKQcuDHFVyia5MXdzHbTRVPhhgeR8iJxZUJJBVxwXVDF/A8ya9wFv/ikIF5us9qsKlbghkqUxsdUIUljwGE=
X-Received: by 2002:a5d:554b:: with SMTP id g11mr1262168wrw.10.1561612941288;
 Wed, 26 Jun 2019 22:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-9-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-9-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 01:22:10 -0400
Message-ID: <CAPig+cQGcNS476e+eDqyyfeVWDsi4=BGS=aTvYZ3=6BdP-0_Uw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/13] walken: demonstrate various topographical sorts
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> Order the revision walk by author or commit dates, to demonstrate how to

s/,//

> apply topo_sort to a revision walk.
>
> While following the tutorial, new contributors are guided to run a walk
> with each sort and compare the results.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
