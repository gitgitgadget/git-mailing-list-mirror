Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C880FCE7A86
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 21:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjIVVWV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 22 Sep 2023 17:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIVVWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 17:22:20 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20974EE
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:22:14 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-76ef80a503fso167581985a.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695417733; x=1696022533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ06rCo7oFVza5CL8jwpc9BemfqNkRfSXaOiMEw3hXo=;
        b=q5+hQg56XG90qMH0woyNgjo3L7q4a5SLwBzkXYyoI75GOqxEq3cVs6xHDFaXVKb+i6
         ozW1hfT2ZkeyGfscACm7ILNDK+AC+sBXmkUnTyE/z0KBsQM3BYGUUQm9wDAyq+Oz5UNs
         exMb63LiIEWoxXNuTjqbRWRYUMk3lirhS6xToStUuzZ5I3CpAuZoZ02LAwpH04GizoDI
         WkYnjaZ9+gvD9az6h6HX88x5Jt50wrsihMijhAqCsOnBayDrd2oUYOlte99IBsq/Sdd3
         SgKxuPIzRTIcVlXLV9aPN5Cx79EjG9mZFGZeS09dczSV58CC7oiTBD2xTWV6cSBQB+9n
         YorA==
X-Gm-Message-State: AOJu0Yz6z2BHyzsWJeLw/nj8nPuTNUDKUeUkqIHt09SvdIyGjqeYY1dR
        9Vyu6w/DMIQZlStz6yHXLkT+gsE8vryGCnuBpPI=
X-Google-Smtp-Source: AGHT+IFlpOOMIQcebK//OmgLDxINm94aUHzKnhQSTpywWKlBwwV3Ybm0q9rBuswIv/7FYlrjkL90fMQ/dBQYnjQTcnc=
X-Received: by 2002:a05:6214:4019:b0:64f:6199:a8e with SMTP id
 kd25-20020a056214401900b0064f61990a8emr539663qvb.23.1695417733188; Fri, 22
 Sep 2023 14:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com> <b80c6089653bffc59faaa585e29d8c46a0611e83.1695392028.git.gitgitgadget@gmail.com>
In-Reply-To: <b80c6089653bffc59faaa585e29d8c46a0611e83.1695392028.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Sep 2023 17:22:02 -0400
Message-ID: <CAPig+cStknyQokREpjbmEisAqmZ8f2n2MemSAPoqf_FgRVe9Vw@mail.gmail.com>
Subject: Re: [PATCH 1/4] doc: switch links to https
To:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:14 AM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> doc: switch links to https
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  #include "git-compat-util.h"
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -3,7 +3,7 @@
>  /*
>   * JSON data structures are defined at:
> - * [1] http://www.ietf.org/rfc/rfc7159.txt
> + * [1] https://www.ietf.org/rfc/rfc7159.txt
>   * [2] http://json.org/

Shouldn't "json.org" receive the same s/http/https/ treatment?
