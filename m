Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6211F404
	for <e@80x24.org>; Mon, 16 Apr 2018 05:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeDPFnU (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 01:43:20 -0400
Received: from mail.javad.com ([54.86.164.124]:55016 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeDPFnT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 01:43:19 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6A5D73E8B8;
        Mon, 16 Apr 2018 05:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523857398;
        bh=G1jpkqwvXuJzqKYTb9oyirYMRTLaubyyl4oHyppAEz8=; l=1167;
        h=Received:From:To:Subject;
        b=JiEiiUrN1n2Y/bn8nNwnnVvbZeLeobbqpRpVDWYdcOgOjWMWRrsctE7x8P4VVzX67
         8WvPGM2X5l79kZhuWuNUSg8ZpGoY2ZgXA8UVV71c/jXH1m2HavbElQaSNUQ+sS0UUM
         Gaq6MsftR4qnZtkyBC/M7KJOJtTldFnYlg1Da4MA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523857398;
        bh=G1jpkqwvXuJzqKYTb9oyirYMRTLaubyyl4oHyppAEz8=; l=1167;
        h=Received:From:To:Subject;
        b=JiEiiUrN1n2Y/bn8nNwnnVvbZeLeobbqpRpVDWYdcOgOjWMWRrsctE7x8P4VVzX67
         8WvPGM2X5l79kZhuWuNUSg8ZpGoY2ZgXA8UVV71c/jXH1m2HavbElQaSNUQ+sS0UUM
         Gaq6MsftR4qnZtkyBC/M7KJOJtTldFnYlg1Da4MA=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f7wv6-0006Iu-Ex; Mon, 16 Apr 2018 08:43:16 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] glossary: substitute "ancestor" for "direct ancestor" in 'push' description.
Date:   Mon, 16 Apr 2018 08:43:16 +0300
Message-ID: <87muy31zbf.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Even though "direct ancestor" is not defined in the glossary, the
common meaning of the term is simply "parent", parents being the only
direct ancestors, and the rest of ancestors being indirect ancestors.

As "parent" is obviously wrong in this place in the description, we
should simply say "ancestor", as everywhere else.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 6b8888d..6c2d23d 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -463,7 +463,7 @@ exclude;;
 [[def_push]]push::
 	Pushing a <<def_branch,branch>> means to get the branch's
 	<<def_head_ref,head ref>> from a remote <<def_repository,repository>>,
-	find out if it is a direct ancestor to the branch's local
+	find out if it is an ancestor to the branch's local
 	head ref, and in that case, putting all
 	objects, which are <<def_reachable,reachable>> from the local
 	head ref, and which are missing from the remote
-- 
2.10.0.1.g57b01a3

