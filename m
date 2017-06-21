Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80B620401
	for <e@80x24.org>; Wed, 21 Jun 2017 13:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbdFUNFL (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 09:05:11 -0400
Received: from mail.javad.com ([54.86.164.124]:56995 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbdFUNFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 09:05:11 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jun 2017 09:05:10 EDT
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 22BDB60669
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 12:58:01 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1dNfCp-0006Cb-ES
        for git@vger.kernel.org; Wed, 21 Jun 2017 15:57:59 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: git revert --continue refuses to, help!
Date:   Wed, 21 Jun 2017 15:57:59 +0300
Message-ID: <87h8z91ors.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

What do I do next, to finish reverting multiple commits? I'd use
'--skip' in 'git rebase', but 'revert' doesn't have one?

[skeleton (tmp|REVERTING)]$ git revert --continue
On branch tmp
You are currently reverting commit d8a30d3.

nothing to commit, working tree clean
[skeleton (tmp|REVERTING)]$ git status
On branch tmp
You are currently reverting commit d8a30d3.
  (all conflicts fixed: run "git revert --continue")
  (use "git revert --abort" to cancel the revert operation)

nothing to commit, working tree clean
[skeleton (tmp|REVERTING)]$ git revert --continue
On branch tmp
You are currently reverting commit d8a30d3.

nothing to commit, working tree clean
[skeleton (tmp|REVERTING)]$ git revert --skip
fatal: Option '--skip' requires a value
[skeleton (tmp|REVERTING)]$ git --version
git version 2.10.0.1.g57b01a3
[skeleton (tmp|REVERTING)]$ 

-- Sergey
