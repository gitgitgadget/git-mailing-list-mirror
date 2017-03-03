Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66AB52023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbdCCL55 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:57:57 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35538 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdCCL5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:57:55 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so12522847pgz.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lHtHSds3if5svKSsBlJRVBcCpQcf59unmNi+5IHhM1k=;
        b=IDCPAcsHODSGE2NBIs1Js/5JJ9oyzEqCKrecy99EoWnGF3kL4TsZLPkNODxRN08KOj
         BI9kXdpVLrPL4RZY4TBsJLrYOBmybV1BwUHwk0UTOdiEVmwdQCxzpRGaiIusgtI8Ort2
         6Uy7GIFN/+waH5+0rkk6nlLtY3DZgbP9rdwhDgpq4yCP9fME5sb9Nyb+mBqoLWDrg/sX
         DWZNtNcFWmMjuGstib+94PpG0wf5d+TVVj7kThITLSWpJCQrsgjXEhujA0xKu/FGYyv8
         +ezNu2FZdDC3C9q0iNkfHMTYdEWkDEQ3qYN9iMifHsJpP+Q65zgAPgpdMkXa1zbzhJ3/
         I8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lHtHSds3if5svKSsBlJRVBcCpQcf59unmNi+5IHhM1k=;
        b=FmyRXLbLFyBYC6qS+i+iBq5qPv301fTQsEyKjmwr8084Qv4uzD2+OwIrrX+O97YcOd
         Hi+FOoWJISpnzmk/Zjjwe/p2SCE5JUr/qvrUjpeyUlZiS1kgc0cA+uV3wc3kSWq9m0zQ
         dBBSzok9Hv6dLk1hDOvowIBoQSHvp3tHMNOCtpufKPPUX8qw5qjiuzLq1aHGnqgz9rYu
         wr8OteCujKSZKhNo16buhiS60L+ZZjbedLPtRbutI5Dp0sJnoEvC3eyyJRBtC5edzcEL
         MCUWRuILvns6Bxty3TQ+czgS7d1t7tacCifXVtdnYMoTjesIs+dH9QmdEDYPldC8SQj8
         YbyA==
X-Gm-Message-State: AMke39nXeyA6oE6JnV9oYA7tGzlz9ZT2WOj4QxiwUbFCQXstd7ec+j0eAs8XqdBa7fGDnQ==
X-Received: by 10.84.151.9 with SMTP id i9mr3835162pli.122.1488542274078;
        Fri, 03 Mar 2017 03:57:54 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id m74sm23096824pfk.41.2017.03.03.03.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 03:57:53 -0800 (PST)
Date:   Fri, 3 Mar 2017 03:57:51 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH 3/3] Remove outdated info in difftool manpage
Message-ID: <20170303115751.GA13225@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When difftool was rewritten in C, it removed the capability to read
fallback configs from mergetool. This changes the documentation to
reflect this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-difftool.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 96c26e6aa..a00cb033e 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -105,9 +105,6 @@ See linkgit:git-diff[1] for the full list of supported options.
 
 CONFIG VARIABLES
 ----------------
-'git difftool' falls back to 'git mergetool' config variables when the
-difftool equivalents have not been defined.
-
 diff.tool::
 	The default diff tool to use.
 
-- 
2.12.0.1.g5415fdfc5.dirty

