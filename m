Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B9FC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572EB6196A
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhC3TAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:00:12 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60866 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhC3TAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 15:00:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 12UJ07Bp024653
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 15:00:07 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Bug] worktree prune --expires
Date:   Tue, 30 Mar 2021 15:00:00 -0400
Message-ID: <011901d72596$e5ed8670$b1c89350$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdcllggUjFwcSzDHTf+xIkyCQnBhaw==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

This is pretty much just a quibble, but the command parser for worktree
prune --expires should really report when a timestamp is invalid. For
example:

worktree prune --expires A:30 actually

actually appears to process the prune going back a very long time instead of
reporting that A:30 isn't a good timestamp.

Experienced using git 2.29.2 in Cygwin - not my usual space and git 2.31.0
on NonStop.

I suspect that this should use the same timestamp parse as for other
commands, although I also noticed that git log --since accepts the same
syntactically awkward time. Am I missing something?

Thanks,
Randall


-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.


