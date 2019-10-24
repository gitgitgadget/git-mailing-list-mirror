Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41A31F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 11:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438997AbfJXL3P (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 07:29:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46410 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390184AbfJXL3P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 07:29:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so14863993wrw.13
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 04:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VoGIUJ0mNsd6PJee5dDra4xz3vvODE/s+rRcWj5icDY=;
        b=i2mQ4ur/cilLY2b8jn6XC7PtYkNznvh54lS9EXZ5pReGdm72Ce9RuZ9LO+bnTAj76m
         aX2zhk9/if6lybz5YzKLvYpqF97RMjHMad79hCRibhJ/SZXSDU/JD+QXVz99hq3qI8J7
         IdOlr7f32VORP2CLkeIG1Q9GJGaBnHGWA63BLeFrvCOsh4gpK2b8EsNLXcJuXp2TNXQc
         eW3ju1afwVX8VxW4AyWdRNKKRCHA45MDdHpres+2mWR11ah4kofPt52/uFrUV1DAeewa
         btk/9o3imifCg8QMalf17nod04SmqgW2QWv2hrumlB53gflnWjOJFMQDylpmAbTTN/Th
         KzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VoGIUJ0mNsd6PJee5dDra4xz3vvODE/s+rRcWj5icDY=;
        b=JHO6FaTCAZDWeAxGD/qTv+N7cuDX6OhE5pwwZHoDUYlqi7L2j0WIhy0QUIqfuqxMx0
         6zal1VjL9j3hGrIXqZAzwQhsh9bmiD3qdlALZxGmhA2dIKOj7c92sFvCVkby8dpB8tpo
         BSoKOJKeByhdboGRBCfXqK0IwmEgA8MslykZeqOH1BUX5XqNLG1yGEW9rQEBIuXUiaQ0
         RF/n5tbKrkx7uw4nlSu7YB9UR9q1doVNU9pmvsBjzUUFMjxDI2oUW3wseAmYcWCtNf34
         FKXvbZqi8DlweAyp1d2l97lCd3eo1+sNhQgY5u2O5YESt7UK+kXo1iuCVhPEQk6fkWbP
         QFwQ==
X-Gm-Message-State: APjAAAVgKdcftm99wrddzRPScPkVNclfupm/GRCPwLRYE9cDqDNaU7mx
        fAHKVgapd72fcuoYLeO+cZABTG3g
X-Google-Smtp-Source: APXvYqwbQpFFz7j/RNZU4tRJqGQQ5ENp7h93T7wCq7y+lSF18IkfqJJUhSudbp/KVeM2ufkFA+ongg==
X-Received: by 2002:a5d:4ace:: with SMTP id y14mr3473090wrs.131.1571916552810;
        Thu, 24 Oct 2019 04:29:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm18617407wrn.46.2019.10.24.04.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 04:29:12 -0700 (PDT)
Message-Id: <pull.412.v3.git.1571916551.gitgitgadget@gmail.com>
In-Reply-To: <pull.412.v2.git.1571815556.gitgitgadget@gmail.com>
References: <pull.412.v2.git.1571815556.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Oct 2019 11:29:10 +0000
Subject: [PATCH v3 0/1] [Outreachy] documentation: remove empty doc files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove empty and redundant documentation files from the
Documentation/technical/ directory.

The empty doc files included only TODO messages with no documentation for
years. Instead an approach is being taken to keep all doc beside the code in
the relevant header files. Having empty doc files is confusing and
disappointing to anybody looking for information, besides having the
documentation in header files makes it easier for developers to find the
information they are looking for.

Some of the content which could have gone here already exists elsewhere:

 * api-object-access.txt -> sha1-file.c and object.h have some details.
 * api-quote.txt -> quote.h has some details.
 * api-xdiff-interface.txt -> xdiff-interface.h has some details.
 * api-grep.txt -> grep.h does not have enough documentation at the moment.

Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]

Heba Waly (1):
  documentation: remove empty doc files

 Documentation/technical/api-grep.txt            |  8 --------
 Documentation/technical/api-object-access.txt   | 15 ---------------
 Documentation/technical/api-quote.txt           | 10 ----------
 Documentation/technical/api-xdiff-interface.txt |  7 -------
 4 files changed, 40 deletions(-)
 delete mode 100644 Documentation/technical/api-grep.txt
 delete mode 100644 Documentation/technical/api-object-access.txt
 delete mode 100644 Documentation/technical/api-quote.txt
 delete mode 100644 Documentation/technical/api-xdiff-interface.txt


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-412%2FHebaWaly%2Fdelete_empty_docs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-412/HebaWaly/delete_empty_docs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/412

Range-diff vs v2:

 1:  5cd79e24fe ! 1:  ee64a075d3 documentation: remove empty doc files
     @@ -12,15 +12,11 @@
          for information, besides having the documentation in header files makes it
          easier for developers to find the information they are looking for.
      
     -    here's a list of the files removed and if the info can be found in the
     -    corresponding header file:
     -    1- Documentation/technical/api-grep.txt -> grep.h does not have enough
     -    documentation at the moment.
     -    2- Documentation/technical/api-object-access.txt -> sha1-file.c and
     -    object.h have some details
     -    3- Documentation/technical/api-quote.txt -> quote.h has some details.
     -    4- Documentation/technical/api-xdiff-interface.txt -> xdiff-interface.h has
     -    some details.
     +    Some of the content which could have gone here already exists elsewhere:
     +    - api-object-access.txt -> sha1-file.c and object.h have some details.
     +    - api-quote.txt -> quote.h has some details.
     +    - api-xdiff-interface.txt -> xdiff-interface.h has some details.
     +    - api-grep.txt -> grep.h does not have enough documentation at the moment.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      

-- 
gitgitgadget
