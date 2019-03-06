Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D9120248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfCFXwm (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:52:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38148 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:52:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id m2so9700485pgl.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ij8SLW5sd/pTrfgjqAYT6qNVn6SE6p3BVoCWWA/Kk/E=;
        b=AjRWXD7HmcqTCfOfSw6WVeG1UfsAsRZD7M3Y6AZh6WQS/j+TMjkliYiDsi3yDgU86f
         5brBe2cmRiwKDXWxphyf0FgzKVRD9p49N4DDl8y+YfTCgRzpJ85HA2cVl93eKErMIwC5
         VgDRSDsao7cJMyOfMSQRX35I6yX9+iRZhBips5W9YdjxCshdOEmpeOP8Ukrv6yn4xDcO
         aopCyGLEQ2aVoAnuVFxzgTUeGFdAMmz45ahKlBTyN9xeQALIKs2DnwslU6sXZyZDMakC
         9r8kO1z34VEO1zvHfIZnIhFYuYKyECqUg28x+IT5/upZ5CYFzZ1Yi2dwS6DSx2ja1Y6K
         463g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ij8SLW5sd/pTrfgjqAYT6qNVn6SE6p3BVoCWWA/Kk/E=;
        b=s+RIPjQQWeE/Ck8IAS25r19GCJ64RrN99ENMu1EHFCxXh/RDFVJfRnx1bSTILCpScu
         Yno52qiN1x/69mcczYhXemu9YMPAvBCM3SqYZ7vNbk++xo7eu84lSQUvBwubLtTwS3Y+
         sR8g1U/Q6ciF1rDipEPPYzZo83awietNbSbx++nyM5g9cxJOohY0I5qVj4XlVfriZr9m
         92WoIDY5jSsRnsNWShsdXTe+US7hYkeJeUaXBiqKU1dsaB35QCahobNMb2kq0RNG4Lqo
         eaD2MgKJbFqmn0QDLP/DdYjt+rBRRpjabRdia/947rW77igHhF9ALThiyam28xIzksPy
         IpiQ==
X-Gm-Message-State: APjAAAWk1jHLnN8e0Eyq7nQodMCMfwhzvAnVpzwhiB9k9SsJeOG27w6H
        OjNtD224/Ng5unk0TQxwKqElpyGrneX47Q==
X-Google-Smtp-Source: APXvYqzCwN9bVDK9fzPr4whp5/vATYYDuPa3iU6e3SZT0HLHmfMeWpzc5DGaV3UcQ0MbObJbtFnZlQ==
X-Received: by 2002:a17:902:bb0c:: with SMTP id l12mr9796310pls.108.1551916361080;
        Wed, 06 Mar 2019 15:52:41 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:44e5:978c:280e:8d47])
        by smtp.gmail.com with ESMTPSA id f28sm5164041pfh.178.2019.03.06.15.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 15:52:39 -0800 (PST)
Date:   Wed, 6 Mar 2019 15:52:38 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v2] Documentation/config: note trailing newline with
 --type=color
Message-ID: <be22686b93fa76f0ff63a7d93cb731545c57cb22.1551916338.git.me@ttaylorr.com>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 63e2a0f8e9 (builtin/config: introduce `color` type specifier,
2018-04-09), `--type=color` was introduced and preferred to the
old-style `--get-color`.

The two behave the same in almost every way, save for the fact that
`--type=color` prints a trailing newline where `--get-color` does not.
Instead of introducing ambiguity between `--type=color` and the other
`--type` variants, document the difference between `--type=color` and
`--get-color` instead.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 1bfe9f56a7..d0b9c50d20 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -240,7 +240,9 @@ Valid `<type>`'s include:
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
 +
-`--type=color [--default=<default>]` is preferred over `--get-color`.
+`--type=color [--default=<default>]` is preferred over `--get-color`
+(but note that `--get-color` will omit the trailing newline printed by
+`--type=color`).
 
 -e::
 --edit::
-- 
2.20.1
