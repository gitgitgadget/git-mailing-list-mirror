Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DF9C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 00:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBOALO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 19:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjBOALM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 19:11:12 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9D28D34
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:11:04 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so379160pjw.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfdPT21yLz42D9MsWaIc2aYbVRF+REp1jz/n8joLz3U=;
        b=mnEgfRLDrIkK71bhVvXB9eWBILQrSA+aYHWpSHjtr3pL/46OxPdAeQNXGjw3HEH4Kk
         R1P8Je8ezlAMVGYfNa+XQCAP9aNL2Aw//7gpeTEZ1/hpPan81pycc/T+cqxHWrbfJPqD
         kmuQ+xuH/k1QhWw27/57ovIcXWvAWa+ROm/cKxtCGZAUMaWz4qd3z4n14CLpLtHBEMxI
         BzBSAajeVB3orpDmO6iwrgqmknYpZoqSnaSIl4e4doFyVSTSKhDHheDeARYopMueeIlO
         vYiHHIeOFgP3OlQk+rjpWwfUkPjnVRxdZibl7D0rjHlcSHt6m0Pl5jiy6wEm04/e74p6
         8ALw==
X-Gm-Message-State: AO0yUKXWggHQWQlI+YzCzTtjtqkFZEzYLgEvCPMZelQ5GKJPaqEHA7kQ
        vFQpPZibu129SAn5tXfWapsenYv+UNs9t07NxgA=
X-Google-Smtp-Source: AK7set+s7vlKSDX/cWepZmi/X8nyb4O7rswCasjJg7A9JrKAAkKsHEPf9B2bqPStOjKtttIinZ19V0GKlJjo3UYlDqw=
X-Received: by 2002:a17:90a:4107:b0:234:190f:87e6 with SMTP id
 u7-20020a17090a410700b00234190f87e6mr294125pjf.8.1676419863607; Tue, 14 Feb
 2023 16:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20230206211823.8651-1-cheskaqiqi@gmail.com> <20230209154417.10763-1-cheskaqiqi@gmail.com>
 <20230209154417.10763-3-cheskaqiqi@gmail.com>
In-Reply-To: <20230209154417.10763-3-cheskaqiqi@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 19:10:51 -0500
Message-ID: <CAPig+cR9pjxnr6PzyTiPULVvKW6Rc+GMeMTGKKp4F8+cWuZdgg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] t4113: indent with tab
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2023 at 10:50 AM Shuqi Liang <cheskaqiqi@gmail.com> wrote:
> As Documentation/CodingGuidelines says, the shell scripts
> are to use tabs for indentation, but this script
> uses 4-column indent with space. Fix it in use tabs for indentation.

s/in use/to use/

> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>

The patch itself looks fine.
