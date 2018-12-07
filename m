Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC7220A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 17:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLGRvY (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 12:51:24 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:24497 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeLGRvY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 12:51:24 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43BKlY5K0Bz5tlH;
        Fri,  7 Dec 2018 18:51:21 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 051E24152;
        Fri,  7 Dec 2018 18:51:21 +0100 (CET)
Subject: [PATCH] git-rebase.txt: update note about directory rename detection
 and am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
 <20181204231709.13824-1-newren@gmail.com>
 <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
 <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
 <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org>
 <xmqqr2ewbevt.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHzESYnQy5JwXvtXyLHgHR9u3UNVOZF2gU1m_uTMGkyfg@mail.gmail.com>
 <bd67cd33-dbe8-03a0-e760-c7bb23854084@kdbg.org>
 <xmqqmupjbnhq.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <66479695-d17e-c9cb-4cb7-8c74e3855032@kdbg.org>
Date:   Fri, 7 Dec 2018 18:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqmupjbnhq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 6aba117d5cf7 ("am: avoid directory rename detection when
calling recursive merge machinery", 2018-08-29), the git-rebase manpage
probably should have also been updated to note the stronger
incompatibility between git-am and directory rename detection.  Update
it now.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  Documentation/git-rebase.txt | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 41631df6e4..7bea21e8e3 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -569,8 +569,9 @@ it to keep commits that started empty.
  Directory rename detection
  ~~~~~~~~~~~~~~~~~~~~~~~~~~

-The merge and interactive backends work fine with
-directory rename detection.  The am backend sometimes does not.
+Directory rename heuristics are enabled in the merge and interactive
+backends.  Due to the lack of accurate tree information, directory
+rename detection is disabled in the am backend.

  include::merge-strategies.txt[]

-- 
2.19.1.1133.g2dd3d172d2
