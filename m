Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5051B1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 05:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfHCFdx (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 01:33:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38738 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfHCFdx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 01:33:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so46852571wmj.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 22:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=bUAknI2IvsmR5pgtY97xH6bZYF2rdMToG/EFaYYOlqc=;
        b=ZWHYtPkHs/v3s3bttOmLhpYHenmdOmFMsti6feXXz2KqonuYEIto71KOEeFL60T4/W
         IgMnf9xHYx1scGC4zx0FeGSwfv58+sErd8QNbsVlH79qORAgCzAYY0UsuXjsKZEA2Qps
         vuQnnN1ALFfsm+jTjEgU9i+1jofHDO4q7DCtL2b9UajkJ6KZzp5fQ+UKoJjqZUrnLxKB
         i2cez9Y0AlGQckS/HkZfPuFWoCqMP54wcO5dSAR1QKbSJDExHDjC5dxx4dGeG16JJqEH
         IEPurxf2hW5gAwmA1o8ZxXhWU/HKI5+Ci9BgO415oaRU1NNoAb5egms7rnMFBXo9d7Rg
         ZRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bUAknI2IvsmR5pgtY97xH6bZYF2rdMToG/EFaYYOlqc=;
        b=prSltlth8F3ugl1vBQydIYD+XsJOPlnxlBJOydjLldnRtfNJL9LMwbOClhjSz7lr28
         hhJcFQo+vqmg26SHo19dlkyaLGtehq85FJNhdx0BBKIbIm+10A4aVapRov5ubrpnw1nu
         BeUNvlFeEgTrWufWFwV3Q/RtDnG0hzO0VYW7DrSTqDtNZpphnoT9UV3WvRP4DiuxhnNT
         bABFAOInKBudgwfjPVRBOrX/GulUY+dmUvAlBH+3GySt4AZwR8/I7i+yeAjl2aPhCdhp
         YlU5JflNUcIrK8WoNVhHjKuW9zOzPSuJ38Gyrks/iVQhmJh8+Nt8DmKgbfCy5/sk2hsb
         UjdA==
X-Gm-Message-State: APjAAAWoSmjeahNSHGVe4iZGYI2sSnS0BAmWi7EKOYB/WMtUZ/ZwJPCc
        QB5GL4AynltxkSosl4NpfydZ5DeZ
X-Google-Smtp-Source: APXvYqzlT4UNcFh/iIepRNYy6g42C9AiQgEGFtaXgqk/4GzLKdQqD0/hpCRjSECC/VV2fDYs2OgIoA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr7479073wmc.53.1564810431197;
        Fri, 02 Aug 2019 22:33:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm70654790wrv.55.2019.08.02.22.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 22:33:50 -0700 (PDT)
Date:   Fri, 02 Aug 2019 22:33:50 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 05:33:48 GMT
Message-Id: <pull.304.git.gitgitgadget@gmail.com>
From:   "Mark Rushakoff via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix two documentation typos
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

I noticed a couple typos while reading through some manpages. 

First was "...if it is does not..." which just contained an extraneous "is".

Then I noticed a "can not" and updated that and other occurrences in
Documentation to cannot. The glossary sentence with "can not" was
"Consequently, an object can not be changed." To me, that reads like "it is
permissible to not change an object, but it is possible that an object may
be changed." Switching to "cannot" makes a stronger assertion that it is
impossible to change an object.

There are also two error messages, "can not move directory into itself" and
"Can not do reflog for '%s': %s\n", which I chose to not modify in this
patch. I am happy to s/an not/annot/ those as a separate change if it is
acceptable to change the wording on an error message like that.

Mark Rushakoff (1):
  doc: typo: s/can not/cannot/ and s/is does/does/

 Documentation/config/transfer.txt             | 2 +-
 Documentation/git-cvsserver.txt               | 2 +-
 Documentation/git-fetch.txt                   | 4 ++--
 Documentation/git-pull.txt                    | 2 +-
 Documentation/glossary-content.txt            | 2 +-
 Documentation/technical/api-ref-iteration.txt | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)


base-commit: 7c20df84bd21ec0215358381844274fa10515017
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-304%2Fmark-rushakoff%2Fdocs-typofix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-304/mark-rushakoff/docs-typofix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/304
-- 
gitgitgadget
