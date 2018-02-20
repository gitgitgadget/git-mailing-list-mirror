Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F3F1F576
	for <e@80x24.org>; Tue, 20 Feb 2018 08:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbeBTIvs (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 03:51:48 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:57992
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750988AbeBTIvs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Feb 2018 03:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1519116706;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Y67jcCsP4oHfgdC3Z86CFoi9OuRRVKTDhHGjZMirtZc=;
        b=RIFaM40sEM3Cy7jzx8vuVcbcdslgtxOmh7LUrQf66ye2X+h2/QW5geNhol8GTEBn
        SfMCrIpcYHai1kfElNHIuKTob0oW6mzPwGPHM7wtiIywFhLhh2dzGPp0Rev/5UcrwLo
        es8x4zhXGEgjZJmdIVlssvZUsjlBq2Jy0gaq7a20=
From:   marmot1123 <marmot.motoki@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Fix misconversion of gitsubmodule.txt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 20 Feb 2018 08:51:46 +0000
X-SES-Outgoing: 2018.02.20-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the 2nd and 4th paragraph of DESCRIPTION, there ware misconversions `sub=
module=E2=80=99s`.
It seems non-ASCII apostrophes, so I rewrite ASCII apostrophes.
---
 Documentation/gitsubmodules.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.=
txt
index 46cf120f666df..0d59ab4cdfb1c 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -24,7 +24,7 @@ On the filesystem, a submodule usually (but not always - =
see FORMS below)
 consists of (i) a Git directory located under the `$GIT_DIR/modules/`
 directory of its superproject, (ii) a working directory inside the
 superproject's working directory, and a `.git` file at the root of
-the submodule=E2=80=99s working directory pointing to (i).
+the submodule's working directory pointing to (i).
=20
 Assuming the submodule has a Git directory at `$GIT_DIR/modules/foo/`
 and a working directory at `path/to/bar/`, the superproject tracks the
@@ -33,7 +33,7 @@ in its `.gitmodules` file (see linkgit:gitmodules[5]) of =
the form
 `submodule.foo.path =3D path/to/bar`.
=20
 The `gitlink` entry contains the object name of the commit that the
-superproject expects the submodule=E2=80=99s working directory to be at.
+superproject expects the submodule's working directory to be at.
=20
 The section `submodule.foo.*` in the `.gitmodules` file gives additional
 hints to Gits porcelain layer such as where to obtain the submodule via

--
https://github.com/git/git/pull/459
