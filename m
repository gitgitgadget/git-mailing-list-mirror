Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FB51FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933532AbcLIPxB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 10:53:01 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35816 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbcLIPxB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 10:53:01 -0500
Received: by mail-lf0-f65.google.com with SMTP id p100so365946lfg.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 07:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27tEhNgEQuWbEXuENinQngRoi8mJS9VgwxGevx5jCbE=;
        b=K6UMLEE8dTr/paQUUY1f6Uz+6ZiXJvifBNKOR3Vwr9IEl/ZB/vgbYVxkX6Yni1i8I5
         Ramj08PGc+Lcs/OzXVfFvrDX2lIZ0gwXIBlboaDHcuV6BuXYHzPkZ+6eUcZQpidwhHwy
         OvaNFxbh7JIBmOrUTerpuzU+x+YVbeXnxQ52IbzkVlZvElqPIcPNIkH7BV9/F9jx+1GU
         twMyGj7MzXJ8fUGm4NVTOCBL2+8GnE3ANF6N407yzduTNDqZ2GBhlYLIm5InELlzT0H5
         rBztC30cvMnk//fv5hKSCSw3g0S+Us6dGClgU7j8yfFT2MqYlwSKCIQo3+xhjkjc28tW
         dFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27tEhNgEQuWbEXuENinQngRoi8mJS9VgwxGevx5jCbE=;
        b=G+C6rGcL4ty1wHmTJB8x+DZlqWKGdKDR8tdTxr9cL09dSK6RRJL6NpOHpf0wjIMZXS
         PDjVnu0l3AGz/V5LYiTr3TayJQq59uhgp5gyGa5bFsm1Rm4ffBaNT+5/yxGfDX1MYKAe
         gYdH5dCuzjaPjaKqzePTS4iAQsJsma/ElLVtn5fpDpwKlVjam8eCP59LAAdtp4+9LSPM
         coUDMjADSex2TQO2HjV8s2lIp9aQmElo4DVRW2oWHHe418oYkwVv+BnaBW2MXAS+twiO
         LP3Rugi5tDly9xpiMvFMvwWVvhV9tG5LWGUjhRnY7KJPdnH707nx7YuxT1sZVw3t1z+E
         7pwQ==
X-Gm-Message-State: AKaTC01NyuO+LFbYW7GzkM6X2mnn9vGGLwDr34VSuuOc4Q9tFzci9X0RKoV/yj/HIyix4A==
X-Received: by 10.25.27.72 with SMTP id b69mr22583387lfb.160.1481298779424;
        Fri, 09 Dec 2016 07:52:59 -0800 (PST)
Received: from kristoffer-SZ68R2.privnett.uib.no (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id r204sm6646500lfr.19.2016.12.09.07.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 07:52:58 -0800 (PST)
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Subject: [PATCH 2/4] doc: add verb in front of command to run
Date:   Fri,  9 Dec 2016 16:51:10 +0100
Message-Id: <20161209155112.2112-3-kristoffer.haugsbakk@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the command 'git clone' as a verb, use "run" as the
verb indicating the action of executing the command 'git clone'.

Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
---
 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 6c434aff3..72ed90ca3 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1478,7 +1478,7 @@ You can repack this private repository whenever you feel like.
 A recommended work cycle for a "subsystem maintainer" who works
 on that project and has an own "public repository" goes like this:
 
-1. Prepare your work repository, by 'git clone' the public
+1. Prepare your work repository, by running 'git clone' on the public
    repository of the "project lead". The URL used for the
    initial cloning is stored in the remote.origin.url
    configuration variable.
-- 
2.11.0

