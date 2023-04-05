Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEACC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbjDEIeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbjDEIeP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 04:34:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49730EB
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 01:34:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso36550227pjb.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680683646;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YZD9szKbfRXWghLDYijk0TX/gnGKIyGPf3aOUfEyWA=;
        b=YOYG8AxSXoZgslWfA4MxO1ONqaAH2nX6YYCF4vvZ4Qnud4VfXDWEOBSK9ZWjYonqNQ
         MlQxKGEmpGhJVkZotC7rOwyvdmUvUV0Tcm0NP5nuTeYOtcrVCyiLSUYHfWyq2mN2Bd13
         /sYsocshayjDyl/YXZFPpYnDRqTaLJnYBf+tyTf8xlORUl8ZLlw7/YOdHnlg77fj2/hH
         hceaSaoFOxPDkJyHbGM2TGU5tcdwjSeZPJBXcanmV6Ugqyskwm1Xno0earcDe+uXvBBw
         HEl4LJvcAmfQzTMTyRA8Y/ResXe9bmzdp0XEUUkiSvFPR7tqe2W5slVspnoDvlMOAs6T
         QsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680683646;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YZD9szKbfRXWghLDYijk0TX/gnGKIyGPf3aOUfEyWA=;
        b=4htHNaerxX17218BBHDLMdDY+ct+WDkeNOInBwVcCtQ22n2NGTGf0e0AspQggD5jTp
         SFdEyPd2GjxylhWmtBNUTucX7BeACHpJgeywPLZORllzatkcMN9JXNuP9yA+aba4rnVi
         ut5DT57bR8AT39nI6KRrR+1BW9DqyeD36olvbBrlhGFW5wu7G5HN5hnFgebZu/NTcmK8
         EjdcRYu8wi5mo68RJCQcyxc7976/4m6c13DgrfdLOWsOMkObR6rq0NTaHWJKSQzr4hoI
         YqJdVlsJI8dkFeH7TJdTGFg6dGmVsJwCuCz4R13k1zJgoayILzvDm4GQ8EzbLEIrs1sY
         x5sw==
X-Gm-Message-State: AAQBX9eLsniUMCtU1Li0/SBqQuu4XbYKYZ8VXS3FNeUAmKX+JduWWiSh
        jz8XvnJYkKSktoOKRry3YTIfzzDpM8M=
X-Google-Smtp-Source: AKy350b20qPm4x/kWhgKFLM5UT/X6kJMvYBfkrCwkmXstD23+XKW6FKvcrDCemLkc3GM75UeW5EoyA==
X-Received: by 2002:a17:90b:3508:b0:237:b702:4958 with SMTP id ls8-20020a17090b350800b00237b7024958mr5567468pjb.38.1680683645941;
        Wed, 05 Apr 2023 01:34:05 -0700 (PDT)
Received: from trent-reznor ([2601:641:4000:81:9906:bd64:c8fa:48fa])
        by smtp.gmail.com with ESMTPSA id p19-20020a170902b09300b001992e74d058sm9722724plr.7.2023.04.05.01.34.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:34:05 -0700 (PDT)
Date:   Wed, 5 Apr 2023 01:34:03 -0700
From:   Daniel Watson <ozzloy@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: clarify MUA discussion with "the"
Message-ID: <ZC0yey+S+OD/S2tt@trent-reznor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without the word "the", the sentence is a little harder to read. The
word "the" makes it clearer that the comment refers to discrete patches,
and not portions of individual patches.

Signed-off-by: Daniel Watson <ozzloy@gmail.com>
---
Thanks for creating git!

 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 927f7329a5..b218e27357 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -543,7 +543,7 @@ trigger a new CI build to ensure all tests pass.
 [[mua]]
 == MUA specific hints
 
-Some of patches I receive or pick up from the list share common
+Some of the patches I receive or pick up from the list share common
 patterns of breakage.  Please make sure your MUA is set up
 properly not to corrupt whitespaces.
 
-- 
2.34.1

