Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F324220248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCEXe2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:34:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfCEXe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:34:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so6911616pfn.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0OX2USgCOyg2ntgMnAgJvzhmpkDzb5gPqLDd6OvJ5rE=;
        b=qL3X00lHFy8a7xCMnNy/hX1c2TvPDaP1ij3TqbPAoMC+mNHW+MMw2cO5g8WuEKZWro
         8q0KiMD1kzyI2QWrV8zDOLQswP5m6RIAFtT+eeVMXiO3pzFTBIozeQ7v63ZUDPQpi4PB
         UPNdXMbP2B8QnC7A+bwjPswnH2M4bU0H4ynf5qnsFFI3Cf7rxmIGlOkXi2gRZF/5qxHQ
         78t8QsEq+7lH3i/mgA1wzmfWzVb6Jt+Rx3/IhSlYAKS7n7wRpw/yHR30lpl9Bl+BlNZ/
         NV9g++PjsLxYv9XRDTb+GUeuP0mWi1KObYm/m2DBVGUY5RnPX1ticwbtjG98Pgd1a0jQ
         dtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0OX2USgCOyg2ntgMnAgJvzhmpkDzb5gPqLDd6OvJ5rE=;
        b=IGC/IN4V4P6pSWsExuowOLGOVKhPpkDG63ysv17Bck7LNEhpfNjlNLvgfbaae0rO67
         9zs2TBMrN4tcUujARoZ4fdZxLB6Z0puCBfomnb+fuakgU5wIQA4mbIBUVe0kjue2r6Up
         zjqv07/80suj6HB4Gp541DiuLUe5FeFKAFWrdHBYvPaDq1s2uUhjrdcyaYktAkNR373T
         X6emCcR4qJ6x/bBeVaA0T3gxEkUDSOMCEI3cOZ3uwPzaDb0RzJvYTGwSjrXstEHZftRc
         uJEIZRCGB7DfPdMVXaYBnC9NS2AChdu/sUD/Ucyykw4T6+qQyX+XBG1rlJYvdONFoqq6
         nwJg==
X-Gm-Message-State: APjAAAV9JR5UdchVi94QQvgEaZkeXgKWLq8c0iDXTzdoZv6PZwkQ0Gql
        djq8aVHsgYmlKBkgtuuSzqADtsJf
X-Google-Smtp-Source: APXvYqz5/2SFG07NLkTNeustGD/q9MK5+LGDkkO+z1Q60t6MXBp+5aFN1d5WIONK61/gt1Tu8ndV9Q==
X-Received: by 2002:a17:902:7686:: with SMTP id m6mr3858391pll.262.1551828867648;
        Tue, 05 Mar 2019 15:34:27 -0800 (PST)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id x23sm52564pgf.10.2019.03.05.15.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 15:34:26 -0800 (PST)
Date:   Tue, 5 Mar 2019 15:34:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2] git-reset.txt: clarify documentation
Message-ID: <20190305233426.GA17789@dev-l>
References: <20190305185423.GA22260@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305185423.GA22260@dev-l>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-reset.txt contained a missing "a" and "wrt". Fix the missing "a" for
correctness and replace "wrt" with "with respect to" so that the
documentation is not so cryptic.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

My mistake, I fired off the email before it was ready.

---
 Documentation/git-reset.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 132f8e55f6..e952b28305 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -428,7 +428,8 @@ working index HEAD target         working index HEAD
 
 `reset --merge` is meant to be used when resetting out of a conflicted
 merge. Any mergy operation guarantees that the working tree file that is
-involved in the merge does not have local change wrt the index before
+involved in the merge does not have a local change with respect to
+the index before
 it starts, and that it writes the result out to the working tree. So if
 we see some difference between the index and the target and also
 between the index and the working tree, then it means that we are not
-- 
2.21.0.260.g8f7229c82f

