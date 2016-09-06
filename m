Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90701F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 14:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756613AbcIFOZw (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 10:25:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33529 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753966AbcIFOZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 10:25:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id w207so18796758wmw.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=dW+yZidt4ZNdOwaOnu3pDD2yciEiCI+YV+zwXx41RPQ=;
        b=U0fn3H+7VbUz71mDkxi4ORgFTqWonz7pian2ET+MWIvRz/8DLuyfrNaOisM7VW3ILg
         FDaGWVVRhYwbV52Cl5zMc6TrxMYkftzbfF5b0J9yd0B6dwNq+WUkqxIjPB5iHCodj6vt
         +0pZlDVZLBcsv7M2VaYamIReErQ/FuawQ3sugDiNiEROtcxZzvw1CmTG3N1xWN5Fe92X
         NtaQFQYEB1YeXuYVSDY9ipRozbzDRVgmIo2WZVc5gyBtyh6gmaPeJ0F4CGbp4ULA4abS
         1ZO2yM6bvEIZSPFelv61Uwg9636vS2zMBt6s2mbRu03aiaJZ7IdDRLRiGzY6iy6wu01O
         eCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dW+yZidt4ZNdOwaOnu3pDD2yciEiCI+YV+zwXx41RPQ=;
        b=cBVepJLLCKGXzyZ5AuyDTVMb4/e8rRslH5YKYjcGc7o83Poc8k5stdNs41Bm+fpyTx
         8vAsp1EvtUrJYpfn3ZFCnAEhcpT3sG/uW4r7+aRDMemqnKQCqc6JjQGg0H8T92dC8aCL
         8m9kdkdJsmHjb1MJ3rzM4wOe86JgblTeBajAHwyl1pT9O85zGIW/v1WK2mzRfZjncOqZ
         19dRJub5Jfg3IFPbUlNXac/EkrAVplU0xTQDfqGUZOJXuWlWkjEdYrHWdI28/4dd38Hg
         bVJXRpJIYAXGKc6nSBZhLTt4ZY9mkRJ1t1m68xMOgV9ySA7T398BEkgbFxvXrGfn2oZC
         IzwQ==
X-Gm-Message-State: AE9vXwPFOTiHNa/rrSsc82zWb2Lh2e7uGlWXkj+GXYiPJLxJsLqygys0HU9uZ0U4TJ118A==
X-Received: by 10.194.75.198 with SMTP id e6mr39465397wjw.31.1473171950204;
        Tue, 06 Sep 2016 07:25:50 -0700 (PDT)
Received: from [192.168.1.26] (epw136.neoplus.adsl.tpnet.pl. [83.20.64.136])
        by smtp.googlemail.com with ESMTPSA id q137sm26818050wmd.19.2016.09.06.07.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 07:25:49 -0700 (PDT)
Subject: Re: [PATCH v2 02/38] rename_ref_available(): add docstring
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
 <f89d56ef0841a3cc35689436c0b9473c6773d22d.1473003902.git.mhagger@alum.mit.edu>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <236a95a0-59d4-3788-9104-5ca299119e66@gmail.com>
Date:   Tue, 6 Sep 2016 16:25:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <f89d56ef0841a3cc35689436c0b9473c6773d22d.1473003902.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 04.09.2016 o 18:08, Michael Haggerty pisze:

> +/*
> + * Check whether an attempt to rename old_refname to new_refname would
> + * cause a D/F conflict with any existing reference (other than
> + * possibly old_refname). If there would be a conflict, emit an error
> + * message and return false; otherwise, return true.
> + *
> + * Note that this function is not safe against all races with other
> + * processes (though rename_ref() catches some races that might get by
> + * this check).
> + */
> +int rename_ref_available(const char *old_refname, const char *new_refname);

Just a sidenote: does Git have a naming convention for query functions
returning a boolean, for example using is_* as a prefix?  That is, shouldn't
it be

  int is_rename_ref_available(const char *old_refname, const char *new_refname);

I'm sorry if this is too nitpicky
-- 
Jakub Narębski

