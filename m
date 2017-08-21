Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2657D208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 13:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbdHUNvV (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 09:51:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32903 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbdHUNvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 09:51:20 -0400
Received: by mail-pg0-f67.google.com with SMTP id n4so9034329pgn.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=c4VbM/BNZUQ9dspN8DVmSFy72AzgyOXL8y7HDpowZAE=;
        b=DkXAnszxA0l2aOgLPZ0kHuyD9XUPcZRjH3zUVulSt/N6GIdBr181eVn0kg9ETGXBE7
         XeWApVp7f6SBwr6pf2FTg0M+WxcgxvlI4YpVgpYthA9ok4Z8AFTgaMuuu+tRF+xcH5Y5
         60hiWa/V7BA8zV1l//awIL34wikMhO3Pd6E5CYqR76I6MeGDmcQl0P7n8iWpEo6lnFHS
         Q5vzHVaM30+O9inLrvdzqrR13JZcLqPKk6pjRtMDu7O3rl9rwsW2SHTfkgfTf88OFlLk
         LvSv1xwDsjrZRytuXv5D6jfGvzRj0vc5UxnF3Vmx7i74e90uVIVvyuRK0cZL6+4sdWtZ
         jbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=c4VbM/BNZUQ9dspN8DVmSFy72AzgyOXL8y7HDpowZAE=;
        b=iNu8GOq9j/j9+Z6U+yEDDKmrQDcTbL2BlLejTSrLpx5bIoFW0l1w6yJAK41EiKyk+w
         8Zeit0ZyJpi29pUqjgOXUNO7P1c0TyNFybifL2ukzDlxtIbUveWQ0jjkIIr8ttc1lIYy
         w9cY2i8moiuQHDOquo5CY4i3pqnT12QmHbUqCEOV7bKHNhSu3po5DmEw3cH/UHgX35Qi
         mO86agagINk9Sn8eFZqNlO2usVyhd9d81GJYqS0IGFq24H+tz2XVbW7o08BjAlPtzkYU
         BlzN0p0HFCRNgGrkwguidfaF9LOCVNqmIkDKMOb/pZIg1VUmzwKZTRgO+r5nRUjwACOu
         EDCg==
X-Gm-Message-State: AHYfb5hsVEDfV631RbQ2WXmJJ6Tx2ky6g5X2wJkgoIpR8Sl27ZBwgAw6
        uooeXgpYgRrInCCDtyU=
X-Received: by 10.99.143.11 with SMTP id n11mr13813388pgd.145.1503323479873;
        Mon, 21 Aug 2017 06:51:19 -0700 (PDT)
Received: from unique-pc ([117.246.137.117])
        by smtp.googlemail.com with ESMTPSA id o125sm25159375pfg.32.2017.08.21.06.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Aug 2017 06:51:19 -0700 (PDT)
Message-ID: <1503323533.2210.7.camel@gmail.com>
Subject: Re: [PATCH v2] branch: change the error messages to be more
 meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
In-Reply-To: <20170821133440.5552-1-kaarticsivaraam91196@gmail.com>
References: <1500107583.1850.4.camel@gmail.com>
         <20170821133440.5552-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain
Date:   Mon, 21 Aug 2017 19:22:13 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, wrong thread :( Please ignore this.

---
Kaartic
