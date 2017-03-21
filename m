Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F512095B
	for <e@80x24.org>; Tue, 21 Mar 2017 00:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbdCUA4Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:56:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61835 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753279AbdCUA4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:56:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12CA57FDD0;
        Mon, 20 Mar 2017 20:56:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=CMgGeTl3NPHRAE41x7uXLFUXNl0
        =; b=Oj8ZnKGFC6OOCVGkJyHCN/CBEDPIjSca6bEroanghkCo8PXz280CGunWheN
        839eAZWSs/ePTDmPEbkXzhPegY29J81ti6wa4mbibwrk03pPTIEk1GgU5+df5QtI
        ax5OGNtfP+0ABwfrnkKks4O1UigcWNICCu/ZxiYcGM2fIvOw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C1B77FDCF;
        Mon, 20 Mar 2017 20:56:22 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67F3F7FDCE;
        Mon, 20 Mar 2017 20:56:21 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 0/5] t1400: modernize style
Date:   Mon, 20 Mar 2017 20:56:11 -0400
Message-Id: <20170321005616.31324-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.0
X-Pobox-Relay-ID: 332216C2-0DD1-11E7-84CE-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=CMgGeTl3NPHRAE41x7uXLFUXNl0=;
 b=ENLcQrU9T86Bih86jhNMFeP48O9WDRmLidOeAyhtpU2fvSx4BYkpEpDAfjN3cHT8Ln43yjyfYrRxDZP4rBFsQBfqxdon+zUzDxIMXk/FGybTUDGIt20ZCoV18YQgEqdsDGqa4Dm3X/NMalBfHANfF65YDNZo4Fm9NK2+8Rpx39w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches follow up on Peff's suggestion to modernize the style in
t1400-update-ref.sh.

    20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net

The first two commits aren't concerned with "modernizing" the tests,
but instead address issues that I noticed while looking more closely
at t1400.

I also considered

  * making the quoting/spacing/breaks around the test descriptions and
    bodies more consistent, but I think this leads to too much code
    churn.

  * moving the here-documents for log creation into the following
    tests, but I don't think it's worth it because it makes already
    long lines even longer.

  t1400: rename test descriptions to be unique
  t1400: set core.logAllRefUpdates in "logged by touch" tests
  t1400: use test_path_is_* helpers
  t1400: remove a set of unused output files
  t1400: use test_when_finished for cleanup

 t/t1400-update-ref.sh | 154 +++++++++++++++++++++++++-------------------------
 1 file changed, 78 insertions(+), 76 deletions(-)

-- 
2.12.0

