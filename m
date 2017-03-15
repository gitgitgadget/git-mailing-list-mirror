Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962A6202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 13:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbdCONPO (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 09:15:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57519 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752561AbdCONPN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Mar 2017 09:15:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 116292080C;
        Wed, 15 Mar 2017 09:15:12 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 15 Mar 2017 09:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=uPLIH7237GxvI1ohNFpd8Mzh6xI
        =; b=Qc5WAbzGqgafLlxVQfm9VQMOroHrxOg/v5EiM1aGSK/XmCzJOd8MnZKrvdI
        m7a0HXWpEVcXg21AdBot8bx4f+TkUQYWLJan2Ns2ltrWNgzf2HZVTDmuY3lfESUx
        xek+nmfnYqPazfsZzESu0gXAGbkRLvwV5B/yN+sZ1mzxzqaQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=uP
        LIH7237GxvI1ohNFpd8Mzh6xI=; b=eD9s/Z7pQBzw1oxPXKMHvKlpTZyLHVOLSh
        ytOpgl8W0aNCGVUziI53zk5tIoClZ29N/gfrpvMA/pGKnTqIFluxuuUiQBQO+Gb2
        48JeFlPLAJSKtG0JukoM3K4kHsl9jV910HLjKCJ9mARUcMvfbtoDbUyNRKVrkXm2
        j+wf+VzE0=
X-ME-Sender: <xms:YD7JWJzzgH-_gyxZyz3vWm2kggxJkiWw7QL8PuqkhJH5z069IOjLyg>
X-Sasl-enc: WmEPcT2idwsGmkR9DUwAVbKmEI3zoKIHDn8ZcJhAGteX 1489583711
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id A85E47E2E3;
        Wed, 15 Mar 2017 09:15:11 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] describe --contains sanity
Date:   Wed, 15 Mar 2017 14:15:07 +0100
Message-Id: <cover.1489581340.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.12.0.384.g157040b11f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2 patches and 1 RFD around describe (--contains). They are technically
independent, but happened along the same stroll in that area
when I tried to match documentation, my expectations, and reality.

1 and 2 should be no-brainers.

3 is something to ponder for a while.

Michael J Gruber (3):
  describe: debug is incompatible with contains
  git-prompt: add a describe style for any tags
  name-rev: Allow lightweight tags and branch refs

 Documentation/git-describe.txt   | 2 +-
 builtin/describe.c               | 2 ++
 builtin/name-rev.c               | 2 ++
 contrib/completion/git-prompt.sh | 3 +++
 t/t9903-bash-prompt.sh           | 2 +-
 5 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.12.0.384.g157040b11f.dirty

