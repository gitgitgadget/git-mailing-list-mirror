Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6481C20357
	for <e@80x24.org>; Wed, 12 Jul 2017 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbdGLWbQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 18:31:16 -0400
Received: from out.mailnull.com ([52.71.76.30]:60335 "EHLO
        outside.256stuff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdGLWbP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 18:31:15 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jul 2017 18:31:15 EDT
Received: by outside.256stuff.com (Postfix, from userid 33)
        id A2F7A246E3; Wed, 12 Jul 2017 18:21:28 -0400 (EDT)
To:     git@vger.kernel.org
From:   roeder.git@mailnull.com
Subject: Git on macOS shows committed files as untracked
Message-Id: <20170712222128.A2F7A246E3@outside.256stuff.com>
Date:   Wed, 12 Jul 2017 18:21:28 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git on macOS (git version 2.13.2 | brew install git) the status command will show folders as untracked even though they are committed and checked out from the repository. Does not reproduce on Windows and Ubuntu.

Repro steps:

1. Download https://www.dropbox.com/s/0q5pbpqpckwzj7b/gitstatusrepro.zip?dl=0
2. unzip gitstatusrepro.zip && cd gitstatusrepro
3. git reset --hard

HEAD is now at 95fcd7e add folder with unicode name

4. git status

On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	"d\314\207\316\271\314\223\314\200\342\225\223\316\265\357\256\257\360\222\221\217\342\227\213\342\225\223\320\243\314\213/"

nothing added to commit but untracked files present (use "git add" to track)


----------
This message was sent from a MailNull anti-spam account.  You can get
your free account and take control over your email by visiting the
following URL.

   http://mailnull.com/
