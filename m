Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D52B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 19:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfCNTMy (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 15:12:54 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38675 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfCNTMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 15:12:54 -0400
Received: by mail-wm1-f42.google.com with SMTP id a188so3811141wmf.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=+dRJdcqh6pzaXMHDdv0zaTZdUPrpz2AkEb/PnsX0oFo=;
        b=Vtl4HxR2FIm49EElXv0RN9fORQEjtNz2HjYGGF6VrZbHNRp0xM0yGsLPF7y0pe+cnR
         hDuBKPa6RffEr1n1SiqQW/DHFW0wl+Y7l23cRf0hcCsgB+ahPtN5hUSkP00J6mFhqr7L
         wKj87Bt9obly2rcWE34WYidNtlvZ96jdgr+2jjtg1SDV7Efgl0ap+7qjIuv/inekfcvj
         5pJNPKe/T8AXIaVHhSppeSVeDjoCqBIHAbDgC97dPbAu/Xxj2ORkDU17EE8ggdyQFJj6
         qicgO96s2UrYPHTjXeQYcL4oMphQrg+zcP3p8on2dnwizTiuaeF4W/3UVY7qYOO/36Go
         asDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=+dRJdcqh6pzaXMHDdv0zaTZdUPrpz2AkEb/PnsX0oFo=;
        b=Ac75qE5d/7JhWa1Jx+ibmhkNj5W9TS2LpLwiiKuFHNHnoxPBzxT7susxX0vcvC4pS+
         M3mZwYXHd/1d0vG9R2V5vnO10dzr3F6aEUYh7rtghvtCXT3aq5iQef0ZEpW6WkiMkimA
         90x6B/h4gJ02OAYsMVuPW4IS8AToBekg0LiZg9JwWIDu2/TzCYJ8XGzRUjkGby4RPkcL
         J7FNB81BdccA0/lT3py411fI8LBNqWgKazmrJu9mpfVmWCXa0ZZq6XHA2XcD7hYmqlo/
         9hKNn+P8A5h1yn4CcwYeHa962Jr8FRc/36JWdePJV6XfKGYwmkpmKxwZE+hUTklh2wYj
         p40Q==
X-Gm-Message-State: APjAAAUP69uOxKdkHQqJXbqd13Un8uWW3+oRdoyjzUAYmriNQ0OhD5CL
        bPhR6vPDQOSaYJN6PyMvdt67EaYQr/Dhdw==
X-Google-Smtp-Source: APXvYqy55E0G0aJoDRpPIupU2+VnlNJPLEZ3vRHPu/0mp9WIFONxstaOZipR3K4Z2TkDGXUhkLbvIg==
X-Received: by 2002:a1c:2545:: with SMTP id l66mr39912wml.96.1552590772075;
        Thu, 14 Mar 2019 12:12:52 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id a2sm20328788wrr.60.2019.03.14.12.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 12:12:51 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: am/cherry-pick/rebase/revert: document --rerere-autoupdate
Date:   Thu, 14 Mar 2019 19:12:31 +0000
Message-Id: <20190314191234.25553-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqef7a9hbx.fsf@gitster-ct.c.googlers.com>
References: <xmqqef7a9hbx.fsf@gitster-ct.c.googlers.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've squashed the first tree patches together

Best Wishes

Phillip


