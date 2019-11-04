Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38FCD1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 05:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfKDFt2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 00:49:28 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:46712 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKDFt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 00:49:27 -0500
Received: by mail-pg1-f173.google.com with SMTP id f19so10519302pgn.13
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 21:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vLPhmFH0lirMn9kftpW2taUAg55QYbU+yuMOsULSwhY=;
        b=V8fsDNiCq7EMxCvkBUIYI8dLXDN5gKcbc41mHIaV4EG6U1VHznHJiZSxS8Ngo/7EWp
         HeHKfeCHud1qSafqWuJWYaECSU58AsvcSUVSVAU8DQagSdTwRCZXdPfjEBhxiEmiZPcw
         JJpv/bjiIfyxtPRfY26VKF0+mASokJp1p4XMAKCZ6QeHdmWDySCapFZsgEwFcDCvHocM
         81VV7DX/iMKkoLW+s9ZlA/rxgZkNs7bKYNdLZZ5mEbwoWD60bL9cXzRn7RNoVk572XLy
         I3oopnft+0gnEkVAOnseW54GtSY0We+BUvv+5oUVLLNfcY/OrfNnsJ2aaLQ7Utz5vcKg
         +NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vLPhmFH0lirMn9kftpW2taUAg55QYbU+yuMOsULSwhY=;
        b=AlqVqQmeKdkPZ+UvCHK0TEjS0wvD0vtFDNFbe3N2AC8sQ9Lsimeo8pdXXlB+Ltqgy7
         d+GEN2ab1s5Lwtp+YZEdVbVpx3a/FQqHsqwnYF0cfN45gDyC6CWVEn9YTXGeLKNXM6Y1
         P9PjD2StI4Zmmye7JJwU4B/8+axk0teasc8nESgAhhWr4P+YwGzKA9IgqnogOfawA5AT
         +OeSP/V6DHReml5XS/16R0g5o+l+QzzGBfiKQxNYq6+7YuCePgIA0gicqFL4FSLW2zfG
         79kVYnHwSD+LEXcsvDm1a3JVOEgNOOvoz/cO/OFBDGmCg8EzpVr/ik2EC9Tq3sJvnnat
         YptQ==
X-Gm-Message-State: APjAAAV80t2lN1EzY0PcrjH362FVMI/AC5skYG0uDGU+SRwl+3nnRIF5
        kikPWv8S8LTciAxtTTVGQS0vFg==
X-Google-Smtp-Source: APXvYqy2gMtZu93mAqoRUYvZsNfYPi1Lv07OqGl8c4eptZ6pT49OOU7aZV+cJhDYrFN7XVFd0q/UaA==
X-Received: by 2002:a63:b44e:: with SMTP id n14mr28270433pgu.154.1572846566432;
        Sun, 03 Nov 2019 21:49:26 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5975:7f6f:59ab:7646])
        by smtp.gmail.com with ESMTPSA id n62sm20828513pjc.6.2019.11.03.21.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 21:49:25 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Sun, 3 Nov 2019 21:49:24 -0800
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.24.0
Message-ID: <20191104054924.GA47418@syl.local>
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Nov 04, 2019 at 02:36:50PM +0900, Junio C Hamano wrote:
> The latest feature release Git v2.24.0 is now available at the
> usual places.  It is comprised of 544 non-merge commits since
> v2.23.0, contributed by 78 people, 21 of which are new faces.

Thanks for a great release. As always, your release notes were
very helpful in putting together GitHub's release highlights [1].

Onwards towards 2.25!

Thanks,
Taylor

[1]: https://github.blog/2019-11-03-highlights-from-git-2-24
