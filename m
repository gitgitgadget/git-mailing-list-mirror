Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED27C20248
	for <e@80x24.org>; Wed,  6 Mar 2019 10:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfCFKmW (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 05:42:22 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:44124 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfCFKmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 05:42:22 -0500
Received: by mail-pf1-f178.google.com with SMTP id a3so8269376pff.11
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 02:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VhyshgIUuGdeWdK1VUbOh0Y5xBJrGcgfMSNuVNYeznA=;
        b=so3gH+x3q3N/W5LIEwWebzixseUbfEOP9tvSWXSLQryeefYoBh0nCe03FRO3cQYWcX
         0ZqZRti7wljLNbWIwEIKXDUHOsG86N2qSKjLl2fW8RO4iJpgbjNXXtasQZYvDLCrUuVq
         WiuglTVMD9lj0QUkWZHhRIYv7QP0Tm/iufLKcv6v+ro7QjH2O0hrwmFEq/C09gUh3TM1
         oCavB5oglOxBOTGKtsb+kr8jyCIaicC5fNmnWtT2TFv0h5BO4IwZfjlnzBBTlJPTcNEs
         BqUOGKUZ6TFhLJAjyQTXZiP9mYwsggVL4naL1djmY91Rev4kX+ACm3OqYZnmo7GLBFj6
         8h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VhyshgIUuGdeWdK1VUbOh0Y5xBJrGcgfMSNuVNYeznA=;
        b=PTWTo5oiq3iBW3/LFTDI8FRwKINyr7XMEuYeYl6wRsUMYUVXPEZfEQLK2fEFB2Ci4z
         08veRYqFhgo3XS4KCP07eZ39KfdozaO7Qd5SIg6F9Z7qfD2/YJXf4IBPQEiPPUIGVa0r
         IzVVaGHMHv8sIO26w22g3g2VE4iqqUx0gipT0qd+Sqt98DwpydsrM728Vo1HFvlCKw8M
         jE8FtMwY1YTLg8p5s6HVSEb+hHQaTTGnzDpvBt/HNbGO7FRexC+2HP85ekYyQIfUQm+0
         3L2qB8ZsdrHmqlEEpFn+ODlzVVxgoTAfysmUW2t7b7EWfBT83wj9AwzGP0qXlZSDvcch
         gp9g==
X-Gm-Message-State: APjAAAWpFuI0vYwtSJi0tID0iGStIuI7U49BoswvdZueQSKh0hHMfCwX
        j+N1hEwXyLa+JWrkAkgcE/gjXtOv
X-Google-Smtp-Source: APXvYqzF0gw+dx2qUx1oBPVrVXKKGjatlaDaFpQYy+sOcAIuFegRbkegpEy6hfqnmknVG6dQNTRzrw==
X-Received: by 2002:a63:4e1a:: with SMTP id c26mr5640520pgb.175.1551868941690;
        Wed, 06 Mar 2019 02:42:21 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k7sm2613637pgr.28.2019.03.06.02.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 02:42:21 -0800 (PST)
Date:   Wed, 6 Mar 2019 02:42:19 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     rpjday@crashcourse.ca
Subject: [PATCH 0/1] update git-clean.txt
Message-ID: <cover.1551868745.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert reported that core.excludesFile was not mentioned in the
git-clean docs[1]. This cleans that up by mentioning that in the docs.

[1]: https://public-inbox.org/git/alpine.LFD.2.21.1902231328560.2222@localhost.localdomain/

Denton Liu (1):
  git-clean.txt: specify core.excludesFile variable is used

 Documentation/git-clean.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.21.0.317.g7f43cb445c

