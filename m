Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA671FAF5
	for <e@80x24.org>; Fri,  3 Feb 2017 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbdBCS3u (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 13:29:50 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36876 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdBCS3t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 13:29:49 -0500
Received: by mail-wm0-f43.google.com with SMTP id v77so40960644wmv.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 10:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=known.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=gJ4PD3+rUx2e8eZpgVIJqzoHTEwIDY8MgBSy/PACAA8=;
        b=HvkSb4x48y4oVNXdZTD+KIXCd0apFHWmHmw3fNZSU0e8mz/ECK8wpofi6aPrJbj32c
         jSFRj1ulsl6qonEepFtv1vInP0QUOCOpceT/Zho8Dz/FmNUpYbrN+tdFXXENjcklHlC6
         dw2Al7abgqgfRBUl+q9v62lXg6NWMZ4mRvyAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gJ4PD3+rUx2e8eZpgVIJqzoHTEwIDY8MgBSy/PACAA8=;
        b=MjdIIyMAgGZAgiWM8Llral+OQnXoxR7bO8NhITXxcfAdJQ3VbyC4UQfZlu2SpX/0u+
         HU3vuWMuZWj+xY+gkytPCq9eAwXH3QaKK9hr4hszke05CO+9HIOVL5gVAZs0EWzC6fxq
         A8zCC+e35Nyz877OX8CZKEhBEjhF78TxjcquhnJBrrzEFXf4gripfiAj4EB9SZerU2As
         xg50GolmL3v3jTluC8/GTI9RfybuMJghQijWducmNc99IX7AZJCVDPrRJ0olh9XSspP0
         2kvklRKPonBn9SBiMxxAbQ12tQLKgNzCBTt9KVAeAQMihXHwKf5M/VqCZsSiKuE+X2HS
         g6cw==
X-Gm-Message-State: AIkVDXKRImsSBJq39MiOV39hhdz3ysKqAFjEEicB8/PuUxIkybNeVXBjLbCQS8g/O/ZcyhneHq4upHH2v1sKQ/ux
X-Received: by 10.223.135.8 with SMTP id a8mr15991629wra.162.1486146587630;
 Fri, 03 Feb 2017 10:29:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.76.1 with HTTP; Fri, 3 Feb 2017 10:29:47 -0800 (PST)
From:   Kevin Layer <layer@known.net>
Date:   Fri, 3 Feb 2017 10:29:47 -0800
Message-ID: <CAGSZTjLmYCyKZ1BBRv+JVYq4oX7EQcNzyxAnS_3NBUPjr3g8zQ@mail.gmail.com>
Subject: feature request: add -q to "git branch"
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It should be possible to quietly create a branch.

Thanks.

Kevin
