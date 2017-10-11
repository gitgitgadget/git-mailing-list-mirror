Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA6D1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 19:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbdJKTOU (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 15:14:20 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:57174 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdJKTOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 15:14:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id z28so5958921qtz.13
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=UG5ye7OZDXVZN2I1K1hzR2DXjcP1E0sbbHSmn93DWHc=;
        b=C6nfPzxe87uqKAKqmThu1G/0/rrvI3cNQk+fueVC2AqqmIPJ1FGgueOUTo8VQWYbLz
         OvKRwehIGCLBmBGpzievyT0tjjsC7GApDbY0oMGTA4aFXNq1mRGSupx61mW8yQpQAhTh
         1EI9IjO2GS1txf1FC3b4DWgNjoGLX3GX7oSGLM2KLk8lgbaUHhyZJcUmEpvofxIJT+P3
         xAA9oFIJCom4syHrvQ0x3QmMZUWOQkVvGro7C9vq776QJdUdhTEjA0CoZ8ctyDu2c5GN
         dh6Hcm3A6c7qbOSaAUlaDU8KveHZ40eyxJJz29zZqpGmKCQvrMkD/H6UuUZ+8XYJ6Jab
         ofNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=UG5ye7OZDXVZN2I1K1hzR2DXjcP1E0sbbHSmn93DWHc=;
        b=Xx9mPCa9miUZAfGKAw6n8QvMGK2baNosFHg/HwciPdqhEx4NPv1ChfmVo86f11aHdN
         sUCFywbUAkxrOrWtRYtRcmV1saGev70maJA1W4bKrHaSpBRlL2Mmwu8umVdcGUQHFmaH
         fmNeTCDz1OEhHJhQVfH3FjGgQXd8ZDYsX6HCRalEjAF3VTC7uXOyyRljPi9l7Img3157
         MJQvIEYXtSTVViGLfksocIAWHFCAuzHmR/YlCINMNxbzFRLRkj1iUt3m26ssqIVFhXqK
         ba8/5jmu9mE3hsEIJgkIdVtE8eqZCsuFaSF+Xr0i+s4mMx4sUW4cHjKbSn1mdz+XHBbY
         PmBw==
X-Gm-Message-State: AMCzsaXTQN6AD/vqLMpq/Med9SJs0z19KfVTCyyb7YUy2yrGjVbg5xZm
        KKL6VDxOFNNX7imNoWKOP1WBTpTiq3E4rZSa+E0=
X-Google-Smtp-Source: AOwi7QBNQWWeZ+3xWeuDy0ZBaP0uXf4F8hv49Xv+MhYoGTu8eHpLBwFE80IAhB71TblByEMXEu4dBpbnasXt/GTJn/0=
X-Received: by 10.200.40.142 with SMTP id i14mr76599qti.326.1507749258538;
 Wed, 11 Oct 2017 12:14:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.32.226 with HTTP; Wed, 11 Oct 2017 12:14:18 -0700 (PDT)
In-Reply-To: <CAC2JkrLfcUzipRPhUHiVEMipsPVcia6ku+QK7OwMJrME-JtAzQ@mail.gmail.com>
References: <CAC2JkrLfcUzipRPhUHiVEMipsPVcia6ku+QK7OwMJrME-JtAzQ@mail.gmail.com>
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Thu, 12 Oct 2017 04:14:18 +0900
Message-ID: <CAC2JkrJV7XdRyLiu3fTLZmLSJzU3GX_2rr6sQcUx-w0-BZ7f1g@mail.gmail.com>
Subject: Fwd: how can I conform if I succeed in sending patch to mailing list
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I found a mistake in documents, fixed it, and send patch to mailing list.

Sending patches by 'git send-email' with Gmail smtp seemed to be
successful because CC included my email address and I received it.
However, I never received email from mailing list. Of course I'm
subscribing mailing list.

How can I conform if I succeed in sending patch to mailing list?

Takahito Ogawa
