Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F261C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 22:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhLLWae convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 12 Dec 2021 17:30:34 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:35443 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLLWae (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 17:30:34 -0500
Received: by mail-pl1-f177.google.com with SMTP id b13so9924842plg.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 14:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wJlt2qdwxbNt3w1wWTBcukeO4yjYFSkTXNJuwXnmsPY=;
        b=1YQM7+Xij2k7e+SVb3aZtWZ7yJkKygR5DISw5gNBEdlPdGp8w9XlAozh1yN0WWYJpZ
         kTfBOp5vn9vRzwqt0HrO5ON9DJZvMp0GsTvx1FGlDS1+dNDqqHiWpkMnKEVlRorwZSjz
         gS0eUQ+tpM/dGiItdQP6WIU0hoip9MYkWorPs/lcyTGAfbCUHvG9CzKi4NUGPsJPXquy
         TstvbaE7euqgOo2VSMyVZnOizXh15NdszhOKv3OmnQRfg2TlH2/mcj0d4e383p+AGJoG
         OlzmJQJKwf9tcBwrLbbTEvaCRQeXWffgkzioy4wwMi3fI+V6Y6oLmLjT1eR/VxQNNVhM
         8gwQ==
X-Gm-Message-State: AOAM533jFnolCKa0DKWs7Gv2LwNfwg16i+orT4JhB1jOuHRkWBabvhmC
        h6MPZTGJaInhSuxdxmVPo+0lLz+qH6gZP3uLbC8=
X-Google-Smtp-Source: ABdhPJxsREvUsz7W3USe84hKuKHTfnufAR3gQGr1GFgXx9mC6uD7pNUgBOvbWqWZuswh1CIzCDE34C6Sg/djm2K/YOs=
X-Received: by 2002:a17:902:7d8b:b0:144:e29b:4f2b with SMTP id
 a11-20020a1709027d8b00b00144e29b4f2bmr91231946plm.57.1639348233607; Sun, 12
 Dec 2021 14:30:33 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com> <patch-v2-2.5-b2d73f8c9da-20211212T194047Z-avarab@gmail.com>
In-Reply-To: <patch-v2-2.5-b2d73f8c9da-20211212T194047Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Dec 2021 17:30:22 -0500
Message-ID: <CAPig+cRb5G7y+Sn3+dQYQq51mTCDTUg1mcrGLjJJ3uoreJ0dsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] git docs: create a "Git file and wire formats" section
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>, Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 12, 2021 at 4:23 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> diff --git a/help.c b/help.c
> @@ -38,6 +38,7 @@ static struct category_description main_categories[] = {
> +       { CAT_gitformats, N_("Internal file- and wire formats formats") },

Should this be: s/file-/file/ ?
