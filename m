Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710A51F453
	for <e@80x24.org>; Wed, 19 Sep 2018 20:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeITCYV (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 22:24:21 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:44822 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 22:24:20 -0400
Received: from [10.13.0.14] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1g2iqJ-0001ya-5h; Wed, 19 Sep 2018 16:12:59 -0400
Received: from amenhotep (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id F350A3EE59;
        Wed, 19 Sep 2018 13:12:53 -0700 (PDT)
Received: from frederik by amenhotep with local (Exim 4.91)
        (envelope-from <frederik@amenhotep>)
        id 1g2iqD-0000AW-At; Wed, 19 Sep 2018 20:12:53 +0000
From:   Frederick Eaton <frederik@ofb.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Frederick Eaton <frederik@ofb.net>
Subject: [PATCH 0/3] some documentation changes from the beginning of the alphabet
Date:   Wed, 19 Sep 2018 13:12:28 -0700
Message-Id: <20180919201231.609-1-frederik@ofb.net>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've never sent patches using git before so I thought it would be
useful to make a small test.

I read ./Documentation/SubmittingPatches and I sent these to myself
and practiced applying them using `git am`, and I also compiled and
checked the revised manual pages to see that they format correctly.
Unfortunately it was too late to run 'git diff --check' because I had
already committed the changes to my repo, but I don't see any
whitespace highlighted when I run 'git log -p'.

I'm sure I'm doing something wrong, so please let me know what it is!

Here's the command I'll use to send the messages (without --dry-run):

git send-email --to "Junio C Hamano <gitster@pobox.com>" --cc git@vger.kernel.org --cc-cmd ./contrib/contacts/git-contacts outgoing/ --dry-run

By the way for some reason git-contacts shows more names when I run it
on the patch hash than when I give it the patch name:

$ ./contrib/contacts/git-contacts 222580cb60ee64f7b81fed64ec8fbfc81952557f
Sébastien Guimmara <sebastien.guimmara@gmail.com>
Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Eric Sunshine <sunshine@sunshineco.com>
Junio C Hamano <gitster@pobox.com>
$ ./contrib/contacts/git-contacts ./outgoing/0002-git-column.1-clarify-initial-description-provide-exa.patch                                
Junio C Hamano <gitster@pobox.com>

Not sure what's going on here, but the changes I propose seem fairly
straightforward...(?)

Frederick Eaton (3):
  git-archimport.1: specify what kind of Arch we're talking about
  git-column.1: clarify initial description, provide examples
  git-describe.1: clarify that "human readable" is also git-readable

 Documentation/git-archimport.txt |  5 +++--
 Documentation/git-column.txt     | 35 ++++++++++++++++++++++++++++++--
 Documentation/git-describe.txt   |  4 +++-
 3 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.19.0

