Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D31E20248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfBYUDI (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:03:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36896 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYUDI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:03:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id a17so8582046ljd.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrBNkQNFB6snKDldTAYiRHjr2Ht9ObeSd4Dd96MBbYY=;
        b=Gp0e1W0POlSfv4qkjW1aqXOdqLOCU52P69W4HEfh+3kCK/+NHx7yHo37Uf+UbVlRlQ
         ak/phcGlAmPbGug+SfU36DBD6imYfO33PxNrnjpbPwRO1BSnsRSN/h6nAgm3XL9xNb/j
         Cm9wBkEdypJIGDK+LE4kN7CpujcUDchDhqCMKUlJkeMz4ooBFxjcOJGGKSisAQY/ixUd
         JWQEyNdqTYRFhO9eBc6AyesZBezacw/cigW9Vmtcpg2uuKjS+5E1f8Tg4badTcpYB6jv
         yEZa64NpDmwg28qAxiSflPQ5K26KQF/pM5+kieYUMFoI2xsNSFPEJmqGuWjoYSWZ2K9Q
         yQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrBNkQNFB6snKDldTAYiRHjr2Ht9ObeSd4Dd96MBbYY=;
        b=MkdUMYLp7ZIRRvG7p6Bcb5TAUyC9KJwGsQicJgAWshP1HOIyW9HzJ4X5JPtzFnA4h1
         Sq6VQ4tuivUFbz2r4SNq/XG16CQpqN5trcojXpDNqLSRSqv130tccVr7Tpwgjgw6jjLo
         si4jahOHNKlCstbzRo6/TBJw+kGJJFsRExYIseHdUcMedrZMwkvLVFTuDyZWUbVVozTx
         wJoa3EwmRAVwyC9usE/ys+tD9Djx88yrgZj5nhKIoNEuTII7p+WoUXc4RQmCt910KViu
         VHY9BNf8Zy93DMv5r+/2a+4vj8dDvOMQjtQpV0ZO+cA18GTeW7vPn3MX+oPnX6sDC91j
         u3og==
X-Gm-Message-State: AHQUAuZXWM1sCnLqzAEIK6nvyyl+XzukvUMKpFBDAE7cbS7WqKw5IHAG
        ibjg70I56ZYBXWpf2E+5z6RiyUOk
X-Google-Smtp-Source: AHgI3IY8CRf8D3HqKC7lwcCCiMB56Hwlqh0GWpdfmSMfopu1hwP1OrqINALB9erubTIceaJtsVC9Rw==
X-Received: by 2002:a2e:19a:: with SMTP id f26mr10740161lji.26.1551124985756;
        Mon, 25 Feb 2019 12:03:05 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c22sm2977168lfi.27.2019.02.25.12.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 12:03:04 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/3] asciidoctor-extensions: fix spurious space after linkgit
Date:   Mon, 25 Feb 2019 21:02:37 +0100
Message-Id: <cover.1551123979.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch 3/3 gets rid of a spurious space which shows up immediately after
Asciidoctor has expanded linkgit:foo[bar] if the macro is followed by
punctuation such as a comma, period or closing parenthesis.

Patch 2/3 adds a missing dependency to the makefile, so that the docs
will actually be rebuilt with that final patch. Patch 1/3 isn't needed
for this series, but could help someone in the future, similar to how
already having patch 2/3 would have helped me...

Martin Ågren (3):
  Documentation/Makefile: add missing xsl dependencies for manpages
  Documentation/Makefile: add missing dependency on
    asciidoctor-extensions
  asciidoctor-extensions: fix spurious space after linkgit

 Documentation/Makefile                  | 4 ++--
 Documentation/asciidoctor-extensions.rb | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.21.0

