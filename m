Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43EC220A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdAWSBI (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:01:08 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:50618 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbdAWSBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:01:07 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id 2334355FC50; Mon, 23 Jan 2017 18:01:05 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/5] show-ref: Allow -d, --head to work with --verify
Date:   Mon, 23 Jan 2017 18:00:54 +0000
Message-Id: <20170123180059.4288-1-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Third iteration, according to Junio's comments. This time we keep
show_ref and show_one separate, accept HEAD with --verify even without
--head, and add tests for dangling ref validation with --verify.

