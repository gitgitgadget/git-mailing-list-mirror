Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A850B20248
	for <e@80x24.org>; Sat, 30 Mar 2019 18:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfC3SaK (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 14:30:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51394 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbfC3SaK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2576145D55;
        Sat, 30 Mar 2019 14:30:08 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=+r/ss3WYPeqbunehPNmOlDgmcNo=; b=aPAvFAmtQLs5RqYJtKgA
        3Ikjxs67oQ09RUFemE0zM1vZ0tpnR672mz2S3GaPB8k915id1mmRUtGIFC1SC69b
        nFuQfkPD4yiEiNmP5rcnnNulnyf+uXqnBW0RpH7cC85MJx9tyZb0Jf1csQwKdxl6
        waoa+D0Mki5RifAIjL8RzgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=sasl; b=pKE9TKLtn1jjb5PzqzA2jAgsDh8Wwn6V/bKuqR2mcb1Y89
        k8gILF1Hqr7NxJ9Qzi5kZLMRlhxtEsj8kBEXLPJS2GHH3mMZdSR1dUTXOo5+TMTL
        Q34ALpVdzTPDKfU32A568/fgt7sNO1ysN4pkozk59WcOTrDcM6j6kNf0dFRrQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C7E245D54;
        Sat, 30 Mar 2019 14:30:08 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 74ACB45D51;
        Sat, 30 Mar 2019 14:30:04 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1 0/2] minor asciidoc/tor formatting fixes
Date:   Sat, 30 Mar 2019 14:29:59 -0400
Message-Id: <20190330183001.16624-1-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Pobox-Relay-ID: D68020E0-5319-11E9-A7DE-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just chipping away at the remaining differences between asciidoc and
asciidoctor.

Todd Zullinger (2):
  Documentation/rev-list-options: wrap --date=3D<format> block with "--"
  Documentation/git-status: fix titles in porcelain v2 section

 Documentation/git-status.txt       | 12 ++++++++----
 Documentation/rev-list-options.txt | 22 +++++++++++-----------
 2 files changed, 19 insertions(+), 15 deletions(-)

