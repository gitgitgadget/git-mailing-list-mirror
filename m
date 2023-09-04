Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043FAC71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 07:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjIDHBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 03:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjIDHBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 03:01:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE711A
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 00:01:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c4923195dso172227366b.2
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693810862; x=1694415662; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k3aExtf593ySJ0qVhxCcHbl2xYtVRiVIFu5HLpfdX7Y=;
        b=FL48cPyIct1e1VSCDZLaaBxeWEK6W9rpR0DqhNEehkCQVFK58JMRIVINX7AotYKLxN
         lnMTgEcO0YtlBLjB40EJ21Kw60cEDeO48MaDgptLYUpe+9v6wT3ngW6lLeDWUiJ34pmh
         pHvE+x4BQVRRjPh9WBxNcQnl6FX2Yea10g6MCz1Kq+Wf2x+1drvh5rZ5ubDt98V41ltQ
         E/EVaGE18R+DP7osNP0c1jJpaSAzXkZs5Plw+wCX4M7XFucnlS1kjY+ppnTKdipwY1Dk
         3GVfYXyczP5GEfiXKqJ+qsD7aT1y7RpKgLqQ4wHOroaY3zMpQQeQ5aIMGaEQyWP9unqE
         zrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693810862; x=1694415662;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3aExtf593ySJ0qVhxCcHbl2xYtVRiVIFu5HLpfdX7Y=;
        b=ZyAnhhb93dcfP6rKzGqrTEMSp9Cf/kfKl6UBU2OQfTdO7NcLfIJ7YTe7XJVCUyBuav
         F978k9Y3vCCt64hUznUhoBntyUFOIqju3VAsNtJMXFfRuIfPZhLJ0hxblscaFMMGw/ut
         Ety7hWFwkfz9cMTerHF/Gx/CMqurMKpHPy6vWiMrYhE6j4qJ8gp7q7EjLVf1IqQ17Fg7
         x2wtw++oqafHMmzRP+jl1nKNNjwGVBEsXctzIcw+fyInzqM/RsMlV9vtZvI8X90Lcv5U
         3xeKEXzu3MNKLd6J3fS0J8DiN9ageMooDPEJ/4zm4l1pkmzS1UgstCnB9k0Ye/jnxsrY
         GDGg==
X-Gm-Message-State: AOJu0YwgqxP1NaqSiXq6a7N1aeClfP20S5EFloN8uOK+YQd/M/OqEktW
        26YtERlN4CEVQ5zx7XGLiZ3EAwaPycWjfwJ1hn8W6n6M4euUfQ==
X-Google-Smtp-Source: AGHT+IFGNd91gPnKiHEBoErajpBXlARR5E0PFLFWlBelzi48N6gy9FJjCIbpKZAoO502znESIZJhEAxtbPYDGxVg3Wk=
X-Received: by 2002:a17:907:77d1:b0:9a2:eb6e:2cf1 with SMTP id
 kz17-20020a17090777d100b009a2eb6e2cf1mr7246224ejc.5.1693810862072; Mon, 04
 Sep 2023 00:01:02 -0700 (PDT)
MIME-Version: 1.0
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Mon, 4 Sep 2023 08:00:00 +0100
Message-ID: <CAGJzqs=CRhCU0FRLpU13CnOCJLOnpxNoHgSa3hFm5Wh0JNxbCw@mail.gmail.com>
Subject: Azure Repos
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. Anyone use Azure Repos (dev.azure.com)
https://azure.microsoft.com/en-us/products/devops/repos ? I'm looking
for help to test credential helper git-credential-azure
https://github.com/hickford/git-credential-azure
