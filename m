Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEBAC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 03:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiITDic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiITDiW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 23:38:22 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED855A2CB
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 20:38:21 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3454e58fe53so12796477b3.2
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 20:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WNAMJRiYYWjQlg3T2pCU9iWq5aH4gy2ogXMc8eGFcpw=;
        b=jxnyNqYhuAvJ6Wq4U9z3/zu9uIALbNEDZreaOhE3M+KiQO3RssIgAxP8b4qcSnmZAb
         iZU71+KrMcbqd7Xr1x840F0A/eX2q+b8HUkGgfryIABKOsUyXCNCoEki7RXgm+x9mYPx
         a9JU5qRzdjKKZ0QkaAMK+ZPrdFe/1hmLa0jFdjljIEwq42FlE49+AmNVtq2FSju4Owbh
         mmw7EYupj39vFzVAqdTCTmTbloaiyO4l2thJoU7cDniI+ooBN063dc9KLyawpgH0fdz8
         FUfjKDEhvA/C+BY5UIY1iHKB0AoQQZ1anlvHIQ9FyMdmVJkGRm14QfAl4gr1tWA2+G9n
         cFQg==
X-Gm-Message-State: ACrzQf2NYWrDf6yI/MznP+BhLdhQ+LZ2sFPtiiaOWBncg6qnHEd+l7aT
        5SQHGAhdXiTVcQG+5BEMekqeq8nzopZo7ieNuL4=
X-Google-Smtp-Source: AMsMyM5OsxP+mklPXp8XcH1XgzLGHBDB8xL7p8N/cjd2RvpTMhBlDzEXsVe0O526FMgiPLagUG8TtT559Q43Gj27qmc=
X-Received: by 2002:a81:69c6:0:b0:345:1187:653d with SMTP id
 e189-20020a8169c6000000b003451187653dmr17347618ywc.482.1663645100507; Mon, 19
 Sep 2022 20:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220920024557.22889-1-jacob@initialcommit.io>
In-Reply-To: <20220920024557.22889-1-jacob@initialcommit.io>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Sep 2022 23:38:09 -0400
Message-ID: <CAPig+cSMDef1qLM9t6_7pP5svcgYz37pp_o5idERGpAOX_0yXQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix various typos in regular and technical docs
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 11:04 PM Jacob Stopak <jacob@initialcommit.io> wrote:
> Used GNU "aspell check <filename>" to review various documentation
> files with the default aspell dictionary. Ignored false-positives
> between american and british english.
>
> Jacob Stopak (2):
>   Documentation: clean up a few misspelled word typos
>   Documentation: clean up various typos in technical docs

The fixes in these two patches all look sensible. Consider this
Reviewed-by: <me> if my read-through is worth anything.
