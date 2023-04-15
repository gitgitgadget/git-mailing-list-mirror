Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE7DC77B70
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 17:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDOR3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDOR3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 13:29:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E687430CD
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 10:29:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8b8aea230so3939981fa.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681579768; x=1684171768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIYH3S8cR0K903n3OV7DdUV5vC6P2ah/lweuuAJJHJk=;
        b=HsLGpoQ6r8Dyn5FPWKNMmhrffWFu+E1z+ElQhzG4GLTv+sCS53IAXQXDl5qgAAF00n
         7GcabRfdElFtJmoaZZa9YYERMIxr6sFwB9Nx6qBLs+ycMgDQ2MMcq0AIw2MNs0NPtWwn
         G0VBpSycYRT/HKrfl9bK4Bb6JFvTn6t0AZyEvI4AV2RWgqyaSsh2i1DulCs2KTYkQKC5
         1SVgMZtElk9VU6Rkw/YjCRW8nxjR8e3Fl6vZt/26ZCzEimhQr2fJfZwk/T9AiNtz+E14
         0aXb5Sqqg/iV/dj/o0HcvbpLruZMgI04KhVBhYlhaP9dehBE8wHmzLv15JXeGDeGJc9b
         5FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681579768; x=1684171768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIYH3S8cR0K903n3OV7DdUV5vC6P2ah/lweuuAJJHJk=;
        b=lLBs9VJKHIg5UnejMed0ndEP+bxmLnUOWFuBpt0Q/Mid756tCHskG9yj3goEwfnQth
         h86O33JuW43fCc8q6kt5LRyUCO7vnWdE3ktWxmLANWheWDmuqVbUjvEr78k4hFga6ECn
         TZHPE+gIcroOeCxzRNiUCE0HtyJ9a25e0q6TGPLE9gP1FCzxh2L9NRSO38xGg5LEZW2j
         A+hPF5aU9PTHXMKQNubb44UA7WTwCjoaxW8IpFTPpaRHYxJ0dLVjyWx2dLH5m5VEylB0
         viEpGZbgDmQE10hvdRrOtZc50QalaiHa49TFoxpAnrJx+qGcQv8o9d05ZKwQ7w3TThuT
         597A==
X-Gm-Message-State: AAQBX9dHbKxsbZDT8u3hQZvqwdzTD5RlVIHxXPcDI06lWFTxk/LRJfDB
        HGwpGQcRFRzxQvJwkJ7AJNoZ5BRIoms=
X-Google-Smtp-Source: AKy350ZgBAPfJCVMo6VQsWvckMZ0uJDcQh2ffDn2yvqxKC7WY/h3EQR0odLYEHinnvf1/NVtY6DEHg==
X-Received: by 2002:ac2:457b:0:b0:4ec:8381:f8e6 with SMTP id k27-20020ac2457b000000b004ec8381f8e6mr626522lfm.46.1681579767810;
        Sat, 15 Apr 2023 10:29:27 -0700 (PDT)
Received: from localhost.localdomain (81-235-255-74-no600.tbcn.telia.com. [81.235.255.74])
        by smtp.gmail.com with ESMTPSA id x2-20020a19f602000000b004d40e22c1eesm1357056lfe.252.2023.04.15.10.29.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 10:29:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] gittutorial: minor correction and monospacing
Date:   Sat, 15 Apr 2023 19:29:09 +0200
Message-ID: <cover.1681579244.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.40.0.406.g2798986c60
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently had reason to go through the gittutorial manpage.

The first patch tweaks a `git status` example output to match what
actually happens if one follows the tutorial.

The second patch adds backticks around branch names, filenames and such
to typeset them in monospace.

Martin Ågren (2):
  gittutorial: drop early mention of origin
  gittutorial: wrap literal examples in backticks

 Documentation/gittutorial.txt | 129 +++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 65 deletions(-)

-- 
2.40.0.406.g2798986c60

