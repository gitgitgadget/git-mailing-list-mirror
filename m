Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23FB2018B
	for <e@80x24.org>; Wed, 29 Jun 2016 14:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbcF2ObO (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:31:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:62434 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbcF2ObN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:31:13 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MZCxA-1b3tSl2rQy-00KtrX; Wed, 29 Jun 2016 16:31:03
 +0200
Date:	Wed, 29 Jun 2016 16:31:03 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t3404: fix another typo
In-Reply-To: <cover.1467210629.git.johannes.schindelin@gmx.de>
Message-ID: <2ad336745e1b2a610b20b7cfba169bd3e042c178.1467210629.git.johannes.schindelin@gmx.de>
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AArEZSUjISUDIv4BjK1C/KgaiWkwqEOj1zjRORt2gCvtlxfRPtL
 /mr0AB9UcY8AOnyiSBupzJ7pReS7eISGjPS8QswQM7k60f0ABjg+T/ysL2iEAaWY0DzCyd3
 hNfWhleKtHEkiDiygWWnmcMHe28nBUvOLp4w6qEVwrPbaipNNLlTOKExxmKb7xiKXqHt9v6
 PAPOIWB4lLAjpDRq75yRQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Vhmno30aTyc=:/hFNHyXBZQNOSynxxUSSTZ
 oASPSTySNHEGs7DXycAnNxH+UK/CY4NsfjlKB33I0OPl5aZa2gdEogdzAmCfkA2oQ2lorI2dF
 y+MOOL+AtlqIZ8LxHwr2A5MXrmP5uXAH7+O30OGTBc1+xdgnMkCyMNeggeE9+mpE/RsBc0WQp
 89U7ZJBCAoLh76tWfolu6cGczTQC0f8VKwwogqUhzv9nkLKIIMmLjNPwcGTHZM0lIT9X4Ngn5
 55O26SZoswRcMvLw8mGE/6kAYUbdSik+TOXeZ/ol3pC/bmpmWKgJJoYqXDKDIyzQXcjT3aZ7l
 7w/E3DdozytJ+0/cc0vskS3wSjBUM3y1opmDl0ejWwyrIQ0xWFyr130QuPG/ZBn3B8c/FjNTa
 hbEkwzt4ocFzNB1yR8sBNLdQjy7sU7Ylp4Ye5u4urpursVULdMTIVOp+zIRN9e8G9JIKVux8f
 VmrM3WkpvYmm1ZoGDS6RNKXEHZtua6a5FICzojEFnrWGelWf4IOuiXqQPa6FpCrVUZOD2sK/a
 3Ts9sfvu6fbyrjxiNLjelTSVFBU0Y0ENsJHgCqlQlzjMOLl3cuBsYoZrB9QutXAHaZwuinhPd
 BqfYdoQ2li2rrl6fLK+IstE3IhTH+aqQytMGhGt7G0z3XzpuYgahcSQjF4i7EkJPHt3Y3XRAC
 Y6M5HvcnwP7a0P6mWXFhybA8q+Ix1E/1cyUdnsB8mFKIwOm4fD+yUHFLjM87kX/IXGlIiEx3B
 TKPayyQIH0hnu5hMi/q362tyXRxBEtPAWt9Cihv5dGs8B4DAQrf8DwULWliNmf5BbrZvv4o3v
 NAIteo2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The past tense of "to run" is "run", not "ran".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66348f1..c7ea8ba 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -60,7 +60,7 @@ test_expect_success 'setup' '
 	test_commit P fileP
 '
 
-# "exec" commands are ran with the user shell by default, but this may
+# "exec" commands are run with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
 # to create a file. Unsetting SHELL avoids such non-portable behavior
 # in tests. It must be exported for it to take effect where needed.
-- 
2.9.0.270.g810e421


