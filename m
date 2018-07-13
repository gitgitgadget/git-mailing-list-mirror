Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4781F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 00:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbeGMAPH (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 20:15:07 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:33737 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbeGMAPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 20:15:06 -0400
Received: by mail-yb0-f202.google.com with SMTP id t14-v6so15510459ybb.0
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 17:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=HK7HGHtJePmrDd5fe48Go97HrGnPeKX73gWLlp9+xa4=;
        b=tQ7Utr8RHFLA6zTfzaTmE+0FWgDwdeYtLDZJzsMKQFvZ0UoAKAOqOD68yN4cLYjl8k
         NNQCkvxuIIGutCVVvi16jgFvoUJEPwmykpJDCYssabFMYV0FZ64ZVss6lv/mcLl51AFh
         s/G9QBY1KRF8yXwUMRiQt8iksNdGfdLOwsZhXqJsWXJqwO4oThJAxGHrHgCs4mOdIcG0
         jJOZdAwump49crghuTXkV2UIdW8cSYMQuaxjeCyvZ2o5NkWiKL7q6sPMtEBSH6dnfp1L
         YvTF86GnbNF9KfHc2J1icexxNTwWBaKIPLNsplYdWSvh38AvTFxzQeyfAfoxjgNe3yKk
         iufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=HK7HGHtJePmrDd5fe48Go97HrGnPeKX73gWLlp9+xa4=;
        b=S02uETcD9VvAEqyQuZcdawFN+GZ8w67VM3QuBwa3a/Hd2hDZv++4FHzL6vJdquat+Y
         oC10qrS91h8WvB1gLhpilhE8XaSq5TH063GZSE5cyFr9L29lc5WeRdgl1c23fdaWXAQo
         o1qMZ1bMoPCZJmmAAYOHX/4YiKljmJ6XpMvO6m9HgFehulDPR/paZ5QQ1S6VRm2NsmsT
         myWRu+IpvQeR+OcvFMA9q8eYlD1fNUSd0MEfPXaLncOJ9WiNl1E+ACAUykqdk8IXV7af
         bUQItK7mKrvDEYNRCvHak2ZyWn6wNQjCS1hahPk9ynCMqgKbcUnWsXyMrMrMLrX3ZKaT
         b/2g==
X-Gm-Message-State: AOUpUlExb0qMdJg9dgDXaAmyoCX3zVNz19d1kpao4+sbfjDx8Ek4OzHE
        0UBJtnKf0JHKDdmFU2FGZDSLvy33BcLGiltEmHRsGZW0rkMrzaMSxVyNzFK1e5L80AmJ6T4G05c
        rL4KAsJZTpMENL+vJ5TLGjPlWKIayR6KKbrQNATJvu5pzxxDWYVbpz+UtUwkRmD1unF6zKEeYIX
        yg
X-Google-Smtp-Source: AAOMgpdl68AK2xxawjoiG/HcD2BsTPVSLFapa79rPHIIBlcH8Lx0AP/RvXumWRK8TXvBOIpr798yyBw+FETESDK0y5Hz
MIME-Version: 1.0
X-Received: by 2002:a81:1253:: with SMTP id 80-v6mr1354794yws.59.1531440190152;
 Thu, 12 Jul 2018 17:03:10 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:03:05 -0700
Message-Id: <cover.1531438861.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 0/2] Annotated tags pointing to missing but promised blobs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are based on jt/partial-clone-fsck-connectivity.

The patches in jt/partial-clone-fsck-connectivity were motivated by bugs
I discovered in partial clones when refs pointed to blobs directly.
While continuing to work on this, I noticed issues with annotated tags -
that is, refs pointing to tags pointing to blobs. Here are some fixes.

Jonathan Tan (2):
  revision: tolerate promised targets of tags
  tag: don't warn if target is missing but promised

 revision.c               |  3 +++
 t/t5616-partial-clone.sh | 44 ++++++++++++++++++++++++++++++++++++++++
 tag.c                    | 13 +++++++++---
 3 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

