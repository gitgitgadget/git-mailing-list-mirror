Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB44B1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 18:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbfJPSBL (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 14:01:11 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35316 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbfJPSBK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 14:01:10 -0400
Received: by mail-wm1-f47.google.com with SMTP id y21so3768589wmi.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=HcWmHUZNyIV1kT6ilG0pOi3mCXVIX8Ax0pkguJEtjoA=;
        b=dmD0JRbYKFz5EgnmFmCqwjxe7KbXFQQl6P2BH9EPRiqih7Ac7Rmluuy9TS4Z/HRSTb
         Xi9AUoM+1SOI4NQ2D3/u+ntUTpYMpLu1zCjD76Qzzd8yAK8kyMBTAUg4bxTN8nUbhBIC
         /WzQTS/sBMdkzqQFAbmA33yMvkQ7rl4Jz0ROptV6U4tvsuTulZDB/5RSelMYBxZgc8Sq
         m98/+ODGj+4dbkHkGbytOgl9K43x9pUJRJOreNTW/AXygdbL+7xLoj7fHv0nN4axxclu
         ZHAmFVkLMrQhvtj2/uYDKyuGrpAGyt0Z/xq65bDhmJaUurxxVRrnFCfphq9YeZFxlEgx
         RPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=HcWmHUZNyIV1kT6ilG0pOi3mCXVIX8Ax0pkguJEtjoA=;
        b=XzIV9e7pokGFa7t2295dRB+8Ado+AwhnVD6n0eF8emaRKvx3PYl2rgRJ5GjimiZdiH
         Sqxjw8HKUerSc1eVEA5ioexdL9fiySg6wmYXfkr+3XEXuwvbO8dOpjJdcEh1kJN/8LFr
         vZBT3RaeeSraZZ7m1wRk4+jdWEuqN8hSttsFWMcPD8m3dInQ0OaNwuAwKmedT9IZ1TDG
         QXEYrBH8BvNogiO339cKtLUjy43JqQRIO+yJjpvkWLc9b5+dQ1FH8Rv4emsWFEcLzeHt
         6TqYtUSM4Dxa9fw3rsT+YtZ24Fc3VvqdIgM8BzQzUZoC/zwQas4f79b8PolYlSuilCF/
         Ju0g==
X-Gm-Message-State: APjAAAUAglPh69XhYmJNlyhijYvkO7Yjif8T7xs67nKvfrCGffjYdYHC
        6y8f6DkmYiMXFXPYFh9UvBKL2y/lV4k=
X-Google-Smtp-Source: APXvYqxKBQsSTxJoXWnp5ptSG0qhnH0NOiIhx2wn7/myCZlcBcsFRj1EJ6HRhDNZH9ZLMw521bVHGg==
X-Received: by 2002:a1c:f201:: with SMTP id s1mr4292087wmc.59.1571248866878;
        Wed, 16 Oct 2019 11:01:06 -0700 (PDT)
Received: from evledraar (h53132.upc-h.chello.nl. [62.194.53.132])
        by smtp.gmail.com with ESMTPSA id u68sm4050290wmu.12.2019.10.16.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 11:01:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: My inactivity in git recently
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
Date:   Wed, 16 Oct 2019 20:01:05 +0200
Message-ID: <87lftk604e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, thought I'd send this to git@ as a public FYI. Some of you were
concerned about my inactivity recently, rest assured I'm fine, just been
busy with other things.

Hoping to get back into it sooner than later, sorry about not replying
to things I've been CC'd on.
