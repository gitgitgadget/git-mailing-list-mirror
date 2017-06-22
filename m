Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DDD51FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 12:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbdFVMuM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 08:50:12 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:57273 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbdFVMuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 08:50:11 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Thu, 22 Jun 2017 14:44:58 +0200
  id 000000000000024C.00000000594BBBCA.000002A6
Date:   Thu, 22 Jun 2017 14:44:58 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: No "invalid option" message with git diff --cached --invalid-option
Message-ID: <20170622124458.ilokr7acas2bzq4z@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm using Git 2.13.1 (from the Debian sid repository) and noticed
the following issue when upgrading.

    $ git diff --compaction-heuristic
    error: invalid option: --compaction-heuristic

    $ git diff --cached --compaction-heuristic
    usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]

I know that --compaction-heuristic is no longer supported but I
was using it an alias and was confused that I got no proper error
message warning me which option was wrong.

It seems to happen for any invalid option which is used in
combination with --cached or --staged.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
