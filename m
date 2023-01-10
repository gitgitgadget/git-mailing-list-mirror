Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A1C61DB3
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 08:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjAJIiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 03:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbjAJIiH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 03:38:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65006D51
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 00:38:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id co23so10920046wrb.4
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 00:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TghVST/V+XBh6xTEOnjdxY4xvuY+PDNITGwUy3Hq7TU=;
        b=Xe2diytgWpVz0YRPDcnnZCwAO5oFARDbtE/P0bW6GFinEWEfYCZjR23E44OJ1R5KO/
         t/DGY3YWvxENA8Zo4EuGjiYrfG/vOZc4fh+oARYMQFru6rDBQ//mpCrdBp4pjmHe/sYP
         xQ999WHEcje9MAZfrZ/+JDvTHfTSWHSHDkQtCHYB5wsPisHRx5yvzwiKzXDLvQThH2RR
         9Il0VvwAMsmXfPS+472nBa7u1l1nTEzYztsdxtrd+jTRKE7f65pPEtlYTn2M95bKxQ2N
         KX8cEPnA+69w7x3yiY/jOINx7/bqaoVbII7nUZMOvF9CvH0gdpvzxdgRtTFcqBCsRObB
         Uf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TghVST/V+XBh6xTEOnjdxY4xvuY+PDNITGwUy3Hq7TU=;
        b=UFpG5CI2WgwduqRTIJd2317MR3yaK/Z59SDGPIv6F8wStdbAxZAriREI2cjnTl8V65
         QG/s/BbXJ1SBd8eRIIu4lGilbuE9ytKr0jmFVjuH3usZjde7BF0sTdOuv94Kw1HP3CcB
         +4zc7BCgu8+grjwSD5yltaRpf9TM84EtupGQnLhKwCk4Up+gXCKSYUqZW1pzdtznVts/
         YJrZGSRFroElfmE8bIZvWNP/CRq641Lh2vCsx5TvZME0wU4Y1um0svrfuE21s7XfW2CY
         F4DBD/BZdyKO/InTkiq88YJ3KXgcbOWoEZ/P+CX1kJsujLzWcAj/ywnL1g6wJm3CNAhF
         JNdQ==
X-Gm-Message-State: AFqh2ko6TtFQhBUjVJfwBhpgbeu/A8xzBqu7yP9+o4VeNkQMI2wTz8TC
        nZ6SOeDcLK9gxEHdGqSWX5+wSR7yciUw/Ez5
X-Google-Smtp-Source: AMrXdXsRdm/LiTlGpSLEaLYQGzofFOK/EYCZzwzAlv/tXAPE731M9UlwHyJxdt40y/pKgo2bi0PeTw==
X-Received: by 2002:adf:eb43:0:b0:242:1809:7e12 with SMTP id u3-20020adfeb43000000b0024218097e12mr39931923wrn.70.1673339883537;
        Tue, 10 Jan 2023 00:38:03 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.75])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4707000000b00291f1a5ced6sm10400733wrq.53.2023.01.10.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 00:38:03 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH] git-bisect-lk2009: update java code conventions link
Date:   Tue, 10 Jan 2023 09:38:01 +0100
Message-Id: <20230110083801.186789-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A reference to Java Code Conventions in git-bisect-lk2009.txt uses an
outdated URL that redirects to table of contents for the conventions.
The actual claim about "80%" that this reference backs up is on the
first page of the conventions:

  https://www.oracle.com/java/technologies/javase/codeconventions-introduction.html

Use this newer URL and its title in the reference.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/git-bisect-lk2009.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index f3d9566c89..36168792ee 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1348,7 +1348,7 @@ References
 ----------
 
 - [[[1]]] https://www.nist.gov/sites/default/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], see Executive Summary and Chapter 8.
-- [[[2]]] http://www.oracle.com/technetwork/java/codeconvtoc-136057.html['Code Conventions for the Java Programming Language'. Sun Microsystems.]
+- [[[2]]] https://www.oracle.com/java/technologies/javase/codeconventions-introduction.html['Code Conventions for the Java Programming Language: 1. Introduction'. Sun Microsystems.]
 - [[[3]]] https://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
 - [[[4]]] https://lore.kernel.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
 - [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
-- 
2.38.1

