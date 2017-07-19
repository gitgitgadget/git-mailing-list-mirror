Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ADA520288
	for <e@80x24.org>; Wed, 19 Jul 2017 14:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbdGSO1f (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 10:27:35 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34317 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbdGSO1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 10:27:33 -0400
Received: by mail-yw0-f182.google.com with SMTP id y186so1130174ywc.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=BrfVN21x/cj0vH0yesksr6f8n3XCcYsQPI9kSyjVD84=;
        b=XxEDX72y448ejMQftaspae4+t7DYvX1pH3FByCe8dbelU7HFG2+vbT0Jos0ssGzbeI
         Zf1kGw00qexyPUbrTaf24iEGvHszCmoSGNKmzyR/5BkndYcpsrtupZ2q8BcEryi1OwXu
         Q5VUrKREJbG6lUc+BmBwp+hfrBXVHpuVQTbGF3TzUJPqCmEUGJ5w0AIxHUoQ+SiYldSq
         L7ubIOFGSg3CUy+jVEAwVr3TcsZqFPOtwADkH83s66qds04aZ4KydiG1V1oWVlXsVyzS
         +jJpRoesJY5Mk4Ge/sLI3LhOX2IxFSFYhEaamdwrxHITjYTdthBCaPtlxYbkhdLANzF9
         PqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=BrfVN21x/cj0vH0yesksr6f8n3XCcYsQPI9kSyjVD84=;
        b=Jf2Uwuck2leA/5f7VfsDdVB2Pwqsu1dlLwn+FnQ9amxfqoOvh30c4qz2KhCNnp1EVx
         5oj++XHfkKRsY/W6PuNDlGVhmmOlc/STDkZ9R1m/7VWdf7b7dRe2DeBavxnWFsIYUkzD
         h57krdjue4OpKjuwEMbZ4RLPlizraUbpfj3T9/2cFwXjHox4tHCsJOnnIBjwr3u4t2q4
         DkYLae7EKbXCYeA0PLJVM/ELtvYtxAh2jeVhv8aZi+UotX7WEXCOU73fbpOe8Cofpdq2
         T3pHKaQFax+Av6XU5LzyAUnvas3OgOzv2xofShIP+Pv5OJU1K/+IrWPjn+MmAd5rk6de
         obLA==
X-Gm-Message-State: AIVw113wraR20Qr+SKpB1rD42XEAoX6EeIZJyt1rCrQQhaEoZG6VMgBF
        h0LcZXtZdBjNMdVbHli8M2JSQftb9tzXSeY=
X-Received: by 10.129.77.194 with SMTP id a185mr269288ywb.126.1500474452599;
 Wed, 19 Jul 2017 07:27:32 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.2.193 with HTTP; Wed, 19 Jul 2017 07:27:32 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 19 Jul 2017 09:27:32 -0500
X-Google-Sender-Auth: eDydiS53gXTKf0lRjUu7abvQxsU
Message-ID: <CAHd499BovefnyWjauE0vNaofmvL8JBZCSzJ7w-cJ8Sm3eoJ4=w@mail.gmail.com>
Subject: subrepo vs submodule
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I found out about "subrepo" today: https://github.com/ingydotnet/git-subrepo

I'm still reading about how it works internally, but what do you guys
think about it? Is it a more or less perfect alternative to
submodules? What would be a reason not to use it?
