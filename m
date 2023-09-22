Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B56CE7A86
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 21:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjIVVZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 22 Sep 2023 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjIVVZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 17:25:25 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F7BAF
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:25:19 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-65637c04014so13275546d6.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695417918; x=1696022718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2JVmIIJgtXxwtJopBr81SwMH7649Xh4d/wrPM5y+do=;
        b=dNDDNzYJ0mxu70dxQVLRV9XIWUf3IcryBPptONKImfmTrDE3rbcVc9vFLtwBQX41Xg
         3j6TKF1XiZkwVwvi0h2G7dBn0EKvYBBtMcQtyxock6/zS8Na8pPNheQmP1gA9hQKx2Eb
         kRynjRGWodp95gtMs9ymlxigOhiDDglYJsfmp+JhnotoxqXxSaEtxSLWydKb62HsS4Oq
         GwxAm7tDH08pJDxDyj3hwj9doglKZnUlN2YmCdb08RO7iS0cwmmTiaOBpLv6pRqJjc+w
         fGV/X620dYCe+LNfHOV1duINEIacnLOT1CORTXtJundWacl/Wngq+/SlsKfw06BPJQpg
         2fwA==
X-Gm-Message-State: AOJu0YxsuecM1M+jX8xOLnHLYFZ2PPmxPMTdShdJN3g/rEFXDfEOkvSa
        5tSsrm+6W9Bqi3wNzU15lMNHtvtmIuWwhWS2Dm96UCngCgc=
X-Google-Smtp-Source: AGHT+IH6KpgFN+8tiVVE1rFvwwpoEk519hfp+5kS3hgYnZwjxLudjJ8/i9ewvtg1B99mQ6ru7ydjrBfkgM2JiGIYsRU=
X-Received: by 2002:a05:6214:4c1b:b0:656:400d:9eb0 with SMTP id
 qh27-20020a0562144c1b00b00656400d9eb0mr487309qvb.43.1695417918490; Fri, 22
 Sep 2023 14:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com> <f9f3f4af1c8889eb69f777a322348afc53feeca2.1695392028.git.gitgitgadget@gmail.com>
In-Reply-To: <f9f3f4af1c8889eb69f777a322348afc53feeca2.1695392028.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Sep 2023 17:25:07 -0400
Message-ID: <CAPig+cRc49GCr+z+LA65VFS8RTaOEkKe8KszQOUhFPxZGQ_QmQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: update links to current pages
To:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:14 AM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> doc: update links to current pages
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
> diff --git a/json-writer.h b/json-writer.h
> @@ -4,7 +4,7 @@
>  /*
>   * JSON data structures are defined at:
>   * [1] https://www.ietf.org/rfc/rfc7159.txt
> - * [2] http://json.org/
> + * [2] https://www.json.org/

Not sure why this change is needed considering that the simpler
s/http/https/ seems sufficient.
