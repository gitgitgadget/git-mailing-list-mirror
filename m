Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADAC433F5
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 06:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbiDXGVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Apr 2022 02:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiDXGVu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 02:21:50 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4289A15CEBF
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:18:51 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j2so664794vsp.5
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dorianmarie.fr; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ON1dxAjV1kTcb2MMXmoOeOzwTCYKo0v5wSoxa0/V0Hk=;
        b=LhcuZRIFMGQpZCO8QIqZvBMOKOGdAyS4Q1Ugxy3FWNAgk+pqh/1eWQ4LM+dJDg2nCS
         V/MUvTTayE2KI/0TrtdrKQMMnn82xb4xaPqUEU8H8PpXPKT/IaD6O+NbyZ+5r9qv875b
         7TkJ96RgjHXLQwaQ3W52wRzblCFxQslWxsXbfhilJNhZvRG8EicnaMng6FH28wD4+qZC
         vB4wIg/EdguolfDFT/GwE7vh9D9HqvnLPB9h957UiOYBAD9Sepn4Oy2m1brDikvV6Fdv
         GjwOiQqvPMLRQLwhdxE9Yh9a82FwRI7JzbDNk85kFovDGdMxKPfCxL7X++NEA6cs26uZ
         7LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ON1dxAjV1kTcb2MMXmoOeOzwTCYKo0v5wSoxa0/V0Hk=;
        b=ddVTxkWX5F47pCheRG0YnkPsYgpEOCJRsfURr6yZucFbkJd19/iwwxcEZpIlRnkDKe
         oPA0LUcGWzIcnfwZtl7tn8WtQwH+MBN093SaQsVNgeR2M8EcBLlD5LlfbW3ohAbBzLeR
         Yvnk5Dp/Dq3oR/7LaNOICbaVC7iaYHqTcUHq56vsXf6LuOcEd0nUVQ433TGuKgAihkLl
         CLgCMxV94ewqOQuMvbHFXE+6dm8241kYI0NI5Gjxzm0qzAUgGhQ8GlgiFu+eq9TtctW9
         hVdZiuONftOjuzrZExlb/2TeTiEs0tTwPcO++hl5dQK5EH1Smd+CiSIhAM8f+WjU+YKR
         lKkw==
X-Gm-Message-State: AOAM533PiXSAbmA/yoK8o3IIJ3tJnD/ePb1OuG5m98ZQ9rwLH2NYZqr8
        2CmyAunYV9dwahrd+n07LpEGt18kwdFwxVTmsZvxAfw/lWhLkr0k
X-Google-Smtp-Source: ABdhPJwrbZE4pGIuhyz1MgthfqWmo2T6EH7fwvUoE16KwiuBzAAV7L8a2NsE/rS/M0p/NosSVWX9AMO1e8F8iDGJUc8=
X-Received: by 2002:a05:6102:3d8f:b0:32a:44bf:d67e with SMTP id
 h15-20020a0561023d8f00b0032a44bfd67emr3579523vsv.2.1650781129309; Sat, 23 Apr
 2022 23:18:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Dorian_Mari=C3=A9?= <dorian@dorianmarie.fr>
Date:   Sun, 24 Apr 2022 08:18:38 +0200
Message-ID: <CAHZPcmD3xmsuM5XQzczqKQEcVXXXc=c9cH9cpqDNPTpBrwd2iA@mail.gmail.com>
Subject: --help for git commands
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I think it would be nice to have a simple help like other programs do
when doing `git [subcommand] --help` or `git [subcommand] -h`.

It would be a short version of the manual.

What do you think?

Thanks,
Dorian
