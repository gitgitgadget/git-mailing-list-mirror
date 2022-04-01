Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D82EC43219
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349779AbiDAPFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349348AbiDAOpv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:45:51 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792BC21592E
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:35:50 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIDX-009TW3-Rn; Fri, 01 Apr 2022 15:25:35 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 00/22] git-p4: Various code tidy-ups
Date:   Fri,  1 Apr 2022 15:24:42 +0100
Message-Id: <20220401142504.58995-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set contains multiple patches to improve consistency and
tidyness of the git-p4 script's code style.

Many of these patches have been driven by the guidlines contained in the
Python PEP8 "Style Guide for Python Code" and were applied using a
mixture of human intervention, and tools including autopep8 and
pycodestyle.

This patch-set stops short of bringing git-p4 into full PEP8 compliance,
most notably in regard to the following items:

  - There is no patch to apply the recommended column limit of
    79-characters,
  - There is no patch to correct hanging indents of multi-line
    declarations such as multi-line function delcarations, function
    invocations, etc.

Patches to correct these items may be provided later.

This fifth version of the patch-set adds a missing Signed-off-by label to
the final patch.

Joel Holdsworth (22):
  git-p4: add blank lines between functions and class definitions
  git-p4: remove unneeded semicolons from statements
  git-p4: indent with 4-spaces
  git-p4: improve consistency of docstring formatting
  git-p4: convert descriptive class and function comments into
    docstrings
  git-p4: remove commented code
  git-p4: sort and de-duplcate pylint disable list
  git-p4: remove padding from lists, tuples and function arguments
  git-p4: remove spaces around default arguments
  git-p4: removed brackets when assigning multiple return values
  git-p4: place a single space after every comma
  git-p4: remove extraneous spaces before function arguments
  git-p4: remove redundant backslash-continuations inside brackets
  git-p4: remove spaces between dictionary keys and colons
  git-p4: ensure every comment has a single #
  git-p4: ensure there is a single space around all operators
  git-p4: normalize indentation of lines in conditionals
  git-p4: compare to singletons with "is" and "is not"
  git-p4: only seperate code blocks by a single empty line
  git-p4: move inline comments to line above
  git-p4: seperate multiple statements onto seperate lines
  git-p4: sort imports

 git-p4.py | 882 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 525 insertions(+), 357 deletions(-)

-- 
2.35.GIT

