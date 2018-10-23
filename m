Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1499C1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJXBQe (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 21:16:34 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36478 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXBQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 21:16:34 -0400
Received: by mail-it1-f195.google.com with SMTP id c85-v6so3001261itd.1
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AeIPnmydPHsvSRtV0jXdXVpVJOqa9ATUBKX2MXu0PjA=;
        b=nb0wGGcM3mHaCBUVX8suXoIgHBihhmpN22+i0tV2y7YlhIHm/Tb5ktfs6h0dHX+Wm5
         sa0FU/FU0nXzqc0cFj+gJgrsqO20J4kOdZcYZDiLXhGZUMl3GXZtTUdfqYSjITpWJYmQ
         KJZb1mef2lW54ouv85Z+KVAomDgbFOAcvnNAkxJKZNC4YoJddSdpx0gXySYkAlmCRfSo
         1T+AFqrbw5pfZ+mSCjnTeiviRFArU8JC3E/LX67heKdYu+K54A9h52SRJ2P5ceSp+tkL
         eZtxOy6kZvKacsPTHqUkaAQ5cMDVCU9TD9gyGKtGOaUiamC8hHa019/xKcZ757zMbLEL
         d+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AeIPnmydPHsvSRtV0jXdXVpVJOqa9ATUBKX2MXu0PjA=;
        b=ehZg0x3eBBQ2xEWWM+Fo6TjCb48dMsiOJpP+VOlpEfM0Ix6J8ay+jphHdww5foreQO
         U+2l5unttAfXd3HF/yAO3+0IT9+QlvT3h2gRfSlKHyteDSnvZVfQv0mZpa7SH4hHMtTi
         wCW44nEiJMBPYKVX402pFpUmBduBhy+SLGLzYDqD27ZWUB8H76mLytQy7Jj5vn5JOdO/
         ksI8z7XD1oA6ySoHh8fWI2q3AWN2kG0e7ko/I1BVUF/tK8YM7rgu6jCKuoT6u5rQMngN
         3gU4xOBUiHyMuCAe25TWs+GovrzqxJpk/PnHYv5tOY+FnKLQpOwqXWNLEr0n3sZeld+n
         +awQ==
X-Gm-Message-State: ABuFfoiBGZWfgYg74GrsVsyJRv4TtIhUFssvaX3fm+2pKukt/QOAMeqo
        HaxOWyU2kuU5NsTe2ckckjyxbf9ZB3N2oBTyqHE=
X-Google-Smtp-Source: ACcGV63Wi2GFNomyYZ+64CptK4gmgMPaZWOL0drIiNG+r++Jb1EOq+JiTLNXOANbcLlUDyp0gh+BZwM2mJFOkgIAOj4=
X-Received: by 2002:a05:660c:18d:: with SMTP id v13mr13310654itj.135.1540313542729;
 Tue, 23 Oct 2018 09:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181023113416.90958-1-carenas@gmail.com> <2518b1ff-d16d-da95-fdc2-698dddb61a36@web.de>
In-Reply-To: <2518b1ff-d16d-da95-fdc2-698dddb61a36@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 23 Oct 2018 09:52:08 -0700
Message-ID: <CAPUEspho2MB=AruF565XaCPL7e+RmfT9iJtbzDAMfFpAkrzoNg@mail.gmail.com>
Subject: Re: [PATCH] khash: silence -Wunused-function
To:     l.s.r@web.de
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 9:19 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

> With Clang 6 and GCC 8 on Debian I don't get any warnings on master or
> 36da893114.

I see it with Clang 7 on Fedora (at least Rawhide but suspect also to
affect the next release, now in beta: 29)

> With Clang 6 on OpenBSD I get warnings about the unused khash functions
> in delta-islands.c on master, though.

Apple LLVM 9 and 10 will also trigger similar warnings to what you see
in OpenBSD and as Junio mentioned recently in a different thread about
semantic patches, this currently affects the CI for "Apple":

  https://travis-ci.org/git/git/builds/444969342

Carlo
