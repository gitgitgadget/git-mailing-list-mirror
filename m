Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F381F404
	for <e@80x24.org>; Tue, 11 Sep 2018 10:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeIKPmM (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 11:42:12 -0400
Received: from mail-yw1-f42.google.com ([209.85.161.42]:36551 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeIKPmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 11:42:12 -0400
Received: by mail-yw1-f42.google.com with SMTP id i144-v6so3251285ywc.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 03:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iu7k8zv9w7EhwV1Zl670fVUIDvhL6h41JKejKibhBrU=;
        b=KZ3VO9Q8Fy5Plgo+PfKdPKmvScxS9U1+pfPZie1A8n/1hrUItcv5kw1KW3a4g798z3
         /DsazA9+jK4ai/uHs0p8yTEdyzgMMq3Gqd4i4rnOkJ0xe/XORVND/FMJbHlKLRjwv/Jc
         eYcF4AYN9uyOu9+r6hOvP0IBrq/dlcpd+ttbYu4ZOHN/PzjsaE1MZJaK7zrq0ZrDU4sa
         +zen+POMP2kBqRpTyU75JVXGWHcgO2cIfajNe7dcMrrYhp3Wu0mJdU4Z6JL/53XO5Zrg
         Lk5xdwv8eBqAxwOE4TWgSRm1nxM7mzxKrajDMNpI99ZwzcElyzMmGNiNnxMNO/wc9j+4
         9Txw==
X-Gm-Message-State: APzg51CKslNS2ewmKxkRm62d19rp2HsnW1FaKMeSkvTSHR+RyGZqjJZ2
        Roiax0TTLhZASIyDRM3oDRdxWWXmaxeeVSWGGpOJQwy+aW8=
X-Google-Smtp-Source: ANB0VdbzzK4FooaotC+9NbRA/z/5SBaPWfYn5Phhq9memawLwv4dRHzGRWRJUf7yLNUhDHPeyN1M5gqDe554OJL/qnY=
X-Received: by 2002:a81:ac27:: with SMTP id k39-v6mr12459925ywh.341.1536662606705;
 Tue, 11 Sep 2018 03:43:26 -0700 (PDT)
MIME-Version: 1.0
From:   Michal Novotny <clime@redhat.com>
Date:   Tue, 11 Sep 2018 12:43:15 +0200
Message-ID: <CANT8FXRbep_32-eeMSa0C1e6q6MUvFddgTUiUgqv54J-2c+iXg@mail.gmail.com>
Subject: with git 1.8.3.1 get only merged tags
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I need to emulate git tag --merged with very old git 1.8.3.1. Is that
somehow possible?
I am looking for a bash function that would take what git 1.8.3.1
offers and return only the tags accessible from the current branch
tip. Could you, please, give me at least a hint how this could be
done?

Thank you
clime
