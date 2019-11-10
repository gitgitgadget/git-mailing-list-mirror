Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9241F454
	for <e@80x24.org>; Sun, 10 Nov 2019 01:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfKJBGx (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 20:06:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37721 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfKJBGx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 20:06:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id k14so9148933eds.4
        for <git@vger.kernel.org>; Sat, 09 Nov 2019 17:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xv4fugQ6UqzpPPGDLFFvg3st+07z1W1FNAr6+olyZlY=;
        b=PUOr7yjywybyomvXT2o+poxh0/6Zklm9hacFL0QMd2XpuPinfYuyfagj5sBMbe9zmF
         f3DNMJukOam8/GM/GLUK/qjlmS0layrvWOe9B+Q6aE7qftGuwJ6/18myK2p8wGITwzVI
         2fSacuEMSRir/kMPftu3xfx4PziKB/8+BFlTZ/Amr5R3rucc+2We8wlOaWtzBCzSe7W9
         rFLi1FhO+yL4MpBj4jxl1jezEO0+dQfyAkq0FJ5T1k0VOf7Qh2b+R0F38zJAJZmvVUKw
         2Z7kHZC/uwPa50oLzOYyQDBBEx8Q/VC6nR7l4V5yA3AfxagT5XdZke83JA6ss4K9L8A3
         IBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xv4fugQ6UqzpPPGDLFFvg3st+07z1W1FNAr6+olyZlY=;
        b=E7sL9h5AdrnmjdzAocQICzS5q8YguSGftu1V7AI+pJ9aC45fFxey8DpZ+zIFKwR6gb
         M44eOFxCRaEGxEK7bSAJeesJm/5cYuAokLZig1/7BcmTIcRrQN4LA6CyazYFns9KS2U2
         fFHJ99gGPO/NGykwy7CLjmI9t43qbiLppYypZQfblfDc66hGCDnXQtYnyIsmVK06vDRI
         /Fk2RiSM6hgWwmwgUo8eK31geqEzyYN7u8dML2xeDEyYKz8djpGkFmMvuo0O/itWZpxF
         0RhOpwY97n5ASgQoTwga+/WoKGZDNU41dt8ZyzdFwMwdB4OhaiTieNQue8N805chl9PW
         rlFg==
X-Gm-Message-State: APjAAAXvBFDAHG262FQJ0fMa+j0ImuJ58Zl6GjM9ToDMoTtnqHYbodTz
        4PQqiMXy22ocxPGjQsF3IdyZ+wNNZ0Wn2Oy0VsbdVpVT
X-Google-Smtp-Source: APXvYqxjiupoA9ReIh63Ixt884g0xLMf7LuUBZp4pnm6pVpLjt3EJ38LUP54RHSsqkReG3qfogCAUvGRzmJHy4/Pie8=
X-Received: by 2002:a50:9254:: with SMTP id j20mr19594990eda.0.1573348010538;
 Sat, 09 Nov 2019 17:06:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.456.git.1573044509.gitgitgadget@gmail.com> <xmqq7e4cqk9y.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e4cqk9y.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sun, 10 Nov 2019 14:06:39 +1300
Message-ID: <CACg5j25S8eJN5Sc9cm_DEu50bmaR5fQBT7dAid2z-Be2y_rpmg@mail.gmail.com>
Subject: Re: [PATCH 0/1] [Outreachy] doc: remove api-index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 7, 2019 at 7:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Remove both api-index.txt and api-index-skel.txt as the API documentation is
> > being moved to the header files, so the index is not needed anymore because
> > the doc files (Documentation/technical/api-*.txt) will be gone.
> >
> > Make changes to Documentation/Makefile accordingly.
>
> Why is this not part of the other series?  Without any of them this
> step does not make sense, no?

Moving it to the other series makes more sense, although I won't
consider it dependent on removing the rest of the files, as we're
changing the location of the documentation anyway, and readers will
need to refer to the code for more info. But I agree with you and will
move it there.

Thanks,
Heba
