Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3B920248
	for <e@80x24.org>; Thu,  7 Mar 2019 06:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfCGGFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 01:05:02 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:46182 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGGFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 01:05:02 -0500
Received: by mail-pf1-f169.google.com with SMTP id g6so10590099pfh.13
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 22:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y5ZPpWxhzMcNbnr34K81b5A1Uzwr/Ux9xOZ+Ynlb/DY=;
        b=iru0YT6q6paxYQ4f+5g92w5Ucd1LPJRRS4rsi4Qj+RHapyaAST/UD8Rjno2fQS7CI4
         iFiNJBtCaHBSlMaNMBhlfGBQwCdIbUIsOP6HTAVM5TzV/wtDUvQS8qW3932p2AAOZ/AF
         rJLJAvQuZ+5lJfL9qAIFmbY0GgZFn5ElIoLxMd3Tya+Qk2boYZ3KPXyd6w1PMmnTni0N
         21KfdU6iwg49moVz8tNtjTATKx4ln4+Rc3k0DQBuCRgDo9YTxKE11NuICqT6Tf5WbrR7
         N+f5ldQYS5f0XEN3Lgf9HM8j5oYqia6mab1iaHG5SxRDECOhrg2LF+EaNqqaG8yTQhpM
         Fxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y5ZPpWxhzMcNbnr34K81b5A1Uzwr/Ux9xOZ+Ynlb/DY=;
        b=cyGyIs4SWk3INUL5FyCOwiNhypw7Qpy3P6CnYH1DRru1WtfLuqDmzlwtTBR62h1Psg
         bNZtOz93YN/n3m3E3dazuAsPfZMBraqk/BYDZImHyY/D7qPYHRjSi3WUIx+I4ejFyEt6
         gqtNNjFqphXagLANDhX/w09L4WhWiPvtOGIbbSXCf2YMxTC5wB27Uz3CAXi69PB/kVEs
         z/ZW5SnDSd01Hf18dR1heS32bmdPwywcx210a1SLYqIqLbZLY6yM1qVBW7NWw+VF7xM6
         1+ElrW1agv9UXi2UGZ1fxhiOKjRXxzwVIqa89hPQIpt2YBvEPdR3Uj5AZnARqUqTdiWy
         3Djg==
X-Gm-Message-State: APjAAAULx5HRF5X1891wUBoGFGdf921ihXzdRhD1u0mci+vHEQK+t9AN
        /3m2LOXGAKZkUN5QQGU/ZDtJLB7O
X-Google-Smtp-Source: APXvYqyrNvEX0h/XIIYSYSFzp515fC7aHVyBn0SxCuWPffDtEHd3PAk/B/qTwvgA5vUpVjzdDr8ymw==
X-Received: by 2002:a63:f558:: with SMTP id e24mr9784163pgk.373.1551938700874;
        Wed, 06 Mar 2019 22:05:00 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id f87sm6344496pff.38.2019.03.06.22.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 22:05:00 -0800 (PST)
Date:   Wed, 6 Mar 2019 22:04:58 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/1] make git-clean.txt more precise
Message-ID: <cover.1551938421.git.liu.denton@gmail.com>
References: <cover.1551868745.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551868745.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert reported that core.excludesFile was not mentioned in the
git-clean docs[1]. This cleans that up by mentioning that in the docs.

[1]: https://public-inbox.org/git/alpine.LFD.2.21.1902231328560.2222@localhost.localdomain/

Changes since v1:

* Use Martin's suggestions of referencing the gitignore(5) instead of
  writing an exhaustive list. Also, sprinkle in some backticks ;)

Denton Liu (1):
  git-clean.txt: clarify ignore pattern files

 Documentation/git-clean.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.21.0.368.gbf248417d7

