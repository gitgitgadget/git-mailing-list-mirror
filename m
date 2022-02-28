Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9DDC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 06:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiB1Gfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 01:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiB1Gfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 01:35:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD666C9E
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 22:35:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s1so9835611plg.12
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 22:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=QCO1/HEd7WRwUqwTXMKOXf4ebpkv4RyC7DMyuYkxZzY=;
        b=o+SWc/13WlqLqxUqpzgEf0pZ3IosCTSlPi4daxEHDZkI26sGvV88bGgaGnqjo9oSZg
         vMbJ4b4k4P/wuYk9G8DwVZOVYM8Ijhy3q2iclY1TX1J3X9cf05agpNNKxgxzVPAGyJqU
         9HKXQpFSYXtKIFiOaaDdHanO/iMo42PH7qTHo5Ri70ocm02jg/C4xZUZ9NofuBtHBSJQ
         2MqpGZ9+4Rr90+pOrGlfEe6V6533hdHrLa9nWT8HaJqZ2OE88BvA9lY92972vzYZt7I8
         9T4fLvYMzYWEWgjMrfXLoiLO2FXg5sIK9UDhu6htVwjptwzyB7GoiPq6M3KrPYAPUNzb
         jrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=QCO1/HEd7WRwUqwTXMKOXf4ebpkv4RyC7DMyuYkxZzY=;
        b=iYwk4YQJWLc2AjKTyh2+ZJXrOHKkcZBgOgbPehddmA4ymMFoZXM/7RkEDnpcKY0Jes
         O4LSMCkz3AxrX0pHGLTqrrqxjBlubvrvb2g7jnnF+5XQyMLVYTIbWtVnAYOANnomG89E
         SgLAnQ7u6Gx3lHHNKMXFQsMII3dRM9BuGY+uaCxfbeB/9WXAV2vYUE6UCVolOrYfZ0yQ
         dx8L/p9+Y/I/1xS5R/ABQPKPvnbTKUARz1pBEQiYZJvzZEe4UpjXaYKzlww9Gs07mU40
         w8dXxnUZA3/fLP+cXqo+nhdXbxE7Sl3P4TL0G4dFKe29Nt9OTLco96fThUzfCpw6VEaG
         QYtw==
X-Gm-Message-State: AOAM5301BcKPukwgz/9UiQt4WxEZ3Fcfg035DcLIEXuhwiRGLFuvG1l/
        9zSb3JHr74NMyyxbAJfxz4w+pXZ0kGU=
X-Google-Smtp-Source: ABdhPJzLKQsx00ijlJCjLQYLtuti4gQiwOkMlkOJR8vtd66M5IHEQ156lB6ALmOm2xtSXjL20SANBg==
X-Received: by 2002:a17:90a:8d85:b0:1b8:a215:e3e4 with SMTP id d5-20020a17090a8d8500b001b8a215e3e4mr14882262pjo.175.1646030101274;
        Sun, 27 Feb 2022 22:35:01 -0800 (PST)
Received: from rsnbd ([103.108.60.141])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ac24d00b001bcd7c2b2c3sm10425399pjx.16.2022.02.27.22.35.00
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 27 Feb 2022 22:35:01 -0800 (PST)
Message-ID: <621c6d15.1c69fb81.bdc9b.a862@mx.google.com>
Date:   Sun, 27 Feb 2022 22:35:01 -0800 (PST)
X-Google-Original-Date: 28 Feb 2022 12:34:53 +0600
MIME-Version: 1.0
From:   "Nancy Brown " <millerwayne185@gmail.com>
To:     git@vger.kernel.org
Subject: looking for something?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGFrZSBhcyB5b3Ugd2lzaApEaXJlY3QgQ29udGFjdCB3d3cub2ZmZXIydS54eXo=

