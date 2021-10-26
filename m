Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D429BC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 06:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D7560FD7
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 06:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhJZGFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 02:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhJZGFd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 02:05:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B766C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 23:03:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w16so926356plg.3
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UNFXdFBIPrW+lMmyS5UXde6GeC5LC3b0gN3OHk9cKbA=;
        b=ioI/gh1yN1vIc/GwXhgMsiWlt0J6ErgszZvFfeqtoyctfpC+ng9vQGxz/ZJRxiad37
         6UyA/Hst5eiV6pTgsMN3sX7bSygKEdlb2Jz5qSX1wBBeo3p6/ayEnUEpRsGtukDwdpKi
         GHTmnHofomjlM9s/QnZKwLWFo7bxKWNELf4u9eXu70u5AVh72D9kT3oRgjQ4uf3O+cXg
         K7gZj3+XXgWaNYK/3tMhhBd8/aEs4RvEnDRc6/gbrp7chYWDBJkowN6/SBegPwdxGkzI
         JYvLrLKhA61CR718eUKJ38HfCP4zALrTIcgBz0FN/ji/VYTtdmHimtkX95Piu0z9qeMU
         gnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UNFXdFBIPrW+lMmyS5UXde6GeC5LC3b0gN3OHk9cKbA=;
        b=qKJHq+0OceHLG8yY6SruUK886wlBjpeMTvtGGNFXUSmiUWj+eJmwSfNx19BoyQrQZk
         WPuRTRrAwtteSTkA282mEtd9Do91z40NzuooyNYH8iPbjT5MDrm+Fy9eTSW8kMQgcDwM
         1KMAddkoBdu2bUtoOZ1GGWGfStsS7xPSc/i9bd8+rACtHIbP38Y7DEPwQY2lbMfFT0yP
         H1UQYChgKf/hcNKKrm+QaH+jvT/X7JLp3SMc20sLiS+kEHza7K6G4UcuALJbCsKNAhWk
         qAw0yvpdWUYazQXnQDgLT4n10rv9uAeNBvQXiJLbXoPMH0RGLSGKT1Meciq4X4Ao5XKU
         YuWA==
X-Gm-Message-State: AOAM533q3KlGr0LwI7r7HFKQ5Wv4GbgVqPuPfbiDqwvqYV4u2dXm05sf
        mln2Kc+Bqkev5n4JjCfVYIrr5TeEdneoOyoMJpU=
X-Google-Smtp-Source: ABdhPJy5trjYhwdnqjqg8IJk9hEvWxlDB8aBgHeu1aFZpp5WSKHYNQ5vRpc52Xr5wg73Pq8rov7j+8hvEnuhVaZk6BA=
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr39544588pjb.221.1635228189733;
 Mon, 25 Oct 2021 23:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635094161.git.martin.agren@gmail.com> <481447f9-7222-d9fc-269f-2de50299fb09@gmail.com>
In-Reply-To: <481447f9-7222-d9fc-269f-2de50299fb09@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 26 Oct 2021 08:02:44 +0200
Message-ID: <CAN0heSrco2P9cwhDNkXeO1xNMAr4+Mo1+0Y-UEhF5vgrkBOa3A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Documentation: change "folder" to "directory"
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        "Dr . Adam Nielsen" <admin@in-ici.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Mon, 25 Oct 2021 at 11:19, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 25/10/21 00.09, Martin =C3=85gren wrote:
> > Martin =C3=85gren (3):
> >    git-multi-pack-index.txt: change "folder" to "directory"
> >    gitignore.txt: change "folder" to "directory"
> >    gitweb.txt: change "folder" to "directory"
> >
>
> The same logical change over three patches, why aren't they be squashed
> into single commit?

Old habit, I guess. :) I tend to find that having multiple patches aids
reviewing. Within reason, obviously. Reviewers don't have to go "I agree
with everything except that particular hunk", but can just say "I agree
with everything except patch two", making tracking things a bit easier.

Similarly, if the patches are all independent (albeit being about the
same topic) and it comes up that a particular patch is not such a good
idea after all because reasons, Junio could just decide to apply a
subset and leave the rest. In this case, the commit message of the third
patch assumes that the first two have already been applied, so they're
not completely independent, but that's about the only interdependency
there is in these.

I'm happy to go either way.

Martin
