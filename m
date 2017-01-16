Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4455E1F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 04:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbdAPEuV (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 23:50:21 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34728 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdAPEuU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 23:50:20 -0500
Received: by mail-vk0-f41.google.com with SMTP id r136so66773702vke.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 20:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=JRJ7zZTY5YoDTuTq2Rd4Vfsrp6PnOfe2BwPBY0LnvwE=;
        b=Xb5p5FfhUVRSVDqdQ1WeJ7yZsx7TGlJcY4/eTR0avEeILM0PxDzgAE+zgwXwsHiEn3
         gbjbocgBPh0z4oXohPCU5UBnLPfLqopt0C3KdRM64/TbHbTrkEzAP6nKw0V61+miY7qx
         b5pUPkla1E2rltSNH5Haxq/P8zu/EFIH4ZL2B+G6Ak6oVfRyEGwn6QV9Xte/YJ9SXSjK
         rFDfyix3qX/no8TmLgWpRwjkfi3Y69Rva9BXPqfpVnFt/tzDwOf0MVAnQVKiu6oV/QdY
         xlLEv7G+tXGjR9efJOFMwc0LXAMw4GOZ6RgVkthETvCB9QB4jVfzZkmnNKwoQLW4hsWv
         ERVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JRJ7zZTY5YoDTuTq2Rd4Vfsrp6PnOfe2BwPBY0LnvwE=;
        b=R6zUsqWA7WofOWa2wQs2UfYbjyX85AFTXzQnrKeV6uuFkg2esGrcS7Ww6FigL9WTvj
         N7gj9DDQ4QaRslMmHoiAlK3L+nk8z0Jlus63/0Hy5KsfyH1BktOfMeJIdCwfMd2LTdma
         wmbDYrHtCQLN3ZR6V1UA79jalu78WBOzFPOLBYu/bEUYRHJJWHte6vJRfPGjofHL+yLm
         fDiWDfV0uN73Byc88MfaX9LdW9VoKGaSM7qveiiqHxS1Pzs5AxvO+/mpg2+Rts1swxBf
         Qwfh+4tcElL/bA4YEZilCTTUdh8cb39khMqE22uvV0TlLrsi7K65lZ0k4LM5WRJjuO4x
         B2mA==
X-Gm-Message-State: AIkVDXLpD8HgZb6+tX42Bo5m9a3swdYhlIeJ0g9S1lfnZB8asOXsNiqRzZH5nwChaImXd2FjhMIrKGQsoPYUww==
X-Received: by 10.31.92.1 with SMTP id q1mr12499271vkb.151.1484541717353; Sun,
 15 Jan 2017 20:41:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.0.65 with HTTP; Sun, 15 Jan 2017 20:41:57 -0800 (PST)
From:   Alexander Shopov <ash@kambanaria.org>
Date:   Mon, 16 Jan 2017 06:41:57 +0200
Message-ID: <CAP6f5MkOoDUqHCvLNQ+xJGWTbrdecet9W_JK5y7JeAnBpGeAaw@mail.gmail.com>
Subject: Different merges from translation perspective
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,
What is the difference between simple, fast forward, automatic and
trivial merge?
I am updating the translation and the only thing I am sure about is
that these four are not octopus merges,
Fast forward is when current state is ancestor of tip, automatic merge
is when the merge algorithm is decided by git rather than developer.
What about simple (git-merge-octopus.sh) and trivial
(builtin/merge.c)?
Kind regards:
al_shopov
