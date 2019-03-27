Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B789C20248
	for <e@80x24.org>; Wed, 27 Mar 2019 10:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfC0KWl (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 06:22:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbfC0KWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 06:22:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 636E8AD2F
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 10:22:40 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     git@vger.kernel.org
Subject: git replace --graft does error checking too late
X-Yow:  ..  I wonder if I ought to tell them about my PREVIOUS LIFE
 as a COMPLETE STRANGER?
Date:   Wed, 27 Mar 2019 11:22:40 +0100
Message-ID: <mvmd0mcsjkf.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running `git replace --graft A B' where B is a non-commit (eg. a
tag) it displays an error, but creates the replace ref anyway.  I think
it should verify that B names a commit object before creating the ref.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
