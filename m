Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70B731F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756942AbdLVXzt (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:55:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:54750 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756902AbdLVXzr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:55:47 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmNHK-1f28pe2Xje-00ZtPC; Sat, 23
 Dec 2017 00:55:44 +0100
Date:   Sat, 23 Dec 2017 00:55:43 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 2/5] sequencer: strip bogus LF at end of error messages
In-Reply-To: <cover.1513986836.git.johannes.schindelin@gmx.de>
Message-ID: <c4343a241548152f99e3f90162c8539ba4f993e5.1513986836.git.johannes.schindelin@gmx.de>
References: <cover.1513986836.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZomTfLoTfsXUcPifV327b1vvf2KlUBn/Y7WOj1eAvZ3wQGKYV/d
 xE0zhrM6rroOf1IxBUf/ApAvPOS05KzSeJqeHHbeKrG5TJ67xTaK7J7JFWUMzkJVmXvF2EM
 VCfur8P8wjduJ/1/ieHqMoVNrit9SgWmuEhSfnaAe0DOj7FLOms6zJsc/djrLvPe6GTj8ZK
 c3nKKZH88cbIo9PsqYrvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nGWGDIOO5hk=:j0yRGOfc3+n02jiwkPB0TS
 JwT7HR6Rvvm0RM+VxgValdp+UVy7Q+Nm0aT8yuFU3zg0x/Fvh+Ul5foAoI0NQJI5uMOXPi2T9
 xZ86kryniAdFwcUBxatl6GtdM19qDIp0dV6i8qqU1NdL/KUU1ckxLTQODQVLSjxq+T7sbsfC7
 YgkwfhIC9KiLh8kFSzkEcCgumemtRK3t+vdsQnitngYi6JkxnN18XSFukoyQeeGaHVrHSduo/
 HuxgC5SBJzQgMo+fD/000xodpuLaGB/NT75B+384kY7E63qRwCnx3ROU9kxpLEXj5gaTxkUSD
 P9JBpCG+eY3Cd/PXEzXCxcG2duWUbFKKpyXZEZzY7+z5va5acRyxvAXwohinWnmHHIs5ymxFq
 GYNL8yT05RbhPI2Ep+eoWRKlf+eI64IO1UEd6UtQ67AtHb9R2ainsHcR0HycwV1QlzpL9eCZL
 LsAs7qeqSUmPA/pSf7UlY38tpFYjIHyh8gTafU89OOzYERueYo0J0lJzzH45ZaKOM1wvj05t3
 ikQvg51z0i26W6v6hHrsJHknGZR3Nc5n0v2spao2ExgnKpO8jTabgDh5XfGejyN4l2afLLn0R
 Xm6cIb9l7245uySJEA9yDh+NTIjmppVZ/hFGmGcXpw/ssKC7cftJLEdEA3I9geMhTZTL82nhL
 0+s2LF0mjrMzuSEXfG6DaQu5JxfT53fs3e+IFCn1+kF46hy0XXZOTIPayoK723/CJnoYCFjAo
 2EDa+Bhbv8rolGUfCWT99ZmMNqZvto+fxRBx1YWoounfnXIqMXBd5+mtzAv/ns1Qvh6TdLaIh
 vR3PbWIiw5N1AcVWDQgZl/AWqv/0sCKczOavjtCBk2UE0D6Tfo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 115085d39ca..8e6b6289be6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -491,7 +491,7 @@ static int is_index_unchanged(void)
 	struct commit *head_commit;
 
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
-		return error(_("could not resolve HEAD commit\n"));
+		return error(_("could not resolve HEAD commit"));
 
 	head_commit = lookup_commit(&head_oid);
 
@@ -511,7 +511,7 @@ static int is_index_unchanged(void)
 
 	if (!cache_tree_fully_valid(active_cache_tree))
 		if (cache_tree_update(&the_index, 0))
-			return error(_("unable to update cache tree\n"));
+			return error(_("unable to update cache tree"));
 
 	return !oidcmp(&active_cache_tree->oid,
 		       &head_commit->tree->object.oid);
@@ -697,12 +697,12 @@ static int is_original_commit_empty(struct commit *commit)
 	const struct object_id *ptree_oid;
 
 	if (parse_commit(commit))
-		return error(_("could not parse commit %s\n"),
+		return error(_("could not parse commit %s"),
 			     oid_to_hex(&commit->object.oid));
 	if (commit->parents) {
 		struct commit *parent = commit->parents->item;
 		if (parse_commit(parent))
-			return error(_("could not parse parent commit %s\n"),
+			return error(_("could not parse parent commit %s"),
 				oid_to_hex(&parent->object.oid));
 		ptree_oid = &parent->tree->object.oid;
 	} else {
-- 
2.15.1.windows.2


