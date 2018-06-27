Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45F81F516
	for <e@80x24.org>; Wed, 27 Jun 2018 04:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeF0Eqz (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 00:46:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56058 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeF0Eqz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 00:46:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A12CC4F1C6;
        Wed, 27 Jun 2018 00:46:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=KAsjp2j1R9/VaRzFLp6zI8BntuE
        =; b=u8sTBDPCIqhNWX3qUltjCKB4EcZ4cGSKRz+IbbSNW+F5yAwygnCO35ataWS
        XkVyK8NXvCKbkDDjqgHE1ENVWFEQNDR6j4JiNPm2Y2GqoX8yaaCDNtLIreZh9vPC
        GL9IoeQOuFXoN2YOclJvoOxhSKiMGfyy40a3wsY17xiWgt44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=Z10z+w9JMpzwVCQZ7Sxm8
        WbIjEaoptq7Y+swqTt07sg/b/lBvS7drpuChCsq6wOIP2m1Zp8HOkEeIUCunjf2T
        jnEuK4n1sUo54vK9JM9kCv/rGf/2JHEo840NeKtyv3FamrBduCNd+m16Q4wF1mPx
        6gu0WYfOC6r8ig/H+vuod0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9867F4F1C3;
        Wed, 27 Jun 2018 00:46:54 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.87.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0714D4F1C1;
        Wed, 27 Jun 2018 00:46:53 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] gitignore.txt: clarify default core.excludesfile path
Date:   Wed, 27 Jun 2018 00:46:51 -0400
Message-Id: <20180627044652.12080-1-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0
X-Pobox-Relay-ID: 1D44980A-79C5-11E8-8FC8-0DFB1A68708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default core.excludesfile path is $XDG_CONFIG_HOME/git/ignore.
$HOME/.config/git/ignore is used if XDG_CONFIG_HOME is empty or unset,
as described later in the document.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/gitignore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index ff5d7f9ed6..d107daaffd 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
 
 SYNOPSIS
 --------
-$HOME/.config/git/ignore, $GIT_DIR/info/exclude, .gitignore
+$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
 
 DESCRIPTION
 -----------
-- 
2.18.0

