Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1181F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 12:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfJ2M0f (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 08:26:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36520 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfJ2M0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 08:26:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so6923424plp.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eB81Bvt9oaE78DN4xFIxH5iFNm8lJ/SyN/LYmZAGgLE=;
        b=AjWWL18vxA+F7UDbgP73aLMknJHe/XJcNRnIGNCzAzLiDQXbBXwEV/bjtGm5jE1GWJ
         4KR46PJZapsdZ3larW85lSC1pwuPSIHpt2tNsaK9yTWJQF7b0tjVqwP2xcPLNExjs3fV
         cSmnAIige/41FQouMS/g50rFYqqBJt4FeHx6D7xmCN20uNirtMMT7zFLWPVT1/61c5yD
         Rrek2dwnErgYRcrzFf4rKphnSS550Mba7eqm+MLLede21dprwB5sUAm/Sk7dZLOqEsJ2
         RrMXtfhX7FBc8s2phT72BYbs2CP5EZF1GWArA4yS0nmN3NoVfuvd9JxGqqkJW1cmz0rS
         Dvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eB81Bvt9oaE78DN4xFIxH5iFNm8lJ/SyN/LYmZAGgLE=;
        b=t67qvrB829Wd5NoRxbdvd8QrW4CByTNSn7gv1iNWwCC4j5d7WU99hdCkCrn6d78pYe
         eXHin2dRuhpbbUa/f3dAu/FOPoXO9k9iFr9m/e938np0ufntZupiINQYODXZYErTiTSk
         LMEt1SAGBxOIPBfX/P9NuxzRbyaq+VHqZYdg6kd+Rtv7QWgjyL7HPKhRqGCmGW6T40SC
         8+N1ddW2NnP6P2hB8LkZr4metaWvyRUrPzrOH9ZWOkKmqBgdr6sqESIu7OzfO7VDhipI
         NcVS+2iTXq5sNPlmZ2viXEujMrw1ksBrFiOCRbYktsWVwuOiRogmTBtwB3eQ5FjZjg/d
         WtCQ==
X-Gm-Message-State: APjAAAXXOQ9lybt+v2S3jFBxZCtNYRwmwCw5bBvU+Rw3cOXuvE1S9RTO
        BULYdOUsDD3jxOJE39m8T0lLdPbN1IuOGiEwGViN8dIx
X-Google-Smtp-Source: APXvYqyPTKg68tfbwc8JwSf1uOB2rMsbxyc7Ds2DO8GxPU7/W+9w33icGfGwK8AjlkCYkXP4zRBymkb8gCq3Si+zMdY=
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr3874136plo.32.1572351994004;
 Tue, 29 Oct 2019 05:26:34 -0700 (PDT)
MIME-Version: 1.0
From:   Arkadij Chistyj <arkdchst@gmail.com>
Date:   Tue, 29 Oct 2019 12:26:23 +0000
Message-ID: <CABf25VhaqrbtRTpL5ZNRy59o4JSsiKpF3pk3+54sDCkvzdgAmw@mail.gmail.com>
Subject: Question - .git subdirectories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello. I'm not sure it's correctly to write to this email address.
Sorry if it doesn't.
Copy of my home directory stores on external disk under git control. I
have devel/ directory that contains some of my old projects with git
repositories. But main git repository in root of disk is not tracking
and storing their contents. I don't want to use submodules or crutches
such as renaming all .git/ in subdirectories. I just want that git
treats my .git/ subdirs as plain dirs with any other names.
It was already described here:
https://stackoverflow.com/questions/2317652/nested-git-repositories-without-submodules.
It's very simple functionality but I can't find any simple and right solution.
I just want to know is this possible or not? If not possible, then why?
Thank you in advance.
