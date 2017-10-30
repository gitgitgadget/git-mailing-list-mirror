Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BE6202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbdJ3Cvv (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 22:51:51 -0400
Received: from marcos.anarc.at ([206.248.172.91]:60686 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbdJ3Cvu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:51:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id DEEA41A00AA
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/7] remote-mediawiki: add namespace support
Date:   Sun, 29 Oct 2017 22:51:35 -0400
Message-Id: <20171030025142.19421-1-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171029160857.29460-2-anarcat@debian.org>
References: <20171029160857.29460-2-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series tries to integrate all the feedback received in the
recent review from Eric Sunshine. It completely removes the confusing
changes to get_mw_namespace_id_for_page() because I believe they are
unrelated to the namespace support.

I also split up the last patch in 4 different patches for clarity and
fixed the vocabulary (it's "virtual" namespaces, not "special", which
is a specific namespace).

I left that die() in there because it makes the code a little cleaner
and I'm lazy.

Thanks again for the good feedback!
