Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71F33208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 14:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbdHROvd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 10:51:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60914 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdHROvb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 10:51:31 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue005
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MURN9-1e8jmT1Njf-00RIfl; Fri, 18
 Aug 2017 16:51:30 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] Documentation/git-for-each-ref: clarify peeling of tags for --format
Date:   Fri, 18 Aug 2017 16:51:23 +0200
Message-Id: <45e7986107a8e8b2f87891c729be8e13043670f3.1503067851.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.224.g15ee91971c
In-Reply-To: <35df94bc16d9b1436d2110f5d5c54732e5d9a619.1503067851.git.git@grubix.eu>
References: <35df94bc16d9b1436d2110f5d5c54732e5d9a619.1503067851.git.git@grubix.eu>
X-Provags-ID: V03:K0:lwC4yWxhUm+OGlZlZJNX5eApMNoPSJ/rwNYSTmAIEFglHFku0iv
 CXsCvZrzCJxOLKWMQOYm5ZO58IKcBLtFnbxnOKm6LqgS16HYxzIbcMk1HCIktGMsaPW1Wy5
 SA4x3tAPa+DwsC8QsMMS8Hy8Cl/4kj2j5Tn+3fJSKKda3IR+pR5RaQs4D0pOtesy7T77DdS
 mMHLGTqpTI0LBsVbIpZkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:njnBt4W4/4Q=:9CxnjabQn6ibhzauASlgJg
 spSU9nDdhn1JcBKK334ErlFltAZHJtjAbwZ2Y6j8qp0lhOqOxm4dZMtRl6aEshPk2x3m1VlvM
 zm8goqXlOnpVrcdZcFvmWBsT4lDvhjduaMTSPCLr0TDHc9moTU/f38pg9n1K2vjzWI2btQx9s
 IcKhkSacg2rwcNgT8iV68hZsRVpQ2xii6x6CC2rtITRitJ+lKBITnNqwK5+hTxLY7q58eLNjm
 Acc1/vK91sfdJUiec5J5+7xR0c0ju+n9RAfCUN5Gqn0TsVf7J9Gx6+jgPzF7THcv8fgPYVoyG
 Oo9oTqX48+4qbQ0HGTv6fdNeM3wfO9W8uAdZlop1P6D3CFK5zukUAWBCaQ9YF0FGaOCInxgnS
 zeAAAqyYxH+qL6KN/6vtqMw877NRsveKKKqFyib+J/0tDhya0TyatXc8fkwWp4oqP18WwwdSz
 B0WAViTAiP9QUgYWWV0R8AuiqYeTEJQBK69W3tCLmBk0hh6A8uaGdA+/IAbU6nnOtnk0N0f5F
 mwfoCBaszo/xUKTzZkwuU3xJ0t3W8e3LP6Cmbrzmonh3wRbkHc2otk+lE2fkjx9jM0VDxzC4H
 hvubAzmCPVuuyVEtnDMRdKPEsibx54dMXbg5z0mwskUaXglmr7IXZJvzIwY54r2OWPPekBFWv
 nDjVHBNo0Y0XmGtaLB9lFcDvAaKcANA2/xp3s282HOg7F/59pRwWWi7b+gLkIFgMswsmeFDEr
 VZqQrfvjFHuZdJbJqFA9AlPUKRAq/fddcLWPsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`*` in format strings means peeling of tag objects so that object field
names refer to the object that the tag object points at, instead of the
tag object itself.

Currently, this is documented using grammar that is clearly inspired by
classical latin, though missing more than an article in order to be
classical english.

Try and straighten that explanation out a bit.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 Documentation/git-for-each-ref.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index dac9138fab..bb370c9c7b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -41,8 +41,9 @@ OPTIONS
 	A string that interpolates `%(fieldname)` from a ref being shown
 	and the object it points at.  If `fieldname`
 	is prefixed with an asterisk (`*`) and the ref points
-	at a tag object, the value for the field in the object
-	tag refers is used.  When unspecified, defaults to
+	at a tag object, use the value for the field in the object
+	which the tag object refers to (instead of the field in the tag object).
+	When unspecified, `<format>` defaults to
 	`%(objectname) SPC %(objecttype) TAB %(refname)`.
 	It also interpolates `%%` to `%`, and `%xx` where `xx`
 	are hex digits interpolates to character with hex code
-- 
2.14.1.224.g15ee91971c

