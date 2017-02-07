Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21AF11FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 06:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbdBGGcL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 01:32:11 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33862 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752530AbdBGGcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 01:32:10 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so8581774pfb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 22:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aR9RIhkeEaCQKpB/6xEP3mIj8ue67KNZmwEo1xesAQ8=;
        b=pbeMqhm+elFRw2+OEA+IA3J9+o98F5BXxyiFDMklZuQq8IvCUqlJy/xK3Ge3CbL0/u
         n/+j39H5v3LTdvJvIzLTVRR6CyLBkWVCMW5FzfsKCPSoJAZKh9wPVA82RA9TmYDlcWva
         4Ey6lHMO6pZHi2DzwzLqnSQM4VVgKv/GLRoxm8TNQKxCewrFOhnBffBmSLYRhLPydidi
         puWeu4ggDVI6LM2SbHLgN4fFdjLgC6FYtCLDCyNajVYGPW1/8est7rz+yXDdllLSU+Z+
         pK5yWWiB/u6KFAlRAhaqHbt8XFBGh5iXqwhzXfFaf8p+joWDEquetNkwlCuJqGBXDZ0x
         f/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aR9RIhkeEaCQKpB/6xEP3mIj8ue67KNZmwEo1xesAQ8=;
        b=qlWBbeG7eMT3ZK95Enh93nVr/XFvHD75IhmKRW3oZSHWVslFZ2RlbahzTkJ2FUv5rd
         mqlwj91Q3zfZcTkkL2r6CxXWD7RMTBFwZno7KJmBI1VLqKtWK3z42lpDim609HfhZzNZ
         uxkfqqCXotlL07ISMY7WSuKnDlmUJFnq7ViDEFZ4ya6FQpE0xKLJZayvD8Zn/4QXmzsU
         kSL/Odmun5GBO3D7VgiQNMJ074rUnrtJZd/IROUSLG5euVHIzX2rT1cKUt/q0VZaXVZD
         tNt62svGNHij6MpdqgL26tseOY7T7C75vCsyhnW6/rJI7F7A+tS59uEpFfrjvOl2XGV/
         X7EQ==
X-Gm-Message-State: AIkVDXKlZH3y/9PHDjT36zC0aj2rzYzw8xMyncG53UgClIaIKlZM5TyY71EWM+V+Otu1CQ==
X-Received: by 10.84.132.1 with SMTP id 1mr23510323ple.44.1486449129580;
        Mon, 06 Feb 2017 22:32:09 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id g70sm7525668pfb.50.2017.02.06.22.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 22:32:09 -0800 (PST)
Date:   Mon, 6 Feb 2017 22:32:07 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, davvid@gmail.com
Subject: [PATCH v2] Document the --no-gui option in difftool
Message-ID: <20170207063207.GA12746@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to this, the `--no-gui` option was not documented in the manpage.
This commit introduces this into the manpage

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-difftool.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 224fb3090..96c26e6aa 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -86,10 +86,11 @@ instead.  `--no-symlinks` is the default on Windows.
 	Additionally, `$BASE` is set in the environment.
 
 -g::
---gui::
+--[no-]gui::
 	When 'git-difftool' is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
-	`diff.guitool` variable instead of `diff.tool`.
+	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
+	option can be used to override this setting.
 
 --[no-]trust-exit-code::
 	'git-difftool' invokes a diff tool individually on each file.
-- 
2.11.1

