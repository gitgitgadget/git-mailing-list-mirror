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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4FA1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfJ2KAw (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:00:52 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33298 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJ2KAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:52 -0400
Received: by mail-wm1-f50.google.com with SMTP id 6so1610184wmf.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6hGr8mV8hP3kHOJTfTt1XqkbxN5CxkB/lM8VOYOeAWY=;
        b=BkaE+BKZQth3NfARqV1FM9Bkxv/l8gxlUdn97mM4TNghCii6ALkOCeQBzbwq5PeQ9T
         nj4/ujHSOJ3ul2ohTq1qkPxDbt9U6ysppTsZlydzldGU4bG5JNM4jHhEdbqlR0oUib2A
         qTBmOh6byiRE4xVjF3RfBHo7xW55Mph0o5/6gBQ8zkdC+EDtKQ3kbhW2ypfIgemIlxwz
         pxkeOVSawKqFDaRB+3AGR65XSqp3IbmtBhpEFLUcasH/KxMLW7nIJN6o6RybL1p5RUTx
         +Gyqa7GeVmPpBakBgQ+n+LwyCWXSAXiX14f5ZtUjsi1Tcnv1mDzx7cOtV34O+zrPvCr6
         ap+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6hGr8mV8hP3kHOJTfTt1XqkbxN5CxkB/lM8VOYOeAWY=;
        b=OxoymJSafJNr7IgIQHmZs8o2YB01BgTL49jRpo+GCn+vcoAWp2WBRSQhOHhIaPl6Sg
         M4xiSEmu0deku2TratOKZCoEZ4seENRqWyrgLaMVCR3wSKTOAGjojshRkVTUAxX6ZbZw
         pZkPOHDtuhQiq7n0NUdmnlAWCpI7OGFzEJpeMlJ1HZm561n6kelBfhVBf95JS8SJh5pV
         teW8wCwYiCI0Ic+goMn6toM18HOJ9CS7PHEUFtO59XErZYnsYTvwp89NOkWiZ/kmGDyj
         wffVwD+pKA8mFoGjaT6a7rF7a6wSXPsAA/Cij4Z1eqvXOQP2mgwo/qOhUZAezu6Ma5+o
         EWWQ==
X-Gm-Message-State: APjAAAVuv47LZJS3py/Bm90zR51TDmxyEA8llcMQ0em228SmmFs4HZeC
        U1yrdWiPIX4awL9dBPp7u6KzgPCG
X-Google-Smtp-Source: APXvYqyKIzbC/e08t8hlfCHCF+SrSpT0Oeh/uV65aZkhIU3sARQMSlSqIZ3zqB0dyS/lXdu7RbMSaw==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr2940929wmc.24.1572343248347;
        Tue, 29 Oct 2019 03:00:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm1516126wro.18.2019.10.29.03.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:47 -0700 (PDT)
Message-Id: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:36 +0000
Subject: [PATCH 00/10] [Outreachy] Move doc to header files
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

Move the documentation from Documentation/technical/api-*.txt to the
corresponding header file, as it's easier for the developers to find the
usage information beside the code instead of looking for it in another doc
file.

Also documentation/technical/api-*.txt is removed because the information it
has is will be redundant and it'll be hard to keep it up to date and
synchronized with the documentation in the header files.

Signed-off-by: Heba Waly heba.waly@gmail.com

Heba Waly (10):
  diff: move doc to diff.h and diffcore.h
  dir: move doc to dir.h
  graph: move doc to graph.h and graph.c
  merge: move doc to ll-merge.h
  sha1-array: move doc to sha1-array.h
  remote: move doc to remote.h and refspec.h
  refs: move doc to refs.h
  attr: move doc to attr.h
  revision: move doc to revision.h
  pathspec: move doc to pathspec.h

 Documentation/technical/api-diff.txt          | 174 ------------------
 .../technical/api-directory-listing.txt       | 130 -------------
 Documentation/technical/api-gitattributes.txt | 154 ----------------
 Documentation/technical/api-history-graph.txt | 173 -----------------
 Documentation/technical/api-merge.txt         | 104 -----------
 Documentation/technical/api-oid-array.txt     |  90 ---------
 Documentation/technical/api-ref-iteration.txt |  78 --------
 Documentation/technical/api-remote.txt        | 127 -------------
 .../technical/api-revision-walking.txt        |  72 --------
 Documentation/technical/api-setup.txt         |  47 -----
 attr.h                                        | 141 +++++++++++++-
 diff.h                                        | 127 +++++++++++++
 diffcore.h                                    |  32 ++++
 dir.h                                         | 118 +++++++++++-
 graph.c                                       |   1 +
 graph.h                                       | 121 ++++++++++++
 ll-merge.h                                    |  80 +++++++-
 pathspec.h                                    |  34 +++-
 refs.h                                        |  51 +++++
 refspec.h                                     |  16 ++
 remote.h                                      |  57 +++++-
 revision.h                                    |  59 ++++++
 sha1-array.h                                  |  80 ++++++++
 23 files changed, 900 insertions(+), 1166 deletions(-)
 delete mode 100644 Documentation/technical/api-diff.txt
 delete mode 100644 Documentation/technical/api-directory-listing.txt
 delete mode 100644 Documentation/technical/api-gitattributes.txt
 delete mode 100644 Documentation/technical/api-history-graph.txt
 delete mode 100644 Documentation/technical/api-merge.txt
 delete mode 100644 Documentation/technical/api-oid-array.txt
 delete mode 100644 Documentation/technical/api-ref-iteration.txt
 delete mode 100644 Documentation/technical/api-remote.txt
 delete mode 100644 Documentation/technical/api-revision-walking.txt
 delete mode 100644 Documentation/technical/api-setup.txt


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-434%2FHebaWaly%2Fmove-doc-to-header-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-434/HebaWaly/move-doc-to-header-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/434
-- 
gitgitgadget
