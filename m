Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B32B1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbdJFN2q (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 09:28:46 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40402 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbdJFN2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 09:28:45 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.147.105])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v96DShUZ009362
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 6 Oct 2017 09:28:44 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Question] Documenting platform implications on CVE to git
Date:   Fri, 6 Oct 2017 09:28:32 -0400
Message-ID: <000801d33ea7$04a7c240$0df746c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdM+pkEK13+1p618SjCnLIQH4C/1CQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I wonder whether there is some mechanism for providing official responses
from platform ports relating to security CVE reports, like CVE-2017-14867.
For example, the Perl implementation on HPE NonStop does not include the SCM
module so commands relating cvsserver may not be available - one thing to be
verified so is a question #1. But the real question (#2) is: where would one
most appropriately document issues like this to be consistent with other
platform responses relating to git?

Thanks,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



