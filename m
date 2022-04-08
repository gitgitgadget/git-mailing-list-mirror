Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26284C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 08:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiDHIMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiDHIMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 04:12:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A268D424B2
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 01:10:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b15so7765025pfm.5
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5/RumQZOupAbdgfOfPQRvt0RL3qrtfMNvNX/XAzr14=;
        b=LmaqxWChxxxJvx5JNrAtGnvjflTzVd1YPCn2rc7FnSX2Dd80jZagy66DU+EtTaF4a+
         mpky7bIK4Xsh6XlDQu2ACq+iaUNY3DJ7T+9k9YfdKGV3rSEuxqascMHxmqv9QRNpL8Se
         xMAqehPOKZuU2ZJxESox7OJvhAkgnBaCFfxa0E+BmalANMrDQZ/pJpFOwqUlWob1Vqyp
         t4y2RlxbA9+ontNBUYkxBJXcHSWiWC1Pca9zgwWz9LnZ3beZzUjXqLBLgYFAPF9DIKCc
         z8nveQ2giiqeQp+sF7qn7B2P+4g7pVUgbck399DNQWeVaPSP+MK/XKP0frG2maRe9zgP
         fjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5/RumQZOupAbdgfOfPQRvt0RL3qrtfMNvNX/XAzr14=;
        b=L5kZ9wwGDsHkoYrI9QL8pv675U7zok2Zw28DBh9Vakwwv1cygqTJ3U1FViXU422Iyv
         NEDZ7m7ntCTENkS7O7wewRqMizSStNGJ2+qhz75FSUdzjUo2dDICTiB7qHNr5fhjE9R/
         qrUbd9M5hsZb6pde88fwctsV9IskMMWg9CJ8O22BvvQbnxylEgjKjYizXUFPGWoPrBwa
         XgH3/wo1kYtDOKekNulmvjCZfcMCrVJbE0/XXK+6/5xh/E7bFDMOVL9CSSER2JKHcAwu
         iFThn5028gQMtlUf5trf9gj1E0FRcolqSA/vOlJ8S2li5f7iIL6MSI52uXI1XYCm0jyJ
         Mtuw==
X-Gm-Message-State: AOAM532r32cri2wQ5wvOrWMrQKz8BQwr6uP30WCBkb8WcnfDHGtHEGvX
        ou7WjxasctJOBdovQd3DxZd6RLmi6We/Zd/USn8=
X-Google-Smtp-Source: ABdhPJyfYJCKYqNIVuRg/kLdVVEKy9YPebXsE/Mr73/uC6IPWFb49O7qSZ2coo5XOtgldAKk3AlfDrGmboCWBbLzthU=
X-Received: by 2002:a63:4421:0:b0:385:d870:d598 with SMTP id
 r33-20020a634421000000b00385d870d598mr14548688pga.361.1649405419998; Fri, 08
 Apr 2022 01:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <YkcmtqcFaO7v1jW5@nand.local> <nycvar.QRO.7.76.6.2204072346410.347@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2204072346410.347@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 8 Apr 2022 10:10:08 +0200
Message-ID: <CAP8UFD2fN=c2JvvzH94Nu8yqt2MOOtXrn29eFxuie9aZ5YVjQw@mail.gmail.com>
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 8, 2022 at 12:39 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Fri, 1 Apr 2022, Taylor Blau wrote:

> > To that end, we have a few options about what to do with the website in
> > the future:
> >
> >   - Convert the Rails application into a static site that could be
> >     hosted elsewhere for free. The non-static portions of the site would
> >     have to become static in one way or another, and we'd have to come
> >     up with an alternative search mechanism to replace the existing one.
>
> This is my preference (and I would love to contribute the time, but am
> quite short on that resource to help much).

I wonder if this could be an Outreachy (maybe next Winter) or a GSoC
(2023) project.
