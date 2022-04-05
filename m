Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA95C4332F
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 12:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiDEM7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385643AbiDEMgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 08:36:25 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17020BF022
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 04:46:51 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=c6rWcB1xs90LaadaBlcWvw+L5lD66QawBzamABMSdOjbv70y+2LtTYkyegdyKfZfhwHZU84ah2fGKd3h7ZlZArQ86FdVl+oJ/9Yi2LxrIPIt2KqR35jANUR5lLjYfNT5Jd7aKr8Y2hCpOZkNEHOhwz/SQLvitSdHN3OVt1arqD7VOnXYZWbYx5z62g3qjgnVzSOSG+lB9isrJ9KVF2/FkQvR8cpvgYtBIjeD2l3k0sqFnweGqMj0newHzHIyshOeIhHOvGZk5UEasVjminqpWnBuln0QKwQAUZqbKLm7ceBFUK+G8UmXjKf936sx2+PLdD1q8Z+M87WPkfOFcyUANQ==; s=purelymail1; d=slashdev.space; v=1; bh=vvgNGa088fzWJCwM8kqWAimEWLbQb16GGS7OwkeaelY=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=U/r6CAsS6W5pvEBoLgI6A0M5d/n8NxEvaVC6DA3qcHrLUfNElFdH0yW8rJV4ksB/40w0vSHczm774mBzVW/lmZRdoqsf1lp06KX2yTijilCzdgFb49M8hhrjXtFDrVAYw/1V3i1rXjHBmaH3tUAUEDWNrVxRhOnHihuufuKm2Qt0sVv0SESxkZs6FlyoY4pjkYIIViuxyjXdGkHb6pd1+zFi4OYM0dxqMPgizovjD57B+7AX6osHb8DrW+Goa86O2YMHckWyWC+R8bAM4pdJwR6udOSuLZFFESHJDEo5P41pCeuvJRptnlyrqBIgP/1lyHPckyW7CzduERwqfV0iPQ==; s=purelymail1; d=purelymail.com; v=1; bh=vvgNGa088fzWJCwM8kqWAimEWLbQb16GGS7OwkeaelY=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 981976735;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Tue, 05 Apr 2022 11:46:41 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     avarab@gmail.com
Cc:     garrit@slashdev.space, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v2 4/4] apply.c: remove unnecessary include
Date:   Tue,  5 Apr 2022 13:45:10 +0200
Message-Id: <20220405114505.24389-5-garrit@slashdev.space>
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

Remove include "lockfile.h" from builtin/apply.c, which is orphaned
since 6d058c88264 (apply: move lockfile into `apply_state`, 2017-10-05)

Signed-off-by: Garrit Franke <garrit@slashdev.space>
---
 builtin/apply.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3f099b9605..555219de40 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "builtin.h"
 #include "parse-options.h"
-#include "lockfile.h"
 #include "apply.h"
=20
 static const char * const apply_usage[] =3D {
--=20
2.35.1

