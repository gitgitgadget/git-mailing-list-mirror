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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E54E1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 03:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfJODbb (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 23:31:31 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33380 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfJODba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 23:31:30 -0400
Received: by mail-wr1-f44.google.com with SMTP id b9so21928595wrs.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 20:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ULLubQfFD2esh11XEiBSymgJWZynMP989uKGMGfngH0=;
        b=rNZ+3iqzmUkcPi0BAwEoMj7IHeSD/tshVX2IEQYSEVcqVYEPvZBXuPCnOEZNnJe8Lg
         aClaJhJ7zo+GpPqzAtTS5glT77tRpnx63b2cX8Vfgyoi+gIo+0SgbpZmb2+2uURKEBaK
         60c4Y07YfCGOBM7WgMLiNbavAuoZBtPAdI106iDJR9OvNWCF8ujzGskSls5iEGD1SD/2
         bVFj5VYgiCaG9dv5kenCrA6ZTb7fInKyZmOpHtcFOXzkEgMt/ablXs+UZ5flmMCOIDSW
         KVUCti6HGg+/NXKbhLf6zOf6o9F2UEXf2vN15p74kZvbdh7r7D0HdlLtg9uyJIq4x3f5
         7mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ULLubQfFD2esh11XEiBSymgJWZynMP989uKGMGfngH0=;
        b=pZLNUbEYyYQCnLRTNfAT+heUB5Ezu+jhvmfSfjtg0dfGi0F3/oQj0v3fXHCqjgu/pT
         2+8H9ixenvzUixDsiUdhVYXq3gnaVZuP/v4xhKbUrWU/TsnBP1Of6fBHIK0Mftb7pjb1
         CC5IGUSiRUR3Py7SFjJ5InGffXhGEvy4QOmWtkfdEboXbKwif/XFzddIAxm2g8ngSfyE
         2zyifrshLG8S7Mi+WZ6fats1AsA6V1YD+jAHQsxvziLBbt00pfDO7FooZ76qi7aJEe22
         3Q+Q4ZIOBPNXooQCVuDVH/mwGzATfi3ATCqmjnVXN65+rIUsWR/QnEkFZ8MTHLkFoGW7
         MPeg==
X-Gm-Message-State: APjAAAVIlbMndEvd+ZpQ4a5IWk0ZMqKShBTA+/cQlhD9nN7VLfdYq5Mr
        mnnVkSW+HcCWXd6F32ZAsMSVmXws
X-Google-Smtp-Source: APXvYqyZ3yYeUI2rpnB4rMJaGNX+JXuApn8PGYJfZZ+uRPcb6FuqxAdHz+0s5HhZ7/Q4fyBYJH6iIA==
X-Received: by 2002:a5d:6745:: with SMTP id l5mr24438228wrw.51.1571110288660;
        Mon, 14 Oct 2019 20:31:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d78sm27649555wmd.47.2019.10.14.20.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 20:31:27 -0700 (PDT)
Message-Id: <pull.397.git.1571110286.gitgitgadget@gmail.com>
From:   "Norman Rasmussen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 03:31:25 +0000
Subject: [PATCH 0/1] diff-highlight: fix a whitespace nit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Norman Rasmussen <norman@rasmussen.co.za>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This changes the indent from
  "<tab><sp><sp><sp><sp><sp><sp><sp><sp>"
to
  "<tab><tab>"
so that the statement lines up with the rest of the block.

Signed-off-by: Norman Rasmussen <norman@rasmussen.co.za>

Norman Rasmussen (1):
  diff-highlight: fix a whitespace nit

 contrib/diff-highlight/DiffHighlight.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 08da6496b61341ec45eac36afcc8f94242763468
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-397%2Fnormanr%2Fdiff-highlight-whitespace-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-397/normanr/diff-highlight-whitespace-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/397
-- 
gitgitgadget
