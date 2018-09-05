Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319431F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIEXkN (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:40:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43100 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIEXkN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:40:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so6948228edb.10
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48rZ2nGoD8E9W55Gob/gJk97xlUXtE4FDWNtxjgKv5A=;
        b=HXGjv5RprWW8Ic/EgViQ2wImAAK+JMK20U2yjey3jZrc8vl25xgmWCBfEop5Rq2LQQ
         UcO9VkLhOhCC488lPD8E3yvdNJtXfeDVOSrR8sDO/Wfg2SNQqHkROroGlj6FRK1vTxEk
         kJQnfvHffQH5Z8C8soRmpkA+T+Tz1BxLGJXCVmarsRn/SHkV9NuYl+DcWFyMx1ULqSip
         hnV1TLdqrMM0r7qiQSkNFONE+8wzy7801lyAQEmBe+3mi9PJP5e4DbmAeUh9mck0RlN+
         SxxH7KGWnhv4NXBw+hV/u+NOWc8jTCmC+q/QIWI2v/ZkqPimFqEZ7QmKOGRiwPVuyfTy
         qB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48rZ2nGoD8E9W55Gob/gJk97xlUXtE4FDWNtxjgKv5A=;
        b=D34FIPCb2hWH+cgV5yBe1R2UazI1V3vN8N9ICsqPmUPALOBm8gGT3cCYJu2EsMSiB+
         dVSd+CiNRH7dEWtmJjX7ifwQfMkf4EvY/fnlLFXho2bwoxcisJ3CLcxkWhRrMR0iv6wu
         8Xm6JYR8uP0tcvHqe1JirnLTlxCyJho5jpwrmpf7GVz0LALz9kMnjjzRgDMufEa6CUVA
         rT/CC0rjUfyBI2JiODkWmOKWzz1VHBIgofErbAC4vwvYfN4QY1qFJby148ey9bwcB2iL
         khw7IHISIhEHate4LIxHBujaWnxuchn2pzvNL3neaiSa+zIpl2Y23/ExrB3ZVO2sfSeC
         bGpQ==
X-Gm-Message-State: APzg51DtHOE5OA5Ku9pnUaJVKGPsKifuuqEhkKDyGxS3DJTarJLNmZiA
        U7FXgH1moWzY/SHFPVlo1XfcTDazCGrc959JetHd6g==
X-Google-Smtp-Source: ANB0Vdb55VjWXdANCjRlEzmeOeba9nprCS8V0wMv6iDmCHRaFx7s9Ed0BNS0l4chuDKrZoyLnu2ta/9yLTXgVBmewtY=
X-Received: by 2002:a50:ad0f:: with SMTP id y15-v6mr43716893edc.78.1536174520953;
 Wed, 05 Sep 2018 12:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <25914342-ff35-90b2-860e-6aff5c109f14@gmail.com>
In-Reply-To: <25914342-ff35-90b2-860e-6aff5c109f14@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Sep 2018 12:08:30 -0700
Message-ID: <CAGZ79kZiA+0R6QB5qgVDUSZBZp_Nv+Yi-SQC5yHeWTzJnw1y8w@mail.gmail.com>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 12:02 PM Sebastian Schuberth
<sschuberth@gmail.com> wrote:
>
> On 9/3/2018 11:10 PM, Johannes Schindelin via GitGitGadget wrote:
>
> > The one sad part about this is the Windows support. Travis lacks it, and we
> > work around that by using Visual Studio Team Services (VSTS) indirectly: one
> > phase in Travis would trigger a build, wait for its log, and then paste that
> > log.
>
> I'm sorry if this has been discussed before, but as this recap doesn't
> mention it: Has AppVeyor been considered as an option? It seems to be
> the defacto standard for Windows CI for projects on GitHub.

There was
https://public-inbox.org/git/BAY169-W30CD27F2F7606F4DF52944A78F0@phx.gbl/
and
https://public-inbox.org/git/alpine.DEB.2.20.1703241242210.17768@tvnag.unkk.fr/
