Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D4720281
	for <e@80x24.org>; Fri, 22 Sep 2017 08:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbdIVIi5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 04:38:57 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:54081 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751832AbdIVIi4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Sep 2017 04:38:56 -0400
Received: from [194.72.166.2] (helo=bokrug.cam.docker.com)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dvJU3-0006GX-BK; Fri, 22 Sep 2017 09:38:51 +0100
Message-ID: <1506069530.2682.41.camel@hellion.org.uk>
Subject: Re: [PATCH v3 0/4] filter-branch: support for incremental update +
 fix for ancient tag format
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 22 Sep 2017 09:38:50 +0100
In-Reply-To: <xmqqzi9njqec.fsf@gitster.mtv.corp.google.com>
References: <1505980146.4636.9.camel@hellion.org.uk>
         <xmqqzi9njqec.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-09-22 at 13:42 +0900, Junio C Hamano wrote:
> Ian Campbell <ijc@hellion.org.uk> writes:
> 
> > This is the third version of my patches to add incremental support to
> > git-filter-branch. Since the last time I have replaced `git mktag --
> > allow-missing-tagger` with `git hash-object -t tag -w --stdin`.
> > 
> > I've force pushed to [1] (Travis is still running) and have set off the
> > process of re-rewriting the devicetree tree from scratch (a multi-day
> > affair) to validate (it's looking good).
> 
> Thanks.

Travis is happy and the dt reconvert looks sensible (only took 60 hours
;-)).

Don't know if this is useful to your workflow but:

The following changes since commit 4384e3cde2ce8ecd194202e171ae16333d241326:

  Git 2.14 (2017-08-04 09:31:12 -0700)

are available in the git repository at:

  https://github.com/ijc/git git-filter-branch

for you to fetch changes up to e31c74f709fbf2827d57b4abf826bb836f120329:

  filter-branch: use hash-object instead of mktag (2017-09-21 08:44:59 +0100)

----------------------------------------------------------------
Ian Campbell (4):
      filter-branch: reset $GIT_* before cleaning up
      filter-branch: preserve and restore $GIT_AUTHOR_* and $GIT_COMMITTER_*
      filter-branch: stash away ref map in a branch
      filter-branch: use hash-object instead of mktag

 Documentation/git-filter-branch.txt |  8 +++++++-
 git-filter-branch.sh                | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 94 insertions(+), 8 deletions(-)
