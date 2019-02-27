Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC709202AA
	for <e@80x24.org>; Wed, 27 Feb 2019 18:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfB0SSP (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 13:18:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44301 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfB0SSP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 13:18:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id q128so14738922ljb.11
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3z+Q1YDmXtNtCx2PElYbgXjnxw5XUlV/X1BkPqXz84=;
        b=GkAAAr768Miz4+UfuUOSAsA4dnNcFJdrlbk0UU1F5zrPDkaAiELFFUTVRe2ytfuVDN
         qrIeOjuCYQ1W080wU7JIgURKsaA/uVh0U7jVJmsJsYXHQfy0rEeR1a5W/N3ycl6HFU5p
         PAgIoci2F29RxnTJdSBRkyilMdqKRgv00epKvzqqqIqr7u1r4VCeNorySSMfg7NXAcxz
         wJ609XSJajw7mMa4atJ3ZGIYufWloM6BNH0BYgJ71mDVQ3dRApZNJvTATWTGnhEWt6tl
         hKjI7rT4L6/09h+sOsJ2OSTVHFBDQEAsDkJxeI8vjakyo0QhN+dE49VPyAUe9tboHLlo
         GufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3z+Q1YDmXtNtCx2PElYbgXjnxw5XUlV/X1BkPqXz84=;
        b=maNprRBQUQ/6U4gEYdFHtPA4eYUao3nB7BOfP8q2S2q6sVYv0Ywy3y0VISXk40WQgS
         kgIY9dnTv2qMd3OfTkkuM+qfE7hW9S/DK9iDivJDtA1RvvXocsIuiKnH3uqTRkXQB5ok
         H927xCR67JP+BWgGihMYr4h2BatnfPmPdiu9eTK7bm06bC+qTbgHP9JW0SL6OlxTAVn/
         06hKXq+Fi9kpmUv8HmYNKpYqkcTr7S4J0rw1nbSwGDqRM8rlG8JJfEk3AWwMbvYt5zUC
         kuEfwJVUTQCFKN2uZw3JZxcyCevAOG3VAs9FQh9KDQi+xQ5azgeShScdrHYJAqS57wwA
         eFHQ==
X-Gm-Message-State: APjAAAXcDPg+AnZ1oQ5d/g/a5Oubd5LE8sHVpk+th+AYdwT39P3ZnfWj
        3LxgP/GHEk1EWHVbjZIBhxNL6yTd
X-Google-Smtp-Source: AHgI3IZvE3wRgUtnMJcvWNyZYL+2IqFGp9JlfrRKIJQJzbna/jw3PrsNn6DRzPnEgJa8uyOxzxiDSA==
X-Received: by 2002:a2e:9e57:: with SMTP id g23mr2230846ljk.124.1551291492537;
        Wed, 27 Feb 2019 10:18:12 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id f19sm547297lfk.69.2019.02.27.10.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 10:18:11 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] asciidoctor-extensions: fix spurious space after linkgit
Date:   Wed, 27 Feb 2019 19:17:51 +0100
Message-Id: <cover.1551290936.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAN0heSqLbn7dRu4eARpyMqhFYpj3Pr5i=EMPnQZK9hUfWmf-KQ@mail.gmail.com>
References: <CAN0heSqLbn7dRu4eARpyMqhFYpj3Pr5i=EMPnQZK9hUfWmf-KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like v1 [1], this v2 removes a spurious space which shows up in a
large number of places in our manpages when Asciidoctor expands the
linkgit:foo[bar] macro. The only difference is a new paragraph in the
commit message of the first patch to explain why we need to explicitly
list a file we depend on.

Thanks Eric and brian for your comments on v1.

[1] https://public-inbox.org/git/cover.1551123979.git.martin.agren@gmail.com/

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

