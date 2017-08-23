Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EB8208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 00:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdHWABB (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 20:01:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37282 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbdHWABA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 20:01:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id r62so173881pfj.4
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 17:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XFE62jDS/t5OFLJRTPaxXWwzIJIzxdDpACsF6NRvRpY=;
        b=GNaIBaQ38Ia92UJXJOmzk0Ws5WA0hxGYSMYYs1aYOQn2B640rQLDCiCCJIs2LPHpq3
         iQrM1R3K+BEZiEJiMDuK8LRqFICkQNO/4aDFekK03ak68Z/XmO/ghJ4qq+DTw/1O2vsS
         r7KosJBHX7D5N9Qov/s/6RoKweRkU77jYWuAj4lzy/H+1vgUJA5kG90fQ2SCziBXQm8t
         L0JmtTJiHElOZh29bnhkUVmi6cobMdp2ok2DkwyjR2HXD/t66hVNr5x/osLy+1jmKmev
         Q4Uw/WQPT75p2CLwi7uZCXbiKEMLZkZaitw1hOkOthNeOqdw1OOv2WpXMck5NZ3cmdwH
         kqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XFE62jDS/t5OFLJRTPaxXWwzIJIzxdDpACsF6NRvRpY=;
        b=ReOKPgDLr1SSKyERrsXriE61I60Ujucu9y9QuC+DPdUk3ozDFFPVFyLvWpDGCIg4yf
         BC8s7ZqSspLJKxbHp5qFXCR+uWnCE3UzoqA8d43RqI/sBupGus+g2bAOyoiXng6u7KLm
         bvkMLv/ykp2nd3RD3YHC/vSwhiXvXQLKxaGUQDmcnH1EJ3Y/EL0yCMA9WmlCABBlZbWq
         uzfW+82c3y98BO69F7PdptAjEr94xvss1ZAPU8CJ49GoHBoPa+b3pi7ZZZ3+dJI0Ra57
         fkyGSD2JL9jqRenbevCnxVHP9pACq1utozBj9Z64RNQNYBak9Mw63yVtp1W3Cect1soW
         fJpw==
X-Gm-Message-State: AHYfb5jbPv5HpT+ypInrxU5RqBqGWjRMXyqMGdX/KhySOWVGy1uFCL6g
        h9xpDjurt9vPLxHmQIA=
X-Received: by 10.84.132.42 with SMTP id 39mr940615ple.448.1503446459625;
        Tue, 22 Aug 2017 17:00:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id i188sm185710pgc.0.2017.08.22.17.00.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 17:00:58 -0700 (PDT)
Date:   Tue, 22 Aug 2017 17:00:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] vcs-svn: remove more unused prototypes and
 declarations
Message-ID: <20170823000057.GE13924@aiede.mtv.corp.google.com>
References: <20170822233732.GX13924@aiede.mtv.corp.google.com>
 <20170823000007.GD13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823000007.GD13924@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to remove these in v1.7.10-rc0~118^2~4^2~5^2~4 (vcs-svn:
eliminate repo_tree structure, 2010-12-10).

This finishes what was started in commit 36f63b50 (vcs-svn: remove
unused prototypes, 2017-08-21).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 555b64bbb6..0d3bbb677d 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -1,14 +1,11 @@
 #ifndef REPO_TREE_H_
 #define REPO_TREE_H_
 
-struct strbuf;
-
 #define REPO_MODE_DIR 0040000
 #define REPO_MODE_BLB 0100644
 #define REPO_MODE_EXE 0100755
 #define REPO_MODE_LNK 0120000
 
-uint32_t next_blob_mark(void);
 void svn_repo_copy(uint32_t revision, const char *src, const char *dst);
 const char *svn_repo_read_path(const char *path, uint32_t *mode_out);
 void svn_repo_delete(const char *path);
-- 
2.14.1.342.g6490525c54

