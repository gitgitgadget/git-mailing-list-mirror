Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E4520248
	for <e@80x24.org>; Fri,  8 Mar 2019 14:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCHODQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 09:03:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44165 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfCHODQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 09:03:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id j3so14234057pgm.11
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 06:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f7VMsalbpBE+gu7S3SYCp8z6fApu235RSTIxr1cs0yM=;
        b=jOoECekf07RCRacqPAL1GqOclCv5nHFDy0WdEuLgTSMpa7lj5SbZoGnpndEi4e2Cul
         YgCbhlb7Hb1rJ4IIEyFouesFTXH0R5wXbqeBhzZVZ4eDLXeqTogDcFvKnbTJUDEyZVqM
         pvNZoAz/qMFfRZvSc9XySWvd+NdLZWP9rMr/y2Hid4/zLCm4tO4fmYgxT/V69WgWQOhd
         AejKidmnVVRJ3bPo3jlHFe/Nt4gF2TFspzAOVERkgkj1xidlbs2aIiWMYiWxnI2S4ZqF
         xxN9Is4dAbd7iF/nkoCP0iz4/dpyi6dBgNZBFBFJnBYKDF8n7KbygER2NabIYpBVHEyE
         PAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f7VMsalbpBE+gu7S3SYCp8z6fApu235RSTIxr1cs0yM=;
        b=XodsdW3iIWF0629CoOF4Pmb2fj1WggdUj/rdHyU7fABr5YEl/ibYdVxU4KdFTA9n9G
         AT32f50Uu1yxfh7vXf2BdRkFt+Vb7uYF1wakybvcqDp8mqBKQ63RXTT5Z/+yi/0zovZC
         1lrCo3YdCiv4LsKQfdlxMR2NzijWJqrLOBFmoee+EPIr5mR4EY9imC+p9vxxWvGeCzyO
         m40aiBn75tqu2wmn/yKYHDFvAhyKNUSgivDW5KgCZjwiVHIUQJnYar+qcC2jLdcciOlr
         +86K76wO2ioe768bIXoxnFkCH247dxLdz9ZYDoXgfY9YRdV0OJ67nk81F9hGYL7hG8qS
         JQXA==
X-Gm-Message-State: APjAAAVO7T+FpIeYJNCPBZEhWAlvSTy1nADs2qCnSURegnZbaIfp+2Md
        5fTEsfjfOc9lUwM1KgbacSEPx5w4K+g=
X-Google-Smtp-Source: APXvYqzH2JiDtoN/1w2a8qoIM8UezWcKp/2roeXC7NuRJ1xg1iTNwHLcDRJh/U8ADz7RbJP+rkZmOA==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1mr13473605plp.34.1552053795420;
        Fri, 08 Mar 2019 06:03:15 -0800 (PST)
Received: from hacker-queen ([157.45.194.51])
        by smtp.gmail.com with ESMTPSA id n75sm21263335pfb.39.2019.03.08.06.03.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 06:03:14 -0800 (PST)
From:   sushmaunnibhavi <sushmaunnibhavi425@gmail.com>
X-Google-Original-From: sushmaunnibhavi <sushmaunnibhavi@gmail.com>
Date:   Fri, 8 Mar 2019 19:33:07 +0530
To:     git@vger.kernel.org
Subject: [GSOC][PATCH 1/2] modified dir-iterator.c
Message-ID: <20190308140307.GA22661@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
Some places in git use raw API opendir/readdir/closedir to traverse a directory recursively, which usually involves function recursion. Now that we have struct dir_iterator,we have to convert these to use the dir-iterator to simplify the code. 

Signed-off-by: Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
 dir-iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index f2dcd82fde..a3b5b8929c 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -169,7 +169,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 		struct dir_iterator_level *level =
 			&iter->levels[iter->levels_nr - 1];
 
-		if (level->dir && closedir(level->dir)) {
+		if (level->dir && (struct dir_iterator_int *)(level->dir)) {//changed closedir to (struct dir_iterator_int *)
 			strbuf_setlen(&iter->base.path, level->prefix_len);
 			warning("error closing directory %s: %s",
 				iter->base.path.buf, strerror(errno));
-- 
2.17.1

