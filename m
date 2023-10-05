Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B83DE93713
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 20:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjJEU2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 16:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjJEU2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 16:28:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638D9A6
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 13:28:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso1584778276.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696537694; x=1697142494; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y65jGN2T7+dxI+lSN6p8+30ERqNS4OINLRZjUKUlzOI=;
        b=FCBE5wPh8APOYy1etAbnpmH1h8fCp6bc5PRePA+k/Mp/hbVXWveh157fujldSUw5DF
         ruzWGLmWtIyrkYFnGVnLVnIYMZRdL8C/O1RsPgj3eCNnMtP9eCRNQXJtySxLU36EuaUC
         mh8YJ7AZqxGmUcWLVpoTPT8FaOsFVKJ/OO9PbKYJ02SNC7wyfI0JhZFlgqM0+bvMgIpN
         P774ukUqWAMyQCaLTFgqGQYjJd+/ZsT2q1BnBSiXixICl+vWGIPxNG85INbejDEPljPp
         ry1q1KGn+bvJtKLgakbNJfcHf3P/fTFq8o5AwAqfpgpvQGU9iTULqz5+ZQ7+5IETpMEp
         1OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696537694; x=1697142494;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y65jGN2T7+dxI+lSN6p8+30ERqNS4OINLRZjUKUlzOI=;
        b=mu1Fg1X5ezECiBbY8NDNy/I949mh1h88EQXR1uhzpvqnvU4Gx7epKpsqiSFXg7k6E6
         5Ldu9RGxiyQOxiaZMvS9TiSn4+/rYHIzt6DSobhh3VxMWn4a0oDA76FrbjDYAMbEHMiX
         /H8sHXbvsCquJBgunLG4v5UQAl3AbqXQZ4Y4aBmfCwrYMos6t7Iudq4UPhAhs3bZvPos
         SgAealqdIYYGgmu/hHVbYrb7QvM+k276w5d+yEjgvwBC5DFalX1dIRaF4JmfjaL4yOfi
         SH0c9qStuFsm/2NphU6c7synCYFFVFuxmtnOq0K1Sxj6zxKNdMQeaQ7MTY9ilC1GEFcC
         sI1w==
X-Gm-Message-State: AOJu0YxAschx2uPgA8oRvezZTr/zss3wnC3i9K0tz5RPKIXY1KxnZCqX
        7FNeArMh2PSvjhI5D29qk9SRPRB0ONNkzdq2z0ddlcCyNHakCKE=
X-Google-Smtp-Source: AGHT+IEKfPohirrVuEXjMrO9OVK3agNpdNZ5XI+uCr0mPI6KQLDVZn+9yc/4+V7++UcZQj6EG3SXVfcyELPxqPpvsms=
X-Received: by 2002:a05:6902:1105:b0:d85:ab4a:836 with SMTP id
 o5-20020a056902110500b00d85ab4a0836mr7292678ybu.39.1696537694453; Thu, 05 Oct
 2023 13:28:14 -0700 (PDT)
MIME-Version: 1.0
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Thu, 5 Oct 2023 21:24:39 +0100
Message-ID: <CACS=G2wQTc--EUuBAiZMWEt7QAFE--Jc_GRfsE-7M37sHVR0Aw@mail.gmail.com>
Subject: [OUTREACHY] Indication Of Interest To Contribute To Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Community,

 I am Naomi Ibe , and I am sending this mail to indicate my interest
to contribute meaningfully in whatever capacity I can to the Git
community.


Git has always been a part of my software engineering journey right
from day one and I would love to understand more about it, while still
helping it grow in whatever little capacity I can.


I understand that Christian Couder is going to be our mentor and I
would be delighted to work with him. I am really eager to learn and
begin contributions.


Thanks a lot for this opportunity.


Best regards,


Naomi
