Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA1C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 13:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiDENBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358016AbiDEMfG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 08:35:06 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77770B2474
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 04:46:31 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=oct+ClOWslXI4pvGmgPz0vpwFM+Mh5/tMjKt9X4oukff1sX86JpJ6DjrZpT0dYRmzQgeq7439sU1bto/13tB80cpERFW2otL8w01+vA5MiDOdoGH0l6ZGuFgRe5Mn6S+9dB8GKkVmEEkLhEBHFViIm3PIrJy+NLWQeVzxJbhqJqs5Vu8XSyEnrgCozAVf+Pnh2eENwUbt7helko8631F2InyloecoTzUvRr8EkcuJWHshal2ln2yCuTOhJMRWlCdVA2DDf8bKqTiUK9a1tqcS4vFakt0ZA1/ECvGZGq0Ht9Ot9IUi4ofA2L46IwJlY9IfFawbal7i8jMoNq21ZkLow==; s=purelymail1; d=slashdev.space; v=1; bh=I74dogiLLRXzqjRgyFG4iBHB6jWtAFe56Oou1CE9Eh8=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=KDEI1HccWP60ReblKhI0SJWy4xC43sFxBWchWQSTglDGGvvpooTVzY/fKk3GCuXdBoiwDwblNEMMq+cM1yLGXyEv61uJZ+/gDbSRyO5zTWzvA2R2IGrGNX4tp65Hv1bbHPQUNTftq36o+MsfsSiJxOEecKF36AzqY1tmsXECxa3Wk5TT9NJLKXtEz1mtypawv/6RftrLPc1sc7IuL5HHNghDqvzWqm8tC31sWet8Kl0QZQ2yOnptMirlelIEx0zFGqr9RBAY/yt8T54Q+JrYdD8V1o4eYSYe/5JO1OD5ouaKN1Ff4qWIhCJo+7DkHAk0FoLtVI6xQ2xyvF8PpGlB0g==; s=purelymail1; d=purelymail.com; v=1; bh=I74dogiLLRXzqjRgyFG4iBHB6jWtAFe56Oou1CE9Eh8=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 981976735;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Tue, 05 Apr 2022 11:46:21 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     avarab@gmail.com
Cc:     garrit@slashdev.space, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v2 2/4] bisect.c: remove unnecessary include
Date:   Tue,  5 Apr 2022 13:45:06 +0200
Message-Id: <20220405114505.24389-3-garrit@slashdev.space>
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

Remove include "hash-lookup.h".

Signed-off-by: Garrit Franke <garrit@slashdev.space>
---
 bisect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 9e6a2b7f20..1aced76257 100644
--- a/bisect.c
+++ b/bisect.c
@@ -6,7 +6,6 @@
 #include "refs.h"
 #include "list-objects.h"
 #include "quote.h"
-#include "hash-lookup.h"
 #include "run-command.h"
 #include "log-tree.h"
 #include "bisect.h"
--=20
2.35.1

