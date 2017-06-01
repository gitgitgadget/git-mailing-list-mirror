Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40912027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdFAJFo (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:05:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751090AbdFAJFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:05:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFE10AD5C;
        Thu,  1 Jun 2017 09:05:42 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Marc Stevens <marc@marc-stevens.nl>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <CDB32E2C-48AF-4636-B921-4C45B614FD35@marc-stevens.nl>
X-Yow:  I'm dressing up in an ill-fitting IVY-LEAGUE SUIT!!  Too late...
Date:   Thu, 01 Jun 2017 11:05:42 +0200
In-Reply-To: <CDB32E2C-48AF-4636-B921-4C45B614FD35@marc-stevens.nl> (Marc
        Stevens's message of "Thu, 01 Jun 2017 10:44:48 +0200")
Message-ID: <mvmzidst6vt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SHA1DCUpdate calls sha1_process with buf being unaligned.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
