Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39FC1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 08:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfF0Itf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 04:49:35 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:34053 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0Itf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 04:49:35 -0400
Received: by mail-ed1-f50.google.com with SMTP id s49so6337675edb.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=B4aCRleLZ/FkF3QICmRqHdmu599brz9U5AesIvY25g0=;
        b=fGf8uzQdWp8P9FE/IBAOJJ/LHMLN1xNk7y4Opb8Z3sXorH82E1quHYXPDvzeecfOzP
         myfqT/RK4lR2UpxhcWzR34nCz4+j0x2dSuOKmC00xQCNrOGYt1z7CfHbqXA2oFqujtlY
         cFkB+jKudfeNuIW+waRbtTsjQPa1Iy+8pY2MZc60B/b5r22Kx/5pD3CZg+hYS9Pu2o6o
         SFll9lFr905oApCa7pSUI/eaYI4m3l34mbD6Pe6j24koHAS8nOjt1WTQaUYaX0wneM3n
         Qk9PSdBclctxJWh8M+qoCCIxlkypZ8L3gEQJlMAq674a/06S5/c7jgn8AoFkYzWHYJ6l
         6NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B4aCRleLZ/FkF3QICmRqHdmu599brz9U5AesIvY25g0=;
        b=Z1QijNL6e1SEURvGr8tiowk9BP+NrWgaQVImtHzapZsIJ7OfieA8vLP0EcE0Y8Cn2o
         f4OJRzMuhZkXHQlcxJsvuWGGx04ALtgReDhsD9eajlqq9TrEr7z8pH4NV983/78zCRzI
         XcS5zjFHGitwFP1LG4WhwT1WL4Wp4gKPn8jK9tpRoTTOa6iStsi59MYhIIF3AcW0vTCe
         x9of12fN6FJ3YOU13Ux5W2pL5VsWnKwQ+4frt0Om0mMjsAkw1ZI+0zOYM4BrxaNOlsg/
         UClCLyCOiCzXx3FpOopnW6X+ilE1/2o2r+aCR8PdAu48fz+0bitgn87baTH90GgplHJE
         eqRg==
X-Gm-Message-State: APjAAAWlLSp5pmcrJ6UOjk7h/w9iIpFzkyGXYSgfvN+gD0f+lEcm6yK8
        9MJOAz4KNXpr7fHUnl+G8JkVvwnF
X-Google-Smtp-Source: APXvYqysEESe7fI7MzXg3Le0KOH/i56BoR7VJbvPX9548HjKXgnuw9v2X6C2nEUUG7nlofHHfQk0xA==
X-Received: by 2002:a50:976d:: with SMTP id d42mr2646992edb.77.1561625373606;
        Thu, 27 Jun 2019 01:49:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22sm522601edd.25.2019.06.27.01.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 01:49:33 -0700 (PDT)
Date:   Thu, 27 Jun 2019 01:49:33 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 08:49:31 GMT
Message-Id: <pull.214.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] windows: embed a manifest
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, you can embed a "manifest" into an executable that changes
behavior in subtle (and not so subtle) ways. Let's embed one, to be able to
define precisely what behavior we want.

Cesar Eduardo Barros (1):
  mingw: embed a manifest to trick UAC into Doing The Right Thing

 compat/win32/git.manifest | 25 +++++++++++++++++++++++++
 git.rc                    |  2 ++
 2 files changed, 27 insertions(+)
 create mode 100644 compat/win32/git.manifest


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-214%2Fdscho%2Fmingw-manifest-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-214/dscho/mingw-manifest-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/214
-- 
gitgitgadget
