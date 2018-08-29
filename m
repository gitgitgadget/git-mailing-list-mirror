Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327B21F404
	for <e@80x24.org>; Wed, 29 Aug 2018 16:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeH2UrU (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 16:47:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40674 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeH2UrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 16:47:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id s13-v6so2531825pfi.7
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Q3AvYAxeIrFy0pLcRT/LqTSfn7IL2ydVlTXyKwfqeQ=;
        b=TmHPJd3MbSdimSEoAVMT7fm5WkhHHeqXa1gFOgXJebyRsup06Z7ywxkFYiiL7M701+
         C+zo5aCghsmASSR/z3Qz7Ib4pblxSG9UuKeindkdNNpcGcguQvc4w0LJ8EGdIalVV8yg
         UrucDfQVErpB4/Dqhhgjsa8lCVFE9BtqGU5+2jkKH6IaAowbiVAMq9mBlNl2f9ZamEbd
         4uqVjpL9C5BnlavgEdrx7oDgcr6t5Dr8LCgn3FxG0NIoXajLZYtjDszfozltBAwDSiF5
         +CthVMEefzG7bmCwbOGfJav/CR1l8hXYTtEMI9fZFz4BBhYGxzhOpJ85V48IpMmaPjPh
         AjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Q3AvYAxeIrFy0pLcRT/LqTSfn7IL2ydVlTXyKwfqeQ=;
        b=Sjq7gLBMmK2oDyH6Kha5S1hj3DCuEF+fEAZ6q8ChmPdLTPbRaPhRSt9u3HGadgZtN3
         MGjMSjBPWoeqZpgiXPel41lhvacfI8d440IO9LbiCDUjLSzSFLdUKPgwCkdYLx0dMn9v
         LAJKhU3hkgwoZ5n++vZcxz+dWCEaqFkL6lXTR+M/QG3GykrQ7bijwgqEh8iQ6VNZXryA
         /qvAN0oHPzp9AGBjSHEB+CyeANEcch5wrFm5PBpr6DcO2wP1Z1PBWawg5I92MJlYJ7GO
         epn+cuVioBIn18GO4AGTYjbSxhgn7RShSjmfq7MQYn1Q2hHFEhKTkzkx0Zh55q2tcVLR
         4efg==
X-Gm-Message-State: APzg51Aa4vSX6Eiy9rDuQD6RIdSt0dW5m4nyTN84sM2Wrbp7P9T/6qKM
        oaXQVt7rM9122jIrSUfWr2U=
X-Google-Smtp-Source: ANB0VdZUZtxLPdARPwz7B+Z70cGe99vYst2+NoOCJwDomet2zI3QRiDBnsDmNHuiv5LS1R6sZysIsw==
X-Received: by 2002:a63:352:: with SMTP id 79-v6mr6418331pgd.112.1535561372888;
        Wed, 29 Aug 2018 09:49:32 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h12-v6sm6195087pfo.135.2018.08.29.09.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 09:49:31 -0700 (PDT)
Date:   Wed, 29 Aug 2018 09:49:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: Don't echo sed command for manpage-base-url.xsl
Message-ID: <20180829164930.GA170940@aiede.svl.corp.google.com>
References: <20180828212104.2515-1-timschumi@gmx.de>
 <20180829134334.14619-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829134334.14619-1-timschumi@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Schumacher wrote:

> Subject: doc: Don't echo sed command for manpage-base-url.xsl

At first glance, I thought this was going to change the rendered
documentation in some way.  Maybe this should say

	Makefile: make 'sed' commands quieter

?  That led me to look in the Makefile, where it appears we already do
this for some sed commands, using QUIET_GEN.  What would you think of
using the same for manpage-base-url.xsl?

Thanks,
Jonathan
