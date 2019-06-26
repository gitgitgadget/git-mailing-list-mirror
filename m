Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D251F461
	for <e@80x24.org>; Wed, 26 Jun 2019 22:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfFZWlv (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 18:41:51 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42350 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfFZWlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 18:41:51 -0400
Received: by mail-pg1-f202.google.com with SMTP id d3so113222pgc.9
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 15:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kpfSgIC/th8hAPRn6krdGOoThkyNH9LHOPXvFOeAEU0=;
        b=lPLNGjuYVcyb3TXiXCfMFdtuYKEHBRPhFtEsAxMAnBolncZ1wHXEZxfbebtGn+XjCe
         xu0LmR1Nu2n4yXr91RhG0yAFLix6HcH76pQJmKusX18qTrIfTlMicNZpOFcKMe1NPkrC
         d06q09MNhkKnT1RbyhTioTcfU/NRsCBsXcLwWajo8hBTC+8qXSDpvfpxW4ufQZ9LNUhX
         R2KgIVqEKjvMjRzK2iCTgRuAUeD9QAVH+Uu8tweVgVdg0y05weHUFhfJPJs+Pt42h5c4
         03dyYlg1oabFSS8gBm3Sz4i2PGjdWNRUPQIs0cRFfBmMkDhGpMdUm7DgytBXu0GFzZ8i
         R1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kpfSgIC/th8hAPRn6krdGOoThkyNH9LHOPXvFOeAEU0=;
        b=kJV/8dbtdnnHJBmQ1OLnv3c0v1CSkBDnsFczRwGTtmVPCwgFgMyn4kcMzit3W+mZ3I
         aebqHszCsaJlED0MV7loZQ5VZlNYPB9qlyPdO8SAfk9Ogo9925V4DszsBvCzdZIt+KZ/
         o7bwePZrlhk1LmcrxvPQ2dthGLAGP8k8YXF9vXnYZVC/mxcr6P/hQmB8FUwK+3uj8pe4
         x5iwltu4TopTrgJ/mMwPlJ3NOEXjm/4BeCjirDKfMmGqi/b/pi+5TQ+w+NIOeVhiFLih
         h7f+7szJ+1x5VBu0or8EiFG/dxDaaFHgwF1MD0WTfYdMbj+k7sFobStMtU2DohweEiCP
         6ing==
X-Gm-Message-State: APjAAAUgVRhEKAp9pe0tU36YuJRgjGGkWaWqpwoggg0jQZ8fQo4kW6xu
        bQUjuL0cTYnLbQbAYLyoFlpCXsiko6StsiHFr3ii
X-Google-Smtp-Source: APXvYqxlF6Z2nooHFzf3JpLfDpaVKs+mGfI4ScPhHv+QGnjw9izxmfwipZ930syGZASymjUX+wm+uU4iA8Zpv4wex2IL
X-Received: by 2002:a63:4518:: with SMTP id s24mr342415pga.123.1561588910349;
 Wed, 26 Jun 2019 15:41:50 -0700 (PDT)
Date:   Wed, 26 Jun 2019 15:41:47 -0700
In-Reply-To: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190626224147.75686-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, what do you think of this small patch that just updates a test:

https://public-inbox.org/git/20190605192624.129677-1-jonathantanmy@google.com/

For what it's worth, Stolee and Peff have replied and both of them seem
to be OK with it.
