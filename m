Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85390C77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 21:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjERVUo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 18 May 2023 17:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjERVUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 17:20:42 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E85E4A
        for <git@vger.kernel.org>; Thu, 18 May 2023 14:20:41 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6238cd06d5fso13349696d6.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 14:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684444840; x=1687036840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv+RhOsqI10N4t48tcI9NrAQfmtEATmZmULPaYaE8H0=;
        b=EDRHRGnhGATqicgB3H9e3cGdu/b7e8ZhjlWmsDstzvFR9/ZbmI3n6/4Z5w/i3LIrvS
         O1XLSJwoMbJNHnzsTEszyNH6KKrZyshAjI/Tcrx1mcWalgR6UNOc/8gPc1dtY8dx2Rai
         goxhEm/AMEro3GJ2ynLtJ+Qts38DeITInE4kwFo70va5uCYqcYj8tS43c1swljwAsgoS
         xo9U5hRwmxlG1AKwkA7I273L3g1eEURADhR2BM9Xde1UBbsprhjaz+YBzJ/zk4UMAKxX
         i+6OwQHLOH8wlUYkTKLFDvHy8/xg+QO2ktxVTh7EtzYxxBfEDMPiXNdiu45jIF3z9Ufn
         YusA==
X-Gm-Message-State: AC+VfDxTbf3nRWJEcOx5BzesJuBCrgLYJ4/j7RCdEKbeKJIQgvLiB8EK
        zMd6W633ljpmGWMUMSopy6uYq39rl7o3SJ3VVR0=
X-Google-Smtp-Source: ACHHUZ4f13sRv6rOHqN0EvP1OChV7suQUeuvsxOtz5l361dJCKCtqlgCkmoK3dRffrak5QxDgzzjdiLx9pqGGi94m2U=
X-Received: by 2002:a05:6214:f6d:b0:623:8fa2:bc17 with SMTP id
 iy13-20020a0562140f6d00b006238fa2bc17mr950645qvb.35.1684444840123; Thu, 18
 May 2023 14:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com> <b974c43ef661db2f34b157c853d59b01f35a4767.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <b974c43ef661db2f34b157c853d59b01f35a4767.1684440205.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 May 2023 17:20:29 -0400
Message-ID: <CAPig+cT_Aq4zZjgf97oytqpox2KAMM_HtCGdfAmt7fPnHw9k3w@mail.gmail.com>
Subject: Re: [PATCH 01/20] t1000-basic: modernize test format
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2023 at 4:04 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> t1000-basic: modernize test format

s/t1000/t0000/

> Some tests in t1000-basic.sh used the older four space indent format.
> Update these to use tabs.

Ditto.

> Signed-off-by: John Cai <johncai86@gmail.com>
