Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C071F453
	for <e@80x24.org>; Tue, 12 Feb 2019 09:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfBLJ4P (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 04:56:15 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39877 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBLJ4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 04:56:15 -0500
Received: by mail-pf1-f182.google.com with SMTP id f132so1051662pfa.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 01:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HRI9dBmXrmuda1KKbAeIPkmU/XwHMdZ/oQ0dQcInFyM=;
        b=aB3JzSclaLg2O+2tfR18V+9taB3H4qUuCkzB4ZNhQ9vbYx+QjYrEhDja8nUCikcnJ6
         Ks85z+enocLMlHKEK3jLDhSVfWk8MaC8crl/2kAeyOqvJN66b1qOrvNw6q/de66IYb8V
         Nn5otpn+WcUdnoETJ2BikJ4ELRDnKjrNMg9gr1EUgBvnJav6DzHm8daT3OLlwxPeqI58
         rwSub4ZedV87NS7k0AwmAwwemEBA0eShU73P4/A4b/EInYuxD+1DSaRmn0lvIn6btFH+
         bDqeedeiJYXp/+2GMEfyW4jToQWDGgCZe+f0DjQrjiPtNXy4iD2lngSA9vS5BQGJlZt+
         CLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HRI9dBmXrmuda1KKbAeIPkmU/XwHMdZ/oQ0dQcInFyM=;
        b=DX/rR7woYimfPAXqKvMyUEWn3GKw1COS0Q3i6WwdudHnEIwyoXtt1aCA3mHy7f/l60
         SlbMFz7WBhKxmwZyDF1Ib5ulCZOwkmnRONP2mhz5MPy7bt38c3kjgBQ5cYDGQbibpjOU
         AUM5cWED20+/bJReLjhWRhAxPIeWe3VuVy+ALDd94B3DzdbGqAwkPND14Q8RLEZd2nf/
         T5ajrz5eBG9ye8cVrjCAmt1QkpLTgFvT/WOoIN2XFw9WRRBiagHisg9XFI2jYIJFZr0R
         LxQUw7OOD34iW+6AnrQea/oseFpK05K9OX5SHiXiPGzpdOcUM/gFGIVkneIYhqGrd1jN
         tHKQ==
X-Gm-Message-State: AHQUAuYOx1XcTO/ONFr99ZiMQDt5V948IJfWVnls9ALA3yv7x0fvMbg8
        FtkyRJa5fzTV8y/GvduJD8iqobuB
X-Google-Smtp-Source: AHgI3IZf3ThCfl9GYwcCcT12Y6xXTFmEem2gggB69Wibc+yUfrw1w9b2kr0eP2vsqU5GAdUZXpCadA==
X-Received: by 2002:a63:ea42:: with SMTP id l2mr2756131pgk.213.1549965373706;
        Tue, 12 Feb 2019 01:56:13 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id y21sm17903268pfi.150.2019.02.12.01.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:56:13 -0800 (PST)
Date:   Tue, 12 Feb 2019 01:56:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com
Subject: [PATCH v2 2/3] git-submodule.txt: make subcommands underlined
Message-ID: <b0c124d022bfa9a0bbe0c9494df24780b67c8a08.1549965172.git.liu.denton@gmail.com>
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
 <cover.1549965172.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549965172.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-remote.txt, the subcommands are underlined. Following that, we
also underline the subcommands in git-submodule.txt.
---
 Documentation/git-submodule.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550..65a952fb96 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,15 +9,15 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
-'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [<options>] [--] [<path>...]
-'git submodule' [--quiet] summary [<options>] [--] [<path>...]
-'git submodule' [--quiet] foreach [--recursive] <command>
-'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
-'git submodule' [--quiet] absorbgitdirs [--] [<path>...]
+'git submodule' [--quiet] 'add' [<options>] [--] <repository> [<path>]
+'git submodule' [--quiet] 'status' [--cached] [--recursive] [--] [<path>...]
+'git submodule' [--quiet] 'init' [--] [<path>...]
+'git submodule' [--quiet] 'deinit' [-f|--force] (--all|[--] <path>...)
+'git submodule' [--quiet] 'update' [<options>] [--] [<path>...]
+'git submodule' [--quiet] 'summary' [<options>] [--] [<path>...]
+'git submodule' [--quiet] 'foreach' [--recursive] <command>
+'git submodule' [--quiet] 'sync' [--recursive] [--] [<path>...]
+'git submodule' [--quiet] 'absorbgitdirs' [--] [<path>...]
 
 
 DESCRIPTION
-- 
2.20.1.522.gd8785cdd01

