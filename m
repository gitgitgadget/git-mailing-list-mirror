Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCCC77B7F
	for <git@archiver.kernel.org>; Sat,  6 May 2023 09:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEFJDF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 6 May 2023 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEFJDD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 05:03:03 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721D4EEA
        for <git@vger.kernel.org>; Sat,  6 May 2023 02:02:23 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-3ef3887e3c0so12780431cf.0
        for <git@vger.kernel.org>; Sat, 06 May 2023 02:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683363727; x=1685955727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5WkqhOyxiUGiKLcRNFoDT94SmV5ftTCGRc5e6FT1Vg=;
        b=PZH8C/Kt6DZkow9LjM3Gfjtfvy/VqrJnzNqrMbiB9DsTzL4GJao8QBUmeEHNHf3SNu
         v2DMI1o6CJJ0abaLtWtETgucGK1GszvnUHmqQeFS+W5XVKvgoNz42hWeAuRQT8rcTdNe
         3cpOP96acAFrDiPWOgUIuwmLnoZFKH4KTRWNS1bGM2wb3Xz9aNB9BUL30pmNLUBbAjfh
         yg6Dt3h1leFGK/8Pwf2qoAxm2wUwCm/ppzVqNmmazy/h8gMhQkrcRvtreX+F17D3NCAu
         P/gfJ0Zt9I7ajzF0mfUVO0lP9howV4hJNF9ae1C7arAa5yfKSYrWf0FJSbfwOztn+GXp
         ik0A==
X-Gm-Message-State: AC+VfDxyhLjEqSiU5ApZrsR1oDkwEXleQvhZCi6pRgiri6GEkZCFJCvA
        eSMtlxBapZI/kmc30/YwM8SYPh/hmfweJBh4XwrkYmF8
X-Google-Smtp-Source: ACHHUZ5G2lOdJMTYV6v/OlG2NchxgH4kcyxgscqfCOhgLnoeEidHvyAtNMRZXNPo3VyM67IcQ2eAdM+ZLOmMdLseWyQ=
X-Received: by 2002:a05:622a:91:b0:3e4:e641:6b1f with SMTP id
 o17-20020a05622a009100b003e4e6416b1fmr6472981qtw.55.1683363726978; Sat, 06
 May 2023 02:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR01MB2318693B28B740F75D90E1DCF3729@MWHPR01MB2318.prod.exchangelabs.com>
In-Reply-To: <MWHPR01MB2318693B28B740F75D90E1DCF3729@MWHPR01MB2318.prod.exchangelabs.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Sat, 6 May 2023 11:01:30 +0200
Message-ID: <CA+JQ7M-MHvtLf=p5+JWEG6ec4r-X0JzFxV0eVhrKNWv8jNLX1g@mail.gmail.com>
Subject: Re: Suggestion to provide a way for screenshots to be added to commit messages
To:     Shafiq Jetha <shafiq.jetha@benevity.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2023 at 4:56 PM Shafiq Jetha <shafiq.jetha@benevity.com> wrote:
>
> It would be nice if we could add images directly to commit messages via git.

Maybe something similar to what git notes does 🤔
Then again, maybe it's easier to just do this differently.
Like keeping track of this using a markdown wiki in the repository and
just storing the images as a part of the project instead
