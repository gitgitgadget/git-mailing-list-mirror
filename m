Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88FA61F516
	for <e@80x24.org>; Fri, 22 Jun 2018 15:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeFVPtg (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 11:49:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43333 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933762AbeFVPtf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 11:49:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id t133-v6so6512481oif.10
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EClFoOr4+snQ7RXM7/RrWNAHL54KLX7ez5iZTGi2R4g=;
        b=inAF1JXrQwymHZWp9hLGpEQmwJBxULUXBJHtlxf0E9k2i29xh6Es/lQwpcqTi+k7C3
         c8l87u/ALizoEwe7u9p+PuS1FIASJE8TtjGtWE7viFcYeofZWG1g2cvkWKWIS0ZGZIep
         +xYS4+MJ1dFYCuQ0e8gjYlEQIs8tgV8UvAAkXtVnNCUQLHsU3fu9VK5yGEzIryfPEBQ7
         s+F5gDv+OhFhlJ4rBfCCbXUs9tkXNYPXHla8YXQTA9XoQqNphdjGOmaSXCznWsSit0nt
         U6igMb85Da1GcvDvEn+aGeJm7DRZ+TyZxdXRvgX3eDFL4SqpJ1sm5W0QpvEOTTuXCLU9
         bZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EClFoOr4+snQ7RXM7/RrWNAHL54KLX7ez5iZTGi2R4g=;
        b=jq8qjzIkzWzazLGdA2BGNOdGroPYkfzVev5Brtxklh4TdTSO7KwLyu4Dhhdf7wWRMV
         CQFnWLk0vMhE61iYUymUPPa2kqt/lrQbWRBLB95b8DLNvQj193aER+LeSm2uc9G65eGl
         0Y73eXr6zysqd0Bfu+ccnae5jb4sjWQ2YpTD62bS+nlNpbqNXKDV1edeFV9B0SODIAb6
         6tfbwW3k+/iN+HcwYEFzCX676iZk2ZJnmjMSPHRARdxXuByZH38OejNKBQEMSPAHotRq
         qgdYArQlMpFESExgBA9l/PKk5yz0id0zT28jW12yiBLcRIvJxbay7vyuXBPmxerL36Fq
         JOSg==
X-Gm-Message-State: APt69E15nfKgEq7nzwoo6EPecOcPl1EmK0Xy377jXI5uKk7YAAWDDdI3
        sbKX6wWMX/7ktxSiyusMrdk3+GKA6Vw=
X-Google-Smtp-Source: AAOMgpeSJR5s/udbi4p902+Z2PUmHvWkVMi+XF/umU6Ly/ExojRqgi+dPpKQZzY/2t3+2Z9jSB+8Mg==
X-Received: by 2002:aca:a686:: with SMTP id t6-v6mr1212852oij.48.1529682574144;
        Fri, 22 Jun 2018 08:49:34 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id b56-v6sm6664784ote.32.2018.06.22.08.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:49:33 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:49:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 1/7] Documentation/config.txt: camel-case lineNumber for
 consistency
Message-ID: <fce254289e5408d2789e76c8a0147517ee1e5bab.1529682173.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529682173.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529682173.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lineNumber has casing that is inconsistent with surrounding options,
like color.grep.matchContext, and color.grep.matchSelected. Re-case this
documentation in order to be consistent with the text around it, and to
ensure that new entries are consistent, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..58fde4daea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1181,7 +1181,7 @@ color.grep.<slot>::
 	filename prefix (when not using `-h`)
 `function`;;
 	function name lines (when using `-p`)
-`linenumber`;;
+`lineNumber`;;
 	line number prefix (when using `-n`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
-- 
2.18.0

