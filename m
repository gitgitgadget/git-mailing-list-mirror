Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D7C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 01:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbiALBW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 20:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiALBW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 20:22:58 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4035C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 17:22:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id br17so2756735lfb.6
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 17:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1MJkBh8JTFncbA9Q6e9M2I/C2jViH0eaXvyj/ehxR4o=;
        b=nbuTmfYB3xDPyuoizVN3dwmIzpxWimlq5/C/boqbpWxt5ZrIILSFxUm+ODeUAOMkeh
         ZmZFkkK8eXFLNqCnDq6MomjVb+AVfPg7hoaOVd2Fi8zr5VTR152lbbwTlnWshtAbTHxd
         GYgOHFEbHcxLKadUQLwfqqC9YFcKod/y7EhQEzRL3rwTdYLoSQKxt7udD9M+WihloZnL
         vFdKQHsF0/uXWWQEKymBBJH+oT8bavsHbqNhpU2Swat8eE8zOCtLOB4pjjxmSei1znQn
         yLbJ20kozSzOrRNs+wP7PFuJ1x0heDX9Djc2PYFhB7BO9sUVXloZHWCMLicRHVqomzdp
         Bl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1MJkBh8JTFncbA9Q6e9M2I/C2jViH0eaXvyj/ehxR4o=;
        b=aoaxA0t8WbLw0U5A5aqsAs9LdfY+Wu4fGQgt0pArXx8meWeHHveGrHlxTyPJNxd3pT
         qV6nBpviqPB6qkkXMqLN+Nr2iG0uuWoP2GLTl+6yvsX6kcR4Db/0cEEO9wbvFR5vXXAK
         8XrxThSb5nNJP6J5lDgMIrlPXB8AWSCOk17SICGEm443FBJXck0xBZjKXfz5ijtBFx/N
         3VzNWzqXYeOdnUFPYXU9TJxwlC8uyrU2kO3nX1GIuEtY/TXapa/BUpXPq6YrklJuIMUz
         +VTnrZDldZYxuqMz1W9yoB5nZxDzzGBiZ4L3kGdc5vjH/caDbK1oEWOzS8/V1ArYTEvk
         eJcQ==
X-Gm-Message-State: AOAM533NeakcMCl79hPW4t0aEbClZDhZ+Wvj3YPhHwdO3u2rzUl2/vyh
        cq49HlQ+SPaxfBeDmxUSznheTXvdv73zsJ+mWXIivtAZ//k=
X-Google-Smtp-Source: ABdhPJwEwjFrLUR/jjEEC3PUVQQGJ9xvwdJtj6DeEaIadIfwMV7mArtRk6BCHUokc2JcQ6HMuLm6amm3KCHmmp2gOCk=
X-Received: by 2002:a05:6512:3689:: with SMTP id d9mr5069580lfs.195.1641950575899;
 Tue, 11 Jan 2022 17:22:55 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
In-Reply-To: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Tue, 11 Jan 2022 17:22:44 -0800
Message-ID: <CAJoAoZ=T6SJh=gp4BbEbw1F2VSnN_NBeh+dKiTihR7vewLh3zg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix SunCC compiler complaints new in v2.35.0-rc0
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 5:21 PM Emily Shaffer <emilyshaffer@google.com> wrote:

ugh, sorry for the thumbfinger. Please ignore.
