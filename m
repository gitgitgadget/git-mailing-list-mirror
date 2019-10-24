Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336E51F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 22:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfJXWBY (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 18:01:24 -0400
Received: from elephants.elehost.com ([216.66.27.132]:20508 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfJXWBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 18:01:24 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x9OM1LIA071622
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 18:01:22 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] git 2.24.0-rc1 t0500 on NonStop in Jenkins
Date:   Thu, 24 Oct 2019 18:01:15 -0400
Message-ID: <011f01d58ab6$91fee620$b5fcb260$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdWKtZmyobK+Q8BCRnebnl9qvg1J5Q==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

We are running the regression suite (as we always have) in Jenkins and are
finding that t0500 is basically a complete failure. I cannot recreate it
using bash where we have a real terminal, but without one, the t0500
consistently fails. I wonder whether any other platform is experiencing the
same situation.

We also find that we cannot run the main test suite as a background job - we
get segmentation faults that I have yet to isolate, but when run in the
foreground, no problem.

I wanted to get this out there because 2.24.0 goes too far as this did not
happen in 2.23.0 or any release prior.

Sincerely,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.



