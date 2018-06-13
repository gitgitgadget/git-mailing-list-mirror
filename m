Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5011F403
	for <e@80x24.org>; Wed, 13 Jun 2018 03:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbeFMDKs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 23:10:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52124 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932957AbeFMDKq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 23:10:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 166D4FD397;
        Tue, 12 Jun 2018 23:10:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=GIJN
        XOj4YTDQfuMjogZbwgVkzNY=; b=ZCXDvNk01H/7dkAKQHm0RLmNEU+AKk0rg/V9
        FNmqoPCl71jo06LDN3JFkiez3gGFOXKiO5S/zkUP/8IXypahgiFjEVxTyTveVL1N
        270zJeJ4M1oC1wElZaqrj2tEOcgVwMUDRbSik+jLAsUsMe9LsBc7bJ8DyniMp74L
        KtaRBx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        HYNC67CSNr1vtuj/1JSD2+oP6O2H1sAIZpHDNlWcI0AAQNFcjnHuOIUPF/hr3VLW
        MHA0MdtGVgUk7YBA0zimlabhT6PrNI+D798b7Hh4FiWxtdU5zuh0col/qh9Ah4Am
        aotsq/W1f2P9EL+KYgWdp9lgphZjotorUotuI6i4DiM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D299FD396;
        Tue, 12 Jun 2018 23:10:46 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 600B9FD390;
        Tue, 12 Jun 2018 23:10:44 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 2/4] git-credential-netrc: minor whitespace cleanup in test script
Date:   Tue, 12 Jun 2018 23:10:37 -0400
Message-Id: <20180613031040.3109-3-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607051958.759-1-tmz@pobox.com>
References: <20180607051958.759-1-tmz@pobox.com>
X-Pobox-Relay-ID: 5D296144-6EB7-11E8-AC26-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/credential/netrc/t-git-credential-netrc.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index 58191a62f8..c5661087fe 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -17,15 +17,15 @@
 	# set up test repository
 
 	test_expect_success \
-    'set up test repository' \
-    'git config --add gpg.program test.git-config-gpg'
+		'set up test repository' \
+		'git config --add gpg.program test.git-config-gpg'
 
 	# The external test will outputs its own plan
 	test_external_has_tap=1
 
 	test_external \
-    'git-credential-netrc' \
-    perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
+		'git-credential-netrc' \
+		perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
 
 	test_done
 )
