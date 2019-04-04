Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D62E20248
	for <e@80x24.org>; Thu,  4 Apr 2019 11:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfDDLIw (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 07:08:52 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:44403 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfDDLIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 07:08:52 -0400
Received: by mail-io1-f44.google.com with SMTP id u12so1575989iop.11
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4W0tljdPI41weG0qBYGP46D73hmPCsav8sMZTKpiuUo=;
        b=nuKoqrsBuhqC6Cx6f+iVGsixhWGwZ9GPjqUeklmbyodIyd6qNJjiJNtiwYIs/ksl7b
         Yr857FSF+aWUCs04YSyGMdB0RO3Tetnv5c1Jn5LR9vRO9i80Osm8ExqlFqeaOUnc+2PK
         TcVBBCiTbhhPIX9zgmvV/+pMgFonMno5jCoAz62U2yATnb1AnS7fDdZoLmIrDV7J1P/y
         o9Odr4DZx+m1cni2+JISVRnflj3+JEdDVftWIUucjJ1gYCAXmaJN/y+Q9wfP1JRoyZqJ
         vrSYsvPCaC48kVhzOGbCBJ31st4BRCghhklxXdQzTVyJqRHzjDQFt3d/3tnP5m+7mnIm
         edYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4W0tljdPI41weG0qBYGP46D73hmPCsav8sMZTKpiuUo=;
        b=re+Jgbnr+cXC4OnwucuEdueXDQ8joFSmAeuRY52/I1en87iLZQE62Lo8v4AAI422Xy
         sj/fOxrRYvv+a9Xvv9qLzydVRUm7vK4eUg/0TSgP0SNJ/EGT6eG7qazOv9GUYsRpTO0l
         hFKZEZY0lJnP5eLBqqbYlxMELdaSFc2apWBjXnqIhzvvIM6XYsIA7ls2xjoueYhBl0pK
         fxheOfC7iu7gDrJ4sBKTK3AVBTqgXWH05NPfzRG8yGW2rGAFc03uDpHJq8GtU4aA3ULv
         Lf0iey0tuaxftzFObkzdaSrcsv/McsGLW/pMdIB8+jjPCwSfX8lI4y9PJycTShglaM5k
         B77w==
X-Gm-Message-State: APjAAAU+tfdScZbOBOKzTWgM02ZNEGynW02yOXvwiCZ0Dsna5fRfmmCP
        FxJj9cpxl65jLolaUMQqztZ3r5HBfl+abnm0EfE=
X-Google-Smtp-Source: APXvYqy+eP2Oqfyv+WfF+U1bJxUjVnTkATKJbQ/Sim6xRq+/NPa2KHiOXaI54OSgd6k0/XYD4KWBHAmee8Gao8K/f+Y=
X-Received: by 2002:a6b:660d:: with SMTP id a13mr3913075ioc.186.1554376131580;
 Thu, 04 Apr 2019 04:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 4 Apr 2019 18:08:25 +0700
Message-ID: <CACsJy8CmkFNv7Fy+rSY0Q=1DhYSrpSfU=XEpSS6QRLASJtsVew@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 4, 2019 at 5:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> * nd/precious (2019-04-01) 1 commit
>  - Introduce "precious" file concept
>
>  "git clean" learned to pay attention to the 'precious' attributes
>  and keep untracked paths with the attribute instead of removing.
>
>  Will merge to 'next'.

There was no conclusion from the last thread if I remember correctly
and I kind of gave up on it. If you want to include anyway, should we
go for a more specific attribute (e.g. "clean") and leave "precious"
for later whenever it's better defined?
-- 
Duy
