Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBCF20281
	for <e@80x24.org>; Thu,  2 Nov 2017 21:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964951AbdKBVZ1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 17:25:27 -0400
Received: from marcos.anarc.at ([206.248.172.91]:35056 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964867AbdKBVZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 17:25:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id CE0391A00AA
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/7] remote-mediawiki: namespace support
Date:   Thu,  2 Nov 2017 17:25:11 -0400
Message-Id: <20171102212518.1601-1-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171030025142.19421-1-anarcat@debian.org>
References: <20171030025142.19421-1-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should be the final roll of patches for namespace support. I
included the undef check even though that problem occurs elsewhere in
the code. I also removed the needless "my" move.

Hopefully that should be the last in the queue!

