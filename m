Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2351F576
	for <e@80x24.org>; Thu, 22 Feb 2018 08:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeBVIw2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 03:52:28 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:39988
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752643AbeBVIw1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Feb 2018 03:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1519289545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=H1FtFPhTMF1+rXtZC5nbJXqidhRDlV6iexvbTaSrtDw=;
        b=P4vJEqhJTWpwi/j6r1+upw1977c3TXkdWaEipUHrXGILPjiZ+hVHutH67ZuMnn6z
        dVYrvwxAz24aYJxQv1hhppTjwT0JjnV435TzBSwg20607kgycClMjRT2uQP16OWNn6e
        QTVrBhhxg3IP4bnvThgXkkma6zCJFpllV12U1UKU=
From:   marmot1123 <marmot.motoki@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161bcb6b3db-dd4dc2a0-4426-4bf0-97f3-18b299d91400-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161bcb6b2b5-6a915ec6-57e5-4619-b281-0e2a193c69a2-000000@eu-west-1.amazonses.com>
References: <01020161bcb6b2b5-6a915ec6-57e5-4619-b281-0e2a193c69a2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 2/2] Replace non-ASCII apostrophes to ASCII single quotes
 in gitsubmodules.txt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 22 Feb 2018 08:52:25 +0000
X-SES-Outgoing: 2018.02.22-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, there are several non-ASCII apostrophes in
gitsubmodules.txt, and misconverged at the https://git-scm.com/docs/gitsubm=
odules/ .
To make codes consistent, these non-ASCII apostrophes are replaced
with ASCII single quotes.  This patch also makes the document readable
on the website.

Signed-off-by: Motoki Seki <marmot.motoki@gmail.com>
---
 Documentation/gitsubmodules.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.=
txt
index 0d59ab4cdfb1c..030c974c25606 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -132,27 +132,27 @@ using older versions of Git.
 +
 It is possible to construct these old form repositories manually.
 +
-When deinitialized or deleted (see below), the submodule=E2=80=99s Git
+When deinitialized or deleted (see below), the submodule's Git
 directory is automatically moved to `$GIT_DIR/modules/<name>/`
 of the superproject.
=20
  * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
-but no submodule working directory. The submodule=E2=80=99s git directory
+but no submodule working directory. The submodule's git directory
 may be there as after deinitializing the git directory is kept around.
 The directory which is supposed to be the working directory is empty inste=
ad.
 +
 A submodule can be deinitialized by running `git submodule deinit`.
 Besides emptying the working directory, this command only modifies
-the superproject=E2=80=99s `$GIT_DIR/config` file, so the superproject=E2=
=80=99s history
+the superproject's `$GIT_DIR/config` file, so the superproject's history
 is not affected. This can be undone using `git submodule init`.
=20
  * Deleted submodule: A submodule can be deleted by running
 `git rm <submodule path> && git commit`. This can be undone
 using `git revert`.
 +
-The deletion removes the superproject=E2=80=99s tracking data, which are
+The deletion removes the superproject's tracking data, which are
 both the `gitlink` entry and the section in the `.gitmodules` file.
-The submodule=E2=80=99s working directory is removed from the file
+The submodule's working directory is removed from the file
 system, but the Git directory is kept around as it to make it
 possible to checkout past commits without requiring fetching
 from another repository.

--
https://github.com/git/git/pull/459
