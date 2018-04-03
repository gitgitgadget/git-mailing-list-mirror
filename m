Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF311F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeDCTEi (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:04:38 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:35855 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeDCTEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 15:04:37 -0400
Received: by mail-pl0-f43.google.com with SMTP id 91-v6so10157391pld.3
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15jRjZkjumQ2usxhoYv1S8UqA7TW53F0Xbs2ZOUqrEU=;
        b=bUjGj0Qpj+JeiHlCv4mVlPEp74eCdN2B9Psgf+WyexQ7wr8PEX/cjAq6Rve9hVDrEw
         3L+15bFSQQwkJ+sfiTYQYS7TjksL1DHB7v+dEuEFnTw7+xEoAHQnwuAK0mTGPEhhsm3L
         URhfFVUotxYpnjcg2vP7Vip6YdyJvylndRgSQwEhZj5Z1yz2qE0y7P3T3qXAPlAgcXVF
         iKOtebSEhc7ZyyADVilK2lrZDZXjNShyrZ2dLOv5iZ/duSt/B0mrDaOIM7EU5AnLD3ML
         U6eVKXUergVkCxMY0bIm60F8C0Q94bgiQpOUH+pVtXkXN6GjJOTRhG7SfJBRljKV4chl
         g1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15jRjZkjumQ2usxhoYv1S8UqA7TW53F0Xbs2ZOUqrEU=;
        b=tFoFSnglPN08GTc5TCREj2+n5sjRj67S6R0kQwQia2XAF9B2f9arZHJIuV4Rjlj2ev
         6P+XoXbg9gjhq8uSLHisnkbEs8Xz6b7j2ZQ5P5MV9NtcscEZon3k+lnI4mgKL+pt279x
         13ngP6nJYlD0P6/cvWqXRmXpC2vYPxDVKeKkLXwAjGSL+TqSYT/PKJJ1NMe8iLiW1xn4
         V/r4tvM4342tpos65Ky05HgOfRjQH2AomH/7ARRBLtvfufQ9s1LvsJwNwSXl01hRjOwF
         Tsw6HFPR6uRocsuWnsCkyGXIeqjFpT69mwbIoPDyldHKDScsGGQwz5iTAs8oGaF+R4Pt
         HXJA==
X-Gm-Message-State: ALQs6tAgJH6991LttJELhdnyMgQc5tVKiyjsQkNX9LiwnjUUAERTERya
        tU6R+ejvPyqnLljWknQmO9yuiw==
X-Google-Smtp-Source: AIpwx4/hTq7Zde+ErP6Fk9xGUSuT2qNHK6yuQa1iKRpab+cmHQlELxHzcHyUl83rOHXxz7ydrjX8lw==
X-Received: by 10.99.108.132 with SMTP id h126mr2707119pgc.150.1522782277018;
        Tue, 03 Apr 2018 12:04:37 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b3sm6515574pff.11.2018.04.03.12.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 12:04:35 -0700 (PDT)
Date:   Tue, 3 Apr 2018 12:04:34 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH 6/6] commit-graph.txt: update future work
Message-Id: <20180403120434.6153fb382d549b2521c06796@google.com>
In-Reply-To: <20180403165143.80661-7-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180403165143.80661-7-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Apr 2018 12:51:43 -0400
Derrick Stolee <dstolee@microsoft.com> wrote:

> We now calculate generation numbers in the commit-graph file and use
> them in paint_down_to_common().

For completeness, I'll mention that I don't see any issues with this
patch, of course.

Thanks for this series.
