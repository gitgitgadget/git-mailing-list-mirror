Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0BB20966
	for <e@80x24.org>; Sat,  1 Apr 2017 07:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbdDAHIk (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 03:08:40 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50094 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750782AbdDAHIk (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2017 03:08:40 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id AC496126D;
        Sat,  1 Apr 2017 03:08:38 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute7.internal (MEProxy); Sat, 01 Apr 2017 03:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antipode.se; h=
        cc:date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=JIWhbg
        S9dH/2acT2NHpbryazHtqXSGpMgJUp+ZdIj/8=; b=rWk+CrP74Ud82eCfDMryjn
        PV6oybkwn4ARBHiX3NyNJd7xkRQOk9Lw006h+LGNtzrPvHYZMl8Xiz0tm8QAI5GB
        oav0s0YojexcuLuaKCVaw2gfc2D8aLa0QVvkMMaL5sn6GKuAuenYwQa+B+ReT76u
        IVX8/iWWmo564BMJ94iDM5ogE4BmrnsPvyDm9Rt59Smpncb0RAgV+1cjHMcooXzT
        8LonvHeEYSwHVwahEK5XTvupzUDvcVqrloD/vJaFG/iUc5d4hGDb0kr7PZSwJ3TP
        zqxt7j6YHNSlq0aDyQn5OloWHUWE10KvStOMkAsHZgzoZGcz+2NdpygpozfA2iIg
        ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=fm1; bh=JIWhbgS9dH/2acT2NHpbryazHtqXSGpMgJUp+ZdIj
        /8=; b=MfJbcE69E/bZ6B24oP9tAWYpvePiCKfT8UTm85VslG55C+FFc3maPe0MJ
        TGv3lPocwtvJPLam2Nhdk2II94rJPx4iK8EKJCDL+EW7zZqYeyPtGdErRlTSMLRj
        oOFF1fRbSHhIowGaJptEbhixRxNZH5iH64IZd+t2ZucAca3DPNsjUmAlHH1iXqJs
        heTiasC+Cp75kIhjBC2GwpCcC7Y1te2MCbf83ZTm063rGzmVMsf1YK6xUKY0GScB
        wolMqOvOiinsfzSNHe0PlfoJ1PzPkMquo/b+DymoZ05R63BwROV5v+PfoCaUqU++
        9F8MRloKOe+ex51ysPMRv6hM+aqNg==
X-ME-Sender: <xms:9lHfWAnuSP68W9sfABM4nqbszoDUZm-oASGeITXxPkfBJlNNm71rSQ>
X-Sasl-enc: v4Z5aXme7J8bqM8BQvYAR+22BpH1KsoJGWUjoixqkqNL 1491030518
Received: from luciana.skrumpis (78-73-126-207-no292.tbcn.telia.com [78.73.126.207])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA9D8241E1;
        Sat,  1 Apr 2017 03:08:37 -0400 (EDT)
From:   Mostyn Bramley-Moore <mostyn@antipode.se>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Mostyn Bramley-Moore <mostyn@antipode.se>
Subject: [PATCH v2] Documentation: improve git ls-files -s manpage entry
Date:   Sat,  1 Apr 2017 09:08:25 +0200
Message-Id: <20170401070825.8033-1-mostyn@antipode.se>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <xmqqpogwx3yr.fsf@gitster.mtv.corp.google.com>
References: <xmqqpogwx3yr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

List the fields in order of appearance in the command output.

Signed-off-by: Mostyn Bramley-Moore <mostyn@antipode.se>
---
 Documentation/git-ls-files.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1cab703..d153c17 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -57,7 +57,7 @@ OPTIONS
 
 -s::
 --stage::
-	Show staged contents' object name, mode bits and stage number in the output.
+	Show staged contents' mode bits, object name and stage number in the output.
 
 --directory::
 	If a whole directory is classified as "other", show just its
-- 
2.9.3

