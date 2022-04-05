Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E9C43217
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 12:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiDENAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385595AbiDEMfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 08:35:51 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAAABB90F
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 04:46:41 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=kyFIRV8Yk+vKlBc6WSc4g7eX3qORqTF56YEXGYZNXY+hCHIg9rq9P5L7SsFFsfBhBfvDCDXBFa6/mFnsJMhen45/mQbpAdL0wvsyQIggID3Ry4zCN1DN1wISB2NfWL34keIivaaMmWi0oLU8e/rtkiVtmOHZs/Plcmkh0e4LIOaWmWFyD6dXYPUYKhBzqwzIWK+NOLCApujbnKA8W1fJRejV+1UWTCGpoeQ2m9if0+XvEwehe5v43hk9uj2zGPlP7u20Y+vhEU5KLDqWZti6eVD0tdJ2ClQBd7dcKZD4D+iWnt2xbj0exbWO3EeqmOXy4sR0CGk+2U7QvXddoS05zA==; s=purelymail1; d=slashdev.space; v=1; bh=N1A4Rz6kINleLuc7ui9LwPc1VElS0nzLRpnTrMQ3xq0=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=g66J28CfuaW8mYjtKKfXk3Y1VwGJ8j57vfQFEHCykb9nlDW8HZbpX2r6PCfI6X/9kHUDgUNfn3VoITDhRlIrp/RjO03whxbWffGHC+X4lopfv6I8eDTbbQzdeyGfPKkhaSPh5E34dPCHTt3aDOXKR96cXUuN1E7xsWUZgJFm8m0HicKvqOZx56+fAbAE+f9hoHQVGxeaUbDPqOXFshBAKelBT6/MiLRaSTmS7ZmrUiPRqepaX+wqKQNX1QcBdCjPNG7UDnBXvStFSlbo3JzcG41OknGDARhFwj//B3N+4xNS71wXSBvWCvjoFXuVbHyWcXo7V2NMyjJaLnEtjGmYOw==; s=purelymail1; d=purelymail.com; v=1; bh=N1A4Rz6kINleLuc7ui9LwPc1VElS0nzLRpnTrMQ3xq0=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 981976735;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Tue, 05 Apr 2022 11:46:31 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     avarab@gmail.com
Cc:     garrit@slashdev.space, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v2 3/4] serve.c: remove unnecessary include
Date:   Tue,  5 Apr 2022 13:45:08 +0200
Message-Id: <20220405114505.24389-4-garrit@slashdev.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331194436.58005-1-garrit@slashdev.space>
References: <20220331194436.58005-1-garrit@slashdev.space>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=ANSI_X3.4-1968
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove include "strvec.h" from serve.c, which is orphaned since
f0a35c9ce52 (serve: drop "keys" strvec, 2021-09-15)

Signed-off-by: Garrit Franke <garrit@slashdev.space>
---
 serve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/serve.c b/serve.c
index b3fe9b5126..733347f602 100644
--- a/serve.c
+++ b/serve.c
@@ -3,7 +3,6 @@
 #include "config.h"
 #include "pkt-line.h"
 #include "version.h"
-#include "strvec.h"
 #include "ls-refs.h"
 #include "protocol-caps.h"
 #include "serve.h"
--=20
2.35.1

