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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A90F1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 03:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfJBDNQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 23:13:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32926 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJBDNP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 23:13:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so17786669wrs.0
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 20:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cecFbFfdNtLIj2tZFlPzRak29yNaF+ab+xWf8LmQcPY=;
        b=HWBGIdjUHsZrJdYQPd2Tc8xAtpSbK/PNmTR71EEr2Ri0mfr+vA8c0/CFTKqPoDfghD
         kgmv/Jlyfg1pmZsC6EUYMS3VD50JYSysDb1RZdMvO7TDVzNk6sI7UlycG/fh9khkGVxD
         sGQZ7z+I3hEH6d7ucqNdW0d3Bg6kYKmZ8qMnHAM7Gu6AP5Iaad+PYK5kvhIco7GwOyzD
         Q0KJ5/CPVhKeTMIXkYNCYpLA1fWs1wMybE/Hj7M84uVVOhkk/coFc84kmKDP1WXXYac4
         vL8LiRdwvyEikRWqRG1Cwn7tZcdbD5FxOWyZIihsBUXIJ8PDxMh4WFUTJon2l2kT4DM1
         KjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cecFbFfdNtLIj2tZFlPzRak29yNaF+ab+xWf8LmQcPY=;
        b=dbOxRwgGRFcbTDhMgz8iqfNSGMKQ3uEQ9KhSVbLBVDLKgLtIKr1uQtUUy95S5Kz/ul
         aCJP3TilLMFn3uXNt0ibqYo0o7UV1JB3I4vQru+PZHDuUYJ6opJ9vdoOZIq3hfSZ3pQH
         RrDCbjOu5Slf5j1WRulTEqyfCyrxnhvija3MmmExW3ezBOCvBjvCX96vSTGwHVfUyTsh
         AeT8XJjaXy8HV0bQbRC21Jpb75X5PUeJgZN+xAww+uWqXkQbnAWDpR9G1MI1MvJaK+KZ
         iPX4IDD/RWNZsIo9j7tvaqgOykDuL8dsRXMuH20CBMpYAzbBigeV6ytMeEEKZ+5O+GMd
         /5wg==
X-Gm-Message-State: APjAAAXUk0CzXsh4lIHJT3hpcpqA9f3zWeNbWYlUIQZArdhRXkyIVB0F
        LLgt9YYlZCAEZE8cxP3YjVoOm5BF
X-Google-Smtp-Source: APXvYqx7TXpeqab9pcYd/OgKLJRQELG8y9wCpg34LPqA9wnWvPDGQUQT4fiURAnwh3aoqTg3/oOeLg==
X-Received: by 2002:a05:6000:34a:: with SMTP id e10mr697008wre.364.1569985993303;
        Tue, 01 Oct 2019 20:13:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm15256323wrn.57.2019.10.01.20.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 20:13:12 -0700 (PDT)
Date:   Tue, 01 Oct 2019 20:13:12 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Oct 2019 03:13:10 GMT
Message-Id: <pull.370.git.gitgitgadget@gmail.com>
From:   "Chris Zehner via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] gitignore: ignore comments on the same line as a pattern
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Zehner <cbzehner@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why make this change?
=====================

Add the ability to use # to put comments after ignore patterns. This is
useful for documenting the reason for particular ignore patterns inclusion
and structure.

Right now a common convention in .gitignore files is to group patterns by
similarity, using new lines beginning with one or more # characters as
headings to explain these groupings. This works well when clarifying why
broad classes of things are ignored, e.g. # build artifacts followed by
several patterns.

When leaving comments about a particular pattern it can be difficult to
distinguish comments about a single patterns from comments used for file
organization.

Comments left after a pattern are unambiguously related to that line, and
that line only.

What should this change do?
===========================

The entirety of a string after a non-escaped #, including the #, is removed
from the pattern in a .gitignore file.

Why make the change this way?
=============================

I don't normally write C, so I probably overlooked more idiomatic ways to do
this. This is done similarly to the way trim_trailing_spaces removes
extraneous spaces from patterns.

Potentially this change could be combined with the existing code for
trim_trailing_spaces, but the logic is slightly different and it seems to me
that the difference in naming aids readability by making it clear what the
responsibilities are for each function.

How can we test this change works?
==================================

That's one area I'd like help with, please.

Test cases:

/pattern/to/match
# Existing comment
/pattern/with/comment # This comment is ignored
/pattern/with/\#octothorpe # \#octothorpe is ignored

I wasn't sure where the correct place to add these would be, I didn't see
(and potentially overlooked) any tests in /t/* that cover this
functionality. Would someone be willing to provide a pointer to the correct
place to add these tests?

Signed-off-by: Chris Zehner cbzehner@gmail.com [cbzehner@gmail.com]

Chris Zehner (1):
  gitignore: ignore comments on the same line as a pattern

 Documentation/gitignore.txt |  8 ++++++--
 dir.c                       | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)


base-commit: bc12974a897308fd3254cf0cc90319078fe45eea
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-370%2Fcbzehner%2Fgitignore-pattern-comment-oneline-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-370/cbzehner/gitignore-pattern-comment-oneline-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/370
-- 
gitgitgadget
