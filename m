Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5ACB20248
	for <e@80x24.org>; Wed, 27 Feb 2019 13:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfB0NES (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 08:04:18 -0500
Received: from elephants.elehost.com ([216.66.27.132]:19856 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0NES (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 08:04:18 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1RD4E7V028920
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 08:04:14 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: Need multibyte advice - Shift-JIS
Date:   Wed, 27 Feb 2019 08:04:08 -0500
Message-ID: <001e01d4ce9c$eff07400$cfd15c00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdTOm/wHybivAqdmTICu+qMb+40Pbw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Team,

I have to admit being perplexed by this one. I have been asked to support
the Shift-JIS character set in file contents, comments, and logs, for a
partner of mine. I know there are a few ways to do this, but I'm looking for
the official non-hacky way to do this. This is CLI only, and our pager,
less, does not support multi-byte, so I'm looking for options there also.

I normally do all of my UTF-16 work from a workstation via ECLIPSE, with
UTF-8 comments, so never really have encountered this as an issue. Although
our UTF-16 HTML files look pretty ugly in a diff.

The platform (NonStop) does not have a lot of UTF-16 tooling by default
(less does not support it), so I may have to write stuff, which is no issue.
We are on 2.21.0 officially as of yesterday.

Kind Regards,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.





