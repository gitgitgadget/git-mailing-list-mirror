Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B2BFA373E
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 22:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJVW07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 18:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJVW04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 18:26:56 -0400
Received: from smtp-out-5.talktalk.net (smtp-out-5.talktalk.net [62.24.135.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60813E3C
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 15:26:52 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id mMw7oFnZllLbymMw9oJF1U; Sat, 22 Oct 2022 23:25:49 +0100
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=OJpZIhSB c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=Gtg6NY3Tyv3dZtJDmhEA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: [PATCH v2 3/3] glossary: add reachability bitmap description
Date:   Sat, 22 Oct 2022 23:25:39 +0100
Message-Id: <20221022222539.2333-4-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20221022222539.2333-1-philipoakley@iee.email>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <20221022222539.2333-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCCeDBo/gV7U5qk2kUuww/rJO5Ip7m5x2TfSUI04qacofoI5XuM/hRb5CMo8sL6mhQ2A4sWd4NyVvLgNhw8H4RCLNmuXJCeD+FF83Y1A2Z0SjUbS7KQ/
 WwFBP7JJivva8hGP6snHtjkmPg/e8sWvxEBlXcn9HryUGLcr9m8css21U4ZdvJx03wFYtPk2mkP3dWwkW0I9OsEE3ZPJDIkKYMhRmgIV+OMbQiWhul0LbCa4
 pkmJZ9I3wOWwr0LVDVhepiSEGEP0ILIWX9vG9OOBAKPEE7/MZs1yEgi1el+WcR8BA1aEYSZCV7wMdbXl2AGUUA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Describe the purpose of the reachability bitmap.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/glossary-content.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 97050826e5..3d67b452aa 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -508,6 +508,14 @@ exclude;;
 	<<def_tree_object,trees>> to the trees or <<def_blob_object,blobs>>
 	that they contain.
 
+[[def_reachability_bitmap]]reachability bitmaps::
+	Reachability bitmaps store information about the
+	<<def_reachable,reachability>> of a selected set of objects in
+	a packfile, or a multi-pack index (MIDX) to speed up object search.
+	A repository may have at
+	most one bitmap. The bitmap may belong to either one pack, or the
+	repository's multi-pack index (if it exists).
+
 [[def_rebase]]rebase::
 	To reapply a series of changes from a <<def_branch,branch>> to a
 	different base, and reset the <<def_head,head>> of that branch
-- 
2.38.1.windows.1

