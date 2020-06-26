Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53101C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381F4207FC
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgFZUdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:33:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:15992 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 16:33:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05QKXAKh043243
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 16:33:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: Static Linking git for HPE NonStop
Date:   Fri, 26 Jun 2020 16:33:05 -0400
Message-ID: <011901d64bf9$0235d2b0$06a17810$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdZL+HZ3rZi3NafZSLW5IggfV+634A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

I am faced with a bit of a conundrum. There are multiple implementations of
SSL on our platform that co-exist in some installations. While it is
possible to select which one is used, it becomes difficult with other
subsystems are at play, including Jenkins. Is there anyway to force a static
linkage instead of using DLLs so that we can isolate this for installations
who want to be insulated from the confusion?

We currently have everything encoded in config.mak.uname and do not use make
configure or configure explicitly. Just make.

Thanks,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



