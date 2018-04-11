Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9EB1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 05:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeDKFdy (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 01:33:54 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38047 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeDKFdx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 01:33:53 -0400
Received: by mail-wm0-f46.google.com with SMTP id i3so1385646wmf.3
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 22:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=T4/LCTbpMkd1+sYJLV/+v8+ogshV+kiZ8snnX9vxoy4=;
        b=nWTwh/duWyVcaB6IXfNDr1T4SSJ6Tpq4Y/a+3/mPHqtjdxW/C3JEIuY/8JdaPSFfMW
         GCJ8wNi97iiDN/+/+NwvDdtggAe9NMgXPo32yVWspjpTAJSkMiDxH1iQYKnzRXXRjGob
         6jZiqogdq9sQ6JEAXv9QCXI2zx/A87GHlSegqaFh3pTtV/rbS9jED3TarcCzS6tAOV3W
         4CFWC+hzxjoWEZsQ5T7Rhk0gDDmfLfQw9X9LlmSUwVpMvz6LrFp7NGxrLcrHHTRarCYr
         0rKoxhnNRT10aldFoVCFBDWKMRZvtUYKeripzetVpf00GmF7POfmCdJdtcMwo6q8uFa+
         F5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=T4/LCTbpMkd1+sYJLV/+v8+ogshV+kiZ8snnX9vxoy4=;
        b=pV9FV/CEuCLTbsv9mmcvzQqTKho8pamFqPdsF9NhhzncW5fqr01SSv+7TmANe7PHa2
         aGqXv5SXb+tva2uLgR40dIUs8rItipQIvj+BlmHsrYoP80WyaG7vQgpMufP/1Url3pDF
         x/2X8T+5TCISVMqurJV8xKoNoBU84NvhJYgXtZI/ue9ZcE8Yh+CC851bOHKZTQVGI5kv
         VOL2kOPJ2kS8hPq4O+hqjhCM0KCPzgiUspxQkoVxdgNgAaIz7PxIgkhQG/9H6clKRQlf
         jcnLdFzxqD426bfbnaLVoFA2x73FKYbfV+e44fF9h5C9icb/dg/XD+IpK3G4s/2i7t5r
         xNkw==
X-Gm-Message-State: ALQs6tBRgblBSdsGQInsWEx20I/aWdqQo0DQWwP1EwQkU3GaOlUylxdE
        8GWukNsNiBLeYjbWBC6sxRv5FzD6
X-Google-Smtp-Source: AIpwx482uuIvg+29zy/fJ74CXR++EVVHmKkr63XS5cYoTDu6c6DAxpuPJH6dQS+QmiCj3sAiXUSM1w==
X-Received: by 10.28.232.202 with SMTP id f71mr1634102wmi.136.1523424831917;
        Tue, 10 Apr 2018 22:33:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 10sm423130wrz.58.2018.04.10.22.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 22:33:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Tip of 'next' has been rewound post 2.17
Date:   Wed, 11 Apr 2018 14:33:50 +0900
Message-ID: <xmqqwoxexq69.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll follow up with the full copy of "What's cooking" report later,
but here is a quick heads-up to warn those who have been building
their private editions on top of 'next' that the tip of 'next' has
been rebuilt, while kicking a few topics back to 'pu'.

Thanks.
