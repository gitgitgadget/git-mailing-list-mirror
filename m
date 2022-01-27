Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD18C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 07:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbiA0Hbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:31:46 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:38448 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiA0Hbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 02:31:45 -0500
Received: by mail-pj1-f53.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so6713556pjj.3
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlEmH+YjuLJR6XDjANLnJN6rdF6HQX6bMHHZfqQkiAI=;
        b=e0N4f20ouA9e0LlSfGswibSANPjP6IbZ4iXm+CMOanBkResHh3oltX6QU5ZnbKosYg
         7l/n1q2YxAjlS06if1ZnJNnlduiQyUoS2+6xn+1Rr+8DwlSwh9UDO3hP0LDF4JAA0lBO
         3gR8bQAy6PeuTrrJzwaF+p/tmGZpvbMVBV2PKB3FqXFs0R9d5Otrg2HcGMx3R2C7T2kS
         jCoA1TQedz+JkNtCCY+aQNH9dAkmgyTBG88/OHoBPNkMplZSIBzdYDEKzHgY2F4TPpU5
         j/pgcqzy4qnv/TWa/sz23Vh+4G3U4hbtmxAY/FIv4cXPJOesz5nkKMhvUN5du0vPlCro
         pDtA==
X-Gm-Message-State: AOAM532vJ0PFF900wBzzMO73gkq8ADBBH11Ey/Ag68GyqbeTH0LvYrNo
        jod/mnk9Dg5E5ZwQTjrpR3Glpyp0fja3L06mRlI=
X-Google-Smtp-Source: ABdhPJyoKpTi5C8dWxXmkyRLeLfGc2IwJ4k8k6w5uTcT5QMMRziW2zpV8PTMc453VSBiK9z87Q71AVtVRcQwB44yWVU=
X-Received: by 2002:a17:902:8c8d:: with SMTP id t13mr2376687plo.35.1643268705391;
 Wed, 26 Jan 2022 23:31:45 -0800 (PST)
MIME-Version: 1.0
References: <xmqqilua89z5.fsf@gitster.g> <20220126234205.2923388-1-gitster@pobox.com>
 <20220126234205.2923388-3-gitster@pobox.com>
In-Reply-To: <20220126234205.2923388-3-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jan 2022 02:31:34 -0500
Message-ID: <CAPig+cRNwjaRtqLcGrz-oE+C+atAHiRgXTDTUTisgDabkOvcMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] CodingGuidelines: hint why we value clearly
 written log messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 1:32 AM Junio C Hamano <gitster@pobox.com> wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> @@ -26,6 +26,13 @@ code.  For Git in general, a few rough rules are:
> + - Log messages to explain your changes are as much important as the

Nit: Dropping "much" makes this sound a bit better grammatically:

"Log messages which explain your changes are as important as the..."

> +   changes themselves.  Clearly written code and in-code comments
> +   explain how the code works and what is assumed from the surrounding
> +   context.  The log messages explain what the changes wanted to
> +   achieve and why the changes were necessary (more on this in the
> +   accompanying SubmittingPatches document).
