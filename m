Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4C020193
	for <e@80x24.org>; Wed,  2 Nov 2016 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbcKBPOw (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 11:14:52 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36730 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbcKBPOw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 11:14:52 -0400
Received: by mail-wm0-f42.google.com with SMTP id p190so275174909wmp.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=known.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=QK5f9BwHN5laL7lI2Q+46a+WeXA8emeG88lqNggUCdg=;
        b=Aq/i1CdzCz7twB9xc2JdGkAT4O9rvv7P+yk6HSlFdllMmmIjq9c2lZ1slA0fbM7/dH
         L6H8iULRjHzIAM9YC4NEP8799JfhwTveTtf1+YK95REnNyHIcBDo58d3wNYRAAU2JEhK
         pGXknOmr80a3IPMcR09PHqEebXZNaXbrLgiRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QK5f9BwHN5laL7lI2Q+46a+WeXA8emeG88lqNggUCdg=;
        b=NWAlrrLevgz4hFKNz7zOLnNNWyGpy0DrYW8R6DJn88Id7jkzKNOyEBLi1TCe+NTRUL
         DcwS0TEEJLqvFLN2N3X2jgcjcg/E4j2VqcI+3sojXg6KIOvIlazMAObY5+8p/hKxNemp
         6VDu6D+n5g1m1L2jsiFFgHyanYCgAwidEEKA1eu3W62ddeWWw+qPZz1yAU01LEtETzeb
         gWJkfFY0mLEapN0MxwM0rU6S8G4bVTIbeSWfi5bTmowj9wLfGHZIuKxCIwNGT0y05WLX
         Vy5D1q+IfoI0oe+pr3D0dCoWC1AO+BSiQRlZ8N30Lwg7k5h8vk8kS/LUr3c1ugFfhAKi
         Hf8A==
X-Gm-Message-State: ABUngvc4Jzi9LulNY6vMnGeZNgvwAV4lNJ2dJIxZERl7Rg4J/jW1tisbx3/eBsuNQD9Dt3xgIahJzpCdhDtuSKSV
X-Received: by 10.28.227.4 with SMTP id a4mr3632709wmh.84.1478099690462; Wed,
 02 Nov 2016 08:14:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.195.11.200 with HTTP; Wed, 2 Nov 2016 08:14:49 -0700 (PDT)
From:   Kevin Layer <layer@known.net>
Date:   Wed, 2 Nov 2016 08:14:49 -0700
Message-ID: <CAGSZTjKg1=tMYgFiwys=ePVT+3p6KTa1mQ0fP9pPns-Nvd+6fA@mail.gmail.com>
Subject: =?UTF-8?Q?How_can_I_tell=2C_from_a_script=2C_if_=E2=80=9Cgit_cherry=2Dpick?=
        =?UTF-8?Q?=E2=80=9D_fails=3F?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the cherry-pick fails due to a merge conflict, it just returns an
exit status of 0.  I have a script that does a series of cherry-picks
and I need to know if they succeed.

I'm sure this has been covered before.

Using git version 1.8.3.1.

Thank you.

Kevin
