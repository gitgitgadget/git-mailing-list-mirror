Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012A7207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbdDRV55 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 18 Apr 2017 17:57:57 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:48060 "EHLO
        homiemail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750766AbdDRV54 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Apr 2017 17:57:56 -0400
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id 2903A262069;
        Tue, 18 Apr 2017 14:57:56 -0700 (PDT)
Received: from localhost.localdomain (207-38-252-131.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.252.131])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 739B1262065;
        Tue, 18 Apr 2017 14:57:55 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, David Turner <dturner@twosigma.com>
Subject: [PATCH v3 0/2] gethostbyname fixes
Date:   Tue, 18 Apr 2017 17:57:41 -0400
Message-Id: <20170418215743.18406-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version includes Junio's fixup to René's patch, and then my patch
rebased on top of René's.  I thought it was easier to just send both
in one series, than to have Junio do a bunch of conflict resolution.
I think this still needs Junio's signoff on the first patch, since
I've added his code.

David Turner (1):
  xgethostname: handle long hostnames

René Scharfe (1):
  use HOST_NAME_MAX to size buffers for gethostname(2)

 builtin/gc.c           | 12 ++++++++----
 builtin/receive-pack.c |  4 ++--
 daemon.c               |  4 ----
 fetch-pack.c           |  4 ++--
 git-compat-util.h      |  6 ++++++
 ident.c                |  4 ++--
 wrapper.c              | 13 +++++++++++++
 7 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.11.GIT

