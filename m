Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFBEC4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 20:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjAAUJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 15:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAAUJp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 15:09:45 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7FA2AC2
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 12:09:44 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id b12so17269500pgj.6
        for <git@vger.kernel.org>; Sun, 01 Jan 2023 12:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6R907NUIv63GtrFK5x7QC7GrpPNT85TFwgnxGznSuU=;
        b=EKPTsY2ROUT0rG6Yj3VKWa6Twk/JHJ+trfW0yfVxLfM/MqqGyFFFN4O3XXFS0eB7V2
         dWOn0tmxUEBh4jBL78Ymqbi/ik/h4fPkD5v/aHjRIP7xF2C0M2ehJ+0mHe+eSGCuETam
         nDXu43QQ9kmWH9BQsYaLbFMollveSRKUcXWKTkenEaMJWzMQXdVvWioZX0gVRK8iQTc4
         I7QMLzCy7kSZyOeYXjPiVUJhCRFa97CEP+Ry/SDUiV++i5jDyNWj7dlF5zbqNGt3De23
         eX1v3KdfUqauSII9skb6EVA25JQ3+XcxZ0sR8MBdmqQQeNGbmteZqJ6gAwyUkDzCsX9u
         BRXw==
X-Gm-Message-State: AFqh2koZrmyaIUC242nqcubksz/kqsiYOV8W09zXqX/J5m1g8Nz6pc2F
        ufjhZuySjmHtVXBDiJ7BiAkImXNqeOUqF8eh/IXSWWgP
X-Google-Smtp-Source: AMrXdXtEgqBWrLIE2qesXrAArMsFUaDXMGfLU6AdfFkTefXM9274ZfoFX1r5Nho5kacdgi4ZQW8FFnflnnAAYcZ2ssY=
X-Received: by 2002:a62:ae17:0:b0:575:c857:edc0 with SMTP id
 q23-20020a62ae17000000b00575c857edc0mr2409178pff.22.1672603783707; Sun, 01
 Jan 2023 12:09:43 -0800 (PST)
MIME-Version: 1.0
References: <46647d82-56f1-350a-a697-543d8f86ae1d@tsoft.com>
In-Reply-To: <46647d82-56f1-350a-a697-543d8f86ae1d@tsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 1 Jan 2023 15:09:32 -0500
Message-ID: <CAPig+cQGFnQwevsSuBkLkWxLaTam0j6rgoDNPHvT9kOfOoBMsg@mail.gmail.com>
Subject: Re: 'git tag' returns tags not in the order they were created
To:     Yuri <yuri@tsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 1, 2023 at 3:05 PM Yuri <yuri@tsoft.com> wrote:
> 'git tag' returns these tags on
> https://github.com/out-of-cheese-error/the-way:
> [...]
> The latest tag is 0.18.0.
> 'git tag' should return tags in the order they were created.
> Maybe they should be sorted by date?

See `git tag --sort=<key>`.
