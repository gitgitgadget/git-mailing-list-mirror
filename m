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
	by dcvr.yhbt.net (Postfix) with ESMTP id E55FA1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 07:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbfJWH0A (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 03:26:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38409 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389633AbfJWHZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 03:25:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so18521365wmi.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GVgYUvbp1TiWXHlMMawE9cK5QI8FSOMFtuypPj6tQG0=;
        b=ho8S0Y9LkjrCtRH2rl4BkliWmEazODBQwD9/vzEWxSsU1l6mvXT0GXL7chaDIHV5Rz
         GuxfTX5RV3V5z92GP+R0u3DV5bDyd1ofFaRBFlOQCIsdTpOJawrEWjgM4TtMGdlI2cGZ
         6w2HGtB8OSAiQ3VxQKFCcEff3OdwrzYfdm7hrA/KATY7N3xuuyCA9OFu0iZJbw9jhGW4
         sePItFiJcu0ZKxiSK12oBWUP/BAU29KrszptOeHQF25xGDC/alzPjPlbrm5UsrZ0hqk3
         a6dqupiFlMQT/C78ELNxhZc07JtKFAOjv3JfP146ny28YF+szgxMVGsUUeBVb9vLMaG+
         S+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GVgYUvbp1TiWXHlMMawE9cK5QI8FSOMFtuypPj6tQG0=;
        b=J3YJbSCJk6ZJdOu7yWGxGntREyKxDcgk+nCylp5KHjREzrC398mMd/nEND5ss2nJvf
         BuTLl6ko4z02nd28Sc2mSoz3MqNTyKoDIGF7mT1PD1c/WdNiYz3id7Ev5EOAKRE0iLyt
         Tm8Og1geOzaiUkG6hBMqLbdaNtJKDezf1BO/iS88fhPNbh3FPJdHT5dooZG1kCESI1KB
         1DJtvyuw/edLc0QidhSCc/i+Bz878ewXriVkOuLfJn1QoXiEIYuo8SgXG0iORZjX5htL
         Ll6s8L1wUG7RHQrxjYJ2ZHZWjjPMGXg6c4vcomFNqKX/xPVht7mrkKieL8xJe3cx5zwi
         nzjw==
X-Gm-Message-State: APjAAAV26SZi+uZ1I9yH4V4RNmgTAdSqhUHCg48t7DFpXDXRfSkDkeqn
        J+QilCJmJiID7EhTZ9x96o2aSs9U
X-Google-Smtp-Source: APXvYqwQqA4sU8SJcQ+ebKzVshcorVIJ42ItqyhFK0Xaq5QS9L7T1AgOu5dE6uwqXtEkp66oDE59Mg==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr6525029wmc.29.1571815557500;
        Wed, 23 Oct 2019 00:25:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7sm22209749wrv.40.2019.10.23.00.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 00:25:57 -0700 (PDT)
Message-Id: <pull.412.v2.git.1571815556.gitgitgadget@gmail.com>
In-Reply-To: <pull.412.git.1571768375.gitgitgadget@gmail.com>
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 07:25:55 +0000
Subject: [PATCH v2 0/1] [Outreachy] documentation: remove empty doc files
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

here's a list of the files removed and if the info can be found in the
corresponding header file: 1- Documentation/technical/api-grep.txt -> grep.h
does not have enough documentation at the moment. 2-
Documentation/technical/api-object-access.txt -> sha1-file.c and object.h
have some details 3- Documentation/technical/api-quote.txt -> quote.h has
some details. 4- Documentation/technical/api-xdiff-interface.txt ->
xdiff-interface.h has some details.

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-412%2FHebaWaly%2Fdelete_empty_docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-412/HebaWaly/delete_empty_docs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/412

Range-diff vs v1:

 1:  ffdde613d8 ! 1:  5cd79e24fe documentation: remove empty doc files
     @@ -5,13 +5,22 @@
          Remove empty and redundant documentation files from the
          Documentation/technical/ directory.
      
     -    As part of moving the documentation from Documentation/technical/api-* to
     -    header files, the following files are deleted because they include only
     -    TODO messages with no documentation to be moved:
     -    Documentation/technical/api-grep.txt
     -    Documentation/technical/api-object-access.txt
     -    Documentation/technical/api-quote.txt
     -    Documentation/technical/api-xdiff-interface.txt
     +    The empty doc files included only TODO messages with no documentation for
     +    years. Instead an approach is being taken to keep all doc beside the code
     +    in the relevant header files.
     +    Having empty doc files is confusing and disappointing to anybody looking
     +    for information, besides having the documentation in header files makes it
     +    easier for developers to find the information they are looking for.
     +
     +    here's a list of the files removed and if the info can be found in the
     +    corresponding header file:
     +    1- Documentation/technical/api-grep.txt -> grep.h does not have enough
     +    documentation at the moment.
     +    2- Documentation/technical/api-object-access.txt -> sha1-file.c and
     +    object.h have some details
     +    3- Documentation/technical/api-quote.txt -> quote.h has some details.
     +    4- Documentation/technical/api-xdiff-interface.txt -> xdiff-interface.h has
     +    some details.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      

-- 
gitgitgadget
