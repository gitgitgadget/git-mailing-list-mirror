Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B769C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 14:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiHJOq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiHJOqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 10:46:11 -0400
Received: from smtp-out-5.talktalk.net (smtp-out-5.talktalk.net [62.24.135.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6205FADC
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 07:46:02 -0700 (PDT)
Received: from localhost.localdomain ([92.1.139.136])
        by smtp.talktalk.net with SMTP
        id Lmx9oEuXdj0TFLmx9o4fQx; Wed, 10 Aug 2022 15:44:59 +0100
X-Originating-IP: [92.1.139.136]
X-Spam: 0
X-OAuthority: v=2.3 cv=BuDjPrf5 c=1 sm=1 tr=0 a=9CHfLf6Jh88OdhEtU6o92g==:117
 a=9CHfLf6Jh88OdhEtU6o92g==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=g1ImkBr809YhIhVJ1noA:9 a=QEXdDO2ut3YA:10
From:   Philip Oakley <philipoakley@iee.email>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        philipoakley@iee.email, tboegi@web.de
Subject: [PATCH v2 0/1] .. Add extra renormalize information.
Date:   Wed, 10 Aug 2022 15:44:49 +0100
Message-Id: <20220810144450.470-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <xmqq5yj6z5rx.fsf@gitster.g>
References: <xmqq5yj6z5rx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfN4KYvI2ZC9hOSk68IdMMI75Vjt+WQK1Z5uDnt90yCyXkHjiE9AYwXLwamZSRC0Nn8vH36/DA4nTcBBpnVeOxnOnoPjImxNxOIY4b6+nXDQe3jmEKsdF
 3u0TqeEQo4/g/dS3NzvZpfdRNPbZG4cWcwlJ6bDPmBHU4OME62wkeW2NL6FSaMlbGvkEwXyY26k7f0dWzoIgKxvRxhUtgrr5vfQ5KcuklW15nOhdDYl1Oxlv
 DVNaREkE2RuI+NrS9MKEvXkuTzrmtA/f8rJMVwHjZTlqWIvlMX1dqYooNMRce3JZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was [PATCH 4/4] 'doc add: renormalize is not idempotent for CRCRLF'
of a GitGitGadget series, which was split off into its own branch
po/doc-add-renormalize

Since V1, remove the use of 'idempotent' which is unknown to many. Instead
clarify the special case.

Philip Oakley (1):
  doc add: renormalize is not idempotent for CRCRLF

 Documentation/git-add.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.37.1.windows.1

